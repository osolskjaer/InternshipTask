<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Books Page</title>

    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }
        input[type="text"],[type="number"] {
            width: 200px;
            display: block;
            padding: 10px;
            margin: 5px 0;
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
        .tg {
            background-color: #f9f9f9
        }
        .aligncenter{
             display: table-cell;
             text-align:center;
        }
        .alignleft{
            display: table-cell;
            text-align:left;
        }
        .container{overflow:hidden; width:100%;}
        .cell2{width:50%; float:left;}
        .cell3{display: table-cell; width:50%; vertical-align: middle; float:left; text-align: left;}
        .rTable { display: table; }
        .rTableRow { display: table-row; }
        .rTableCell  { display: table-cell; }
        .columns20
        {
            display: table-cell;
            width:20%;
        }
        .width33{width: 33%;}
        .float {
            display: table-cell;
            vertical-align: middle;
            text-align: left;
        }
        .full-width { width: 100%; }
    </style>
</head>
<body style="width:98vw; margin: 10px">
<div class="container rTable">
    <div class="width33 rTableCell">
        <table class="full-width">
            <tr>
                <td align="left">
                    <form action="../../index.jsp">
                        <input type="submit" value = "Back to main menu" style="height:60px; width:100%">
                    </form>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <form action="<c:url value="/edit/0"/>">
                        <input type="submit" value = "ADD A NEW BOOK" style="height:60px; width:100%; background-color:CadetBlue">
                    </form>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <c:if test="${booksCount>0}">
                        По запросу найдено ${booksCount} книг.
                    </c:if>
                </td>
            </tr>
        </table>
    </div>
    <div class="float rTableCell">
        <form action="<c:url value="/books"/>">
            <div class="rTable" style="width:420px;overflow:hidden; float: right">
                <div class="rTableRow">
                    <h2>Search</h2>
                </div>
                <div class="rTableRow">
                    <div class="cell3">Title:</div>
                    <div class="cell3"><input type="text" name="title" value=${title}></div>
                </div>
                <div class="rTableRow">
                    <div class="cell3">Author:</div>
                    <div class="cell3"><input type="text" name="author" value=${author}></div>
                </div>
                <div class="rTableRow">
                    <div class="cell3">Description:</div>
                    <div class="cell3"><input type="text" name="description" value=${description}></div>
                </div>
                <div class="rTableRow">
                    <div class="alignleft cell3">YearFrom:</div>
                    <div class="alignleft cell3"><input type="number" name="yearFrom" value=${yearFrom}></div>
                </div>
                <div class="rTableRow">
                    <div class="cell3">YearTo:</div>
                    <div class="cell3"><input type="number" name="yearTo" value=${yearTo}></div>
                </div>
                <div class="rTableRow">
                    <div class="cell3">Only Unread Books</div>
                    <c:choose>
                        <c:when test="${onlyUnread.length()==0}">
                            <div class="cell3"><input type="checkbox" name="onlyUnread" value="checked"></div>
                        </c:when>
                        <c:otherwise>
                            <div class="cell3"><input type="checkbox" name="onlyUnread" value="checked" checked = ${onlyUnread}></div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <input type="submit" value = "Поиск" style="height:50px; width:410px">
            </div>
        </form>
    </div>
</div>

<h1 align="center">Book List</h1>
<c:if test="${!empty listBooks}">
<div class="rTable full-width">
    <div class="rTableRow">
        <div class="columns20 rTable">
                <div class="cell2"><a href="/books?items=5&title=${title}&author=${author}&description=${description}&yearFrom=${yearFrom}&yearTo=${yearTo}">По 5 на странице</a></div>
                <div class="cell2"><a href="/books?items=10&title=${title}&author=${author}&description=${description}&yearFrom=${yearFrom}&yearTo=${yearTo}">По 10 на странице</a></div>
        </div>
        <div class="rTableCell" style="width: 45%"></div>
        <div class="rTableCell">
            <div class="width33 aligncenter rTableCell">
                <c:if test="${page>0}">
                    <a href="/books?page=${page-1}&title=${title}&author=${author}&description=${description}&yearFrom=${yearFrom}&yearTo=${yearTo}">Previous page</a>
                </c:if>
            </div>
            <div class="width33 aligncenter rTableCell">
                Страница ${page+1}
            </div>
            <div class="width33 aligncenter rTableCell">
                <c:if test="${empty page || page+1 < maxPages}">
                    <a href="/books?page=${page+1}&title=${title}&author=${author}&description=${description}&yearFrom=${yearFrom}&yearTo=${yearTo}">Next page</a>
                </c:if>
            </div>
        </div>
    </div>
</div>


    <table class="tg full-width">
        <tr>
            <th width="50">ID</th>
            <th width="100">Title</th>
            <th width="500">Description</th>
            <th width="100">Author</th>
            <th width="50">Year</th>
            <th width="100">ISBN</th>
            <th width="50">isRead</th>
            <th width="50">Edit</th>
            <th width="50">Delete</th>
        </tr>
        <c:forEach items="${listBooks}" var="book">
            <tr>
                <td>${book.id}</td>
                <td><a href="/bookdata/${book.id}" target="_blank">${book.bookTitle}</a></td>
                <td>${book.shortDescription}</td>
                <td>${book.bookAuthor}</td>
                <td>${book.releaseYear}</td>
                <td>${book.ISBN}</td>
                <td><br>${book.read == true ? "Yes" : "No"}
                    <c:if test="${!book.read}"> <br> <a href="<c:url value='/read/${book.id}'/>">Read</a> </c:if>
                </td>
                <td><a href="<c:url value='/edit/${book.id}'/>">Edit</a></td>
                <td><a href="<c:url value='/remove/${book.id}'/>">Delete</a></td>
            </tr>
        </c:forEach>
    </table>
</c:if>
    <c:if test="${empty listBooks}">
        We are very sorry, but we can't find a book you wanted.
    </c:if>




</body>
</html>
