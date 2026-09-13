package web.com.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import web.com.Service.UserService;
import web.com.Service.FileSystemStorageServiceImpl;
import web.com.entity.User;

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

@Controller
@RequestMapping("/admin/users")
public class UserController {
	private final UserService userService;
	private final FileSystemStorageServiceImpl fileSystemStorageService;

	UserController(UserService userService, FileSystemStorageServiceImpl fileSystemStorageService) {
		this.userService = userService;
		this.fileSystemStorageService = fileSystemStorageService;
	}

	@GetMapping
	public String list(Model model,
	                    @RequestParam(name = "username", required = false) String username,
	                    @RequestParam("page") Optional<Integer> page,
	                    @RequestParam("size") Optional<Integer> size) {
	    return search(model, username, page, size);
	}

	@GetMapping("/search")
	public String search(Model model,
	                      @RequestParam(name = "username", required = false) String username,
	                      @RequestParam("page") Optional<Integer> page,
	                      @RequestParam("size") Optional<Integer> size) {
		int count = (int) userService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("username"));

		Page<User> resultPage = null;

		if (StringUtils.hasText(username)) {
			resultPage = userService.findByUsernameContaining(username, pageable);
			model.addAttribute("username", username);
		} else {
			resultPage = userService.findAll(pageable);
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

		model.addAttribute("userPage", resultPage);

		return "admin/users/list";
	}

	@GetMapping("/new")
	public String showCreateForm(Model model) {
		model.addAttribute("user", new User());
		return "admin/users/create";
	}

	@GetMapping("/edit/{id}")
	public String editUser(@PathVariable Long id, Model model) {
		model.addAttribute("user", userService.findById(id));
		return "admin/users/edit";
	}

	@GetMapping("/delete/{id}")
	public String deleteUser(@PathVariable Long id) {
		User user = userService.findById(id);
		if (user != null) {
			if (StringUtils.hasText(user.getAvatar())) {
				try {
					fileSystemStorageService.delete(user.getAvatar());
				} catch (Exception ignored) {}
			}
			userService.delete(user);
		}
		return "redirect:/admin/users";
	}

	@PostMapping("/save")
	public String saveUser(@Valid @ModelAttribute("user") User user,
	                        BindingResult bindingResult,
	                        @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile,
	                        RedirectAttributes redirectAttributes) throws Exception {

	    User existing = null;
	    if (user.getId() != null) {
	        existing = userService.findById(user.getId());
	        if (existing != null) {
	            // Giữ nguyên mật khẩu cũ nếu khi sửa không nhập mật khẩu mới
	            if (!StringUtils.hasText(user.getPassword())) {
	                user.setPassword(existing.getPassword());
	            }
	        }
	    }

	    if (bindingResult.hasErrors()) {
	        return user.getId() == null ? "admin/users/create" : "admin/users/edit";
	    }

	    // Xử lý ảnh đại diện avatar
	    if (avatarFile != null && !avatarFile.isEmpty()) {
	        if (existing != null && StringUtils.hasText(existing.getAvatar())) {
	            try {
	                fileSystemStorageService.delete(existing.getAvatar());
	            } catch (Exception ignored) {}
	        }
	        String avatarUrl = fileSystemStorageService.getStorageFilename(avatarFile, "user-avatars");
	        fileSystemStorageService.store(avatarFile, avatarUrl);
	        user.setAvatar(avatarUrl);
	    } else if (existing != null) {
	        user.setAvatar(existing.getAvatar());
	    }

	    userService.save(user);

	    redirectAttributes.addFlashAttribute("message",
	            user.getId() == null ? "Thêm người dùng thành công!" : "Cập nhật người dùng thành công!");

	    return "redirect:/admin/users";
	}
}
