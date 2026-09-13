<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
    <title>Cập nhật Người dùng</title>
</head>

<div class="mt-4 mx-auto" style="max-width: 550px;">
    <div class="card shadow-sm">
        <div class="card-header bg-warning text-dark py-2">
            <h5 class="mb-0">Cập nhật Người dùng</h5>
        </div>
        <div class="card-body p-4">
            <form:form action="${pageContext.request.contextPath}/admin/users/save" method="post" modelAttribute="user" enctype="multipart/form-data">
                
                <!-- Ẩn ID và avatar cũ để giữ nguyên khi không chọn ảnh mới -->
                <form:hidden path="id" />
                <form:hidden path="avatar" />

                <div class="mb-3">
                    <label for="username" class="form-label fw-bold">Tên tài khoản (Username) <span class="text-danger">*</span></label>
                    <form:input path="username" id="username" class="form-control" required="required" />
                    <form:errors path="username" cssClass="text-danger small mt-1 d-block" />
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label fw-bold">Mật khẩu mới</label>
                    <input type="password" name="password" id="password" class="form-control" placeholder="Bỏ trống nếu giữ nguyên mật khẩu cũ..." />
                    <span class="text-muted small">Chỉ nhập nếu bạn muốn đổi mật khẩu người dùng.</span>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label fw-bold">Email <span class="text-danger">*</span></label>
                    <form:input path="email" type="email" id="email" class="form-control" required="required" />
                    <form:errors path="email" cssClass="text-danger small mt-1 d-block" />
                </div>

                <div class="mb-3">
                    <label for="role" class="form-label fw-bold">Vai trò (Role) <span class="text-danger">*</span></label>
                    <form:select path="role" id="role" class="form-select">
                        <form:option value="USER" label="Người dùng (USER)" />
                        <form:option value="ADMIN" label="Quản trị viên (ADMIN)" />
                    </form:select>
                    <form:errors path="role" cssClass="text-danger small mt-1 d-block" />
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold d-block">Avatar hiện tại</label>
                    <c:choose>
                        <c:when test="${not empty user.avatar}">
                            <c:choose>
                                <%-- Nếu là link ảnh online (bắt đầu bằng http hoặc https) --%>
                                <c:when test="${fn:startsWith(user.avatar, 'http://') || fn:startsWith(user.avatar, 'https://')}">
                                    <c:set var="avatarSrc" value="${user.avatar}" />
                                </c:when>
                                <%-- Nếu database đã lưu sẵn dấu gạch chéo đầu dòng (/images/...) --%>
                                <c:when test="${fn:startsWith(user.avatar, '/')}">
                                    <c:set var="avatarSrc" value="${pageContext.request.contextPath}${user.avatar}" />
                                </c:when>
                                <%-- Ngược lại, nối với đường dẫn /images/ mặc định --%>
                                <c:otherwise>
                                    <c:set var="avatarSrc" value="${pageContext.request.contextPath}/images/${user.avatar}" />
                                </c:otherwise>
                            </c:choose>

                            <img src="${avatarSrc}"
                                 alt="${user.username}"
                                 width="50" height="50"
                                 referrerpolicy="no-referrer"
                                 class="rounded-circle border p-1 mb-2 object-fit-cover"
                                 onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${user.username}&background=random';" />
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary mb-2">Chưa có avatar</span>
                        </c:otherwise>
                    </c:choose>

                    <label for="avatarFile" class="form-label d-block small text-muted">Chọn ảnh mới thay thế (bỏ qua nếu giữ avatar cũ):</label>
                    <input type="file" name="avatarFile" id="avatarFile" class="form-control" accept="image/*" />
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4">
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Quay lại</a>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
            </form:form>
        </div>
    </div>
</div>
