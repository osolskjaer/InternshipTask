package bookmanager.controller;

import bookmanager.model.Book;
import bookmanager.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Iterator;
import java.util.List;

@Controller
public class BookController {
    private BookService bookService;
    private int itemsOnPage = 10;
    private int maxPages = 0;
    @Autowired(required = true)
    @Qualifier(value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    private List<Book> currentPageBookList(int pageNumber, List<Book> fullList)
    {
        List<Book> sublist;
        maxPages = fullList.size()/itemsOnPage;
        if (fullList.size()%itemsOnPage != 0) maxPages++;
        if (itemsOnPage*(pageNumber+1) >= fullList.size())
        {
            sublist = fullList.subList(itemsOnPage* pageNumber, fullList.size());
        }
        else sublist = fullList.subList(itemsOnPage*pageNumber, itemsOnPage*(pageNumber+1));
        return sublist;
    }

    @RequestMapping(value = "/books")
    public String searchResult(@RequestParam(value = "items", required = false, defaultValue = "0") int items, @RequestParam(value = "page", required = false, defaultValue = "0") int page,
                               @RequestParam(value = "title", required = false) String title,               @RequestParam(value = "author", required = false) String author,
                               @RequestParam(value = "description", required = false) String description,   @RequestParam(value = "yearFrom", required = false, defaultValue = "1900") Integer yearFrom,
                               @RequestParam(value = "yearTo", required = false, defaultValue = "2017") Integer yearTo, @RequestParam(value = "onlyUnread", required = false, defaultValue = "") String onlyUnread,
                               Model model){
        if (items != 0) itemsOnPage = items;
        model.addAttribute("book", new Book());
        List<Book> booksList = this.bookService.listBooks();
        if (booksList.size() > 0) {
            Iterator<Book> i = booksList.iterator();
            while (i.hasNext()) {
                Book book = i.next();
                if ((title != null && title.length() > 0 && !book.getBookTitle().toLowerCase().contains(title.toLowerCase())) ||
                    (author != null && author.length() > 0 && !book.getBookAuthor().toLowerCase().contains(author.toLowerCase())) ||
                    (description != null && description.length() > 0 && !book.getBookDescription().toLowerCase().contains(description.toLowerCase())) ||
                    (onlyUnread.equals("checked") && book.isRead() == true) ||
                    (book.getReleaseYear() < yearFrom || book.getReleaseYear() > yearTo))
                        i.remove();
            }
        }
        if (booksList.size() > 0)
        {
            model.addAttribute("booksCount", booksList.size());
            booksList = currentPageBookList(page, booksList);
        }

        model.addAttribute("maxPages", maxPages);
        model.addAttribute("listBooks", booksList);
        model.addAttribute("author", author);
        model.addAttribute("title", title);
        model.addAttribute("description", description);
        model.addAttribute("yearFrom", yearFrom);
        model.addAttribute("yearTo", yearTo);
        model.addAttribute("page", page);
        model.addAttribute("onlyUnread", onlyUnread);
        return "books";
    }

    @RequestMapping(value = "/books/add", method = RequestMethod.POST)
    public String addBook(@ModelAttribute("book") Book book){
        System.out.println(book);
        if(book.getId() == 0){
            this.bookService.addBook(book);
        }else {
            this.bookService.updateBook(book);
        }
        return "redirect:/books";
    }

    @RequestMapping("/remove/{id}")
    public String removeBook(@PathVariable("id") int id){
        this.bookService.removeBook(id);

        return "redirect:/books";
    }

    @RequestMapping("edit/{id}")
    public String editBook(@PathVariable("id") int id, Model model){
        if (id != 0)
        model.addAttribute("book", this.bookService.getBookById(id));
        else model.addAttribute("book", new Book());

        return "edit";
    }

    @RequestMapping("/read/{id}")
    public String setAsRead(@PathVariable("id") int id)
    {
        this.bookService.setAsRead(this.bookService.getBookById(id));
        return "redirect:/books";
    }
    @RequestMapping("bookdata/{id}")
    public String bookData(@PathVariable("id") int id, Model model){
        model.addAttribute("book", this.bookService.getBookById(id));

        return "bookdata";
    }
}
