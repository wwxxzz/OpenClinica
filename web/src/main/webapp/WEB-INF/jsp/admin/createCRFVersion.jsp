<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.workflow" var="resworkflow"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.page_messages" var="respage"/>

<jsp:useBean scope='session' id='version' class='org.akaza.openclinica.bean.submit.CRFVersionBean'/>
<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<jsp:useBean scope='request' id='crfName' class='java.lang.String'/>

<%--
    该页面为创建新的CRF页面/CreateCRFVersion?module=manage或admin
    include admin-header.jsp\managestudy-header.jsp\sideAlert.jsp\sideInfo.jsp\workflow.jsp\footer.jsp
    FY 2017-4-9
--%>

<script>
    function myCancel() {
        var cancelButton=document.getElementById('cancel');
        if ( cancelButton != null) {
            if(confirm('<fmt:message key="sure_to_cancel" bundle="${resword}"/>')) {
                window.location.href="ListCRF?module=" + "<c:out value="${module}"/>";
                return true;
            } else {
                return false;
            }
        }
        return true;
    }
    function submitform(){
        var crfUpload = document.getElementById('excel_file_path');
        //Does the user browse or select a file or not
        if (crfUpload.value =='' ) {
            alert("Select a file to upload!");
            return false;
        }
    }
    function submitXform(){
        var crfName = document.getElementById('crfName');
        var versionName = document.getElementById('versionName');
        var versionDescription = document.getElementById('versionDescription');
        var revisionNotes = document.getElementById('revisionNotes');
        var xformText = document.getElementById('xformText');

        if (crfName && crfName.value =='' ) {
            alert('<fmt:message key="xform_upload_crfName" bundle="${resword}"/>');
            return false;
        } else if (versionName.value =='' ){
            alert('<fmt:message key="xform_upload_version" bundle="${resword}"/>');
            return false;
        } else if (versionDescription.value =='' ){
            alert('<fmt:message key="xform_upload_version_description" bundle="${resword}"/>');
            return false;
        } else if (revisionNotes.value =='' ){
            alert('<fmt:message key="xform_upload_version_revision_notes" bundle="${resword}"/>');
            return false;
        } else if (xformText.value =='' ){
            alert('<fmt:message key="xform_upload_xform_contents" bundle="${resword}"/>');
            return false;
        }
    }
</script>

<!--两种header-->
<c:choose>
    <c:when test="${userBean.sysAdmin && module=='admin'}">
        <c:import url="../include/admin-header.jsp"/>
    </c:when>
    <c:otherwise>
        <c:import url="../include/managestudy-header.jsp"/>
    </c:otherwise>
</c:choose>
<!--end of 两种header-->

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
            <div id="collapseins" class="panel-collapse collapse in">
                <div class="panel-body">
                    <b><fmt:message key="create_CRF" bundle="${resword}"/> : </b>
                    <fmt:message key="br_create_new_CRF_entering" bundle="${respage}"/><br/>
                    <b><fmt:message key="create_CRF_version" bundle="${resword}"/> : </b>
                    <fmt:message key="br_create_new_CRF_uploading" bundle="${respage}"/><br/>
                    <b><fmt:message key="revise_CRF_version" bundle="${resword}"/> : </b>
                    <fmt:message key="br_if_you_owner_CRF_version" bundle="${respage}"/><br/>
                    <b><fmt:message key="CRF_spreadsheet_template" bundle="${resword}"/> : </b>
                    <fmt:message key="br_download_blank_CRF_spreadsheet_from" bundle="${respage}"/><br/>
                    <b><fmt:message key="example_CRF_br_spreadsheets" bundle="${resword}"/> : </b>
                    <fmt:message key="br_download_example_CRF_instructions_from" bundle="${respage}"/><br/>
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

        <%--start of jumbotron--%>
        <div class="jumbotron">
            <%--主标题--%>
            <h2 class="text-center">
                <c:choose>
                    <c:when test="${empty crfName}">
                        <fmt:message key="create_a_new_CRF_case_report_form" bundle="${resworkflow}"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="create_CRF_version" bundle="${resworkflow}"/> <c:out value="${crfName}"/>
                    </c:otherwise>
                </c:choose>
            </h2>
            <%--end of 主标题--%>
        </div>
        <%--end of jumbotron--%>

        <%--start of 主体内容--%>
            <!--tabnavs-->
            <ul id="uploadtab" class="nav nav-tabs">
                <li class="active">
                    <a href="#excel" data-toggle="tab">
                        <fmt:message key="xls_file_upload" bundle="${resword}"/>
                    </a>
                </li>
                <c:if test="${xformEnabled == 'true'}">
                    <li>
                        <a href="#xform" data-toggle="tab">
                            <fmt:message key="xform_file_upload" bundle="${resword}"/>
                        </a>
                    </li>
                </c:if>
            </ul>
            <!--end of tabnavs-->

            <!--tabbody-->
            <div id="uploadtabContent" class="tab-content">

                <!--tab for excel upload-->
                <div class="tab-pane fade in active" id="excel">

                    <div>&nbsp;</div>

                    <div class="row">

                        <div class="col-lg-6 column">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h3 class="panel-title">
                                        <fmt:message key="ms_excel_file_to_upload" bundle="${resword}"/>
                                    </h3>
                                </div>
                                <form action="CreateCRFVersion?action=confirm&crfId=<c:out value="${version.crfId}"/>&name=<c:out value="${version.name}"/>" method="post" ENCTYPE="multipart/form-data">
                                    <div class="panel-body">
                                        <input type="file" name="excel_file" id="excel_file_path">
                                        <jsp:include page="../showMessage.jsp">
                                            <jsp:param name="key" value="excel_file"/>
                                        </jsp:include>
                                        <input type="hidden" name="crfId" value="<c:out value="${version.crfId}"/>">
                                    </div>
                                    <div class="panel-footer">
                                        <button type="submit" onclick="return submitform();" class="btn btn-primary">
                                            <span class="glyphicon glyphicon-eye-open"></span>
                                            <fmt:message key="preview_CRF_version" bundle="${resword}"/>
                                        </button>
                                        <button type="button" class="btn btn-default" onclick="location.href='ListCRF?module=<c:out value="${module}"/>'">
                                            <fmt:message key="exit" bundle="${resword}"/>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="col-lg-6 column">
                            <div class="alert alert-info">
                                <fmt:message key="can_download_blank_CRF_excel" bundle="${restext}"/>
                                <a href="DownloadVersionSpreadSheet?template=1">
                                    <b><fmt:message key="here" bundle="${resword}"/></b>
                                </a>
                            </div>
                            <div class="alert alert-warning">
                                <fmt:message key="openclinica_excel_support" bundle="${restext}"/>
                            </div>
                        </div>

                    </div>
                </div>
                <!--end of tab for excel upload-->

                <!--tab for xform upload-->
                <c:if test="${xformEnabled == 'true'}">
                    <div class="tab-pane fade" id="xform">
                        <form id="xformSubmit" action="CreateXformCRFVersion?action=confirm&crfId=<c:out value="${version.crfId}"/>&name=<c:out value="${version.name}"/>" method="post" ENCTYPE="multipart/form-data">
                            <table class="table table-bordered">
                                <tbody>
                                <c:if test="${empty CrfId}">
                                    <tr>
                                        <td><label for="crfName"><fmt:message key="CRF_name" bundle="${resword}"/></label></td>
                                        <td><input type="text" id="crfName" name="crfName"/></td>
                                    </tr>
                                </c:if>
                                <tr>
                                    <td><label for="versionName"><fmt:message key="version_name" bundle="${resword}"/></label></td>
                                    <td><input type="text" id="versionName" name="versionName"/></td>
                                </tr>
                                <tr>
                                    <td><label for="versionDescription"><fmt:message key="crf_version_description" bundle="${resword}"/></label></td>
                                    <td><input type="text" id="versionDescription" name="versionDescription"/></td>
                                </tr>
                                <tr>
                                    <td><label for="revisionNotes"><fmt:message key="revision_notes" bundle="${resword}"/></label></td>
                                    <td><input type="text" id="revisionNotes" name="revisionNotes"/></td>
                                </tr>
                                </tbody>
                            </table>
                            <div>
                                <textarea class="crf-upload-padded-div" id="xformText" name="xformText" rows="40" cols="60"></textarea>
                            </div>
                            <p><fmt:message key="xform_upload_media_instruction" bundle="${resword}"/></p>

                            <fmt:message key="upload_media_files" bundle="${resword}"/>
                            <input type="file" name="media_file" id="xform_media_file_path" multiple>
                            <jsp:include page="../showMessage.jsp">
                                <jsp:param name="key" value="excel_file"/>
                            </jsp:include>
                            <input type="hidden" name="crfId" value="<c:out value="${version.crfId}"/>">
                            <input type="submit" onclick="return submitXform()" value="<fmt:message key="submit" bundle="${resword}"/>" class="button_medium">
                            <input type="button" onclick="location.href='ListCRF?module=<c:out value="${module}"/>'" name="exit" value="<fmt:message key="exit" bundle="${resword}"/>   "class="button_medium"/>
                        </form>
                    </div>
                </c:if>
                <!--end of tab for xform upload-->
            </div>
            <!--end of tabbody-->

            <%--<c:choose>--%>
                <%--<c:when test="${userBean.sysAdmin && module=='admin'}">--%>
                    <%--<c:import url="../include/workflow.jsp">--%>
                        <%--<c:param name="module" value="admin"/>--%>
                    <%--</c:import>--%>
                <%--</c:when>--%>
                <%--<c:otherwise>--%>
                    <%--<c:import url="../include/workflow.jsp">--%>
                        <%--<c:param name="module" value="manage"/>--%>
                    <%--</c:import>--%>
                <%--</c:otherwise>--%>
            <%--</c:choose>--%>
        <%--end of 主体内容--%>

    </div>
    <%--end of 主内容区--%>

</div>
<%--end of 侧栏与主内容区--%>

<!--footer.jsp-->
<jsp:include page="../include/footer.jsp"/>
<!--end of footer.jsp-->
