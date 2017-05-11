<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.workflow" var="resworkflow"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.page_messages" var="resmessages"/>
<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<jsp:useBean scope='session' id='study' class='org.akaza.openclinica.bean.managestudy.StudyBean' />
<jsp:useBean scope='session' id='userRole' class='org.akaza.openclinica.bean.login.StudyUserRoleBean' />

<%--
    该页面为主页
    include home-header.jsp\sideAlert.jsp\sideInfo.jsp\addSubjectMonitor.jsp\footer.jsp
    FY 2017-4-8
--%>

<!--home-header.jsp-->
<jsp:include page="include/home-header.jsp"/>
<!--end of home-header.jsp-->

<link rel="stylesheet" href="../../includes/jmesa/jmesa.css">
<script src="../../includes/jmesa/jquery.jmesa.js"></script>
<script src="../../includes/jmesa/jmesa.js"></script>
<script src="../../includes/jmesa/jquery.blockUI.js"></script>
<script src="../../includes/jmesa/jquery-migrate-1.1.1.js"></script>

<%--侧栏和主要内容区--%>
<div class="row clearfix">
    <%--侧栏sidebar--%>
    <div class="col-lg-2 column">

        <!--第一部分警告区sideAlert.jsp-->
        <jsp:include page="include/sideAlert.jsp"/>
        <!--end of sideAlert.jsp-->

        <%--第二部分提示信息instructions--%>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" href="#collapseins">
                        <fmt:message key="instructions" bundle="${resword}"/>
                        <span class="glyphicon glyphicon-pushpin pull-right"></span>
                    </a>
                </h4>
            </div>
            <div id="collapseins" class="panel-collapse collapse in">
                <div class="panel-body">
                    <fmt:message key="may_change_request_access" bundle="${restext}"/>
                </div>
            </div>
        </div>
        <%--end of instructions--%>

        <!--第三部分sideInfo暂时不显示-->
        <%--<jsp:include page="include/sideInfo.jsp"/>--%>
        <!--end of sideInfo-->

    </div>
    <%--end of 侧边栏sidebar--%>

    <%--主内容区main content--%>
    <div class="col-lg-10 column">

        <%--start of jumbotron--%>
        <div class="jumbotron">
            <%--欢迎的标题--%>
            <h2 class="text-center">
                <fmt:message key="welcome_to" bundle="${restext}"/>
                <c:choose>
                    <c:when test='${study.parentStudyId > 0}'>
                        <c:out value='${study.parentStudyName}'/>
                    </c:when>
                    <c:otherwise>
                        <c:out value='${study.name}'/>
                    </c:otherwise>
                </c:choose>
            </h2>
            <%--end of 欢迎的标题--%>

            <%--what is it?study identifier--%>
            <c:set var="roleName" value=""/>
            <c:if test="${userRole != null && !userRole.invalid}">
                <c:set var="roleName" value="${userRole.role.name}"/>
                <c:set var="studyidentifier">
                    <span class="text-danger"><c:out value="${study.identifier}"/></span>
                </c:set>
            </c:if>
            <%--end of what is it?--%>

            <%--note and discrepancies质疑--%>
            <h3 class="text-center">
                <a href="ViewNotes?module=submit&listNotes_f_discrepancyNoteBean.user=<c:out value='${userBean.name}' />">
                    <fmt:message key="notes_assigned_to_me" bundle="${restext}"/>
                    <span>${assignedDiscrepancies}</span>
                </a>
            </h3>
            <%--end of note and discrepancies质疑--%>
        </div>
        <%--end of jumbotron--%>

        <%--data tables, 不同的角色能看到不同的表格--%>

        <%--investigator or researchassistant--%>
        <c:if test="${userRole.investigator || userRole.researchAssistant || userRole.researchAssistant2}">
            <script>
                function onInvokeAction(id,action) {
                    if(id.indexOf('findSubjects') == -1)  {
                        setExportToLimit(id, '');
                    }
                    createHiddenInputFieldsForLimitAndSubmit(id);
                }
                function onInvokeExportAction(id) {
                    var parameterString = createParameterStringForLimit(id);
                    location.href = '${pageContext.request.contextPath}/MainMenu?'+ parameterString;
                }
            </script>

            <div class="row">
                <div class="col-lg-12">
                    <form  action="${pageContext.request.contextPath}/ListStudySubjects">
                        <input type="hidden" name="module" value="admin">
                            ${findSubjectsHtml}
                    </form>
                    <a data-toggle="modal" href="#addSubjectMonitorModal">Add New Subjects</a>
                </div>
            </div>
            <c:import url="addSubjectMonitor.jsp"/>
        </c:if>
        <%--end of investigator or researchassistant--%>

        <%--coordinator or director--%>
        <c:if test="${userRole.coordinator || userRole.director}">
            <script>
                function onInvokeAction(id,action) {
                    if(id.indexOf('studySiteStatistics') == -1)  {
                        setExportToLimit(id, '');
                    }
                    if(id.indexOf('subjectEventStatusStatistics') == -1)  {
                        setExportToLimit(id, '');
                    }
                    if(id.indexOf('studySubjectStatusStatistics') == -1)  {
                        setExportToLimit(id, '');
                    }
                    createHiddenInputFieldsForLimitAndSubmit(id);
                }
            </script>

            <div class="row">
                <div class="col-lg-6">
                    <form  action="${pageContext.request.contextPath}/MainMenu">
                            ${studySiteStatistics}
                    </form>
                </div>
                <div class="col-lg-6">
                    <form  action="${pageContext.request.contextPath}/MainMenu">
                            ${studyStatistics}
                    </form>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <form  action="${pageContext.request.contextPath}/MainMenu">
                            ${subjectEventStatusStatistics}
                    </form>
                </div>
                <div class="col-lg-6">
                    <form  action="${pageContext.request.contextPath}/MainMenu">
                            ${studySubjectStatusStatistics}
                    </form>
                </div>
            </div>
        </c:if>
        <%--end of coordinator or director--%>

        <%--monitor--%>
        <c:if test="${userRole.monitor}">
            <script>
                function onInvokeAction(id,action) {
                    setExportToLimit(id, '');
                    createHiddenInputFieldsForLimitAndSubmit(id);
                }
                function onInvokeExportAction(id) {
                    var parameterString = createParameterStringForLimit(id);
                }
                function prompt(formObj,crfId){
                    var bool = confirm("<fmt:message key="uncheck_sdv" bundle="${resmessages}"/>");
                    if(bool){
                        formObj.action='${pageContext.request.contextPath}/pages/handleSDVRemove';
                        formObj.crfId.value=crfId;
                        formObj.submit();
                    }
                }
            </script>
            <!--create tabs-->
            <div id="searchFilterSDV" style="border: 1px solid blue;">
                <table border="2" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="bottom" id="Tab1'">
                            <div id="Tab1NotSelected">
                                <div class="tab_BG"><div class="tab_L"><div class="tab_R">
                                    <a class="tabtext" title="<fmt:message key="view_by_event_CRF" bundle="${resword}"/>" href='pages/viewAllSubjectSDVtmp?studyId=${studyId}' onclick="javascript:HighlightTab(1);">
                                        <fmt:message key="view_by_event_CRF" bundle="${resword}"/>
                                    </a>
                                </div></div></div>
                            </div>
                            <div id="Tab1Selected" style="display:none">
                                <div class="tab_BG_h"><div class="tab_L_h"><div class="tab_R_h">
												<span class="tabtext">
													<fmt:message key="view_by_event_CRF" bundle="${resword}"/>
												</span>
                                </div></div></div>
                            </div>
                        </td>
                        <td valign="bottom" id="Tab2'">
                            <div id="Tab2Selected">
                                <div class="tab_BG"><div class="tab_L"><div class="tab_R">
                                    <a class="tabtext" title="<fmt:message key="view_by_studysubjectID" bundle="${resword}"/>" href='pages/viewSubjectAggregate?studyId=${studyId}' onclick="javascript:HighlightTab(2);">
                                        <fmt:message key="view_by_studysubjectID" bundle="${resword}"/>
                                    </a>
                                </div></div></div>
                            </div>
                            <div id="Tab2NotSelected" style="display:none">
                                <div class="tab_BG_h"><div class="tab_L_h"><div class="tab_R_h">
												<span class="tabtext">
													<fmt:message key="view_by_studysubjectID" bundle="${resword}"/>
												</span>
                                </div></div></div>
                            </div>
                        </td>
                    </tr>
                </table>
                <script language="JavaScript">
                    HighlightTab(1);
                </script>
            </div><!--end of tabs-->
            <div id="subjectSDV" style="border: 1px solid blue;">
                <form name='sdvForm' action="${pageContext.request.contextPath}/pages/viewAllSubjectSDVtmp" style="border:2px solid orange;">
                    <input type="hidden" name="studyId" value="${study.id}">
                    <input type="hidden" name=imagePathPrefix value="">
                        <%--This value will be set by an onclick handler associated with an SDV button --%>
                    <input type="hidden" name="crfId" value="0">
                        <%-- the destination JSP page after removal or adding SDV for an eventCRF --%>
                    <input type="hidden" name="redirection" value="viewAllSubjectSDVtmp">
                        <%--<input type="hidden" name="decorator" value="mydecorator">--%>
                        ${sdvMatrix}
                    <br />
                    <input type="submit" name="sdvAllFormSubmit" class="button_medium" value="<fmt:message key="submit" bundle="${resword}"/>" onclick="this.form.method='POST';this.form.action='${pageContext.request.contextPath}/pages/handleSDVPost';this.form.submit();"/>
                    <input type="submit" name="sdvAllFormCancel" class="button_medium" value="<fmt:message key="cancel" bundle="${resword}"/>" onclick="this.form.action='${pageContext.request.contextPath}/pages/viewAllSubjectSDVtmp';this.form.submit();"/>
                </form>
            </div>
        </c:if>
        <%--end of monitor--%>

        <%--end of data tables--%>

    </div>
    <%--end of 主内容区--%>
</div>
<%--end of 侧栏和主要内容区--%>

<!--footer.jsp-->
<jsp:include page="include/footer.jsp"/>
<!--end of footer.jsp-->
