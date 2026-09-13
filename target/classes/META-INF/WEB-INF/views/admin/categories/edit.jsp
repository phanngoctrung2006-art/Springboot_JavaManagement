<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
    <title>Cập nhật Danh mục</title>
</head>

<div class="mt-4 mx-auto" style="max-width: 550px;">
    <div class="card shadow-sm">
        <div class="card-header bg-warning text-dark py-2">
            <h5 class="mb-0">Cập nhật Danh mục</h5>
        </div>
        <div class="card-body p-4">
            <form:form action="${pageContext.request.contextPath}/admin/categories/save" method="post" modelAttribute="category" enctype="multipart/form-data">
                
                <!-- Ẩn ID và icon cũ để controller giữ nguyên khi không up ảnh mới -->
                <form:hidden path="categoryid" />
                <form:hidden path="icon" />

                <div class="mb-3">
                    <label for="categoryname" class="form-label fw-bold">Tên danh mục <span class="text-danger">*</span></label>
                    <form:input path="categoryname" id="categoryname" class="form-control" />
                    <form:errors path="categoryname" cssClass="text-danger small mt-1 d-block" />
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold d-block">Icon hiện tại</label>
                    <c:choose>
                        <c:when test="${not empty category.icon}">
                            <c:choose>
                                <%-- Nếu là link ảnh online (bắt đầu bằng http hoặc https) --%>
                                <c:when test="${fn:startsWith(category.icon, 'http://') || fn:startsWith(category.icon, 'https://')}">
                                    <c:set var="imgSrc" value="${category.icon}" />
                                </c:when>
                                <%-- Nếu database đã lưu sẵn dấu gạch chéo đầu dòng (/images/...) --%>
                                <c:when test="${fn:startsWith(category.icon, '/')}">
                                    <c:set var="imgSrc" value="${pageContext.request.contextPath}${category.icon}" />
                                </c:when>
                                <%-- Ngược lại, nối với đường dẫn /images/ mặc định --%>
                                <c:otherwise>
                                    <c:set var="imgSrc" value="${pageContext.request.contextPath}/images/${category.icon}" />
                                </c:otherwise>
                            </c:choose>

                            <img src="${imgSrc}"
                                 alt="${category.categoryname}"
                                 width="50" height="50"
                                 class="rounded border p-1 mb-2 object-fit-cover"
                                 onerror="this.onerror=null; this.src='https://placehold.co/50x50?text=No+Img';" />
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary mb-2">Chưa có icon</span>
                        </c:otherwise>
                    </c:choose>

                    <label for="iconFile" class="form-label d-block small text-muted">Chọn ảnh mới thay thế (bỏ qua nếu giữ ảnh cũ):</label>
                    <input type="file" name="iconFile" id="iconFile" class="form-control" accept="image/*" />
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4">
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary">Quay lại</a>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
            </form:form>
        </div>
    </div>
</div>