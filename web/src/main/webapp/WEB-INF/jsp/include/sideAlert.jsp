<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>

<%--
	侧边栏第一块,显示警告信息,比如上次登录时间\操作反馈
	include showSideMessage.jsp
	from menu.jsp
	FY 2017-4-19
--%>

<c:if test="${userBean != null && userBean.id>0}">
	<c:choose>
		<c:when test="${!empty pageMessages || param.message == 'authentication_failed'|| param.alertmessage !=null}">

			<div class="panel panel-warning">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" href="#collapsealert">
							<fmt:message key="alerts_messages" bundle="${resword}"/>
							<span class="glyphicon glyphicon-pushpin pull-right"></span>
						</a>
					</h4>
				</div>
				<div id="collapsealert" class="panel-collapse collapse in">
					<div class="panel-body">
						<c:choose>
							<c:when test="${userBean!= null && userBean.id>0}">
								<jsp:include page="../include/showSideMessage.jsp" />
							</c:when>
							<c:otherwise>
								<fmt:message key="have_logged_out_application" bundle="${resword}"/>
								<a href="MainMenu"><fmt:message key="login_page" bundle="${resword}"/></a>
								<fmt:message key="in_order_to_re_enter_openclinica" bundle="${resword}"/>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

		</c:when>
		<c:otherwise>

			<div class="panel panel-warning">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" href="#collapsealert1">
							<fmt:message key="alerts_messages" bundle="${resword}"/>
							<span class="glyphicon glyphicon-pushpin pull-right"></span>
						</a>
					</h4>
				</div>
				<div id="collapsealert1" class="panel-collapse collapse in">
					<div class="panel-body">
						<c:choose>
							<c:when test="${userBean!= null && userBean.id>0}">
								<jsp:include page="../include/showSideMessage.jsp" />
							</c:when>
							<c:otherwise>
								<fmt:message key="have_logged_out_application" bundle="${resword}"/>
								<a href="MainMenu"><fmt:message key="login_page" bundle="${resword}"/></a>
								<fmt:message key="in_order_to_re_enter_openclinica" bundle="${resword}"/>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</c:if>
