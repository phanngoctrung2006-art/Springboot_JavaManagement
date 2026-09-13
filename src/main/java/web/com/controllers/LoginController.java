package web.com.controllers;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.ui.Model;
import web.com.Service.UserService;

@Controller
public class LoginController {
	final UserService userService;

	LoginController(UserService userService) {
		this.userService = userService;
	}
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	@PostMapping("/login")
	public String loginPost(@RequestParam String uname, @RequestParam String psw,Model model, RedirectAttributes redirectAttributes) {
		if (!userService.login(uname, psw)) {
			model.addAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng");
			return "login";
		}
		redirectAttributes.addFlashAttribute("message", "Đăng nhập thành công");
		return "redirect:/home";
	}
}
