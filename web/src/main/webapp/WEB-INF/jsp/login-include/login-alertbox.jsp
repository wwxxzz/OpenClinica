<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>

<%--
    当用户名或密码错误时\或用户被锁时
    在登录框中显示相应信息
    include showPageMessages.jsp
    from login.jsp
    FY 2017.4.8
--%>

<% 
    String action = request.getParameter("action");
    if (action!=null) {
       if (action.equals("errorLogin")) { 
%>
            <div class="alert alert-danger">
                <a href="#" class="close" data-dismiss="alert">
                    &times;
                </a>
                <fmt:message key="password_failed" bundle="${restext}"/>
            </div>
<%
       }  
    }
%>

<% 
    if (action!=null) {
       if (action.equals("errorLocked")) { 
%>
            <div class="alert alert-danger">
                <a href="#" class="close" data-dismiss="alert">
                    &times;
                </a>
                <fmt:message key="account_locked" bundle="${restext}"/>
            </div>
<%
       } 
    }
%>
<jsp:include page="../include/showPageMessages.jsp" />
