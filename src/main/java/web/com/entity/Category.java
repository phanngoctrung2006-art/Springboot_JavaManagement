package web.com.entity;
import jakarta.persistence.*;
import lombok.*;
import java.io.Serializable;
@Entity
@Table(name = "categories")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Category implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(nullable = false, unique = true)
	private Long categoryid;
	private String categoryname;
	private String icon;
	
	
}
