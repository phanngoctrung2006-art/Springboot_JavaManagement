<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><sitemesh:write property='title'/></title>
    <!-- Nhúng Bootstrap 5 để có sẵn bảng và nút bấm -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <sitemesh:write property='head'/>
</head>
<body>

    <!-- Menu ngang đơn giản -->
    <nav class="navbar navbar-expand navbar-dark bg-dark px-3 mb-4">
        <div class="navbar-nav">
            <a class="nav-link active" href="<c:url value='/admin/categories'/>">Danh mục</a>
            <a class="nav-link" href="<c:url value='/'/>">Về trang chủ</a>
        </div>
    </nav>

    <!-- Khu vực hiển thị nội dung của list.jsp / create.jsp -->
    <div class="container">
        <sitemesh:write property='body'/>
    </div>

</body>
</html>