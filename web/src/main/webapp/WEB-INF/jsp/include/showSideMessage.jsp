<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.page_messages" var="resmessages"/>

<jsp:useBean scope='request' id='pageMessages' class='java.util.ArrayList'/>

<%--
    用于输出sideAlet中的信息
    from sideAlert.jsp
    FY 2017-4-8
--%>

<c:if test="${!empty pageMessages}">
    <c:forEach var="message" items="${pageMessages}">
        <c:out value="${message}" escapeXml="false"/>
    </c:forEach>
</c:if>

<c:if test="${empty pageMessages && param.alertmessage!=null  }">
    <c:out value="${param.alertmessage}" escapeXml="false"/>
</c:if>

<c:if test="${param.message == 'authentication_failed'}">
    <fmt:message key="no_have_correct_privilege_current_study" bundle="${resmessages}"/>
    <fmt:message key="change_study_contact_sysadmin" bundle="${resmessages}"/>
</c:if>

