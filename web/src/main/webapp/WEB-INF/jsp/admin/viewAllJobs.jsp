<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>
<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<jsp:useBean scope='request' id='table' class='org.akaza.openclinica.web.bean.EntityBeanTable'/>
<jsp:useBean scope='request' id='message' class='java.lang.String'/>
<jsp:useBean id="now" class="java.util.Date" />

<%--
    该页面为管理任务页面/ViewAllJobs
    include admin-header.jsp\sideAlert.jsp\sideInfo.jsp\footer.jsp
    FY 2017-4-8
--%>

<!--admin-header.jsp-->
<jsp:include page="../include/admin-header.jsp"/>
<!--end of admin-header.jsp-->

<%--侧栏和主内容区--%>
<div class="row clearfix">
    <%--sidebar--%>
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

                </div>
            </div>
        </div>
        <%--end of instructions--%>

        <!--sideInfo暂时禁用-->
        <%--<jsp:include page="../include/sideInfo.jsp"/>--%>
        <!--end of sideInfo-->

    </div>
    <%--end of sidebar--%>

    <%--主内容区--%>
    <div class="col-lg-10 column">

        <div class="row">
            <div class="col-lg-12 column">
                <%--start of jumbotron--%>
                <div class="jumbotron">
                    <%--主标题--%>
                    <h2 class="text-center">
                        <fmt:message key="administer_all_jobs" bundle="${resword}"/>
                    </h2>
                    <%--end of 主标题--%>
                </div>
                <%--end of jumbotron--%>
            </div>
        </div>

        <div class="row">
            <%--主体内容--%>
            <div class="btn-group col-lg-10 col-lg-offset-1 column">
                <button type="button" class="btn btn-primary" onclick="location.href='ViewJob'">
                    <span class="glyphicon glyphicon-log-out"></span>&nbsp;
                    <fmt:message key="view_all_export_data_jobs" bundle="${resword}"/>
                </button>
                <button type="button" class="btn btn-primary" onclick="location.href='ViewImportJob'">
                    <span class="glyphicon glyphicon-log-in"></span>&nbsp;
                    <fmt:message key="view_all_import_data_jobs" bundle="${resword}"/>
                </button>
                <button type="button" class="btn btn-primary" onclick="location.href='pages/listCurrentScheduledJobs'">
                    <span class="glyphicon glyphicon-eye-open"></span>&nbsp;
                    <fmt:message key="view_currently_executing_data_export_jobs" bundle="${resword}"/>
                </button>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12 column">
                <p>&nbsp;</p><!--divider-->
                <p>
                    <fmt:message key="note_that_job_is_set" bundle="${resword}"/>
                    <c:set var="dtetmeFormat">
                        <fmt:message key="date_time_format_string" bundle="${resformat}"/>
                    </c:set>
                    <fmt:formatDate value="${now}" pattern="${dtetmeFormat}"/>.
                </p>
            </div>
        </div>
        <%--end of 主体内容--%>

    </div>
    <%--end of 主内容区--%>
</div>
<%--end of 侧栏与主内容区--%>

<p>&nbsp;</p><!--divider-->

<!--footer.jsp-->
<jsp:include page="../include/footer.jsp"/>
<!--end of footer.jsp-->