<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.workflow" var="resworkflow"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>

<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<jsp:useBean scope='session' id='userRole' class='org.akaza.openclinica.bean.login.StudyUserRoleBean' />
<jsp:useBean scope='request' id='table' class='org.akaza.openclinica.web.bean.EntityBeanTable'/>

<%--
    该页面为管理CRF页面/ListCRF,分为admin和manage权限,权限不同时显示的不同
    include admin-header.jsp\managestudy-header.jsp\sideAlert.jsp\showTable.jsp\showStudyRow.jsp\footer.jsp
    FY 2017-4-8
--%>

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
                    <fmt:message key="CRF_library_shows_all_CRFs" bundle="${restext}"/>
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
                    <c:when test="${userBean.sysAdmin && module=='admin'}">
                        <fmt:message key="administer_CRFs2" bundle="${resworkflow}"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="manage_CRFs2" bundle="${resworkflow}"/>
                    </c:otherwise>
                </c:choose>
            </h2>
            <%--end of 主标题--%>
        </div>
        <%--end of jumbotron--%>

        <%--start of 主体内容--%>
        <c:import url="../include/showTable.jsp">
            <c:param name="rowURL" value="showCRFRow.jsp" />
        </c:import>
        <%--end of 主体内容--%>

    </div>
    <%--end of 主内容区--%>
</div>
<%--end of 侧栏与主内容区--%>

<!--footer.jsp-->
<jsp:include page="../include/footer.jsp"/>
<!--end of footer.jsp-->

