package surveys;
import UserPackage.UserModel;

import javax.servlet.http.HttpSession;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


public class surveyController {
        private final int sessionUserId;

        public surveyController(int sessionUserId) {
            this.sessionUserId = sessionUserId;
        }

        public List<SurveyModel> getAllSurveysWithQuestionsAndAnswers() {
            List<SurveyModel> surveys = new ArrayList<>();
            String surveyQuery = "SELECT * FROM survey";

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement surveyStmt = conn.prepareStatement(surveyQuery);
                 ResultSet surveyRs = surveyStmt.executeQuery()) {

                while (surveyRs.next()) {
                    int surveyId = surveyRs.getInt("survey_id");
                    String surveyTopic = surveyRs.getString("survey_topic");
                    int numberOfQuestions = surveyRs.getInt("number_of_questions");
                    int userId = surveyRs.getInt("user_id");
                    Timestamp timestamp = surveyRs.getTimestamp("created_at");
                    LocalDateTime createdAt = timestamp.toLocalDateTime();

                    SurveyModel survey = new SurveyModel(surveyId, surveyTopic, numberOfQuestions, userId,createdAt);
                    SurveyUserProfileModel surveyowner = SurveyUserProfileController.getSurveyUserProfile(userId);
                    List<SurveyUserProfileModel> ownner = new ArrayList<>();
                    ownner.add(surveyowner);
                    survey.setUser(ownner);

                    // Fetch the questions for this survey
                    String questionQuery = "SELECT * FROM question WHERE survey_id = ?";
                    try (PreparedStatement questionStmt = conn.prepareStatement(questionQuery)) {
                        questionStmt.setInt(1, surveyId);
                        ResultSet questionRs = questionStmt.executeQuery();

                        List<QuestionModel> questions = new ArrayList<>();
                        while (questionRs.next()) {
                            int questionId = questionRs.getInt("question_id");
                            String questionText = questionRs.getString("question");
                            int questionNumber = questionRs.getInt("question_number");
                            int numberOfAnswers = questionRs.getInt("number_of_answers"); // NEW

                            QuestionModel question = new QuestionModel(
                                    questionId, questionText, questionNumber, numberOfAnswers
                            );

                            // Fetch answers for this question
                            String answerQuery = "SELECT * FROM answer WHERE question_id = ?";
                            try (PreparedStatement answerStmt = conn.prepareStatement(answerQuery)) {
                                answerStmt.setInt(1, questionId);
                                ResultSet answerRs = answerStmt.executeQuery();

                                List<AnswerModel> answers = new ArrayList<>();
                                while (answerRs.next()) {
                                    int answerId = answerRs.getInt("answer_id");
                                    String answerText = answerRs.getString("answer");
                                    int answerNumber = answerRs.getInt("answer_number");
                                    String imageUrl = answerRs.getString("image_url");
                                    int numberOfVotes = answerRs.getInt("number_of_votes");

                                    AnswerModel answer = new AnswerModel(answerId, answerText, answerNumber, imageUrl);
                                    answer.setNumberOfVotes(numberOfVotes);
                                    answers.add(answer);
                                }

                                question.setAnswers(answers);
                            }

                             // get user voting
                            String userVoteQuery = "SELECT answer_id FROM response WHERE survey_id = ? AND question_id = ? AND user_id = ?";
                            try (PreparedStatement userVoteStmt = conn.prepareStatement(userVoteQuery)) {
                                userVoteStmt.setInt(1, surveyId);
                                userVoteStmt.setInt(2, questionId);
                                userVoteStmt.setInt(3, sessionUserId);
                                ResultSet userVoteRs = userVoteStmt.executeQuery();

                                List<UserVoteModel> userVotes = new ArrayList<>();
                                while (userVoteRs.next()) {
                                    int answerId = userVoteRs.getInt("answer_id");
                                    int answerNumber = getAnswerNumberById(answerId);
                                    UserVoteModel userVote = new UserVoteModel(sessionUserId, answerId, answerNumber);
                                    userVotes.add(userVote);
                                }
                                question.setUserVotes(userVotes);
                            }

                            questions.add(question);
                        }

                        survey.setQuestions(questions);
                    }

                    surveys.add(survey);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            return surveys;
        }
    // Helper method to get answerNumber by answerId
    private int getAnswerNumberById(int answerId) {
        String query = "SELECT answer_number FROM answer WHERE answer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, answerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("answer_number");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if not found
    }

    public List<SurveyModel> getSurveysOfUser(int userId) {
        // Get all surveys (including questions and answers)
        List<SurveyModel> allSurveys = getAllSurveysWithQuestionsAndAnswers();

        // Filter surveys created by the given user
        List<SurveyModel> userSurveys = new ArrayList<>();

        for (SurveyModel survey : allSurveys) {
            if (survey.getUserId() == userId) {
                userSurveys.add(survey);  // Add survey to userSurveys if created by this user
            }
        }

        return userSurveys;  // Return the filtered list
    }

    public List<SurveyModel> getAllSurveysByModeratorsAndAdmins() {
        List<SurveyModel> allSurveys = new ArrayList<>();
        String userQuery = "SELECT user_id FROM users WHERE user_type IN ('Admin', 'Moderator')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(userQuery)) {

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int userId = rs.getInt("user_id");
                List<SurveyModel> userSurveys = getSurveysOfUser(userId);
                allSurveys.addAll(userSurveys);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return allSurveys;
    }

    public SurveyModel getSurveyById(int surveyId) {
        // You can call getAllSurveysWithQuestionsAndAnswers() and filter
        for (SurveyModel s : getAllSurveysWithQuestionsAndAnswers()) {
            if (s.getSurveyId() == surveyId) return s;
        }
        return null;
    }

    public List<SurveyModel> searchSurveys(String keyword) {
        List<SurveyModel> matchedSurveys = new ArrayList<>();

        String query =
                "SELECT DISTINCT s.survey_id " +
                        "FROM survey s " +
                        "JOIN users u ON s.user_id = u.user_id " +
                        "LEFT JOIN question q ON s.survey_id = q.survey_id " +
                        "LEFT JOIN answer a ON q.question_id = a.question_id " +
                        "WHERE " +
                        "s.survey_topic ILIKE ? OR " +
                        "u.username ILIKE ? OR " +
                        "q.question ILIKE ? OR " +
                        "a.answer ILIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            String searchPattern = "%" + keyword + "%";
            for (int i = 1; i <= 4; i++) {
                stmt.setString(i, searchPattern);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int surveyId = rs.getInt("survey_id");
                SurveyModel survey = getSurveyById(surveyId); // You should implement or already have this
                if (survey != null) {
                    matchedSurveys.add(survey);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return matchedSurveys;
    }

    public List<SurveyModel> searchSurveysByUser(int userId, String keyword) {
        List<SurveyModel> matchedSurveys = new ArrayList<>();

        String query =
                "SELECT DISTINCT s.survey_id " +
                        "FROM survey s " +
                        "JOIN users u ON s.user_id = u.user_id " +
                        "LEFT JOIN question q ON s.survey_id = q.survey_id " +
                        "LEFT JOIN answer a ON q.question_id = a.question_id " +
                        "WHERE s.user_id = ? AND ( " +
                        "s.survey_topic ILIKE ? OR " +
                        "u.username ILIKE ? OR " +
                        "q.question ILIKE ? OR " +
                        "a.answer ILIKE ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            String keywordPattern = "%" + keyword + "%";
            stmt.setInt(1, userId);
            stmt.setString(2, keywordPattern);
            stmt.setString(3, keywordPattern);
            stmt.setString(4, keywordPattern);
            stmt.setString(5, keywordPattern);

            ResultSet rs = stmt.executeQuery();

            List<Integer> surveyIds = new ArrayList<>();
            while (rs.next()) {
                surveyIds.add(rs.getInt("survey_id"));
            }

            // Fetch the full survey data using existing method
            List<SurveyModel> allSurveys = getAllSurveysWithQuestionsAndAnswers();
            for (SurveyModel survey : allSurveys) {
                if (surveyIds.contains(survey.getSurveyId())) {
                    matchedSurveys.add(survey);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return matchedSurveys;
    }


    public SurveyModel getSurveyWithQuestionsAndAnswersById(int surveyId) {
        for (SurveyModel survey : getAllSurveysWithQuestionsAndAnswers()) {
            if (survey.getSurveyId() == surveyId) {
                return survey;
            }
        }
        return null;
    }


    public List<SurveyModel> searchParlimateSurveys(String keyword) {
        List<SurveyModel> surveys = new ArrayList<>();

        String query =
                "SELECT DISTINCT s.survey_id " +
                        "FROM survey s " +
                        "JOIN users u ON s.user_id = u.user_id " +
                        "LEFT JOIN question q ON s.survey_id = q.survey_id " +
                        "LEFT JOIN answer a ON q.question_id = a.question_id " +
                        "WHERE (u.user_type = 'Admin' OR u.user_type = 'Moderator') AND ( " +
                        "s.survey_topic ILIKE ? OR " +
                        "u.username ILIKE ? OR " +
                        "q.question ILIKE ? OR " +
                        "a.answer ILIKE ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            String keywordPattern = "%" + keyword + "%";
            stmt.setString(1, keywordPattern);
            stmt.setString(2, keywordPattern);
            stmt.setString(3, keywordPattern);
            stmt.setString(4, keywordPattern);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int surveyId = rs.getInt("survey_id");
                // You already have this method to fetch full details:
                SurveyModel survey = getSurveyWithQuestionsAndAnswersById(surveyId);
                if (survey != null) {
                    surveys.add(survey);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return surveys;
    }

    public boolean createSurvey(SurveyModel survey) {
        String insertSurvey = "INSERT INTO survey (survey_topic, number_of_questions, user_id) VALUES (?, ?, ?) RETURNING survey_id";
        String insertQuestion = "INSERT INTO question (question, question_number, number_of_answers, survey_id) VALUES (?, ?, ?, ?) RETURNING question_id";
        String insertAnswer = "INSERT INTO answer (answer, answer_number, image_url, question_id) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // Insert survey
            int surveyId;
            try (PreparedStatement surveyStmt = conn.prepareStatement(insertSurvey)) {
                surveyStmt.setString(1, survey.getSurveyTopic());
                surveyStmt.setInt(2, survey.getNumberOfQuestions());
                surveyStmt.setInt(3, sessionUserId);

                ResultSet rs = surveyStmt.executeQuery();
                if (rs.next()) {
                    surveyId = rs.getInt("survey_id");
                } else {
                    conn.rollback();
                    return false;
                }
            }

            // Insert questions
            for (QuestionModel q : survey.getQuestions()) {
                int questionId;
                try (PreparedStatement questionStmt = conn.prepareStatement(insertQuestion)) {
                    questionStmt.setString(1, q.getQuestionText());
                    questionStmt.setInt(2, q.getQuestionNumber());
                    questionStmt.setInt(3, q.getNumberOfAnswers());
                    questionStmt.setInt(4, surveyId);

                    ResultSet rs = questionStmt.executeQuery();
                    if (rs.next()) {
                        questionId = rs.getInt("question_id");
                    } else {
                        conn.rollback();
                        return false;
                    }
                }

                // Insert answers
                for (AnswerModel a : q.getAnswers()) {
                    try (PreparedStatement answerStmt = conn.prepareStatement(insertAnswer)) {
                        answerStmt.setString(1, a.getAnswerText());
                        answerStmt.setInt(2, a.getAnswerNumber());
                        answerStmt.setString(3, a.getImageUrl());
                        answerStmt.setInt(4, questionId);
                        answerStmt.executeUpdate();
                    }
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteSurvey(int surveyId) {
        String deletePercentage = "DELETE FROM percentage WHERE answer_id IN (SELECT answer_id FROM answer WHERE question_id IN (SELECT question_id FROM question WHERE survey_id = ?))";
        String deleteResponses = "DELETE FROM response WHERE survey_id = ?";
        String deleteAnswers = "DELETE FROM answer WHERE question_id IN (SELECT question_id FROM question WHERE survey_id = ?)";
        String deleteQuestions = "DELETE FROM question WHERE survey_id = ?";
        String deleteSurvey = "DELETE FROM survey WHERE survey_id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement p1 = conn.prepareStatement(deletePercentage);
                 PreparedStatement p2 = conn.prepareStatement(deleteResponses);
                 PreparedStatement p3 = conn.prepareStatement(deleteAnswers);
                 PreparedStatement p4 = conn.prepareStatement(deleteQuestions);
                 PreparedStatement p5 = conn.prepareStatement(deleteSurvey)) {

                p1.setInt(1, surveyId);
                p1.executeUpdate();

                p2.setInt(1, surveyId);
                p2.executeUpdate();

                p3.setInt(1, surveyId);
                p3.executeUpdate();

                p4.setInt(1, surveyId);
                p4.executeUpdate();

                p5.setInt(1, surveyId);
                p5.executeUpdate();

                conn.commit();
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateSurvey(SurveyModel survey) {
        deleteSurvey(survey.getSurveyId());
        return createSurvey(survey);
    }

}

