package bookmanager.model;

import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;

@Entity
@DynamicUpdate
@Table(name = "BOOK")
public class Book {

    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "title")
    private String bookTitle;

    @Column(name = "description")
    private String bookDescription;

    @Column(name = "author")
    private String bookAuthor;

    @Column(name = "ISBN")
    private String ISBN;

    @Column(name = "printYear")
    private int releaseYear;

    @Column(name = "readAlready")
    private boolean isRead;
    @Transient
    private int shortDescriptionLength = 400;

    public int getShortDescriptionLength() {
        return shortDescriptionLength;
    }

    public String getShortDescription()
    {
        if (bookDescription == null) return new String("");
        if (bookDescription.length() > shortDescriptionLength) {
            String shortDescription = bookDescription.substring(0, shortDescriptionLength);
            return shortDescription.substring(0, shortDescription.lastIndexOf(" ")).concat("...");
        }
        else return bookDescription;
    }
    public void setShortDescriptionLength(int shortDescriptionLength) {
        this.shortDescriptionLength = shortDescriptionLength;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getBookAuthor() {
        return bookAuthor;
    }

    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }

    public String getBookDescription() {
        return bookDescription;
    }

    public void setBookDescription(String bookDescription) {
        this.bookDescription = bookDescription;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean read) {
        isRead = read;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", bookTitle='" + bookTitle + '\'' +
                ", bookDescription='" + bookDescription + '\'' +
                ", bookAuthor='" + bookAuthor + '\'' +
                ", ISBN='" + ISBN + '\'' +
                ", releaseYear=" + releaseYear +
                ", isRead=" + isRead +
                '}';
    }
}
