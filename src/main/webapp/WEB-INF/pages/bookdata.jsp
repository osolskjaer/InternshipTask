<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>

<html>
<head>
  <title>BookData</title>

  <style type="text/css">
    .tg {
      border-collapse: collapse;
      border-spacing: 0;
      border-color: #ccc;
    }

    .tg td {
      font-family: Arial, sans-serif;
      font-size: 14px;
      padding: 10px 5px;
      border-style: solid;
      border-width: 1px;
      overflow: hidden;
      word-break: normal;
      border-color: #ccc;
      color: #333;
      background-color: #fff;
    }

    .tg th {
      font-family: Arial, sans-serif;
      font-size: 14px;
      font-weight: normal;
      padding: 10px 5px;
      border-style: solid;
      border-width: 1px;
      overflow: hidden;
      word-break: normal;
      border-color: #ccc;
      color: #333;
      background-color: #f0f0f0;
    }

  </style>

</head>
<body>
<h1>Book Details</h1>

<table class="tg full-width">
  <tr>
    <th width="50">ID</th>
    <th width="100">Title</th>
    <th width="500">Description</th>
    <th width="100">Author</th>
    <th width="50">Year</th>
    <th width="100">ISBN</th>
    <th width="50">isRead</th>
  </tr>
    <tr>
      <td>${book.id}</td>
      <td>${book.bookTitle}</td>
      <td>${book.bookDescription}</td>
      <td>${book.bookAuthor}</td>
      <td>${book.releaseYear}</td>
      <td>${book.ISBN}</td>
      <td><br>${book.read == true ? "Yes" : "No"}
      </td>
    </tr>
</table>
<br>
<table>
  <tr>
    <td align="left">
      <form action="/books">
        <input type="submit" value = "Back to library" style="height:60px; width:300px">
      </form>
    </td>
    <td align="left">
      <c:if test="${!book.read}">
        <form action="/read/${book.id}">
          <input type="submit" value = "I've read this book" style="height:60px; width:300px">
        </form>
      </c:if>
    </td>
  </tr>
</table>
</body>
</html>