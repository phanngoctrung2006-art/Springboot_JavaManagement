package web.com.repository;

import org.springframework.data.domain.Pageable;
import java.util.List;

import web.com.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
	List<User> findByUsername(String username);
	Page<User> findByUsernameContaining(String username, Pageable pageable);
}
