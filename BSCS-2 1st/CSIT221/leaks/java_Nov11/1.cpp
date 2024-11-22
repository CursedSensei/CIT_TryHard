// Start typing your code

public class Book {
    private String title;
    private String author;
    private double price;
    private String genre;
    
    public Book(String title, String author, double price, String genre) {
        this.title = title;
        this.author = author;
        this.price = price;
        this.genre = genre.toLowerCase();
    }
    
    public String getTitle() {
        return title;
    }
    public String getAuthor() {
        return author;
    }
    public double getPrice() {
        return price;
    }
    public String getGenre() {
        return genre;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    public void setAuthor(String author) {
        this.author = author;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public void setGenre(String genre) {
        this.genre = genre.toLowerCase();
    }
    
    @Override
    public String toString() {
        return String.format("Book (%s) by %s - P%.2f - %s", title, author, price, genre.toLowerCase());
    }
}