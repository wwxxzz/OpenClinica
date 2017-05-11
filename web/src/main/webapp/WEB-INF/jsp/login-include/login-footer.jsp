<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.licensing" var="licensing"/>

<%--
    登录页面的页脚
    from login.jsp
    FY 2017.4.8
--%>

        <div style="text-align: center;">
            <ul class="nav nav-pills navfooter">
                <li><a href="http://www.openclinica.com" target="new"><fmt:message key="openclinica_portal" bundle="${resword}"/></a></li>
                <li><a href="javascript:openDocWindow('https://docs.openclinica.com')"><fmt:message key="help" bundle="${resword}"/></a></li>
                <li><a href="${pageContext.request.contextPath}/Contact"><fmt:message key="contact" bundle="${resword}"/></a></li>
                <li><a href="http://rj.baidu.com/soft/detail/14744.html?ald" title="Chrome"><span class="glyphicon glyphicon-save"></span>Chrome下载</a></li>
                <li><a>版权信息</a></li>
            </ul>
        </div>
    </body>
</html>
