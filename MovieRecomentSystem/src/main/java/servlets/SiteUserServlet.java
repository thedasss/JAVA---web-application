package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import controllers.SiteUserController;
import models.SiteUser;

@WebServlet("/users")
public class SiteUserServlet extends HttpServlet {

    private SiteUserController siteUserController = new SiteUserController();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteSiteUser(request, response);
                    break;
                case "list":
                default:
                    listSiteUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error handling user actions", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        System.out.println("action "+action);

        try {
            switch (action) {
                case "add":
                	addSiteUser(request, response);
                  
                    break;
                    
                case "login":
                	loginUser(request, response);
                    break;
                case "edit":
                    updateSiteUser(request, response);
                    break;
                default:
                    response.sendRedirect("users?action=list");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error posting user data", e);
        }
    }
    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Call the login method in the SiteUserController
        SiteUser loggedInUser = siteUserController.login(username, password);

        if (loggedInUser != null) {
            // If login successful, store the user object in session and redirect to dashboard
            request.getSession().setAttribute("loggedInUser", loggedInUser.getEmail());
            response.sendRedirect("movies?action=user"); // Change the redirect URL to your dashboard page
        } else {
            // If login fails, show an error message or redirect back to login page with an error parameter
            response.sendRedirect("login.jsp?error=1"); // Change the redirect URL to your login page
        }
    }
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        jakarta.servlet.RequestDispatcher dispatcher = request.getRequestDispatcher("/user-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 String email = (String) request.getSession().getAttribute("loggedInUser");
        SiteUser existingUser = siteUserController.getUserByEmail(email);
        request.setAttribute("user", existingUser);
        jakarta.servlet.RequestDispatcher dispatcher = request.getRequestDispatcher("/userprofile.jsp");
        dispatcher.forward(request, response);
    }

    private void addSiteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        SiteUser newUser = new SiteUser(0, firstName, lastName, email, phone, username, password);
        siteUserController.addUser(newUser);
        if(request.getParameter("from") !=null) {
        	request.getSession().setAttribute("loggedInUser", newUser.getEmail());
        	 response.sendRedirect("movies?action=user");
        }else {
        	 response.sendRedirect("users?action=list");
        }
    }

    private void updateSiteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        SiteUser user = new SiteUser(userID, firstName, lastName, email, phone, username, password);
        siteUserController.updateUser(user);
        if(request.getParameter("from") !=null) {
        	 response.getWriter().println("<script>alert('Redirecting to edit page...');</script>");
             
        	response.sendRedirect("users?action=edit");
        }else {
        	response.sendRedirect("users?action=list");
        }
    }

    private void deleteSiteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        siteUserController.deleteUser(userID);
        if(request.getParameter("from")!=null) {
           	response.sendRedirect("logout.jsp");
        }else {
        	response.sendRedirect("users?action=list");
        }
    }

    private void listSiteUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<SiteUser> users = siteUserController.getAllUsers();
        request.setAttribute("users", users);
        jakarta.servlet.RequestDispatcher dispatcher = request.getRequestDispatcher("/users-list.jsp");
        dispatcher.forward(request, response);
    }
}
