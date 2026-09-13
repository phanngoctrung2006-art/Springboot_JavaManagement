package web.com.repository;

import java.util.List;
import web.com.entity.Category;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
	List<Category> findByCategoryname(String categoryname);
	Page<Category> findByCategorynameContaining(String categoryname, Pageable pageable);
	
}
