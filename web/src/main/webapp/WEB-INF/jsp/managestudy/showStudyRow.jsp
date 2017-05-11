<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.terms" var="resterm"/>

<c:set var="dteFormat"><fmt:message key="date_format_string" bundle="${resformat}"/></c:set>

<jsp:useBean scope="request" id="currRow" class="org.akaza.openclinica.web.bean.DisplayStudyRow" />

<%--
    该JSP用来在studyList.jsp上显示表格
    FY 2017-4-8
--%>

<c:set var="available"><fmt:message key="available" bundle="${resterm}"/></c:set>
<c:set var="removed"><fmt:message key="removed" bundle="${resterm}"/></c:set>
<c:choose>
    <c:when test="${currRow.bean.parent.status.name eq available}">
        <c:set var="className" value="aka_green_highlight"/>
    </c:when>
    <c:when test="${currRow.bean.parent.status.name eq removed}">
        <c:set var="className" value="aka_red_highlight"/>
    </c:when>
</c:choose>
<tr>
    <td><b><c:out value="${currRow.bean.parent.name}"/></b></td>
    <td><c:out value="${currRow.bean.parent.identifier}"/></td>
    <td><c:out value="${currRow.bean.parent.oid}"/></td>
    <td><c:out value="${currRow.bean.parent.principalInvestigator}"/></td>
    <td><c:out value="${currRow.bean.parent.facilityName}"/></td>
    <td><fmt:formatDate value="${currRow.bean.parent.createdDate}" pattern="${dteFormat}"/></td>
    <td><c:out value="${currRow.bean.parent.status.name}"/></td>
    <td>
        <table>
            <tr>
                <td>
                    <a href="ViewStudy?id=<c:out value="${currRow.bean.parent.id}"/>&viewFull=yes" title="<fmt:message key="view" bundle="${resword}"/>">
                        <span class="glyphicon glyphicon-search"></span>
                    </a>
                </td>
                <td>&nbsp;&nbsp;&nbsp;</td>
                <c:choose>
                    <c:when test="${!currRow.bean.parent.status.deleted}">
                        <td>
                            <a href="RemoveStudy?action=confirm&id=<c:out value="${currRow.bean.parent.id}"/>" title="<fmt:message key="remove" bundle="${resword}"/>">
                                <span class="glyphicon glyphicon-remove"></span>
                            </a>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td>
                            <a href="RestoreStudy?action=confirm&id=<c:out value="${currRow.bean.parent.id}"/>" title="<fmt:message key="restore" bundle="${resword}"/>">
                                <span class="glyphicon glyphicon-repeat"></span>
                            </a>
                        </td>
                    </c:otherwise>
                </c:choose>
            </tr>
        </table>
    </td>
</tr>
<c:forEach var="child" items="${currRow.bean.children}">
    <%-- color-coded statuses...--%>
    <c:choose>
        <c:when test="${child.status.name eq 'available'}">
            <c:set var="className" value="green"/>
        </c:when>
        <c:when test="${child.status.name eq 'removed'}">
            <c:set var="className" value="aka_red_highlight"/>
        </c:when>
    </c:choose>
    <tr>
        <td><c:out value="${child.name}"/></td>
        <td><c:out value="${child.identifier}"/></td>
        <td><c:out value="${child.oid}"/></td>
        <td><c:out value="${child.principalInvestigator}"/></td>
        <td><c:out value="${child.facilityName}"/></td>
        <td><fmt:formatDate value="${child.createdDate}" pattern="${dteFormat}"/></td>
        <td><c:out value="${child.status.name}"/></td>
        <td>
            <table>
                <tr>
                    <td>
                        <a href="ViewSite?id=<c:out value="${child.id}"/>" title="<fmt:message key="view" bundle="${resword}"/>">
                            <span class="glyphicon glyphicon-search"></span>
                        </a>
                    </td>
                    <td>&nbsp;&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</c:forEach>
