package bookmanager.service;

import bookmanager.model.Book;

import java.util.List;

public interface BookService {

     void addBook(Book book);

     void updateBook(Book book);

     void removeBook(int id);

     void setAsRead(Book book);

     Book getBookById(int id);

     List<Book> listBooks();
}
