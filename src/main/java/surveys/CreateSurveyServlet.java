package surveys;

import UserPackage.UserModel;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CreateSurveyServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 50    // 50 MB
)
public class CreateSurveyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch user votes for this question and
        HttpSession session = request.getSession(false);
        // Get the user object from session
        UserModel user = (UserModel) session.getAttribute("user");

        // Extract the userId
        int userid = user.getUserId();
        // Define the upload directory for the user

        surveyController controller = new surveyController(userid);

        try {
            // Retrieve form data
            String surveyTopic = request.getParameter("surveyTopic");
            String numberOfQuestionsStr = request.getParameter("numberOfQuestions");
            String userIdStr = request.getParameter("userId");

            int defaultUserId = 1; // Default user ID if none provided
            int userId = (userIdStr != null && !userIdStr.isEmpty())
                    ? Integer.parseInt(userIdStr)
                    : defaultUserId;
            int numberOfQuestions = (numberOfQuestionsStr != null && !numberOfQuestionsStr.isEmpty())
                    ? Integer.parseInt(numberOfQuestionsStr)
                    : 0;

            // Validate required fields
            if (surveyTopic == null || surveyTopic.isEmpty() || numberOfQuestions <= 0 || numberOfQuestions > 30) {
                throw new IllegalArgumentException("Missing or invalid required parameters: survey topic or number of questions.");
            }

            // Create SurveyModel
            SurveyModel survey = new SurveyModel(0, surveyTopic, numberOfQuestions, userId, LocalDateTime.now());
            List<QuestionModel> questions = new ArrayList<>();

            // Process each question
            for (int qIndex = 0; qIndex < numberOfQuestions; qIndex++) {
                String questionText = request.getParameter("questions[" + qIndex + "][text]");
                String numAnswersStr = request.getParameter("questions[" + qIndex + "][numAnswers]");
                String questionNumberStr = request.getParameter("questions[" + qIndex + "][questionNumber]");

                int numAnswers = (numAnswersStr != null && !numAnswersStr.isEmpty())
                        ? Integer.parseInt(numAnswersStr)
                        : 0;
                int questionNumber = (questionNumberStr != null && !questionNumberStr.isEmpty())
                        ? Integer.parseInt(questionNumberStr)
                        : qIndex + 1;

                // Validate question data
                if (questionText == null || questionText.isEmpty() || numAnswers <= 0 || numAnswers > 5) {
                    throw new IllegalArgumentException("Invalid question data for question " + (qIndex + 1) + ".");
                }

                QuestionModel question = new QuestionModel(0, questionText, questionNumber, numAnswers);
                List<AnswerModel> answers = new ArrayList<>();

                // Process each answer for the question
                for (int aIndex = 0; aIndex < numAnswers; aIndex++) {
                    String answerText = request.getParameter("questions[" + qIndex + "][answers][" + aIndex + "][text]");
                    Part imagePart = request.getPart("questions[" + qIndex + "][answers][" + aIndex + "][image]");
                    String imageUrl = null;

                    // Validate answer text
                    if (answerText == null || answerText.isEmpty()) {
                        throw new IllegalArgumentException("Invalid answer text for answer " + (aIndex + 1) + " in question " + (qIndex + 1) + ".");
                    }

                    // Handle image upload if present
                    if (imagePart != null && imagePart.getSize() > 0) {
                        String fileName  = extractFileName(imagePart);
                        String uploadPath = getServletContext().getRealPath("") + File.separator + "images" + File.separator + "user_" + userid + File.separator+ "user_surveys";

                        // Ensure the user-specific directory exists
                        File userSurveyDir = new File(uploadPath);
                        if (!userSurveyDir.exists()) {
                            userSurveyDir.mkdirs(); // Create the directory (including parent directories if needed)
                        }

                        imageUrl =  fileName;
                        imagePart.write(uploadPath + File.separator + fileName);
                    }

                    AnswerModel answer = new AnswerModel(0, answerText, aIndex + 1, imageUrl);
                    answers.add(answer);
                }

                question.setAnswers(answers);
                questions.add(question);
            }

            survey.setQuestions(questions);

            // Call the controller to create the survey
            boolean isTrue = controller.createSurvey(survey);

            if (isTrue) {
                // If successful, show alert and redirect (adjust the redirect URL as needed)
                String alertMessage = "Survey Created Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetAllSurveysServlet';</script>");
            } else {
                // If not successful, forward to the error page
                String alertMessage = "Failed to create survey.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
                dis.forward(request, response);
            }

        } catch (NumberFormatException e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Provide user-friendly error message
            String alertMessage = "Invalid input or database error. Please try again.";
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
            dis.forward(request, response);

        } catch (IllegalArgumentException e) {
            // Catch missing or invalid parameter exceptions
            String alertMessage = e.getMessage();
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
            dis.forward(request, response);

        } catch (Exception e) {
            // Catch unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again later.");
            RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
            dis.forward(request, response);
        }
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String content : contentDisposition.split(";")) {
                if (content.trim().startsWith("filename")) {
                    return content.substring(content.indexOf("=") + 2, content.length() - 1);
                }
            }
        }
        return null; // Return null if no filename is found
    }
}