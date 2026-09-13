package web.com.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import web.com.Service.CategoryService;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import web.com.entity.Category;
import web.com.Service.FileSystemStorageServiceImpl;
@Controller
@RequestMapping("/admin/categories")
public class CategoryController {
	private final CategoryService categoryService;
	private final FileSystemStorageServiceImpl fileSystemStorageService;

	CategoryController(CategoryService categoryService, FileSystemStorageServiceImpl fileSystemStorageService) {
		this.categoryService = categoryService;
		this.fileSystemStorageService = fileSystemStorageService;
	}
	
	@GetMapping
	public String list(Model model,
	                    @RequestParam(name = "name", required = false) String name,
	                    @RequestParam("page") Optional<Integer> page,
	                    @RequestParam("size") Optional<Integer> size) {
	    return search(model, name, page, size);
	}
	// Tìm kiếm phân trang 
	@GetMapping("/search")
	public String search(Model model, @RequestParam(name = "name", required = false) String name,
			@RequestParam("page") Optional<Integer> page, @RequestParam("size") Optional<Integer> size) {
		int count = (int) categoryService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("Categoryname"));

		Page<Category> resultPage = null;

		if (StringUtils.hasText(name)) {

			resultPage = categoryService.findByCategoryNameContaining(name, pageable);

			model.addAttribute("name", name);

		} else {

			resultPage = categoryService.findAll(pageable);

		}

		int totalPages = resultPage.getTotalPages();

		if (totalPages > 0) {

			int start = Math.max(1, currentPage - 2);

			int end = Math.min(currentPage + 2, totalPages);

			if (totalPages > count) {

				if (end == totalPages)
					start = end - count;

				else if (start == 1)
					end = start + count;

			}

			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());

			model.addAttribute("pageNumbers", pageNumbers);

		}

		model.addAttribute("categoryPage", resultPage);

		return "admin/categories/list";

	}

	@GetMapping("/new")
	public String showCreateForm(Model model) {
		model.addAttribute("category", new Category());
		return "admin/categories/create";
	}

	@GetMapping("/edit/{id}")
	public String editCategory(@PathVariable Long id, Model model) {
		model.addAttribute("category", categoryService.findById(id));
		return "admin/categories/edit";
	}

	@GetMapping("/delete/{id}")
	public String deleteCategory(@PathVariable Long id) {
		Category category = categoryService.findById(id);
		if (category != null) {
			categoryService.delete(category);
		}
		return "redirect:/admin/categories";
	}
	@PostMapping("/save")
	public String saveCategory(@Valid @ModelAttribute("category") Category category,
	                            BindingResult bindingResult,
	                            @RequestParam(value = "iconFile", required = false) MultipartFile iconFile,
	                            RedirectAttributes redirectAttributes) throws Exception {

	    // 1. Validate dữ liệu nhập (name không trống, v.v...)
	    if (bindingResult.hasErrors()) {
	        return category.getCategoryid() == null ? "admin/categories/create" : "admin/categories/edit";
	    }

	    // 2. Xử lý ảnh
	    if (iconFile != null && !iconFile.isEmpty()) {
	        // Có upload ảnh mới -> nếu đang sửa và đã có ảnh cũ thì xóa ảnh cũ trước (tránh rác ổ đĩa)
	        if (category.getCategoryid() != null) {
	            Category existing = categoryService.findById(category.getCategoryid());
	            if (existing != null && StringUtils.hasText(existing.getIcon())) {
	                try {
	                    fileSystemStorageService.delete(existing.getIcon());
	                } catch (Exception ignored) {}
	            }
	        }
	        String iconUrl = fileSystemStorageService.getStorageFilename(iconFile, "category-icons");
	        fileSystemStorageService.store(iconFile, iconUrl);
	        category.setIcon(iconUrl);

	    } else if (category.getCategoryid() != null) {
	        // Không chọn ảnh mới khi sửa -> giữ nguyên ảnh cũ, tránh bị mất/null
	        Category existing = categoryService.findById(category.getCategoryid());
	        if (existing != null) {
	            category.setIcon(existing.getIcon());
	        }
	    }

	    // 3. Lưu vào DB
	    categoryService.save(category);

	    // 4. Thông báo kết quả
	    redirectAttributes.addFlashAttribute("message",
	            category.getCategoryid() == null ? "Thêm mới thành công!" : "Cập nhật thành công!");

	    return "redirect:/admin/categories";
	}
}