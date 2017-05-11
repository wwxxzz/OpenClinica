<%@ page contentType="text/html; charset=UTF-8" %>
<%-- calling syntax:
	(assuming showTable.jsp and userRow.jsp are in the same directory)
	<c:import url="../include/showTable.jsp">
	    <c:param name="rowURL" value="userRow.jsp" />
	</c:import>
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>

<jsp:useBean scope="request" id="table" class="org.akaza.openclinica.web.bean.EntityBeanTable" />

<%--
    该JSP用来在studyList.jsp\listuseraccounts.jsp\ListCRF.jsp上显示表格
    调用语法如上所示
    include showSubmitted.jsp
    FY 2017-4-8
--%>

<c:set var="rowURL" value="${param.rowURL}" />
<c:set var="outerFormName" value="${param.outerFormName}" />
<c:set var="searchFormOnClickJS" value="${param.searchFormOnClickJS}" />

<c:choose>
	<c:when test='${(outerFormName != null) && (outerFormName != "")}'>
		<c:set var="searchFormDisplayed" value="${0}"/>
	</c:when>
	<c:otherwise>
		<c:set var="searchFormDisplayed" value="${1}"/>
	</c:otherwise>
</c:choose>

<%-- transform booleans --%>
<c:choose>
	<c:when test="${table.ascendingSort}">
		<c:set var="ascending" value="${1}" />
	</c:when>
	<c:otherwise>
		<c:set var="ascending" value="${0}" />
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${table.filtered}">
		<c:set var="filtered" value="${1}" />
	</c:when>
	<c:otherwise>
		<c:set var="filtered" value="${0}" />
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${table.paginated}">
		<c:set var="paginated" value="${1}" />
	</c:when>
	<c:otherwise>
		<c:set var="paginated" value="${0}" />
	</c:otherwise>
</c:choose>

<c:set var="firstPageQuery" value="${table.baseGetQuery}&module=${module}&ebl_page=1&ebl_sortColumnInd=${table.sortingColumnInd}&ebl_sortAscending=${ascending}&ebl_filtered=${filtered}&ebl_filterKeyword=${table.keywordFilter}&ebl_paginated=1" />
<c:set var="prevPageQuery" value="${table.baseGetQuery}&module=${module}&ebl_page=${table.currPageNumber - 1}&ebl_sortColumnInd=${table.sortingColumnInd}&ebl_sortAscending=${ascending}&ebl_filtered=${filtered}&ebl_filterKeyword=${table.keywordFilter}&ebl_paginated=1" />
<c:set var="nextPageQuery" value="${table.baseGetQuery}&module=${module}&ebl_page=${table.currPageNumber + 1}&ebl_sortColumnInd=${table.sortingColumnInd}&ebl_sortAscending=${ascending}&ebl_filtered=${filtered}&ebl_filterKeyword=${table.keywordFilter}&ebl_paginated=1" />
<c:set var="lastPageQuery" value="${table.baseGetQuery}&module=${module}&ebl_page=${table.totalPageNumbers}&ebl_sortColumnInd=${table.sortingColumnInd}&ebl_sortAscending=${ascending}&ebl_filtered=${filtered}&ebl_filterKeyword=${table.keywordFilter}&ebl_paginated=1" />
<c:set var="viewAllQuery" value="${table.baseGetQuery}&module=${module}&ebl_page=${1}&ebl_sortColumnInd=${table.sortingColumnInd}&ebl_sortAscending=${ascending}&ebl_filtered=0&ebl_filterKeyword=&ebl_paginated=0" />
<c:set var="doNotPaginateQuery" value="${table.baseGetQuery}&module=${module}&ebl_page=1&ebl_sortColumnInd=${table.sortingColumnInd}&ebl_sortAscending=${ascending}&ebl_filtered=${filtered}&ebl_filterKeyword=${table.keywordFilter}&ebl_paginated=0" />
<c:set var="paginateQuery" value="${table.baseGetQuery}&module=${module}&ebl_page=1&ebl_sortColumnInd=${table.sortingColumnInd}&ebl_sortAscending=${ascending}&ebl_filtered=${filtered}&ebl_filterKeyword=${table.keywordFilter}&ebl_paginated=1" />
<c:set var="removeFilterQuery" value="${table.baseGetQuery}&module=${module}&ebl_page=${table.currPageNumber}&ebl_sortColumnInd=${table.sortingColumnInd}&ebl_sortAscending=${ascending}&ebl_filtered=0&ebl_filterKeyword=&ebl_paginated=${paginated}" />

<%-- Table Actions rows (pagination, search, tools) --%>

<%-- Search cell (for multi-page tables) --%>
<div class="row">
	<c:if test="${searchFormDisplayed != 0}">
	<form action="<c:out value="${table.postAction}" />?module=${module}" method="POST">
		</c:if>
		<jsp:include page="showSubmitted.jsp" />
		<c:forEach var="postArg" items="${table.postArgs}">
			<input type="hidden" name="<c:out value="${postArg.key}"/>" value="<c:out value="${postArg.value}"/>" />
		</c:forEach>
		<input type="hidden" name="ebl_page" value="<c:out value="${table.currPageNumber}" />" />
		<input type="hidden" name="ebl_sortColumnInd" value="<c:out value="${table.sortingColumnInd}"/>" />
		<input type="hidden" name="ebl_sortAscending" value="<c:out value="${ascending}"/>"/>
		<input type="hidden" name="ebl_filtered" value="1" />
		<input type="hidden" name="ebl_paginated" value="<c:out value="${paginated}"/>" />
		<div class="col-lg-10 col-lg-offset-1 column">
			<div class="input-group">
				<input name="ebl_filterKeyword" type="text" class="form-control" value="<c:out value="${table.keywordFilter}"/>" />
				<span class="input-group-btn">
				<button type="submit" class="btn btn-info btn-search"
						<c:choose>
							<c:when test="${searchFormDisplayed == 0}">
								onClick="if (document.<c:out value="${outerFormName}"/>.ebl_filterKeyword.value == '') return false; document.<c:out value="${outerFormName}"/>.elements['submitted'].value=0;document.<c:out value="${outerFormName}"/>.elements['action'].value='';<c:out value="${searchFormOnClickJS}" escapeXml="false" />"
							</c:when>
							<c:otherwise>
								onClick="if (document.forms[0].ebl_filterKeyword.value == '') return false;"
							</c:otherwise>
						</c:choose>
				><span class="glyphicon glyphicon-search"></span>&nbsp;<fmt:message key="find" bundle="${resword}"/></button>
				<c:set var="isFirstLink" value="${true}" />
				<c:if test="${table.filtered}">
					<button type="button" class="btn btn-info" onclick="location.href='<c:out value="${removeFilterQuery}"/>'">
						<span class="glyphicon glyphicon-erase"></span>
                        <fmt:message key="clear_search_keywords" bundle="${restext}"/>
					</button>
					<c:set var="isFirstLink" value="${false}" />
				</c:if>
					<%-- Table Tools/Actions--%>
				<c:forEach var="link" items="${table.links}">
					<c:choose>
						<c:when test="${link.caption != 'OpenClinica CRF Library'}">
							<button type="button" class="btn btn-primary" onclick="location.href='<c:out value="${link.url}"/>'">
								<c:out value="${link.caption}" />
							</button>
						</c:when>
						<c:otherwise>
					<button type="button" class="btn btn-primary" onclick="location.href='<c:out value="${link.url}"/>'">
						<c:out value="${link.caption}" />
					</button>
						</c:otherwise>
					</c:choose>
					<c:set var="isFirstLink" value="${false}" />
				</c:forEach>
					<%-- End Table Tools/Actions--%>
			</span>
			</div>
		</div>
		<c:if test="${searchFormDisplayed != 0}">
	</form>
	</c:if>
</div>
<%-- End Search cell --%>

<%-- Pagination cell (for multi-page tables) first and back icons --%>
<div class="row">
	<div class="col-lg-8 col-lg-offset-2 column">
		<ul class="pager">
			<%--home and back icons--%>
			<li><a href="<c:out value="${firstPageQuery}"/>">
				<span class="glyphicon glyphicon-fast-backward"></span> Home
			</a></li>
			<li><a href="<c:out value="${prevPageQuery}"/>">
				<span class="glyphicon glyphicon-backward"></span> Back
			</a></li>
			<%--Page x of x--%>
			<li>
				<a href="#">
					<c:choose>
						<c:when test="${empty table.rows}">
							<fmt:message key="no_pages" bundle="${resword}"/>
						</c:when>
						<c:otherwise>
							<fmt:message key="page" bundle="${resword}"/>
							<c:out value="${table.currPageNumber}" />
							<fmt:message key="of" bundle="${resword}"/>
							<c:out value="${table.totalPageNumbers}" />
						</c:otherwise>
					</c:choose>
				</a>
			</li>
			<%--next and last icons--%>
			<li><a href="<c:out value="${nextPageQuery}"/>">
				Next <span class="glyphicon glyphicon-forward"></span>
			</a></li>
			<li><a href="<c:out value="${lastPageQuery}"/>">
				End <span class="glyphicon glyphicon-fast-forward"></span>
			</a></li>
		</ul>
	</div>
</div>
<%-- End Pagination cell --%>

<%-- end Table Actions rows (pagination, search, tools) --%>

<%--start of data table--%>
<table class="table table-bordered table-striped">
	<tbody>
	<c:choose>
		<c:when test="${empty table.columns}">
			<tr>
				<td>
					<c:choose>
						<c:when test='${table.noColsMessage == ""}'>
							<fmt:message key="there_are_no_columns_to_display" bundle="${restext}"/>
						</c:when>
						<c:otherwise>
							<c:out value="${table.noColsMessage}" />
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<%-- Column Headers --%>
			<tr>
				<c:set var="i" value="${0}" />
				<c:forEach var="column" items="${table.columns}">

					<%-- BEGIN SET ORDER BY QUERY --%>
					<c:choose>
						<%-- if the user clicks on the column which is already the current sorting column, flip the sorting order; if he clicks on a different column, default to ascending --%>
						<%-- note that (1 - x) flips a boolean value x, if x = 1 or x = 0 --%>
						<c:when test="${table.sortingColumnInd == i}">
							<c:set var="showAscending" value="${1 - ascending}" />
						</c:when>
						<c:otherwise>
							<c:set var="showAscending" value="${1}" />
						</c:otherwise>
					</c:choose>
					<c:set var="orderByQuery" value="${table.baseGetQuery}&module=${module}&ebl_page=1&ebl_sortColumnInd=${i}&ebl_sortAscending=${showAscending}&ebl_filtered=${filtered}&ebl_filterKeyword=${table.keywordFilter}&ebl_paginated=${paginated}" />
					<%-- END SET ORDER BY QUERY --%>

					<%-- PRINT COLUMN HEADING --%>
					<c:choose>
						<c:when test="${i==0}">
							<td>
						</c:when>
						<c:otherwise>
							<td>
						</c:otherwise>
					</c:choose>
					<c:if test="${column.showLink}">
						<a href="<c:out value="${orderByQuery}"/>">
					</c:if>
					<%-- Alter header format to reduce table space--%>
					<c:choose>
						<c:when test="${column.name eq 'Date Updated'}">
							<c:out value="Date Updated" escapeXml="false" />
						</c:when>
						<c:when test="${column.name eq 'Last Updated by'}">
							<c:out value="Last Updated by" escapeXml="false" />
						</c:when>
						<c:when test="${column.name eq 'Date Created'}">
							<c:out value="Date Created" escapeXml="false" />
						</c:when>
						<c:otherwise>
							<c:out value="${column.name}" />
						</c:otherwise>
					</c:choose>
					<c:if test="${column.showLink}">
						</a>
					</c:if>
					<c:if test="${(table.sortingColumnInd == i) && column.showLink}">
						<c:choose>
							<c:when test="${table.ascendingSort}">
								<span class="glyphicon glyphicon-collapse-up"></span>
							</c:when>
							<c:otherwise>
								<span class="glyphicon glyphicon-collapse-down"></span>
							</c:otherwise>
						</c:choose>
					</c:if>
					</td>
					<c:set var="i" value="${i + 1}" />
				</c:forEach>
			</tr>
			<%-- End Column Headers --%>
			<c:choose>
				<c:when test="${empty table.rows}">
					<tr>
						<td colspan="<c:out value="${i}" />">
							<c:choose>
								<c:when test='${table.noRowsMessage == ""}'>
									<fmt:message key="there_are_no_rows_to_display" bundle="${restext}"/>
								</c:when>
								<c:otherwise>
									<c:out value="${table.noRowsMessage}" />
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<%-- Data --%>
					<c:set var="eblRowCount" value="${0}" />
					<c:set var="prevRow" scope="request" value="" />
					<c:set var="allRows" scope="request" value="${table.rows}" />
					<c:forEach var="row" items="${table.rows}">
						<c:set var="currRow" scope="request" value="${row}" />
						<c:import url="${rowURL}">
							<c:param name="eblRowCount" value="${eblRowCount}" />
						</c:import>
						<c:set var="eblRowCount" value="${eblRowCount + 1}" />
						<c:set var="prevRow" scope="request" value="${currRow}" />
					</c:forEach>
					<%-- End Data --%>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
	</tbody>
</table>