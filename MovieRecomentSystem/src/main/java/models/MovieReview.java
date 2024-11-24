package models;

public class MovieReview {
	private int id;
    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private int movieId;
    private String review;
    private double rating;
    
    public MovieReview () {
    	
    }

    // Constructor
    public MovieReview(int id, int movieId, String review, double rating) {
    	this.id = id;
        this.movieId = movieId;
        this.review = review;
        this.rating = rating;
    }

    // Getter and setter for movieId
    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    // Getter and setter for review
    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    // Getter and setter for rating
    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    @Override
    public String toString() {
        return "MovieReview{" +
               "movieId=" + movieId +
               ", review='" + review + '\'' +
               ", rating=" + rating +
               '}';
    }
}
