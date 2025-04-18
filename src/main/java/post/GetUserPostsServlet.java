package post;

import UserPackage.UserModel;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.System.out;

@WebServlet("/GetUserPostsServlet")
public class GetUserPostsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String userId = request.getParameter("userId");
            System.out.println("Processing request for userId: " + userId);

            List<PostModel> posts = PostController.getPostByID(userId);

            // Convert PostModel list to Map list
            List<Map<String, Object>> postMaps = new ArrayList<>();
            for (PostModel post : posts) {
                Map<String, Object> postMap = new HashMap<>();
                postMap.put("postId", post.getPostId());
                postMap.put("userId", post.getUserId());
                postMap.put("content", post.getContent());
                postMap.put("datetime", post.getDatetime() != null ? post.getDatetime().toString() : null);
                postMap.put("name", post.getName());
                postMaps.add(postMap);
            }

            ObjectMapper mapper = new ObjectMapper();
            String json = mapper.writeValueAsString(postMaps);

            out.write(json);
            out.flush();

        } catch (Exception e) {
            System.err.println("Error in servlet: " + e.getMessage());
            response.setStatus(500);
            out.write(("{\"error\":\"" + e.getMessage() + "\"}").getBytes());
            e.printStackTrace();
        }
    }
}
//    test data
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
//        response.setContentType("application/json");
//        try (PrintWriter out = response.getWriter()) {
//            // TEST: Return simple JSON
//            out.write("[{\"userId\":217,\"postId\":1,\"content\":\"Test post\",\"datetime\":\"2024-01-01 12:00:00\",\"name\":\"Test User\"}]");
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
