<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<head>
    <title>Danh sách Người dùng</title>
</head>

<div class="mt-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">Quản lý Người dùng</h3>
        <a href="${pageContext.request.contextPath}/admin/users/new" class="btn btn-primary btn-sm">
            + Thêm mới người dùng
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
            <form action="${pageContext.request.contextPath}/admin/users/search" method="get" class="row g-2">
                <div class="col-md-5">
                    <input type="text" name="username"
                           value="${not empty username ? username : ''}" class="form-control"
                           placeholder="Nhập tên tài khoản (username)...">
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-dark">Tìm kiếm</button>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary">Làm mới</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Bảng danh sách người dùng -->
    <div class="card">
        <div class="card-body p-0">
            <table class="table table-bordered table-hover mb-0 align-middle">
                <thead class="table-light">
                    <tr>
                        <th style="width: 80px;" class="text-center">ID</th>
                        <th style="width: 90px;" class="text-center">Avatar</th>
                        <th>Tên tài khoản (Username)</th>
                        <th>Email</th>
                        <th style="width: 120px;" class="text-center">Vai trò</th>
                        <th style="width: 150px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${userPage.hasContent()}">
                            <c:forEach var="item" items="${userPage.content}">
                                <tr>
                                    <td class="text-center">${item.id}</td>
                                    
                                    <!-- Cột hiển thị Avatar -->
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${not empty item.avatar}">
                                                <c:choose>
                                                    <c:when test="${fn:startsWith(item.avatar, 'http://') || fn:startsWith(item.avatar, 'https://')}">
                                                        <c:set var="avatarSrc" value="${item.avatar}" />
                                                    </c:when>
                                                    <c:when test="${fn:startsWith(item.avatar, '/')}">
                                                        <c:set var="avatarSrc" value="${pageContext.request.contextPath}${item.avatar}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="avatarSrc" value="${pageContext.request.contextPath}/images/${item.avatar}" />
                                                    </c:otherwise>
                                                </c:choose>

                                                <img src="${avatarSrc}"
                                                     alt="${item.username}"
                                                     width="40" height="40"
                                                     referrerpolicy="no-referrer"
                                                     class="rounded-circle border object-fit-cover"
                                                     onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${item.username}&background=random';" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://ui-avatars.com/api/?name=${item.username}&background=random"
                                                     alt="No Avatar"
                                                     width="40" height="40"
                                                     class="rounded-circle border object-fit-cover" />
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td><strong>${item.username}</strong></td>
                                    <td>${item.email}</td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${item.role eq 'ADMIN'}">
                                                <span class="badge bg-danger">ADMIN</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-primary">USER</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/users/edit/${item.id}" class="btn btn-sm btn-warning">Sửa</a>
                                        <a href="${pageContext.request.contextPath}/admin/users/delete/${item.id}" 
                                           class="btn btn-sm btn-danger" 
                                           onclick="return confirm('Xác nhận xóa người dùng này?');">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="text-center py-3 text-muted">Không tìm thấy người dùng nào.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- Phân trang -->
        <c:if test="${userPage.totalPages > 1}">
            <div class="card-footer d-flex justify-content-between align-items-center py-2">
                <span class="small text-muted">
                    Trang <strong>${userPage.number + 1}</strong> / ${userPage.totalPages}
                </span>
                <nav>
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${userPage.first ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/users/search?username=${not empty username ? username : ''}&page=${userPage.number}&size=${userPage.size}">&laquo;</a>
                        </li>

                        <c:forEach var="pageNumber" items="${pageNumbers}">
                            <li class="page-item ${pageNumber == (userPage.number + 1) ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/users/search?username=${not empty username ? username : ''}&page=${pageNumber}&size=${userPage.size}">${pageNumber}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${userPage.last ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/users/search?username=${not empty username ? username : ''}&page=${userPage.number + 2}&size=${userPage.size}">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>
</div>
