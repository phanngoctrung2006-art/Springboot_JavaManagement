package web.com.Service;

import java.util.List;
import web.com.entity.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import web.com.repository.CategoryRepository;
@Service
public class CategoryService implements ICategoryService {
	private final CategoryRepository categoryRepository;

	CategoryService(CategoryRepository categoryRepository) {
		this.categoryRepository = categoryRepository;
	}
	@Override
	public void delete(Category category) {
		categoryRepository.delete(category);
	}

	@Override
	public void save(Category category) {
		categoryRepository.save(category);
	}

	@Override
	public void update(Category category) {
		categoryRepository.save(category);
	}

	@Override
	public long count() {
		return categoryRepository.count();
	}

	@Override
	public List<Category> findAll() {
		return categoryRepository.findAll();
	}

	@Override
	public List<Category> findByCategoryname(String name) {
		return categoryRepository.findByCategoryname(name);
	}

	@Override
	public Page<Category> findByCategoryNameContaining(String name, Pageable pageable) {
		return categoryRepository.findByCategorynameContaining(name, pageable);
	}
	@Override
	public Category findById(Long id) {
		return categoryRepository.findById(id).orElse(null);
	}
	@Override
	public Page<Category> findAll(Pageable pageable) {
		return categoryRepository.findAll(pageable);
	}
}
