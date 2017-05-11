<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.akaza.openclinica.service.user.LdapUserService"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(this.getServletContext());
LdapUserService ldapUserService = (LdapUserService) ctx.getBean(LdapUserService.class);
%>

<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>

<%--
忘记密码的弹框
from login.jsp
FY 2017-4-8
--%>

<%--requestPasswordModal--%>
<form action="${pageContext.request.contextPath}/RequestPassword" method="post" class="form-horizontal">
    <%--modal fade--%>
    <div class="modal fade" id="requestPasswordModal" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">

                <%--标题与关闭--%>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                    <h4 class="modal-title text-center" id="requestPasswordPopLabel">
                        <fmt:message key="request_password_form" bundle="${resword}"/>
                    </h4>
                </div>

                <%--body of popup--%>
                <div class="modal-body">

                    <p><fmt:message key="you_must_be_an_openClinica_member_to_receive_a_password" bundle="${resword}"/></p><!--help word-->
                    <p><a href="<%= ldapUserService.getPasswordRecoveryURL() %>" target="_blank">
                        <fmt:message key="login.requestPassword.retrieveLdapPassword" bundle="${resword}"/>
                    </a></p>
                    <p class="text-center"><fmt:message key="all_fields_are_required" bundle="${resword}"/></p><!--warning-->

                    <%--start of form--%>
                    <form class="form-horizontal">
                        <input type="hidden" name="action" value="confirm">

                        <%--用户名--%>
                        <div class="form-group">
                            <label for="usernameinput" class="col-lg-5 control-label"><fmt:message key="user_name" bundle="${resword}"/></label>
                            <div class="col-lg-7">
                                <input type="text" name="name" class="form-control" id="usernameinput" placeholder="请输入用户名">
                            </div>
                        </div>

                        <%--email--%>
                        <div class="form-group">
                            <label for="emailinput" class="col-lg-5 control-label"><fmt:message key="email" bundle="${resword}"/></label>
                            <div class="col-lg-7">
                                <input type="text" name="email" class="form-control" id="emailinput" placeholder="请输入电子邮件">
                            </div>
                        </div>

                        <%--passwordchallenge question--%>
                        <div class="form-group">
                            <label class="col-lg-5 control-label"><fmt:message key="password_challenge_question" bundle="${resword}"/></label>
                            <div class="col-lg-7">
                                <select name="passwdChallengeQuestion" class="form-control">
                                    <option><fmt:message key="Please_Select_One" bundle="${resword}"/></option>
                                    <option><fmt:message key="favourite_pet" bundle="${resword}"/></option>
                                    <option><fmt:message key="city_of_birth" bundle="${resword}"/></option>
                                    <option><fmt:message key="mother_maiden_name" bundle="${resword}"/></option>
                                    <option><fmt:message key="favorite_color" bundle="${resword}"/></option>
                                </select>
                            </div>
                        </div>

                        <%--password challenge answer--%>
                        <div class="form-group">
                            <label for="pswdclganswer" class="col-lg-5 control-label"><fmt:message key="password_challenge_answer" bundle="${resword}"/></label>
                            <div class="col-lg-7">
                                <input type="text" name="passwdChallengeAnswer" class="form-control" id="pswdclganswer" placeholder="请输入您的答案">
                            </div>
                        </div>
                    </form>
                    <%--end of form--%>
                </div>
                <%--end of body of popup--%>

                <%--footer of popup--%>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="cancel" bundle="${resword}"/></button>
                    <input type="submit" name="Submit" value="<fmt:message key="submit_password_request" bundle="${resword}"/>" class="btn btn-primary">
                </div>
                <%--end of footer--%>

            </div>
            <%--end of modal-content--%>
        </div>
        <%--end of modal-dialog--%>
    </div>
    <%--end of modal fade--%>
</form>
<%--end of form of requestPasswordModal--%>