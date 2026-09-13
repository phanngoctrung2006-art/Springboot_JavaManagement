<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<head>
    <title>Danh sách Danh mục</title>
</head>

<div class="mt-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">Quản lý Danh mục</h3>
        <a href="${pageContext.request.contextPath}/admin/categories/new" class="btn btn-primary btn-sm">
            + Thêm mới
        </a>
    </div>

    <!-- Thông báo kết quả -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show py-2" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Khung tìm kiếm -->
    <div class="card mb-3">
        <div class="card-body p-3">
            <form action="${pageContext.request.contextPath}/admin/categories/search" method="get" class="row g-2">
                <div class="col-md-5">
                    <input type="text" name="name"
                           value="${not empty name ? name : ''}" class="form-control"
                           placeholder="Nhập tên danh mục...">
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-dark">Tìm kiếm</button>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary">Làm mới</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Bảng danh sách -->
    <div class="card">
        <div class="card-body p-0">
            <table class="table table-bordered table-hover mb-0 align-middle">
                <thead class="table-light">
                    <tr>
                        <th style="width: 80px;" class="text-center">ID</th>
                        <th style="width: 90px;" class="text-center">Icon</th>
                        <th>Tên danh mục</th>
                        <th style="width: 150px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${categoryPage.hasContent()}">
                            <c:forEach var="item" items="${categoryPage.content}">
                                <tr>
                                    <td class="text-center">${item.categoryid}</td>
                                    
                                    <!-- Cột hiển thị hình ảnh chuẩn -->
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${not empty item.icon}">
                                                <!-- Xác định nguồn đường dẫn hình ảnh -->
                                                <c:choose>
                                                    <%-- Nếu là link ảnh online (bắt đầu bằng http hoặc https) --%>
                                                    <c:when test="${fn:startsWith(item.icon, 'http://') || fn:startsWith(item.icon, 'https://')}">
                                                        <c:set var="imgSrc" value="${item.icon}" />
                                                    </c:when>
                                                    <%-- Nếu database đã lưu sẵn dấu gạch chéo đầu dòng (/images/...) --%>
                                                    <c:when test="${fn:startsWith(item.icon, '/')}">
                                                        <c:set var="imgSrc" value="${pageContext.request.contextPath}${item.icon}" />
                                                    </c:when>
                                                    <%-- Ngược lại, nối với đường dẫn /images/ mặc định --%>
                                                    <c:otherwise>
                                                        <c:set var="imgSrc" value="${pageContext.request.contextPath}/images/${item.icon}" />
                                                    </c:otherwise>
                                                </c:choose>

                                                <img src="${imgSrc}"
                                                     alt="${item.categoryname}"
                                                     width="40" height="40"
                                                     class="rounded border object-fit-cover"
                                                     onerror="this.onerror=null; this.src='https://placehold.co/40x40?text=No+Img';" />
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted small">No icon</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td><strong>${item.categoryname}</strong></td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/categories/edit/${item.categoryid}" class="btn btn-sm btn-warning">Sửa</a>
                                        <a href="${pageContext.request.contextPath}/admin/categories/delete/${item.categoryid}" 
                                           class="btn btn-sm btn-danger" 
                                           onclick="return confirm('Xác nhận xóa danh mục này?');">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="4" class="text-center py-3 text-muted">Không tìm thấy danh mục nào.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- Phân trang -->
        <c:if test="${categoryPage.totalPages > 1}">
            <div class="card-footer d-flex justify-content-between align-items-center py-2">
                <span class="small text-muted">
                    Trang <strong>${categoryPage.number + 1}</strong> / ${categoryPage.totalPages}
                </span>
                <nav>
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${categoryPage.first ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/categories/search?name=${not empty name ? name : ''}&page=${categoryPage.number}&size=${categoryPage.size}">&laquo;</a>
                        </li>

                        <c:forEach var="pageNumber" items="${pageNumbers}">
                            <li class="page-item ${pageNumber == (categoryPage.number + 1) ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/categories/search?name=${not empty name ? name : ''}&page=${pageNumber}&size=${categoryPage.size}">${pageNumber}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${categoryPage.last ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/categories/search?name=${not empty name ? name : ''}&page=${categoryPage.number + 2}&size=${categoryPage.size}">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>
