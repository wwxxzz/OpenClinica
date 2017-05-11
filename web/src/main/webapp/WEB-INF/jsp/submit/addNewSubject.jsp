<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>

<jsp:useBean scope="session" id="study" class="org.akaza.openclinica.bean.managestudy.StudyBean" />
<jsp:useBean scope="request" id="pageMessages" class="java.util.ArrayList" />
<jsp:useBean scope="request" id="presetValues" class="java.util.HashMap" />
<jsp:useBean scope="request" id="groups" class="java.util.ArrayList" />

<c:set var="uniqueIdentifier" value="" />
<c:set var="chosenGender" value="" />
<c:set var="label" value="" />
<c:set var="secondaryLabel" value="" />
<c:set var="enrollmentDate" value="" />
<c:set var="dob" value="" />
<c:set var="yob" value="" />
<c:set var="groupId" value="${0}" />

<c:forEach var="presetValue" items="${presetValues}">
    <c:if test='${presetValue.key == "uniqueIdentifier"}'>
        <c:set var="uniqueIdentifier" value="${presetValue.value}" />
    </c:if>
    <c:if test='${presetValue.key == "gender"}'>
        <c:set var="chosenGender" value="${presetValue.value}" />
    </c:if>
    <c:if test='${presetValue.key == "label"}'>
        <c:set var="label" value="${presetValue.value}" />
    </c:if>
    <c:if test='${presetValue.key == "secondaryLabel"}'>
        <c:set var="secondaryLabel" value="${presetValue.value}" />
    </c:if>
    <c:if test='${presetValue.key == "enrollmentDate"}'>
        <c:set var="enrollmentDate" value="${presetValue.value}" />
    </c:if>
    <c:if test='${presetValue.key == "dob"}'>
        <c:set var="dob" value="${presetValue.value}" />
    </c:if>
    <c:if test='${presetValue.key == "yob"}'>
        <c:set var="yob" value="${presetValue.value}" />
    </c:if>
    <c:if test='${presetValue.key == "group"}'>
        <c:set var="groupId" value="${presetValue.value}" />
    </c:if>
</c:forEach>

<%--
    该页面为添加受试者页面/AddNewSubject
    include submit-header.jsp\sideAlert.jsp\instructionsSetupStudyEvent.jsp\footer.jsp
    FY 2017-4-8
--%>

<script src="../../../includes/global_functions_javascript.js"></script>

<!--submit-header.jsp-->
<jsp:include page="../include/submit-header.jsp"/>
<!--end of submit-header.jsp-->


<%--侧栏和主内容区--%>
<div class="row clearfix">
    <%--侧栏--%>
    <div class="col-lg-2 column">

        <!--sideAlert-->
        <jsp:include page="../include/sideAlert.jsp"/>
        <!--end of sideAlert-->

        <%--instructions--%>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" href="#collapseins">
                        <fmt:message key="instructions" bundle="${resword}"/>
                        <span class="glyphicon glyphicon-pushpin pull-right"></span>
                    </a>
                </h4>
            </div>
            <div id="collapseins" class="panel-collapse collapse">
                <div class="panel-body">
                    <fmt:message key="fill_to_add_click_help" bundle="${restext}"/>
                </div>
            </div>
        </div>
        <%--end of instructions--%>

        <!--sideInfo暂时禁用-->
        <%--<jsp:include page="../include/sideInfo.jsp"/>--%>
        <!--end of sideInfo-->

    </div>
    <%--end of 侧栏--%>

        <%--主内容区--%>
        <div class="col-lg-10 column">

            <div class="row">
                <div class="col-lg-12 column">
                    <%--start of jumbotron--%>
                    <div class="jumbotron">
                        <%--主标题--%>
                        <h2 class="text-center">
                            <c:out value="${study.name}" />:<fmt:message key="add_subject" bundle="${resword}"/>
                        </h2>
                        <%--end of 主标题--%>
                    </div>
                    <%--end of jumbotron--%>
                </div>
            </div>

            <%--主体--%>
            <div class="row">
                <p class="text-center">
                    <span class="glyphicon glyphicon-asterisk"></span>
                    <fmt:message key="field_required" bundle="${resword}"/>
                </p>
                <form class="form-horizontal" role="form" action="AddNewSubject" method="post">
                    <jsp:include page="../include/showSubmitted.jsp" />

                    <%--study_subject_ID--%>
                    <div class="form-group">
                        <label for="studySubjectID" class="col-lg-3 control-label">
                            <fmt:message key="study_subject_ID" bundle="${resword}"/>
                        </label>
                        <div class="col-lg-7">
                            <c:choose>
                                <c:when test="${study.studyParameterConfig.subjectIdGeneration =='auto non-editable'}">
                                    <input onfocus="this.select()" type="text" value="<c:out value="${label}"/>"  class="form-control" disabled id="studySubjectID">
                                    <input type="hidden" name="label" value="<c:out value="${label}"/>">
                                </c:when>
                                <c:otherwise>
                                    <input onfocus="this.select()" type="text" name="label" value="<c:out value="${label}"/>"  class="form-control" id="studySubjectID">
                                </c:otherwise>
                            </c:choose>
                            <jsp:include page="../showMessage.jsp">
                                <jsp:param name="key" value="label"/>
                            </jsp:include>
                        </div>
                        <div class="col-lg-2">
                            <span class="glyphicon glyphicon-asterisk"></span>
                        </div>
                    </div>
                    <%--end of study_subject_ID--%>

                    <%--person_ID--%>
                    <c:choose>
                        <c:when test="${study.studyParameterConfig.subjectPersonIdRequired =='required'}">
                            <div class="form-group">
                                <label for="personID" class="col-lg-3 control-label">
                                    <fmt:message key="person_ID" bundle="${resword}"/>
                                </label>
                                <div class="col-lg-7">
                                    <input onfocus="this.select()" type="text" name="uniqueIdentifier" value="<c:out value="${uniqueIdentifier}"/>" class="form-control" id="personID">
                                    <jsp:include page="../showMessage.jsp">
                                        <jsp:param name="key" value="uniqueIdentifier"/>
                                    </jsp:include>
                                </div>
                                <div class="col-lg-2">
                                    <span class="glyphicon glyphicon-asterisk"></span>
                                    <c:if test="${study.studyParameterConfig.discrepancyManagement=='true'}">
                                        <a href="#" onClick="openDSNoteWindow('CreateDiscrepancyNote?name=subject&field=uniqueIdentifier&column=unique_identifier','spanAlert-uniqueIdentifier'); return false;"
                                           title="<fmt:message key="discrepancy_note" bundle="${resword}"/>">
                                            <span class="glyphicon glyphicon-flag"></span>
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${study.studyParameterConfig.subjectPersonIdRequired =='optional'}">
                            <div class="form-group">
                                <label for="personID" class="col-lg-3 control-label">
                                    <fmt:message key="person_ID" bundle="${resword}"/>
                                </label>
                                <div class="col-lg-7">
                                    <input onfocus="this.select()" type="text" name="uniqueIdentifier" value="<c:out value="${uniqueIdentifier}"/>" class="form-control" id="personID">
                                    <jsp:include page="../showMessage.jsp">
                                        <jsp:param name="key" value="uniqueIdentifier"/>
                                    </jsp:include>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="uniqueIdentifier" value="<c:out value="${uniqueIdentifier}"/>">
                        </c:otherwise>
                    </c:choose>
                    <%--end of person_ID--%>

                    <%--secondary_ID--%>
                    <div class="form-group">
                        <label for="secondaryID" class="col-lg-3 control-label">
                            <fmt:message key="secondary_ID" bundle="${resword}"/>
                        </label>
                        <div class="col-lg-7">
                            <input onfocus="this.select()" type="text" name="secondaryLabel" value="<c:out value="${secondaryLabel}"/>" class="form-control" id="secondaryID">
                            <jsp:include page="../showMessage.jsp">
                                <jsp:param name="key" value="secondaryLabel"/>
                            </jsp:include>
                        </div>
                    </div>
                    <%--end of secondary_ID--%>

                    <%--date_of_enrollment_for_study--%>
                    <div class="form-group">
                        <label for="enrollmentDateField" class="col-lg-3 control-label">
                            <c:if test="${study.parentStudyId == 0}">
                                <fmt:message key="date_of_enrollment_for_study" bundle="${resword}"/>
                                -<c:out value="${study.name}" />
                            </c:if>
                            <c:if test="${study.parentStudyId > 0}">
                                <fmt:message key="date_of_enrollment_for_study" bundle="${resword}"/>
                                -<c:out value="${study.parentStudyName}" />
                            </c:if>
                        </label>
                        <div class="col-lg-7">
                            <input onfocus="this.select()" type="text" name="enrollmentDate" value="<c:out value="${enrollmentDate}"/>" class="form-control" id="enrollmentDateField" />
                            <jsp:include page="../showMessage.jsp">
                                <jsp:param name="key" value="enrollmentDate"/>
                            </jsp:include>
                        </div>
                        <div class="col-lg-2">
                            <span class="glyphicon glyphicon-asterisk"></span>
                            <c:if test="${study.studyParameterConfig.discrepancyManagement=='true'}">
                                <a href="#" onClick="openDSNoteWindow('CreateDiscrepancyNote?name=studySub&field=enrollmentDate&column=enrollment_date','spanAlert-enrollmentDate'); return false;"
                                   title="<fmt:message key="discrepancy_note" bundle="${resword}"/>">
                                    <span class="glyphicon glyphicon-flag"></span>
                                </a>
                            </c:if>
                        </div>
                    </div>
                    <%--end of date_of_enrollment_for_study--%>

                    <%--gender--%>
                    <c:if test="${study.studyParameterConfig.genderRequired !='not used'}">
                        <div class="form-group">
                            <label for="gender" class="col-lg-3 control-label">
                                <fmt:message key="gender" bundle="${resword}"/>
                            </label>
                            <div class="col-lg-7">
                                <select id="gender" name="gender" class="form-control">
                                    <option value=""><fmt:message key="select" bundle="${resword}"/></option>
                                    <c:choose>
                                        <c:when test="${!empty chosenGender}">
                                            <c:choose>
                                                <c:when test='${chosenGender == "m"}'>
                                                    <option value="m" selected><fmt:message key="male" bundle="${resword}"/></option>
                                                    <option value="f"><fmt:message key="female" bundle="${resword}"/></option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="m"><fmt:message key="male" bundle="${resword}"/></option>
                                                    <option value="f" selected><fmt:message key="female" bundle="${resword}"/></option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="m"><fmt:message key="male" bundle="${resword}"/></option>
                                            <option value="f"><fmt:message key="female" bundle="${resword}"/></option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                                <jsp:include page="../showMessage.jsp">
                                    <jsp:param name="key" value="gender"/>
                                </jsp:include>
                            </div>
                            <div class="col-lg-2">
                                <c:choose>
                                    <c:when test="${study.studyParameterConfig.genderRequired !='false'}">
                                        <span class="glyphicon glyphicon-asterisk"></span>
                                    </c:when>
                                </c:choose>
                                <c:if test="${study.studyParameterConfig.discrepancyManagement=='true'}">
                                    <a href="#" onClick="openDSNoteWindow('CreateDiscrepancyNote?name=subject&field=gender&column=gender','spanAlert-gender'); return false;"
                                       title="<fmt:message key="discrepancy_note" bundle="${resword}"/>">
                                        <span class="glyphicon glyphicon-flag"></span>
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                    <%--end of gender--%>

                    <%--date/year_of_birth--%>
                    <c:choose>
                        <c:when test="${study.studyParameterConfig.collectDob == '1'}">
                            <div class="form-group">
                                <label for="dobField" class="col-lg-3 control-label">
                                    <fmt:message key="date_of_birth" bundle="${resword}"/>
                                </label>
                                <div class="col-lg-7">
                                    <input onfocus="this.select()" type="text" name="dob" value="<c:out value="${dob}" />" class="form-control" id="dobField" />
                                    <jsp:include page="../showMessage.jsp">
                                        <jsp:param name="key" value="dob"/>
                                    </jsp:include>
                                </div>
                                <div class="col-lg-2">
                                    <span class="glyphicon glyphicon-asterisk"></span>
                                    <c:if test="${study.studyParameterConfig.discrepancyManagement=='true'}">
                                        <a href="#" onClick="openDSNoteWindow('CreateDiscrepancyNote?name=subject&field=dob&column=date_of_birth','spanAlert-dob'); return false;"
                                           title="<fmt:message key="discrepancy_note" bundle="${resword}"/>">
                                            <span class="glyphicon glyphicon-flag"></span>
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${study.studyParameterConfig.collectDob == '2'}">
                            <div class="form-group">
                                <label for="yobField" class="col-lg-3 control-label">
                                    <fmt:message key="year_of_birth" bundle="${resword}"/>
                                </label>
                                <div class="col-lg-7">
                                    <input onfocus="this.select()" type="text" name="yob" value="<c:out value="${yob}" />" class="form-control" id="yobField"/>
                                    <jsp:include page="../showMessage.jsp">
                                        <jsp:param name="key" value="yob"/>
                                    </jsp:include>
                                </div>
                                <div class="col-lg-2">
                                    (<fmt:message key="date_format_year" bundle="${resformat}"/>)
                                    <span class="glyphicon glyphicon-asterisk"></span>
                                    <c:if test="${study.studyParameterConfig.discrepancyManagement=='true'}">
                                        <a href="#" onClick="openDSNoteWindow('CreateDiscrepancyNote?name=subject&field=yob&column=date_of_birth','spanAlert-yob'); return false;"
                                           title="<fmt:message key="discrepancy_note" bundle="${resword}"/>">
                                            <span class="glyphicon glyphicon-flag"></span>
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="dob" value="" />
                        </c:otherwise>
                    </c:choose>
                    <%--end of date/year_of_birth--%>

                    <%--subject_group_class--%>
                    <c:if test="${(!empty groups)}">
                        <div class="form-group">
                            <label for="enrollmentDateField" class="col-lg-3 control-label">
                                <fmt:message key="subject_group_class" bundle="${resword}"/>
                            </label>
                            <div class="col-lg-9">
                                <c:set var="count" value="0"/>
                                <c:forEach var="group" items="${groups}">
                                    <div class="row">
                                        <div class="col-lg-4">
                                            <c:out value="${group.name}"/>
                                        </div>
                                        <div class="col-lg-6">
                                            <select name="studyGroupId<c:out value="${count}"/>" class="form-control">
                                                <option value="0">--</option>
                                                <c:forEach var="sg" items="${group.studyGroups}">
                                                    <c:choose>
                                                        <c:when test="${group.studyGroupId == sg.id}">
                                                            <option value="<c:out value="${sg.id}" />" selected><c:out value="${sg.name}"/></option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="<c:out value="${sg.id}"/>"><c:out value="${sg.name}"/></option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </select>
                                            <c:import url="../showMessage.jsp">
                                                <c:param name="key" value="studyGroupId${count}" />
                                            </c:import>
                                        </div>
                                        <div class="col-lg-2">
                                            <c:if test="${group.subjectAssignment=='Required'}">
                                                <span class="glyphicon glyphicon-asterisk"></span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-4">
                                            <fmt:message key="notes" bundle="${resword}"/>
                                        </div>
                                        <div class="col-lg-6">
                                            <input onfocus="this.select()" type="text" class="form-control" name="notes<c:out value="${count}"/>"  value="<c:out value="${group.groupNotes}"/>">
                                            <c:import url="../showMessage.jsp">
                                                <c:param name="key" value="notes${count}" />
                                            </c:import>
                                        </div>
                                    </div>
                                    <c:set var="count" value="${count+1}"/>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    <%--end of subject_group_class--%>

                    <%--提交--%>
                    <div class="form-group">
                        <div class="col-lg-offset-3 col-lg-9 btn-group">
                            <input type="submit" class="btn btn-primary" name="submitEvent" value="<fmt:message key="save_and_assign_study_event" bundle="${restext}"/>">
                            <input type="submit" class="btn btn-primary" name="submitEnroll" value="<fmt:message key="save_and_add_next_subject" bundle="${restext}"/>">
                            <input type="submit" class="btn btn-primary" name="submitDone" value="<fmt:message key="save_and_finish" bundle="${restext}"/>">
                            <input type="button" class="btn btn-primary" name="cancel" onclick="confirmCancel('ListStudySubjects');" value="<fmt:message key="cancel" bundle="${resword}"/>">
                        </div>
                    </div>
                    <%--end of 提交--%>

                </form>
                <c:import url="instructionsSetupStudyEvent.jsp">
                    <c:param name="currStep" value="enroll" />
                </c:import>
            </div>
            <%--end of 主体--%>

        </div>
        <%--end of 主内容区--%>
</div>
<%--end of 侧栏与主内容区--%>

<!--footer.jsp-->
<jsp:include page="../include/footer.jsp"/>
<!--end of footer.jsp-->
