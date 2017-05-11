<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>

<jsp:useBean scope="request" id="label" class="java.lang.String"/>
<jsp:useBean scope="session" id="study" class="org.akaza.openclinica.bean.managestudy.StudyBean" />
<jsp:useBean scope="request" id="pageMessages" class="java.util.ArrayList" />
<jsp:useBean scope="request" id="presetValues" class="java.util.HashMap" />
<jsp:useBean scope="request" id="groups" class="java.util.ArrayList" />

<c:set var="uniqueIdentifier" value="" />
<c:set var="chosenGender" value="" />
<c:set var="label" value="" />
<c:set var="secondaryLabel" value="" />
<c:set var="enrollmentDate" value="" />
<c:set var="startDate" value=""/>
<c:set var="dob" value="" />
<c:set var="yob" value="" />
<c:set var="groupId" value="${0}" />
<c:set var="studyEventDefinition" value=""/>
<c:set var="location" value=""/>

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
	<c:if test='${presetValue.key == "startDate"}'>
		<c:set var="startDate" value="${presetValue.value}" />
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
	
	<c:if test='${presetValue.key == "studyEventDefinition"}'>
		<c:set var="studyEventDefinition" value="${presetValue.value}" />
	</c:if>
	<c:if test='${presetValue.key == "location"}'>
		<c:set var="location" value="${presetValue.value}" />
	</c:if>
</c:forEach>

<%--
    当角色为investigator or researchassistant时,用于添加受试者
    include showSubmitted.jsp
    from menu.jsp
    FY 2017-4-8
--%>

<%--css for *必填符号--%>
<style>
    .form-group.hasreq label:after {
        content: ' *';
        color: #999;
        font-size: 150%;
    }
</style>

<%--start of form of addsubjectmonitorModal--%>
<form name="subjectForm" action="AddNewSubject" method="post" class="form-horizontal">
    <input type="hidden" name="subjectOverlay" value="true">
    <%--start of modal fade--%>
    <div class="modal fade" id="addSubjectMonitorModal" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">

                <%--title and X of popup--%>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                    <h4 class="modal-title text-center" id="addSubjectMonitorModalLabel">
                        <fmt:message key="add_new_subject" bundle="${resword}"/>
                    </h4>
                </div>

                <%--body of popup--%>
                <div class="modal-body">

                    <%--start of form--%>
                    <form class="form-horizontal">

                        <%--studysubjectid--%>
                        <div class="form-group hasreq">
                            <label for="ssidinput" class="col-lg-5 control-label"><fmt:message key="study_subject_ID" bundle="${resword}"/></label>
                            <div class="col-lg-7">
                                <jsp:include page="include/showSubmitted.jsp" />
                                <input type="hidden" name="addWithEvent" value="1"/>
                                <c:choose>
                                    <c:when test="${study.studyParameterConfig.subjectIdGeneration =='auto non-editable'}">
                                        <input onfocus="this.select()" type="text" value="<c:out value="${label}"/>" class="form-control" id="ssidinput" disabled>
                                        <input type="hidden" name="label" value="<c:out value="${label}"/>">
                                    </c:when>
                                    <c:otherwise>
                                        <input onfocus="this.select()" type="text" name="label" value="<c:out value="${label}"/>" class="form-control" id="ssidinput">
                                    </c:otherwise>
                                </c:choose>
                                <jsp:include page="showMessage.jsp"><jsp:param name="key" value="label"/></jsp:include>
                            </div>
                        </div>

                        <%--person id--%>
                        <c:choose>
                            <c:when test="${study.studyParameterConfig.subjectPersonIdRequired =='required'}">
                                <div class="form-group hasreq">
                                    <label for="personidinput" class="col-lg-5 control-label"><fmt:message key="person_ID" bundle="${resword}"/></label>
                                    <div class="col-lg-7">
                                        <input onfocus="this.select()" type="text" name="uniqueIdentifier" value="<c:out value="${uniqueIdentifier}"/>" class="form-control" id="personidinput">
                                        <jsp:include page="showMessage.jsp"><jsp:param name="key" value="uniqueIdentifier"/></jsp:include>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${study.studyParameterConfig.subjectPersonIdRequired =='optional'}">
                                <div class="form-group">
                                    <label for="personidinput" class="col-lg-5 control-label"><fmt:message key="person_ID" bundle="${resword}"/></label>
                                    <div class="col-lg-7">
                                        <input onfocus="this.select()" type="text" name="uniqueIdentifier" value="<c:out value="${uniqueIdentifier}"/>" class="form-control" id="personidinput">
                                        <jsp:include page="showMessage.jsp"><jsp:param name="key" value="uniqueIdentifier"/></jsp:include>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="uniqueIdentifier" value="<c:out value="${uniqueIdentifier}"/>">
                            </c:otherwise>
                        </c:choose>

                        <%--enrollment date--%>
                        <div class="form-group hasreq">
                            <label for="enrollmentDateField" class="col-lg-5 control-label"><fmt:message key="enrollment_date" bundle="${resword}"/></label>
                            <div class="col-lg-7">
                                <input onfocus="this.select()" type="text" name="enrollmentDate" value="<c:out value="${enrollmentDate}" />" id="enrollmentDateField" class="form-control" />
                                <jsp:include page="showMessage.jsp"><jsp:param name="key" value="enrollmentDate"/></jsp:include>
                            </div>
                        </div>

                        <%--gender--%>
                        <c:if test="${study.studyParameterConfig.genderRequired !='not used'}">
                            <c:choose>
                                <c:when test="${study.studyParameterConfig.genderRequired !='false'}">
                                    <div class="form-group hasreq">
                                        <label class="col-lg-5 control-label"><fmt:message key="gender" bundle="${resword}"/></label>
                                        <div class="col-lg-7">
                                            <select name="gender" class="form-control">
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
                                            <jsp:include page="showMessage.jsp"><jsp:param name="key" value="gender"/></jsp:include>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:if>

                        <%--date/year of birth--%>
                        <c:choose>
                            <c:when test="${study.studyParameterConfig.collectDob == '1'}">
                                <div class="form-group hasreq">
                                    <label for="dobField" class="col-lg-5 control-label"><fmt:message key="date_of_birth" bundle="${resword}"/></label>
                                    <div class="col-lg-7">
                                        <input onfocus="this.select()" type="text" name="dob" value="<c:out value="${dob}" />" class="form-control" id="dobField" />
                                        <jsp:include page="showMessage.jsp"><jsp:param name="key" value="dob"/></jsp:include>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${study.studyParameterConfig.collectDob == '2'}">
                                <div class="form-group hasreq">
                                    <label for="yobField" class="col-lg-5 control-label"><fmt:message key="year_of_birth" bundle="${resword}"/></label>
                                    <div class="col-lg-7">
                                        <input onfocus="this.select()" type="text" name="yob" value="<c:out value="${yob}" />" class="form-control" id="yobField"/>
                                        (<fmt:message key="date_format_year" bundle="${resformat}"/>)
                                        <jsp:include page="showMessage.jsp"><jsp:param name="key" value="yob"/></jsp:include>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="dob" value="" />
                            </c:otherwise>
                        </c:choose>

                        <%--subject group class--%>
                        <c:if test="${(!empty studyGroupClasses)}">
                            <c:choose>
                                <c:when test="${group.subjectAssignment=='Required'}">
                                    <div class="form-group hasreq">
                                        <label class="col-lg-5 control-label"><fmt:message key="subject_group_class" bundle="${resword}"/></label>
                                        <div class="col-lg-7">
                                            <c:forEach var="group" items="${studyGroupClasses}">
                                                <c:out value="${group.name}"/>
                                                <select name="studyGroupId<c:out value="${count}"/>" class="form-control">
                                                    <option value=""><c:out value="${group.name}"/>:</option>
                                                    <c:forEach var="studyGroup" items="${group.studyGroups}">
                                                        <option value="<c:out value="${studyGroup.id}"/>"><c:out value="${studyGroup.name}"/></option>
                                                    </c:forEach>
                                                </select>
                                                <c:import url="showMessage.jsp"><c:param name="key" value="studyGroupId${count}" /></c:import>
                                                <c:set var="count" value="${count+1}"/>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="form-group">
                                        <label class="col-lg-5 control-label"><fmt:message key="subject_group_class" bundle="${resword}"/></label>
                                        <div class="col-lg-7">
                                            <c:forEach var="group" items="${studyGroupClasses}">
                                                <c:out value="${group.name}"/>
                                                <select name="studyGroupId<c:out value="${count}"/>" class="form-control">
                                                    <option value=""><c:out value="${group.name}"/>:</option>
                                                    <c:forEach var="studyGroup" items="${group.studyGroups}">
                                                        <option value="<c:out value="${studyGroup.id}"/>"><c:out value="${studyGroup.name}"/></option>
                                                    </c:forEach>
                                                </select>
                                                <c:import url="showMessage.jsp"><c:param name="key" value="studyGroupId${count}" /></c:import>
                                                <c:set var="count" value="${count+1}"/>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:if>

                        <%--Study EventD_2--%>
                        <div class="form-group hasreq">
                            <label class="col-lg-5 control-label"><fmt:message key="SED_2" bundle="${resword}"/></label>
                            <div class="col-lg-7">
                                <select name="studyEventDefinition" class="form-control">
                                    <option value=""><fmt:message key="select" bundle="${resword}"/></option>
                                    <c:forEach var="event" items="${allDefsArray}">
                                        <option <c:if test="${studyEventDefinition == event.id}">SELECTED</c:if> value="<c:out value="${event.id}"/>"><c:out value="${event.name}" /></option>
                                    </c:forEach>
                                </select>
                                <jsp:include page="showMessage.jsp"><jsp:param name="key" value="studyEventDefinition"/></jsp:include>
                            </div>
                        </div>

                        <%--start date--%>
                        <div class="form-group hasreq">
                            <label for="enrollmentDateField2" class="col-lg-5 control-label"><fmt:message key="start_date" bundle="${resword}"/></label>
                            <div class="col-lg-7">
                                <input onfocus="this.select()" type="text" name="startDate" value="<c:out value="${startDate}" />" id="enrollmentDateField2" class="form-control" />
                                <jsp:include page="showMessage.jsp"><jsp:param name="key" value="startDate"/></jsp:include>
                            </div>
                        </div>

                        <%--location--%>
                        <c:choose>
                            <c:when test="${study.studyParameterConfig.eventLocationRequired == 'required'}">
                                <div class="form-group hasreq">
                                    <label for="locinput" class="col-lg-5 control-label"><fmt:message key="location" bundle="${resword}"/></label>
                                    <div class="col-lg-7">
                                        <input onfocus="this.select()" type="text" name="location" value="<c:out value="${location}"/>" id="locinput" class="form-control" />
                                        <jsp:include page="showMessage.jsp"><jsp:param name="key" value="location"/></jsp:include>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${study.studyParameterConfig.eventLocationRequired == 'optional'}">
                                <div class="form-group">
                                    <label for="locinput1" class="col-lg-5 control-label"><fmt:message key="location" bundle="${resword}"/></label>
                                    <div class="col-lg-7">
                                        <input onfocus="this.select()" type="text" name="location" id="locinput1" class="form-control" />
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="location" value=""/>
                            </c:otherwise>
                        </c:choose>

                    </form>
                    <%--end of form--%>
                </div>
                <%--end of body of popup--%>

                <%--footer of popup--%>
                <div class="modal-footer">
                    <button type="button" name="cancel" class="btn btn-default" data-dismiss="modal"><fmt:message key="cancel" bundle="${resword}"/></button>
                    <input type="submit" name="addSubject" value="<fmt:message key="add2" bundle="${resword}"/>" class="btn btn-primary">
                </div>
                <%--end of footer--%>

            </div><%--end of modal-content --%>
        </div><%--end of modal-dialog --%>
    </div><%--end of modal fade--%>
</form><%--end of form of requestPasswordModal--%>