<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
    <title>Thêm mới Người dùng</title>
</head>

<div class="mt-4 mx-auto" style="max-width: 550px;">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white py-2">
            <h5 class="mb-0">Thêm mới Người dùng</h5>
        </div>
        <div class="card-body p-4">
            <form:form action="${pageContext.request.contextPath}/admin/users/save" method="post" modelAttribute="user" enctype="multipart/form-data">
                
                <div class="mb-3">
                    <label for="username" class="form-label fw-bold">Tên tài khoản (Username) <span class="text-danger">*</span></label>
                    <form:input path="username" id="username" class="form-control" placeholder="Nhập tên tài khoản..." required="required" />
                    <form:errors path="username" cssClass="text-danger small mt-1 d-block" />
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label fw-bold">Mật khẩu <span class="text-danger">*</span></label>
                    <form:password path="password" id="password" class="form-control" placeholder="Nhập mật khẩu..." required="required" />
                    <form:errors path="password" cssClass="text-danger small mt-1 d-block" />
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label fw-bold">Email <span class="text-danger">*</span></label>
                    <form:input path="email" type="email" id="email" class="form-control" placeholder="example@domain.com" required="required" />
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

                <div class="mb-4">
                    <label for="avatarFile" class="form-label fw-bold">Ảnh đại diện (Avatar)</label>
                    <input type="file" name="avatarFile" id="avatarFile" class="form-control" accept="image/*" />
                </div>

                <div class="d-flex justify-content-end gap-2">
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Hủy bỏ</a>
                    <button type="submit" class="btn btn-success">Lưu lại</button>
                </div>
            </form:form>
        </div>
    </div>
</div>
