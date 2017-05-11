<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<jsp:useBean scope='session' id='userBean' class='org.akaza.openclinica.bean.login.UserAccountBean'/>
<jsp:useBean scope='request' id='crf' class='org.akaza.openclinica.bean.admin.CRFBean'/>

<%--
    该页面为显示受试者矩阵页面/ListStudySubjects,内含JMESA表格
    include admin-header.jsp\managestudy-header.jsp\sideAlert.jsp\addNewSubjectExpressNew.jsp\footer.jsp
    FY 2017-4-9
--%>

<!--header-->
<jsp:include page="../include/submit-header.jsp"/>
<!--end of header-->

<link rel="stylesheet" href="../../../includes/jmesa/jmesa.css">
<script src="../../../includes/jmesa/jquery.min.js"></script>
<script src="../../../includes/jmesa/jquery.jmesa.js"></script>
<script src="../../../includes/jmesa/jmesa.js"></script>
<script src="../../../includes/jmesa/jquery.blockUI.js"></script>
<script src="../../../includes/jmesa/jquery-migrate-1.1.1.js"></script>
<script>
    function onInvokeAction(id,action) {
        if(id.indexOf('findSubjects') == -1)  {
            setExportToLimit(id, '');
        }
        createHiddenInputFieldsForLimitAndSubmit(id);
    }
    function onInvokeExportAction(id) {
        var parameterString = createParameterStringForLimit(id);
        location.href = '${pageContext.request.contextPath}/ListStudySubjects?'+ parameterString;
    }
    jQuery(document).ready(function() {
        jQuery('#addSubject').click(function() {
            jQuery.blockUI({ message: jQuery('#addSubjectForm'), css:{left: "300px", top:"10px" } });
        });

        jQuery('#cancel').click(function() {
            jQuery.unblockUI();
            return false;
        });
    });
</script>
<script>
    <c:if test="${showOverlay}">
    jQuery.blockUI({ message: jQuery('#addSubjectForm'), css:{left: "300px", top:"10px" } });
    </c:if>
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
            <div id="collapseins" class="panel-collapse collapse in">
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

        <%--start of jumbotron--%>
        <div class="jumbotron">
            <%--主标题--%>
            <h2 class="text-center">
                <fmt:message key="view_subjects_in" bundle="${restext}"/> <c:out value="${study.name}"/>
            </h2>
            <%--end of 主标题--%>
        </div>
        <%--end of jumbotron--%>

        <%--start of 主体内容--%>
        <div id="findSubjectsDiv">
            <form action="${pageContext.request.contextPath}/ListStudySubjects">
                <input type="hidden" name="module" value="admin">
                ${findSubjectsHtml}
            </form>
        </div>
        <div id="addSubjectForm" style="display:none;">
            <c:import url="../submit/addNewSubjectExpressNew.jsp"/>
        </div>
        <%--end of 主体内容--%>

    </div>
    <%--end of 主内容区--%>
</div>
<%--end of 侧栏与主内容区--%>

<!--footer.jsp-->
<jsp:include page="../include/footer.jsp"/>
<!--end of footer.jsp-->