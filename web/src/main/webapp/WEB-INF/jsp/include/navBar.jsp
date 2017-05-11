<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="org.akaza.openclinica.i18n.util.ResourceBundleProvider" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.workflow" var="resworkflow"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>

<%--
    该页面为导航栏,包含上两行和navbar
    from home-header.jsp
    FY 2017-4-8
--%>

<script>
    function confirmCancel(pageName){
        var confirm1 = confirm('<fmt:message key="sure_to_cancel" bundle="${resword}"/>');
        if(confirm1){
            window.location = pageName;
        }
    }
    function confirmExit(pageName){
        var confirm1 = confirm('<fmt:message key="sure_to_exit" bundle="${resword}"/>');
        if(confirm1){
            window.location = pageName;
        }
    }
    function goBack(){
        var confirm1 = confirm('<fmt:message key="sure_to_cancel" bundle="${resword}"/>');
        if(confirm1){
            return history.go(-1);
        }
    }
    function lockedCRFAlert(userName){
        alert('<fmt:message key="CRF_unavailable" bundle="${resword}"/>'+'\n'
                +'          '+userName+' '+'<fmt:message key="Currently_entering_data" bundle="${resword}"/>'+'\n'
                +'<fmt:message key="Leave_the_CRF" bundle="${resword}"/>');
        return false;
    }
    function confirmCancelAction( pageName, contextPath){
        var confirm1 = confirm('<fmt:message key="sure_to_cancel" bundle="${resword}"/>');
        if(confirm1){
            var tform = document.forms["fr_cancel_button"];
            tform.action=contextPath+"/"+pageName;
            tform.submit();
        }
    }
    function confirmExitAction( pageName, contextPath){
        var confirm1 = confirm('<fmt:message key="sure_to_exit" bundle="${resword}"/>');
        if(confirm1){
            var tform = document.forms["fr_cancel_button"];
            tform.action=contextPath+"/"+pageName;
            tform.submit();
        }
    }
</script>

<jsp:useBean scope='session' id='tableFacadeRestore' class='java.lang.String' />
<c:set var="restore" value="true"/>
<c:if test="${tableFacadeRestore=='false'}">
    <c:set var="restore" value="false"/>
</c:if>
<c:set var="profilePage" value="${param.profilePage}"/>
<%--  If Controller Spring based append ../ to urls --%>
<c:set var="urlPrefix" value=""/>
<c:set var="requestFromSpringController" value="${param.isSpringController}" />
<c:if test="${requestFromSpringController == 'true' }">
    <c:set var="urlPrefix" value="${pageContext.request.contextPath}/"/>
</c:if>

<div class="row">
    <%--study info--%>
    <c:choose>
        <c:when test='${study.parentStudyId > 0}'>
            <div class="col-lg-4 column">
                <ul class="nav nav-tabs" style="border:none;">
                    <li>
                        <a href="${urlPrefix}ViewStudy?id=${study.parentStudyId}&viewFull=yes" title="<c:out value='${study.parentStudyName}'/>" >
                            <b>
                                <span class="glyphicon glyphicon-pencil"></span>
                                <c:out value="${study.abbreviatedParentStudyName}" />
                            </b>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="col-lg-4 column">
                <ul class="nav nav-tabs" style="border:none;">
                    <li>
                        <a href="${urlPrefix}ViewSite?id=${study.id}" title="<c:out value='${study.name}'/>" >
                            <b>
                                <c:out value="${study.abbreviatedName}" />
                            </b>
                            (<c:out value="${study.abbreviatedIdentifier}" />)
                        </a>
                    </li>
                </ul>
            </div>
            <div class="col-lg-4 column">
                <ul class="nav nav-tabs" style="border:none;">
                    <li>
                        <a href="${urlPrefix}ChangeStudy">
                            <span class="glyphicon glyphicon-map-marker"></span>
                            <fmt:message key="change_study_site" bundle="${resworkflow}"/>
                        </a>
                    </li>
                </ul>
            </div>
        </c:when>
        <c:otherwise>
            <div class="col-lg-6 column">
                <ul class="nav nav-tabs" style="border:none;">
                    <li>
                        <a href="${urlPrefix}ViewStudy?id=${study.id}&viewFull=yes" title="<c:out value='${study.name}'/>" >
                            <b>
                                <span class="glyphicon glyphicon-pencil"></span>
                                <c:out value="${study.abbreviatedName}" />
                            </b>
                            (<c:out value="${study.abbreviatedIdentifier}" />)
                        </a>
                    </li>
                </ul>
            </div>
            <div class="col-lg-6 column">
                <ul class="nav nav-tabs" style="border:none;">
                    <li>
                        <a href="${urlPrefix}ChangeStudy">
                            <span class="glyphicon glyphicon-map-marker"></span>
                            <fmt:message key="change_study_site" bundle="${resworkflow}"/>
                        </a>
                    </li>
                </ul>
            </div>
        </c:otherwise>
    </c:choose>
    <%--end of study info--%>
</div>

<div class="row">
    <%--user info--%>
    <div class="col-lg-6 column">
        <ul class="nav nav-tabs" style="border:none;margin-bottom: 10px;">
            <li>
                <a href="${urlPrefix}UpdateProfile">
                    <span class="glyphicon glyphicon-user"></span>
                    <b><c:out value="${userBean.name}" /></b>
                    (<c:out value="${userRole.role.description}" />)
                    <c:out value="<%=ResourceBundleProvider.getLocale().toString()%>"/>
                </a>
            </li>
        </ul>
    </div>
    <div class="col-lg-6 column">
        <ul class="nav nav-tabs" style="border:none;margin-bottom: 10px;">
            <li>
                <a href="${urlPrefix}j_spring_security_logout">
                    <span class="glyphicon glyphicon-log-out"></span>
                    <fmt:message key="log_out" bundle="${resword}"/>
                </a>
            </li>
        </ul>
    </div>
    <%--end of user info--%>
</div>

<div class="row">
    <%--start of navbar--%>
    <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">

            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#example-navbar-collapse">
                    <span class="sr-only">ToggleNav</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>

            <div class="collapse navbar-collapse" id="example-navbar-collapse">

                <%--start of navpills,不同角色的navpills不同--%>
                <ul class="nav navbar-nav">
                    <c:if test="${userRole.readonly }">
                        <li><a href="${urlPrefix}MainMenu"><span class="glyphicon glyphicon-home"></span>&nbsp;<fmt:message key="nav_home" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}ListStudySubjects"><span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}ViewNotes?module=submit"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}StudyAuditLog"><span class="glyphicon glyphicon-list"></span>&nbsp;<fmt:message key="nav_study_audit_log" bundle="${resword}"/></a></li>
                    </c:if>
                    <c:if test="${userRole.coordinator || userRole.director}">
                        <li><a href="${urlPrefix}MainMenu"><span class="glyphicon glyphicon-home"></span>&nbsp;<fmt:message key="nav_home" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}ListStudySubjects"><span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}ViewNotes?module=submit"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}StudyAuditLog"><span class="glyphicon glyphicon-list"></span>&nbsp;<fmt:message key="nav_study_audit_log" bundle="${resword}"/></a></li>
                    </c:if>
                    <c:if test="${userRole.researchAssistant ||userRole.researchAssistant2}">
                        <li><a href="${urlPrefix}MainMenu"><span class="glyphicon glyphicon-home"></span>&nbsp;<fmt:message key="nav_home" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}ListStudySubjects"><span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></li>
                        <c:if test="${study.status.available}">
                            <li><a href="${urlPrefix}AddNewSubject"><span class="glyphicon glyphicon-plus-sign"></span>&nbsp;<fmt:message key="nav_add_subject" bundle="${resword}"/></a></li>
                        </c:if>
                        <li><a href="${urlPrefix}ViewNotes?module=submit"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/></a></li>
                    </c:if>
                    <c:if test="${userRole.investigator}">
                        <li><a href="${urlPrefix}MainMenu"><span class="glyphicon glyphicon-home"></span>&nbsp;<fmt:message key="nav_home" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}ListStudySubjects"><span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></li>
                        <c:if test="${study.status.available}">
                            <li><a href="${urlPrefix}AddNewSubject"><span class="glyphicon glyphicon-plus-sign"></span>&nbsp;<fmt:message key="nav_add_subject" bundle="${resword}"/></a></li>
                        </c:if>
                        <li><a href="${urlPrefix}ViewNotes?module=submit"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/></a></li>
                    </c:if>
                    <c:if test="${userRole.monitor }">
                        <li><a href="${urlPrefix}MainMenu"><span class="glyphicon glyphicon-home"></span>&nbsp;<fmt:message key="nav_home" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}ListStudySubjects"><span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}pages/viewAllSubjectSDVtmp?sdv_restore=${restore}&studyId=${study.id}"><span class="glyphicon glyphicon-ok"></span>&nbsp;<fmt:message key="nav_sdv" bundle="${resword}"/></a></li>
                        <li><a href="${urlPrefix}ViewNotes?module=submit"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/></a></li>
                    </c:if>

                    <%--dropdown,任务菜单--%>
                    <li class="dropdown">

                        <%--下拉菜单按钮--%>
                        <%--<button type="button" class="btn btn-primary navbar-btn dropdown-toggle" data-toggle="dropdown">--%>
                        <%--<fmt:message key="nav_tasks" bundle="${resword}"/><span class="caret"></span>--%>
                        <%--</button>--%>
                        <%--end of 下拉菜单按钮--%>

                        <%--模态框按钮--%>
                        <button type="button" class="btn btn-primary navbar-btn" data-toggle="modal" data-target="#taskModal">
                            <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <fmt:message key="nav_tasks" bundle="${resword}"/>
                        </button>
                        <%--end of 模态框按钮--%>

                        <%--模态框--%>
                        <div class="modal fade" id="taskModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                        <h3 class="modal-title text-primary" id="taskModalLabel" align="center">
                                            Control Panel - <fmt:message key="nav_tasks" bundle="${resword}"/>
                                        </h3>
                                    </div>
                                    <div class="modal-body">

                                        <%--根据userRole生成不同任务按钮--%>
                                        <div class="row">
                                            <c:if test="${userRole.readonly}">
                                                <div class="col-lg-6 column" style="text-align: center;">
                                                    <%--section1--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_submit_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ListStudySubjects" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ViewNotes?module=submit" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ViewStudyEvents" type="button" class="btn btn-default">
                                                            <fmt:message key="nav_view_events" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                    <%--section3--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_extract_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ViewDatasets" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-eye-open"></span>&nbsp;<fmt:message key="nav_view_datasets" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                    <%--section4--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_study_setup" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ViewStudy?id=${study.id}&viewFull=yes" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-zoom-in"></span>&nbsp;<fmt:message key="nav_view_study" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ListStudyUser" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-wrench"></span>&nbsp;<fmt:message key="nav_users" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 column" style="text-align: center;">
                                                    <%--section2--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_monitor_and_manage_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}pages/viewAllSubjectSDVtmp?sdv_restore=${restore}&studyId=${study.id}" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-ok"></span>&nbsp;<fmt:message key="nav_source_data_verification" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}StudyAuditLog" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-list"></span>&nbsp;<fmt:message key="nav_study_audit_log" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ViewRuleAssignment?read=true" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-book"></span>&nbsp;<fmt:message key="nav_rules" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ListSubjectGroupClass?read=true" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-transfer"></span>&nbsp;<fmt:message key="nav_groups" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ListCRF?module=manage" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-duplicate"></span>&nbsp;<fmt:message key="nav_crfs" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${userRole.monitor }">
                                                <div class="col-lg-6 column" style="text-align: center;">
                                                        <%--section1--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_monitor_and_manage_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ListStudySubjects" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ViewStudyEvents" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-calendar"></span>&nbsp;<fmt:message key="nav_view_events" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}pages/viewAllSubjectSDVtmp?sdv_restore=${restore}&studyId=${study.id}" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-ok"></span>&nbsp;<fmt:message key="nav_source_data_verification" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ViewNotes?module=submit" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}StudyAuditLog" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-list"></span>&nbsp;<fmt:message key="nav_study_audit_log" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                </div>

                                                <div class="col-lg-6 column" style="text-align: center;">
                                                        <%--section2--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_extract_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ViewDatasets" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-eye-open"></span>&nbsp;<fmt:message key="nav_view_datasets" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}CreateDataset" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-file"></span>&nbsp;<fmt:message key="nav_create_dataset" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${userRole.researchAssistant ||userRole.researchAssistant2  }">
                                                <div class="col-lg-6 column" style="text-align: center;">
                                                        <%--section1--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_submit_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ListStudySubjects" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/>
                                                        </a>
                                                        <c:if test="${study.status.available}">
                                                            <a href="${urlPrefix}AddNewSubject" type="button" class="btn btn-default">
                                                                <span class="glyphicon glyphicon-plus-sign"></span>&nbsp;<fmt:message key="nav_add_subject" bundle="${resword}"/>
                                                            </a>
                                                        </c:if>
                                                        <a href="${urlPrefix}ViewNotes?module=submit" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/>
                                                        </a>
                                                        <c:if test="${!study.status.frozen && !study.status.locked}">
                                                            <a href="${urlPrefix}CreateNewStudyEvent" type="button" class="btn btn-default">
                                                                <fmt:message key="nav_schedule_event" bundle="${resword}"/>
                                                            </a>
                                                        </c:if>
                                                        <a href="${urlPrefix}ViewStudyEvents" type="button" class="btn btn-default">
                                                            <fmt:message key="nav_view_events" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ImportCRFData" type="button" class="btn btn-default">
                                                            <fmt:message key="nav_import_data" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${userRole.investigator}">
                                                <div class="col-lg-6 column" style="text-align: center;">
                                                        <%--section1--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_submit_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ListStudySubjects" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/>
                                                        </a>
                                                        <c:if test="${study.status.available}">
                                                            <a href="${urlPrefix}AddNewSubject" type="button" class="btn btn-default">
                                                                <span class="glyphicon glyphicon-plus-sign"></span>&nbsp;<fmt:message key="nav_add_subject" bundle="${resword}"/>
                                                            </a>
                                                        </c:if>
                                                        <a href="${urlPrefix}ViewNotes?module=submit" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/>
                                                        </a>
                                                        <c:if test="${!study.status.frozen && !study.status.locked}">
                                                            <a href="${urlPrefix}CreateNewStudyEvent" type="button" class="btn btn-default">
                                                                <span class="glyphicon glyphicon-paperclip"></span>&nbsp;<fmt:message key="nav_schedule_event" bundle="${resword}"/>
                                                            </a>
                                                        </c:if>
                                                        <a href="${urlPrefix}ViewStudyEvents" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-calendar"></span>&nbsp;<fmt:message key="nav_view_events" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ImportCRFData" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-log-in"></span>&nbsp;<fmt:message key="nav_import_data" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 column" style="text-align: center;">
                                                        <%--section2--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_extract_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ViewDatasets" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-eye-open"></span>&nbsp;<fmt:message key="nav_view_datasets" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}CreateDataset" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-file"></span>&nbsp;<fmt:message key="nav_create_dataset" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${userRole.coordinator || userRole.director}">
                                                <div class="col-lg-6 column" style="text-align: center;">
                                                        <%--section1--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_submit_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ListStudySubjects" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/>
                                                        </a>
                                                        <c:if test="${study.status.available}">
                                                            <a href="${urlPrefix}AddNewSubject" type="button" class="btn btn-default">
                                                                <span class="glyphicon glyphicon-plus-sign"></span>&nbsp;<fmt:message key="nav_add_subject" bundle="${resword}"/>
                                                            </a>
                                                        </c:if>
                                                        <a href="${urlPrefix}ViewNotes?module=submit" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/>
                                                        </a>
                                                        <c:if test="${!study.status.frozen && !study.status.locked}">
                                                            <a href="${urlPrefix}CreateNewStudyEvent" type="button" class="btn btn-default">
                                                                <span class="glyphicon glyphicon-paperclip"></span>&nbsp;<fmt:message key="nav_schedule_event" bundle="${resword}"/>
                                                            </a>
                                                        </c:if>
                                                        <a href="${urlPrefix}ViewStudyEvents" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-calendar"></span>&nbsp;<fmt:message key="nav_view_events" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ImportCRFData" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-log-in"></span>&nbsp;<fmt:message key="nav_import_data" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                        <%--section3--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_extract_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ViewDatasets" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-eye-open"></span>&nbsp;<fmt:message key="nav_view_datasets" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}CreateDataset" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-file"></span>&nbsp;<fmt:message key="nav_create_dataset" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 column" style="text-align: center;">
                                                        <%--section2--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_monitor_and_manage_data" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}pages/viewAllSubjectSDVtmp?sdv_restore=${restore}&studyId=${study.id}" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-ok"></span>&nbsp;<fmt:message key="nav_source_data_verification" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}StudyAuditLog" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-list"></span>&nbsp;<fmt:message key="nav_study_audit_log" bundle="${resword}"/>
                                                        </a>
                                                        <c:choose>
                                                            <c:when test="${study.parentStudyId > 0 && (userRole.coordinator || userRole.director) }">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="${urlPrefix}ViewRuleAssignment?read=true" type="button" class="btn btn-default">
                                                                    <span class="glyphicon glyphicon-book"></span>&nbsp;<fmt:message key="nav_rules" bundle="${resword}"/>
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <c:choose>
                                                            <c:when test="${study.parentStudyId > 0 && (userRole.coordinator || userRole.director) }">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="${urlPrefix}ListSubjectGroupClass?read=true" type="button" class="btn btn-default">
                                                                    <span class="glyphicon glyphicon-transfer"></span>&nbsp;<fmt:message key="nav_groups" bundle="${resword}"/>
                                                                </a>
                                                                <a href="${urlPrefix}ListCRF?module=manage" type="button" class="btn btn-default">
                                                                    <span class="glyphicon glyphicon-duplicate"></span>&nbsp;<fmt:message key="nav_crfs" bundle="${resword}"/>
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                        <%--section4--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_study_setup" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ViewStudy?id=${study.id}&viewFull=yes" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-zoom-in"></span>&nbsp;<fmt:message key="nav_view_study" bundle="${resword}"/>
                                                        </a>
                                                        <c:choose>
                                                            <c:when test="${study.parentStudyId > 0 && (userRole.coordinator || userRole.director) }">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="${urlPrefix}pages/studymodule" type="button" class="btn btn-default">
                                                                    <span class="glyphicon glyphicon-cog"></span>&nbsp;<fmt:message key="nav_build_study" bundle="${resword}"/>
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <a href="${urlPrefix}ListStudyUser" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-wrench"></span>&nbsp;<fmt:message key="nav_users" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                        <%--end of 根据userRole生成不同按钮--%>

                                        <%--每个userRole都有的两个按钮--%>
                                        <div class="row">
                                            <div class="col-lg-6 column" style="text-align: center;">
                                                <%--section others--%>
                                                <h4 class="text-center text-primary"><fmt:message key="nav_other" bundle="${resword}"/></h4>
                                                <div class="btn-group-vertical" style="display: inline-block;">
                                                    <a href="${urlPrefix}UpdateProfile" type="button" class="btn btn-default">
                                                        <span class="glyphicon glyphicon-user"></span>&nbsp;<fmt:message key="nav_update_profile" bundle="${resword}"/>
                                                    </a>
                                                    <a href="${urlPrefix}j_spring_security_logout" type="button" class="btn btn-default">
                                                        <span class="glyphicon glyphicon-log-out"></span>&nbsp;<fmt:message key="nav_log_out" bundle="${resword}"/>
                                                    </a>
                                                </div>
                                            </div>
                                            <%--根据userBean生成的按钮--%>
                                            <c:if test="${userBean.sysAdmin || userBean.techAdmin}">
                                                <div class="col-lg-6 column" style="text-align: center;">
                                                        <%--section1--%>
                                                    <h4 class="text-center text-primary"><fmt:message key="nav_administration" bundle="${resword}"/></h4>
                                                    <div class="btn-group-vertical" style="display: inline-block;">
                                                        <a href="${urlPrefix}ListStudy" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-screenshot"></span>&nbsp;<fmt:message key="nav_studies" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ListUserAccounts" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-share-alt"></span>&nbsp;<fmt:message key="nav_users" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ListCRF?module=admin" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-duplicate"></span>&nbsp;<fmt:message key="nav_crfs" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ViewAllJobs" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-object-align-vertical"></span>&nbsp;<fmt:message key="nav_jobs" bundle="${resword}"/>
                                                        </a>
                                                        <a href="${urlPrefix}ListSubject" type="button" class="btn btn-default">
                                                            <span class="glyphicon glyphicon-king"></span>&nbsp;<fmt:message key="nav_subjects" bundle="${resword}"/>
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <%--end of 根据userBean生成的按钮--%>
                                        </div>
                                        <%--end of 每个userRole都有的两个按钮--%>

                                    </div><%-- /.modal-body --%>
                                </div><%-- /.modal-content --%>
                            </div><%-- /.modal dialog--%>
                        </div>
                        <%--end of 模态框--%>

                        <%--下拉菜单--%>
                        <ul class="dropdown-menu">
                            <%--不同角色的任务下拉菜单不同--%>
                            <c:if test="${userRole.monitor }">
                                <%--section1--%>
                                <li class="dropdown-header"><fmt:message key="nav_monitor_and_manage_data" bundle="${resword}"/></li>
                                <li><a href="${urlPrefix}ListStudySubjects"><span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}ViewStudyEvents"><span class="glyphicon glyphicon-calendar"></span>&nbsp;<fmt:message key="nav_view_events" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}pages/viewAllSubjectSDVtmp?sdv_restore=${restore}&studyId=${study.id}"><span class="glyphicon glyphicon-ok"></span>&nbsp;<fmt:message key="nav_source_data_verification" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}ViewNotes?module=submit"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}StudyAuditLog"><span class="glyphicon glyphicon-list"></span>&nbsp;<fmt:message key="nav_study_audit_log" bundle="${resword}"/></a></li>
                                <li class="divider"></li>
                                <%--section2--%>
                                <li class="dropdown-header"><fmt:message key="nav_extract_data" bundle="${resword}"/></li>
                                <li><a href="${urlPrefix}ViewDatasets"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;<fmt:message key="nav_view_datasets" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}CreateDataset"><span class="glyphicon glyphicon-file"></span>&nbsp;<fmt:message key="nav_create_dataset" bundle="${resword}"/></a></li>
                            </c:if>

                            <c:if test="${userRole.researchAssistant ||userRole.researchAssistant2  }">
                                <%--section1--%>
                                <li class="dropdown-header"><fmt:message key="nav_submit_data" bundle="${resword}"/></li>
                                <li><a href="${urlPrefix}ListStudySubjects"><span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></li>
                                <c:if test="${study.status.available}">
                                    <li><a href="${urlPrefix}AddNewSubject"><span class="glyphicon glyphicon-plus-sign"></span>&nbsp;<fmt:message key="nav_add_subject" bundle="${resword}"/></a></li>
                                </c:if>
                                <li><a href="${urlPrefix}ViewNotes?module=submit"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/></a></li>
                                <c:if test="${!study.status.frozen && !study.status.locked}">
                                    <li><a href="${urlPrefix}CreateNewStudyEvent"><fmt:message key="nav_schedule_event" bundle="${resword}"/></a></li>
                                </c:if>
                                <li><a href="${urlPrefix}ViewStudyEvents"><fmt:message key="nav_view_events" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}ImportCRFData"><fmt:message key="nav_import_data" bundle="${resword}"/></a></li>
                            </c:if>

                            <c:if test="${userRole.investigator}">
                                <%--section1--%>
                                <li class="dropdown-header"><fmt:message key="nav_submit_data" bundle="${resword}"/></li>
                                <li><a href="${urlPrefix}ListStudySubjects"><span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></li>
                                <c:if test="${study.status.available}">
                                    <li><a href="${urlPrefix}AddNewSubject"><span class="glyphicon glyphicon-plus-sign"></span>&nbsp;<fmt:message key="nav_add_subject" bundle="${resword}"/></a></li>
                                </c:if>
                                <li><a href="${urlPrefix}ViewNotes?module=submit"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/></a></li>
                                <c:if test="${!study.status.frozen && !study.status.locked}">
                                    <li><a href="${urlPrefix}CreateNewStudyEvent"><span class="glyphicon glyphicon-paperclip"></span>&nbsp;<fmt:message key="nav_schedule_event" bundle="${resword}"/></a></li>
                                </c:if>
                                <li><a href="${urlPrefix}ViewStudyEvents"><span class="glyphicon glyphicon-calendar"></span>&nbsp;<fmt:message key="nav_view_events" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}ImportCRFData"><span class="glyphicon glyphicon-log-in"></span>&nbsp;<fmt:message key="nav_import_data" bundle="${resword}"/></a></li>
                                <li class="divider"></li>
                                <%--section2--%>
                                <li class="dropdown-header"><fmt:message key="nav_extract_data" bundle="${resword}"/></li>
                                <li><a href="${urlPrefix}ViewDatasets"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;<fmt:message key="nav_view_datasets" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}CreateDataset"><span class="glyphicon glyphicon-file"></span>&nbsp;<fmt:message key="nav_create_dataset" bundle="${resword}"/></a></li>
                            </c:if>

                            <c:if test="${userRole.coordinator || userRole.director}">
                                <%--section1--%>
                                <li class="dropdown-header"><fmt:message key="nav_submit_data" bundle="${resword}"/></li>
                                <li><a href="${urlPrefix}ListStudySubjects"><span class="glyphicon glyphicon-th-large"></span>&nbsp;<fmt:message key="nav_subject_matrix" bundle="${resword}"/></a></li>
                                <c:if test="${study.status.available}">
                                    <li><a href="${urlPrefix}AddNewSubject"><span class="glyphicon glyphicon-plus-sign"></span>&nbsp;<fmt:message key="nav_add_subject" bundle="${resword}"/></a></li>
                                </c:if>
                                <li><a href="${urlPrefix}ViewNotes?module=submit"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<fmt:message key="nav_notes_and_discrepancies" bundle="${resword}"/></a></li>
                                <c:if test="${!study.status.frozen && !study.status.locked}">
                                    <li><a href="${urlPrefix}CreateNewStudyEvent"><span class="glyphicon glyphicon-paperclip"></span>&nbsp;<fmt:message key="nav_schedule_event" bundle="${resword}"/></a></li>
                                </c:if>
                                <li><a href="${urlPrefix}ViewStudyEvents"><span class="glyphicon glyphicon-calendar"></span>&nbsp;<fmt:message key="nav_view_events" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}ImportCRFData"><span class="glyphicon glyphicon-log-in"></span>&nbsp;<fmt:message key="nav_import_data" bundle="${resword}"/></a></li>
                                <li class="divider"></li>
                                <%--section2--%>
                                <li class="dropdown-header"><fmt:message key="nav_monitor_and_manage_data" bundle="${resword}"/></li>
                                <li><a href="${urlPrefix}pages/viewAllSubjectSDVtmp?sdv_restore=${restore}&studyId=${study.id}"><span class="glyphicon glyphicon-ok"></span>&nbsp;<fmt:message key="nav_source_data_verification" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}StudyAuditLog"><span class="glyphicon glyphicon-list"></span>&nbsp;<fmt:message key="nav_study_audit_log" bundle="${resword}"/></a></li>
                                <c:choose>
                                    <c:when test="${study.parentStudyId > 0 && (userRole.coordinator || userRole.director) }">
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="${urlPrefix}ViewRuleAssignment?read=true"><span class="glyphicon glyphicon-book"></span>&nbsp;<fmt:message key="nav_rules" bundle="${resword}"/></a></li>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${study.parentStudyId > 0 && (userRole.coordinator || userRole.director) }">
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="${urlPrefix}ListSubjectGroupClass?read=true"><span class="glyphicon glyphicon-transfer"></span>&nbsp;<fmt:message key="nav_groups" bundle="${resword}"/></a></li>
                                        <li><a href="${urlPrefix}ListCRF?module=manage"><span class="glyphicon glyphicon-duplicate"></span>&nbsp;<fmt:message key="nav_crfs" bundle="${resword}"/></a></li>
                                    </c:otherwise>
                                </c:choose>
                                <li class="divider"></li>
                                <%--section3--%>
                                <li class="dropdown-header"><fmt:message key="nav_extract_data" bundle="${resword}"/></li>
                                <li><a href="${urlPrefix}ViewDatasets"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;<fmt:message key="nav_view_datasets" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}CreateDataset"><span class="glyphicon glyphicon-file"></span>&nbsp;<fmt:message key="nav_create_dataset" bundle="${resword}"/></a></li>
                                <li class="divider"></li>
                                <%--section4--%>
                                <li class="dropdown-header"><fmt:message key="nav_study_setup" bundle="${resword}"/></li>
                                <li><a href="${urlPrefix}ViewStudy?id=${study.id}&viewFull=yes"><span class="glyphicon glyphicon-zoom-in"></span>&nbsp;<fmt:message key="nav_view_study" bundle="${resword}"/></a></li>
                                <c:choose>
                                    <c:when test="${study.parentStudyId > 0 && (userRole.coordinator || userRole.director) }">
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="${urlPrefix}pages/studymodule"><span class="glyphicon glyphicon-cog"></span>&nbsp;<fmt:message key="nav_build_study" bundle="${resword}"/></a></li>
                                    </c:otherwise>
                                </c:choose>
                                <li><a href="${urlPrefix}ListStudyUser"><span class="glyphicon glyphicon-wrench"></span>&nbsp;<fmt:message key="nav_users" bundle="${resword}"/></a></li>
                                <li class="divider"></li>
                            </c:if>

                            <c:if test="${userBean.sysAdmin || userBean.techAdmin}">
                                <%--section1--%>
                                <li class="dropdown-header"><fmt:message key="nav_administration" bundle="${resword}"/></li>
                                <li><a href="${urlPrefix}ListStudy"><span class="glyphicon glyphicon-screenshot"></span>&nbsp;<fmt:message key="nav_studies" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}ListUserAccounts"><span class="glyphicon glyphicon-share-alt"></span>&nbsp;<fmt:message key="nav_users" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}ListCRF?module=admin"><span class="glyphicon glyphicon-duplicate"></span>&nbsp;<fmt:message key="nav_crfs" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}ViewAllJobs"><span class="glyphicon glyphicon-object-align-vertical"></span>&nbsp;<fmt:message key="nav_jobs" bundle="${resword}"/></a></li>
                                <li><a href="${urlPrefix}ListSubject"><span class="glyphicon glyphicon-king"></span>&nbsp;<fmt:message key="nav_subjects" bundle="${resword}"/></a></li>
                                <li class="divider"></li>
                            </c:if>

                            <%--section others--%>
                            <li class="dropdown-header"><fmt:message key="nav_other" bundle="${resword}"/></li>
                            <li><a href="${urlPrefix}UpdateProfile"><span class="glyphicon glyphicon-user"></span>&nbsp;<fmt:message key="nav_update_profile" bundle="${resword}"/></a></li>
                            <li><a href="${urlPrefix}j_spring_security_logout"><span class="glyphicon glyphicon-log-out"></span>&nbsp;<fmt:message key="nav_log_out" bundle="${resword}"/></a></li>
                        </ul>
                        <%--end of 下拉菜单--%>
                    </li>
                    <%--end of dropdown, task section--%>
                </ul>
                <%--end of navpills--%>

                <%--start of search--%>
                <div>
                    <form class="navbar-form navbar-right" role="search" METHOD="GET" action="${urlPrefix}ListStudySubjects">
                        <div class="form-group">
                            <input type="text" name="findSubjects_f_studySubject.label" class="form-control" placeholder="Search Subject ID">
                        </div>
                        <button type="submit" class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
                    </form>
                </div>
                <%--end of search--%>

            </div>

        </div>
    </nav>
    <%--end of navbar--%>
</div>