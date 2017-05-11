<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<%--已登录用户重定向至首页--%>
<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
    <c:if test="${userBean.name!=''}">
        <c:redirect url="/MainMenu"/>
    </c:if>


<%--
    更新登录页,添加BS
    包含login-alertbox.jsp\requestPasswordPop.jsp\login-footer.jsp\showMessage.jsp
    FY 2017-4-8
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login</title>

        <link rel="stylesheet" href="<c:url value='/includes/bootstrap/3.3.7/css/bootstrap.min.css'/>" type="text/css"/>
        <style>
            .innerbg{
                padding: 50px 0px 100px 0px;
            }
            .suggestbrowser{
                background: rgba(255, 99, 71, 0.7);
                border-radius: 6px;
                line-height: 1.2em;
            }
            .suggestbrowser h4{
                color: black;
                padding: 10px;
            }
            .form-box{
                overflow: hidden;
                padding: 25px 5px 0px 5px;
                background: rgba(	248,248,255, 0.7);
                border-radius: 6px;
            }
            .form-box label{
                color: black;
            }
            .alertbox{
                margin-top: 10px;
            }
            .footertemp{
                margin-top: 110px; /*for login page footer position*/
            }
            .navfooter{
                display: inline-block;
                background: rgba(0,0,0,0.5);
                border-radius: 4px;
            }
        </style>

        <script src="<c:url value='/includes/bootstrap/3.3.7/js/jquery.min.js'/>"></script>
        <script src="<c:url value='/includes/bootstrap/3.3.7/js/bootstrap.min.js'/>"></script>
        <script src="../../../includes/ua-parser.min.js"></script><%--获取浏览器信息--%>
        <script src="../../../includes/jquery.backstretch.min.js"></script><%--背景拉伸--%>
        <%--设置背景图片--%>
        <script>
            jQuery(document).ready(function() {
                $.backstretch("../../../images/bgseupaint.png");
            });
        </script>
    </head>

    <fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
    <fmt:setBundle basename="org.akaza.openclinica.i18n.workflow" var="resworkflow"/>
    <fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
    <fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>

    <body onLoad="document.getElementById('username').focus();">
        <div class="innerbg"><!--css-->

            <%--整体页面的container--%>
            <div class="container">

                <%--SEU LOGO--%>
                <div class="row">
                    <div class="col-lg-6 col-lg-offset-3" align="center">
                        <img src="../../../images/seulogo.png" alt="SEULOGO" class="img-responsive">
                    </div>
                </div>

                <%--浏览器检测--%>
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="suggestbrowser"><!--css-->
                            <script type="text/javascript">
                                var isChrome = window.navigator.userAgent.indexOf("Chrome") !== -1;
                                if (isChrome) {}
                                else {
                                    alert("您正在使用的不是Chrome浏览器,为了使您获得最佳体验,我们建议您安装使用Chrome浏览器(可以通过页面下方[建议的浏览器]链接下载)");
                                    document.write("<h4 class='text-center'>"+"<fmt:message key="choose_browser" bundle="${restext}"/>"+ "</h4>");
                                }
                            </script>
                        </div>
                    </div>
                </div>


                <%--登录表单--%>
                <div class="row">
                    <div class="col-lg-4 col-lg-offset-4 form-box"><!--css-->
                        <div class="row">

                            <form class="form-horizontal" role="form" action="<c:url value='/j_spring_security_check'/>" method="post">

                                <div class="form-group"><!--username-->
                                    <label for="username" class="col-lg-5 control-label"><fmt:message key="user_name" bundle="${resword}"/></label>
                                    <div class="col-lg-5">
                                        <input type="text" id="username" name="j_username" class="form-control" placeholder="请输入用户名">
                                    </div>
                                </div>

                                <div class="form-group"><!--password-->
                                    <label for="j_password" class="col-lg-5 control-label"><fmt:message key="password" bundle="${resword}"/></label>
                                    <div class="col-lg-5">
                                        <input type="password" id="j_password" name="j_password" class="form-control" placeholder="请输入密码" autocomplete="off">
                                    </div>
                                </div>

                                <div class="form-group"><!--login button-->
                                    <div class="col-lg-offset-5 col-lg-5">
                                        <button type="submit" class="btn btn-primary" name="submit" value="login" style="width: 100%;"><fmt:message key='login' bundle='${resword}'/></button>
                                    </div>
                                </div>

                                <div class="form-group"><!--requestpassword-->
                                    <div class="col-lg-offset-5 col-lg-5">
                                        <a data-toggle="modal" href="#requestPasswordModal"><fmt:message key="forgot_password" bundle="${resword}"/></a>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>

                <%--登录出错alertbox--%>
                <div class="row alertbox">
                    <div class="col-lg-4 col-lg-offset-4"><!--css-->
                        <jsp:include page="../login-include/login-alertbox.jsp"/>
                    </div>
                </div>

            </div>
            <%--end of 整体页面的container--%>

            <%--start of form of requestPasswordModal--%>
            <jsp:include page="requestPasswordPop.jsp"/>
            <%--end of form of requestPasswordModal--%>

        </div><!--end of innerbg-->

        <%--页脚--%>
        <jsp:include page="../login-include/login-footer.jsp"/>
