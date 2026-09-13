<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
    <title>Thêm mới Danh mục</title>
</head>

<div class="mt-4 mx-auto" style="max-width: 550px;">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white py-2">
            <h5 class="mb-0">Thêm mới Danh mục</h5>
        </div>
        <div class="card-body p-4">
            <form:form action="${pageContext.request.contextPath}/admin/categories/save" method="post" modelAttribute="category" enctype="multipart/form-data">
                
                <div class="mb-3">
                    <label for="categoryname" class="form-label fw-bold">Tên danh mục <span class="text-danger">*</span></label>
                    <form:input path="categoryname" id="categoryname" class="form-control" placeholder="Nhập tên danh mục..." />
                    <form:errors path="categoryname" cssClass="text-danger small mt-1 d-block" />
                </div>

                <div class="mb-4">
                    <label for="iconFile" class="form-label fw-bold">Hình ảnh / Icon</label>
                    <input type="file" name="iconFile" id="iconFile" class="form-control" accept="image/*" />
                </div>

                <div class="d-flex justify-content-end gap-2">
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary">Hủy bỏ</a>
                    <button type="submit" class="btn btn-success">Lưu lại</button>
                </div>
            </form:form>
        </div>
    </div>
</div>