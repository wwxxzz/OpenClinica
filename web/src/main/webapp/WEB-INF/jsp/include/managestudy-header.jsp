<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.workflow" var="resworkflow"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>

<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<jsp:useBean scope='session' id='study' class='org.akaza.openclinica.bean.managestudy.StudyBean' />
<jsp:useBean scope='session' id='userRole' class='org.akaza.openclinica.bean.login.StudyUserRoleBean' />
<jsp:useBean scope='request' id='isAdminServlet' class='java.lang.String' />

<%--
    该页面为Header(LOGO+导航栏),包含html结构
    include navBar.jsp
    from listCRF.jsp
    FY 2017-4-8
--%>

<!DOCTYPE html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title><fmt:message key="openclinica" bundle="${resword}"/></title>

        <link rel="stylesheet" href="<c:url value='/includes/bootstrap/3.3.7/css/bootstrap.min.css'/>" />

        <script src="<c:url value='/includes/bootstrap/3.3.7/js/jquery.min.js'/>"></script>
        <script src="<c:url value='/includes/bootstrap/3.3.7/js/bootstrap.min.js'/>"></script>

        <%--<link rel="stylesheet" href="includes/styles.css" type="text/css">--%>
        <%--<script type="text/JavaScript" language="JavaScript" src="includes/global_functions_javascript.js"></script>--%>
        <%--<script type="text/JavaScript" language="JavaScript" src="includes/Tabs.js"></script>--%>
        <%--<script type="text/JavaScript" language="JavaScript" src="includes/CalendarPopup.js"></script>--%>
        <%--<!-- Added for the new Calender -->--%>
        <%--<link rel="stylesheet" type="text/css" media="all" href="includes/new_cal/skins/aqua/theme.css" title="Aqua" />--%>
        <%--<script type="text/javascript" src="includes/new_cal/calendar.js"></script>--%>
        <%--<script type="text/javascript" src="includes/new_cal/lang/calendar-en.js"></script>--%>
        <%--<script type="text/javascript" src="includes/new_cal/lang/<fmt:message key="jscalendar_language_file" bundle="${resformat}"/>"></script>--%>
        <%--<script type="text/javascript" src="includes/new_cal/calendar-setup.js"></script>--%>
        <%--<!-- End -->--%>
        <%--<script type="text/JavaScript" language="JavaScript" src="includes/prototype.js"></script>--%>

    </head>

    <body>
    <%--整体页面的container--%>
    <div class="container">

        <%--整个admin-header.jsp核心部分--%>
        <div class="row clearfix">
            <div class="col-lg-12 column">
                <%--整个header--%>
                <div class="row">
                    <%--LOGO--%>
                    <div class="col-lg-2 column">
                        <img src="../../../images/seubadge130.jpg" class="img-responsive" alt="logo">
                    </div>
                    <%--导航栏--%>
                    <div class="col-lg-10 column">
                        <!--navBar.jsp-->
                        <jsp:include page="navBar.jsp"/>
                        <!--end of navBar.jsp-->
                    </div>
                </div>
            </div>
        </div>
        <%--end of 整个admin-header.jsp核心部分--%>