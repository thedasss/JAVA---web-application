package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import controllers.PaymentController;
import controllers.SiteUserController;
import models.Payment;
import models.SiteUser;

@WebServlet("/payments")
public class PaymentServlet extends HttpServlet {

    private PaymentController paymentController = new PaymentController();

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
                    deletePayment(request, response);
                    break;
                case "list":
                default:
                    listPayments(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error handling payment actions", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "add":
                    addPayment(request, response);
                    break;
                case "new":
                    makePayment(request, response);
                    break;
                case "edit":
                    updatePayment(request, response);
                    break;
                default:
                    response.sendRedirect("payments?action=list");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error posting payment data", e);
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the JSP form for adding a new payment
        request.getRequestDispatcher("/new-payment-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int paymentID = Integer.parseInt(request.getParameter("id"));
        Payment existingPayment = paymentController.getPayment(paymentID);
        request.setAttribute("payment", existingPayment);
        // Forward to the JSP form for editing the payment
        request.getRequestDispatcher("/edit-payment-form.jsp").forward(request, response);
    }

    private void addPayment(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	SiteUserController userController =new SiteUserController();
    	
       
        SiteUser user  =userController.getUserByEmail(request.getParameter("userId"));
        String fullName = user.getFirstName() + " " + user.getLastName();
        String email = user.getEmail();
        String cardNo = request.getParameter("cardNo");
        String bankName = request.getParameter("bankName");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Payment newPayment = new Payment(0, user.getUserID(), fullName, email, cardNo, bankName, amount);
        paymentController.addPayment(newPayment);
        response.sendRedirect("movies?action=user");
    }

    private void makePayment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int siteUserID = Integer.parseInt(request.getParameter("siteUserID"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String cardNo = request.getParameter("cardNo");
        String bankName = request.getParameter("bankName");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Payment newPayment = new Payment(0, siteUserID, fullName, email, cardNo, bankName, amount);
        paymentController.addPayment(newPayment);
        response.sendRedirect("movies?action=user");
    }
    
    private void updatePayment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int paymentID = Integer.parseInt(request.getParameter("paymentID"));
        int siteUserID = Integer.parseInt(request.getParameter("siteUserID"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String cardNo = request.getParameter("cardNo");
        String bankName = request.getParameter("bankName");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Payment payment = new Payment(paymentID, siteUserID, fullName, email, cardNo, bankName, amount);
        paymentController.updatePayment(payment);
        response.sendRedirect("payments?action=list");
    }

    private void deletePayment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int paymentID = Integer.parseInt(request.getParameter("id"));
        paymentController.deletePayment(paymentID);
        response.sendRedirect("payments?action=list");
    }

    private void listPayments(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Payment> payments = paymentController.getAllPayments();
        request.setAttribute("payments", payments);
        
        request.getRequestDispatcher("/payment-list.jsp").forward(request, response);
    }
}
