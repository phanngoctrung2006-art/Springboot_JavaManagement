package web.com.Service;

import java.util.List;

import web.com.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IUserService {
	void delete(User user);
	void deleteUserById(Long id);
	long count();
	List<User> findAll();
	List<User> findByUsername(String username);
	Page <User> findByUsernameContaining(String username, Pageable pageable);
	void save(User user);
	void update(User user);
}
