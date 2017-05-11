<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<jsp:useBean scope='request' id='table' class='org.akaza.openclinica.web.bean.EntityBeanTable'/>
<jsp:useBean scope='request' id='message' class='java.lang.String'/>

<%--
    该页面为管理用户页面/ListUserAccounts
    include home-header.jsp\sideAlert.jsp\showTable.jsp\showStudyRow.jsp\footer.jsp
    FY 2017-4-8
--%>

<!--admin-header.jsp-->
<jsp:include page="../include/admin-header.jsp"/>
<!--end of admin-header.jsp-->

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
                        <fmt:message key="administer_users" bundle="${resword}"/>
                    </h2>
                    <%--end of 主标题--%>
                </div>
                <%--end of jumbotron--%>
            </div>
        </div>

        <%--主体--%>
        <div class="row">
            <div class="btn-group col-lg-10 col-lg-offset-1 column">
                <button type="button" class="btn btn-primary" onclick="location.href='CreateUserAccount'">
                    <span class="glyphicon glyphicon-plus"></span>&nbsp;
                    <fmt:message key="create_a_new_user" bundle="${resword}"/>
                </button>
                <button type="button" class="btn btn-primary" onclick="location.href='AuditUserActivity?restore=true'">
                    <span class="glyphicon glyphicon-eye-open"></span>&nbsp;
                    <fmt:message key="audit_user_activity" bundle="${resword}"/>
                </button>
                <button type="button" class="btn btn-primary" onclick="location.href='Configure'">
                    <span class="glyphicon glyphicon-lock"></span>&nbsp;
                    <fmt:message key="lock_out_configuration" bundle="${resword}"/>
                </button>
                <button type="button" class="btn btn-primary" onclick="location.href='ConfigurePasswordRequirements'">
                    <span class="glyphicon glyphicon-cog"></span>&nbsp;
                    <fmt:message key="configure_password_requirements" bundle="${resword}"/>
                </button>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12 column">
                <p>&nbsp;</p><!--divider-->
                <c:import url="../include/showTable.jsp">
                    <c:param name="rowURL" value="showUserAccountRow.jsp" />
                </c:import>
            </div>
        </div>
        <%--end of 主体--%>

    </div>
    <%--end of 主内容区--%>
</div>
<%--end of 侧栏与主内容区--%>

<!--footer.jsp-->
<jsp:include page="../include/footer.jsp"/>
<!--end of footer.jsp-->

