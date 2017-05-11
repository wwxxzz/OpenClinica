<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<jsp:useBean scope='request' id='table' class='org.akaza.openclinica.web.bean.EntityBeanTable'/>

<%--
    该页面为管理研究页面/ListStudy
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
                    <fmt:message key="studies_are_indicated_in_bold" bundle="${restext}"/>
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
                        <fmt:message key="administer_studies" bundle="${resword}"/>
                    </h2>
                    <%--end of 主标题--%>
                </div>
                <%--end of jumbotron--%>
            </div>
        </div>

        <%--主体--%>
        <div class="row">
            <div class="btn-group col-lg-2 col-lg-offset-5 column">
                <button type="button" class="btn btn-primary" onclick="location.href='CreateStudy'">
                    <span class="glyphicon glyphicon-plus"></span>&nbsp;
                    <fmt:message key="create_a_new_study" bundle="${resword}"/>
                </button>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12 column">
                <p>&nbsp;</p><!--divider-->
                <p>
                    <fmt:message key="studies_are_indicated_in_bold" bundle="${restext}"/>
                </p>
                <c:import url="../include/showTable.jsp">
                    <c:param name="rowURL" value="showStudyRow.jsp" />
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








