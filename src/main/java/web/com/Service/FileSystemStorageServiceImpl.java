package web.com.Service;
import java.io.InputStream; 
import java.nio.file.Files; 
import java.nio.file.Path; 
import java.nio.file.Paths; 
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils; 
import org.springframework.core.io.Resource; 
import org.springframework.core.io.UrlResource; 
import org.springframework.stereotype.Service; 
import org.springframework.web.multipart.MultipartFile; 
import web.com.Exception.StorageException; 
import web.com.config.StorageProperties; 
 
@Service 
public class FileSystemStorageServiceImpl implements IStorageService { 
 private final Path rootLocation; 
  
 @Override
 public String getStorageFilename(MultipartFile file, String id) {
     // 1. Lấy phần mở rộng của file gốc (jpg, png, ...)
     String originalFilename = file.getOriginalFilename();
     String ext = "";
     if (originalFilename != null && originalFilename.contains(".")) {
         ext = originalFilename.substring(originalFilename.lastIndexOf("."));
     }

     // 2. Tạo tên file chuẩn: ví dụ category-icons_1715600000.jpg hoặc category-icons_uuid.jpg
     // Đảm bảo có dấu ngăn cách rõ ràng giữa id (category-icons) và mã ngẫu nhiên
     String uniqueName = UUID.randomUUID().toString().substring(0, 8);
     
     return id + "_" + System.currentTimeMillis() + ext; 
     // Kết quả sẽ ra dạng: category-icons_1726223456.jpg
 }
 public FileSystemStorageServiceImpl(StorageProperties properties) { 
  this.rootLocation = Paths.get(properties.getLocation()); 
 } 
 @Override 
 public void store(MultipartFile file, String storeFilename) { 
  try { 
   if(file.isEmpty()) { 
    throw new StorageException("Failed to store empty file"); 
     
   } 
   Path destinationFile = 
this.rootLocation.resolve(Paths.get(storeFilename)) 
     .normalize().toAbsolutePath(); //lấy đường dẫn tuyệt đối
  
 if(!destinationFile.getParent().equals(this.rootLocation.toAbsolutePath())) { 
    throw new StorageException("Cannot store file outside curent directory"); 
   } 
   if (!Files.exists(this.rootLocation)) {
    Files.createDirectories(this.rootLocation);
   }
   try (InputStream inputStream = file.getInputStream()) { 
    Files.copy(inputStream, destinationFile, 
StandardCopyOption.REPLACE_EXISTING);   
   } 
  } catch (Exception e) { 
   throw new StorageException("Failed to store file: ", e); 
  } 
   
 } 
 @Override 
 public Resource loadAsResource(String filename) { 
  try { 
   Path file = load(filename); 
   Resource resource = new UrlResource(file.toUri()); 
   if(resource.exists() || resource.isReadable()) { 
    return resource; 
   } 
   throw new StorageException("Can not read file: " + filename); 
    
  } catch (Exception e) { 
   throw new StorageException("Could not read file: " + filename); 
  } 
 } 
 @Override 
 public Path load(String filename) { 
  return rootLocation.resolve(filename); 
 } 
 @Override 
 public void delete(String storeFilename) throws Exception { 
  if (storeFilename == null || storeFilename.trim().isEmpty() || storeFilename.startsWith("http://") || storeFilename.startsWith("https://")) {
   return;
  }
  try {
   Path destinationFile = rootLocation.resolve(Paths.get(storeFilename)).normalize().toAbsolutePath(); 
   if (Files.exists(destinationFile)) {
    Files.delete(destinationFile); 
   }
  } catch (Exception ignored) {}
 } 
 @Override 
 public void init() { 
  try { 
   Files.createDirectories(rootLocation); 
   System.out.println(rootLocation.toString()); 
  } catch (Exception e) { 
   throw new StorageException("Could not read file: ", e); 
  } 
 } 
} 