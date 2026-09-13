<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/></title>

    <!-- 1. Nhúng Bootstrap CSS (dùng CDN hoặc đường dẫn local từ thư mục assets) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Giữ lại thẻ head riêng của từng trang con (nếu có) -->
    <sitemesh:write property="head"/>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

    <!-- Header / Navbar -->
    <header>
        <%@ include file="/common/web/header.jsp"%>
    </header>

    <!-- Main Content: container tự canh lề và co giãn responsive -->
    <main class="container my-4 flex-grow-1">
        <sitemesh:write property="body"/>
    </main>

    <!-- Footer: mt-auto giữ footer luôn ở đáy màn hình -->
    <footer class="mt-auto">
        <%@ include file="/common/web/footer.jsp"%>
    </footer>

    <!-- 2. Nhúng Bootstrap JS Bundle (bao gồm Popper để chạy dropdown, modal, navbar collapse) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>