package models;

public class Payment {
    private int paymentID;
    private int siteUserID;
    private String fullName;
    private String email;
    private String cardNo;
    private String bankName;
    private double amount;

    // Constructors
    public Payment() {
    }

    public Payment(int paymentID, int siteUserID, String fullName, String email, String cardNo, String bankName, double amount) {
        this.paymentID = paymentID;
        this.siteUserID = siteUserID;
        this.fullName = fullName;
        this.email = email;
        this.cardNo = cardNo;
        this.bankName = bankName;
        this.amount = amount;
    }

    // Getters and Setters
    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public int getSiteUserID() {
        return siteUserID;
    }

    public void setSiteUserID(int siteUserID) {
        this.siteUserID = siteUserID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}
