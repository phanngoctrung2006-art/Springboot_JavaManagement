package web.com.Service;

import java.util.List;
import web.com.entity.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
public interface ICategoryService {
 void delete(Category category);
 void save(Category category);
  void update(Category category);
  long count();
  List<Category> findAll();
  Page<Category> findByCategoryNameContaining(String name, Pageable pageable);
  Category findById(Long id);
  Page<Category> findAll(Pageable pageable);
  List<Category> findByCategoryname(String name);
}
