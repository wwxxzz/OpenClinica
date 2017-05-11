<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.workflow" var="resworkflow"/>

<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<jsp:useBean scope='session' id='userRole' class='org.akaza.openclinica.bean.login.StudyUserRoleBean' />
<jsp:useBean scope='request' id='table' class='org.akaza.openclinica.web.bean.EntityBeanTable'/>

<%--
    该页面为管理受试者页面/ListSubject,内含JMESA表格
    include admin-header.jsp\sideAlert.jsp\sideInfo.jsp\footer.jsp
    FY 2017-4-8
--%>

<!--admin-header.jsp-->
<jsp:include page="../include/admin-header.jsp"/>
<!--end of admin-header.jsp-->

<link rel="stylesheet" href="../../../includes/jmesa/jmesa.css">
<script src="../../../includes/jmesa/jquery.min.js"></script>
<script src="../../../includes/jmesa/jquery.jmesa.js"></script>
<script src="../../../includes/jmesa/jmesa.js"></script>
<script src="../../../includes/jmesa/jquery-migrate-1.1.1.js"></script>
<script>
    function onInvokeAction(id,action) {
        if(id.indexOf('listSubjects') == -1)  {
        setExportToLimit(id, '');
        }
        createHiddenInputFieldsForLimitAndSubmit(id);
    }
    function onInvokeExportAction(id) {
        var parameterString = createParameterStringForLimit(id);
        location.href = '${pageContext.request.contextPath}/ListSubject?'+ parameterString;
    }
</script>


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
                        <fmt:message key="administer_subjects" bundle="${resworkflow}"/>
                    </h2>
                    <%--end of 主标题--%>
                </div>
                <%--end of jumbotron--%>
            </div>
        </div>

        <%--主体--%>
        <div class="row">
            <form  action="${pageContext.request.contextPath}/ListSubject">
                <input type="hidden" name="module" value="submit">
                ${listSubjectsHtml}
            </form>
        </div>
        <%--end of 主体--%>

    </div>
    <%--end of 主内容区--%>
</div>
<%--end of 侧栏与主内容区--%>

<!--footer.jsp-->
<jsp:include page="../include/footer.jsp"/>
<!--end of footer.jsp-->
