<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<html>
<head>
    <title>Books Page</title>

    <style type="text/css">

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
<form action="/books">
    <input type="submit" value = "Back to main menu" style="height:60px; width:300px">
</form>

<c:url var="addAction" value="/books/add"/>

<form:form action="${addAction}" commandName="book" accept-charset="UTF-8">
    <table>
        <form:input path="read" type="hidden" value="false"/>

        <c:if test="${!empty book.bookTitle}">
            <tr>
                <td>
                    <form:label path="id">
                        <spring:message text="ID"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="id" readonly="true" size="8"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="bookAuthor">
                    <spring:message text="Author"/>
                </form:label>
            </td>
            <td>
                <c:choose>
                    <c:when test="${empty book.bookTitle}">
                        <form:input path="bookAuthor"/>
                    </c:when>
                    <c:otherwise>
                        <form:input path="bookAuthor" readonly="true" value="${book.bookAuthor}"/>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="bookTitle">
                    <spring:message text="Title"/>
                </form:label>
            </td>
            <td>
                <form:input path="bookTitle"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="releaseYear">
                    <spring:message text="Year Of Release"/>
                </form:label>
            </td>
            <td>
                <form:input path="releaseYear"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="ISBN">
                    <spring:message text="ISBN"/>
                </form:label>
            </td>
            <td>
                <form:input path="ISBN"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="bookDescription">
                    <spring:message text="Description"/>
                </form:label>
            </td>
            <td>
                <form:textarea path="bookDescription" rows="10" cols="100" />
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <c:choose>
                    <c:when test="${empty book.bookTitle}">
                        <input type="submit" style="height:60px; width:300px"
                               value="<spring:message text="Add Book"/>"/>
                    </c:when>
                    <c:otherwise>
                        <input type="submit" style="height:60px; width:300px"
                               value="<spring:message text="Edit Book"/>"/>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>
</form:form>

</body>
</html>
