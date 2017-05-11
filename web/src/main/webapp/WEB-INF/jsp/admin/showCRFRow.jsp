<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>

<jsp:useBean scope="request" id="currRow" class="org.akaza.openclinica.web.bean.ListCRFRow" />

<%--
    该JSP用来在listCRF.jsp上显示表格
    FY 2017-4-9
--%>

<c:set var="count" value="${currRow.bean.versionNumber}"/>
<c:set var="count" value="${count+1}"/>
<c:set var="dteFormat"><fmt:message key="date_format_string" bundle="${resformat}"/></c:set>
<c:choose>
    <c:when test="${currRow.bean.status.name eq 'available'}">
        <c:set var="className" value="text-success"/>
    </c:when>
    <c:when test="${currRow.bean.status.name eq 'removed'}">
        <c:set var="className" value="text-danger"/>
    </c:when>
</c:choose>
<tr>
    <td rowspan="<c:out value="${count}"/>"><c:out value="${currRow.bean.name}"/></td>
    <td rowspan="<c:out value="${count}"/>"><fmt:formatDate value="${currRow.bean.updatedDate}" pattern="${dteFormat}"/></td>
    <td rowspan="<c:out value="${count}"/>"><c:out value="${currRow.bean.updater.name}"/></td>
    <td rowspan="<c:out value="${count}"/>"><c:out value="${currRow.bean.oid}"/></td>
    <td><fmt:message key="original" bundle="${resword}"/></td>
    <%--oid space --%>
    <td>&nbsp;</td>
    <td><fmt:formatDate value="${currRow.bean.createdDate}" pattern="${dteFormat}"/></td>
    <td><c:out value="${currRow.bean.owner.name}"/></td>
    <td class="<c:out value='${className}'/>"><c:out value="${currRow.bean.status.name}"/></td>
    <%--download space --%>
    <td>&nbsp;</td>
    <td>
        <table>
            <tr>
                <td>
                    <a href="ViewCRF?module=<c:out value="${module}"/>&crfId=<c:out value="${currRow.bean.id}"/>" title="<fmt:message key="view" bundle="${resword}"/>">
                        <span name="bt_View1" class="glyphicon glyphicon-search"></span>
                    </a>
                </td>
                <td>&nbsp;&nbsp;</td>
                <c:choose>
                    <c:when test="${currRow.bean.status.available}">
                        <c:if test="${userBean.sysAdmin || (userRole.manageStudy && userBean.name==currRow.bean.owner.name) || userRole.readonly}">
                            <td>
                                <a href="InitUpdateCRF?module=<c:out value="${module}"/>&crfId=<c:out value="${currRow.bean.id}"/>" title="<fmt:message key="edit" bundle="${resword}"/>">
                                    <span name="bt_Edit1" class="glyphicon glyphicon-pencil"></span>
                                </a>
                            </td>
                            <td>&nbsp;&nbsp;</td>
                            <td>
                                <a href="RemoveCRF?module=<c:out value="${module}"/>&action=confirm&id=<c:out value="${currRow.bean.id}"/>" title="<fmt:message key="remove" bundle="${resword}"/>">
                                    <span name="bt_Remove1" class="glyphicon glyphicon-remove"></span>
                                </a>
                            </td>
                            <td>&nbsp;&nbsp;</td>
                        </c:if>
                        <c:if test="${!userRole.readonly}">
                            <td>
                                <a href="InitCreateCRFVersion?module=<c:out value="${module}"/>&crfId=<c:out value="${currRow.bean.id}"/>&name=<c:out value="${currRow.bean.name}"/>" title="<fmt:message key="create_new_version" bundle="${resword}"/>">
                                    <span name="bt_NewVersion1" class="glyphicon glyphicon-plus"></span>
                                </a>
                            </td>
                            <td>&nbsp;&nbsp;</td>
                            <c:if test="${module=='manage'}">
                                <td>
                                    <a href="BatchCRFMigration?module=<c:out value="${module}"/>&crfId=<c:out value="${currRow.bean.id}"/>" title="<fmt:message key="batch_crf_version_migration" bundle="${resword}"/>">
                                        <span name="Reassign" class="glyphicon glyphicon-share"></span>
                                    </a>
                                </td>
                            </c:if>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <td>
                            <a href="RestoreCRF?module=<c:out value="${module}"/>&action=confirm&id=<c:out value="${currRow.bean.id}"/>" title="<fmt:message key="restore" bundle="${resword}"/>">
                                <span name="bt_Restore3" class="glyphicon glyphicon-repeat"></span>
                            </a>
                        </td>
                    </c:otherwise>
                </c:choose>
            </tr>
        </table>
    </td>
</tr>

<c:forEach var ="version" items="${currRow.bean.versions}">
    <%-- color-coded statuses...--%>
    <c:choose>
        <c:when test="${version.status.name eq 'available'}">
            <c:set var="className" value="text-success"/>
        </c:when>
        <c:when test="${version.status.name eq 'removed'}">
            <c:set var="className" value="text-danger"/>
        </c:when>
    </c:choose>
    <tr>
        <td><c:out value="${version.name}"/></td>
        <td><c:out value="${version.oid}"/></td>
        <td><fmt:formatDate value="${version.createdDate}" pattern="${dteFormat}"/></td>
        <td><c:out value="${version.owner.name}"/></td>
        <td class="<c:out value='${className}'/>"><c:out value="${version.status.name}"/></td>
        <td>
            <c:choose>
                <c:when test="${version.downloadable}">
                    <a href="DownloadVersionSpreadSheet?crfId=<c:out value="${currRow.bean.id}"/>&crfVersionId=<c:out value="${version.id}"/>" title="<fmt:message key="download_spreadsheet" bundle="${resword}"/>">
                        <span name="bt_Download1" class="glyphicon glyphicon-download-alt"></span>
                    </a>
                </c:when>
                <c:otherwise>
                    <fmt:message key="N/A" bundle="${resword}"/>
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <table>
                <tr>
                    <td>
                        <a href="ViewSectionDataEntry?module=<c:out value="${module}"/>&crfId=<c:out value="${currRow.bean.id}"/>&crfVersionId=<c:out value="${version.id}"/>&tabId=1&crfListPage=yes" title="<fmt:message key="view" bundle="${resword}"/>">
                            <span name="bt_View1" class="glyphicon glyphicon-search"></span>
                        </a>
                    </td>
                    <td>&nbsp;&nbsp;</td>
                    <c:if test="${study.studyParameterConfig.participantPortal=='enabled'}">
                        <td>
                            <a href="ParticipantFormServlet?crfOID=<c:out value="${version.oid}"/>" target="_blank" title="<fmt:message key="view_participant_form" bundle="${resword}"/>">
                                <span name="bt_ViewParticipant1" class="glyphicon glyphicon-eye-open"></span>
                            </a>
                        </td>
                        <td>&nbsp;&nbsp;</td>
                    </c:if>
                    <c:if test="${version.status.available && userBean.sysAdmin && module=='admin'}">
                        <td>
                            <a href="LockCRFVersion?module=<c:out value="${module}"/>&id=<c:out value="${version.id}"/>" title="<fmt:message key="archive" bundle="${resword}"/>">
                                <span name="bt_Lock1" class="glyphicon glyphicon-lock"></span>
                            </a>
                        </td>
                        <td>&nbsp;&nbsp;</td>
                    </c:if>
                    <c:if test="${version.status.name=='locked'}">
                        <td>
                            <a href="UnlockCRFVersion?module=<c:out value="${module}"/>&id=<c:out value="${version.id}"/>" title="<fmt:message key="unarchive" bundle="${resword}"/>">
                                <span name="bt_Unlock1" class="glyphicon glyphicon-ok-circle"></span>
                            </a>
                        </td>
                        <td>&nbsp;&nbsp;</td>
                    </c:if>
                    <c:if test="${userBean.sysAdmin || (userRole.manageStudy && userBean.name==version.owner.name)}">
                        <c:choose>
                            <c:when test="${version.status.available}">
                                <td>
                                    <a href="RemoveCRFVersion?module=<c:out value="${module}"/>&action=confirm&id=<c:out value="${version.id}"/>" title="<fmt:message key="remove" bundle="${resword}"/>">
                                        <span name="bt_Remove1" class="glyphicon glyphicon-remove"></span>
                                    </a>
                                </td>
                                <td>&nbsp;&nbsp;</td>
                            </c:when>
                            <c:when test="${version.status.name == 'removed'}">
                                <td>
                                    <a href="RestoreCRFVersion?module=<c:out value="${module}"/>&action=confirm&id=<c:out value="${version.id}"/>" title="<fmt:message key="restore" bundle="${resword}"/>">
                                        <span name="bt_Restore1" class="glyphicon glyphicon-repeat"></span>
                                    </a>
                                </td>
                                <td>&nbsp;&nbsp;</td>
                            </c:when>
                        </c:choose>
                    </c:if>
                    <c:if test="${userBean.sysAdmin}">
                        <td>
                            <a href="DeleteCRFVersion?module=<c:out value="${module}"/>&action=confirm&verId=<c:out value="${version.id}"/>" title="<fmt:message key="delete" bundle="${resword}"/>">
                                <span name="bt_Delete1" class="glyphicon glyphicon-remove-sign"></span>
                            </a>
                        </td>
                    </c:if>
                </tr>
            </table>
        </td>
    </tr>
</c:forEach>
