package surveys;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
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
    private static final String UPLOAD_DIR = "uploads"; // Directory to store uploaded images
    private surveyController controller = new surveyController();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
//                    if (imagePart != null && imagePart.getSize() > 0) {
//                        String fileName = imagePart.getSubmittedFileName();
//                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
//                        File uploadDir = new File(uploadPath);
//                        if (!uploadDir.exists()) {
//                            uploadDir.mkdirs();
//                        }
//                        imageUrl = UPLOAD_DIR + File.separator + fileName;
//                        imagePart.write(uploadPath + File.separator + fileName);
//                    }

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
}