<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand navbar-dark bg-primary px-4 py-2">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">ShopApp</a>
        <div class="navbar-nav ms-auto gap-3">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/login">Đăng Nhập</a>
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a>
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/categories">Quản lý thư mục</a>
        </div>
    </div>
</nav>