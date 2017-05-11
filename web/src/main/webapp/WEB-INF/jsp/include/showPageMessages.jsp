<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean scope='request' id='pageMessages' class='java.util.ArrayList'/>

<%--
    该页面用于输出各类消息
    from login-alertbox.jsp
    FY 2017-4-8
--%>

<c:if test="${!empty pageMessages}">
    <c:forEach var="message" items="${pageMessages}">
        <c:out value="${message}" escapeXml="false"/>
    </c:forEach>
</c:if>
