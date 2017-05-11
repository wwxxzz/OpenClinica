<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.terms" var="resterm"/>
<jsp:useBean scope="request" id="currRow" class="org.akaza.openclinica.web.bean.UserAccountRow" />

<%--
    该JSP用来在listuseraccounts.jsp上显示表格
    FY 2017-4-8
--%>

<tr>
    <c:choose>
        <c:when test='${currRow.bean.status.deleted}'>
            <td style="color:red;"><c:out value="${currRow.bean.name}" /></td>
        </c:when>
        <c:otherwise>
            <td><c:out value="${currRow.bean.name}" /></td>
        </c:otherwise>
    </c:choose>
    <td><c:out value="${currRow.bean.firstName}" /></td>
    <td><c:out value="${currRow.bean.lastName}" /></td>
    <td><c:out value="${currRow.bean.status.name}" /></td>

    <%-- ACTIONS --%>
    <td>
        <table>
            <tr>
                <c:choose>
                    <c:when test='${(currRow.bean.techAdmin && !(userBean.techAdmin))}'>
                        <%-- put in grayed-out buttons here? --%>
                        <%--<td><img src="images/bt_Remove_i.gif" alt="Access denied" title="Access denied"></img></td>
                        <td><img src="images/bt_Remove_i.gif" alt="Access denied" title="Access denied"></img></td>
                        <td><img src="images/bt_Remove_i.gif" alt="Access denied" title="Access denied"></img></td> --%>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test='${currRow.bean.status.deleted}'>
                                <c:set var="confirmQuestion">
                                    <fmt:message key="are_you_sure_you_want_to_restore" bundle="${resword}">
                                        <fmt:param value="${currRow.bean.name}"/>
                                    </fmt:message>
                                </c:set>
                                <c:set var="onClick" value="return confirm('${confirmQuestion}');"/>
                                <td>
                                    <a href="DeleteUser?action=4&userId=<c:out value="${currRow.bean.id}"/>" onClick="<c:out value="${onClick}" />" title="<fmt:message key="restore" bundle="${resword}"/>">
                                        <span class="glyphicon glyphicon-repeat"></span>
                                    </a>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td>
                                    <a href="ViewUserAccount?userId=<c:out value="${currRow.bean.id}"/>" title="<fmt:message key="view" bundle="${resword}"/>">
                                        <span class="glyphicon glyphicon-search"></span>
                                    </a>
                                </td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td>
                                    <a href="EditUserAccount?userId=<c:out value="${currRow.bean.id}"/>" title="<fmt:message key="edit" bundle="${resword}"/>">
                                        <span class="glyphicon glyphicon-pencil"></span>
                                    </a>
                                </td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td>
                                    <a href="SetUserRole?action=confirm&userId=<c:out value="${currRow.bean.id}"/>" title="<fmt:message key="set_role" bundle="${resword}"/>">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </a>
                                </td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <c:set var="confirmQuestion">
                                    <fmt:message key="are_you_sure_you_want_to_remove" bundle="${resword}">
                                        <fmt:param value="${currRow.bean.name}"/>
                                    </fmt:message>
                                </c:set>
                                <c:set var="onClick" value="return confirm('${confirmQuestion}');"/>
                                <td>
                                    <a href="DeleteUser?action=3&userId=<c:out value="${currRow.bean.id}"/>" onClick="<c:out value="${onClick}" />" title="<fmt:message key="remove" bundle="${resword}"/>">
                                        <span class="glyphicon glyphicon-remove"></span>
                                    </a>
                                </td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <c:if test='${currRow.bean.status.locked}'>
                                    <td>
                                        <a href="UnLockUser?userId=<c:out value="${currRow.bean.id}"/>" title="<fmt:message key="unlock" bundle="${resword}"/>">
                                            <span class="glyphicon glyphicon-lock"></span>
                                        </a>
                                    </td>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </tr>
        </table>
    </td>
</tr>
<%--<c:choose>
		<c:when test='${(currRow.bean.techAdmin && !(userBean.techAdmin))}'>
		</c:when>
		<c:otherwise>--%>
<%-- start test for tech admin above here --%>
<c:choose>
    <c:when test="${empty currRow.bean.roles}">
        <tr>
            <td>&nbsp;</td>
            <td colspan="3"><fmt:message key="no_roles_assigned" bundle="${resword}"/></td>
            <td>&nbsp;</td>
        </tr>
    </c:when>
    <c:otherwise>
        <c:forEach var="sur" items="${currRow.bean.roles}">
            <c:choose>
                <c:when test='${sur.studyName != ""}'>
                    <c:set var="study" value="${sur.studyName}" />
                </c:when>
                <c:otherwise>
                    <c:set var="study" value="Study ${sur.studyId}" />
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test='${sur.status.deleted}'>
                    <c:set var="actionName" >
                        <fmt:message key="restore" bundle="${resword}"/>
                    </c:set>
                    <c:set var="actionId" value="4" />
                </c:when>
                <c:otherwise>
                    <c:set var="actionName">
                        <fmt:message key="delete" bundle="${resword}"/>
                    </c:set>
                    <c:set var="actionId" value="3" />
                </c:otherwise>
            </c:choose>
            <c:set var="confirmQuestion">
                <fmt:message key="are_you_want_to_the_role_for" bundle="${restext}">
                    <fmt:param value="${actionName}"/>
                    <fmt:param value="${sur.role.description}"/>
                    <fmt:param value="${study}"/>
                </fmt:message>
            </c:set>
            <c:set var="onClick" value="return confirm('${confirmQuestion}');"/>
            <tr>
                <td>&nbsp;</td>
                <td colspan="3" >
                    <c:if test='${sur.status.deleted}'>
                    <font color='red'>
                        </c:if>
                        <c:choose>
                            <c:when test='${sur.studyName != ""}'>
                                <c:out value="${sur.studyName}" />
                            </c:when>
                            <c:otherwise>
                                Study <c:out value="${sur.studyId}" />
                            </c:otherwise>
                        </c:choose>
                        -
                        <c:if test="${sur.parentStudyId > 0}">
                            <fmt:message key="${siteRoleMap[sur.role.id] }" bundle="${resterm}"/>
                        </c:if>
                        <c:if test="${sur.parentStudyId == 0}">
                            <fmt:message key="${studyRoleMap[sur.role.id] }" bundle="${resterm}"/>
                        </c:if>
                        <c:if test='${sur.status.deleted}'>
                    </font>
                    </c:if>
                </td>
                <td>
                    <c:if test='${!sur.status.deleted}'>
                        <a href="EditStudyUserRole?studyId=<c:out value="${sur.studyId}" />&userName=<c:out value="${currRow.bean.name}"/>" title="<fmt:message key="edit" bundle="${resword}"/>">
                            <span name="bt_Edit1" class="glyphicon glyphicon-pencil"></span>
                        </a>&nbsp;
                    </c:if>
                    <c:choose>
                        <c:when test='${sur.status.deleted}'>
                            <a href="DeleteStudyUserRole?studyId=<c:out value="${sur.studyId}" />&userName=<c:out value="${currRow.bean.name}"/>&action=4" onClick="<c:out value="${onClick}" />" title="<fmt:message key="restore" bundle="${resword}"/>">
                                <span name="bt_Restore3" class="glyphicon glyphicon-repeat"></span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="DeleteStudyUserRole?studyId=<c:out value="${sur.studyId}" />&userName=<c:out value="${currRow.bean.name}"/>&action=3" onClick="<c:out value="${onClick}" />" title="<fmt:message key="remove" bundle="${resword}"/>">
                                <span name="bt_Remove3" class="glyphicon glyphicon-remove"></span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </c:otherwise>
    <%-- end test of tech admin below here --%>
</c:choose>
<%--</c:otherwise>
</c:choose> --%>
