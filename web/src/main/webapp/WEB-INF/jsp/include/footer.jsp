<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.licensing" var="licensing"/>

<%--
    主页的页脚
    from menu.jsp
    FY 2017-4-8
--%>

<%-- Footer --%>
<nav class="navbar navbar-default navbar-fixed-bottom" style="display: flex;">
    <div style="margin: auto;">
        <ul class="nav nav-pills navfooterlight">
            <li><a href="http://www.openclinica.com" target="new"><fmt:message key="openclinica_portal" bundle="${resword}"/></a></li>
            <li><a href="javascript:openDocWindow('https://docs.openclinica.com')"><fmt:message key="help" bundle="${resword}"/></a></li>
            <li><a href="${pageContext.request.contextPath}/Contact"><fmt:message key="contact" bundle="${resword}"/></a></li>
            <li><a href="http://rj.baidu.com/soft/detail/14744.html?ald" title="Chrome"><span class="glyphicon glyphicon-save"></span>Chrome下载</a></li>
            <li><a>版权信息</a></li>
        </ul>
    </div>
</nav>
<style>
    body{
        padding-bottom: 70px;
    }
</style>
<%-- End Footer --%>
<%--<style>--%>
    <%--.navfooterlight{--%>
        <%--display: inline-block;--%>
        <%--border-radius: 4px;--%>
        <%--background: rgba(238,238,238,0.9);--%>
    <%--}--%>
<%--</style>--%>

    </body>
</html>
