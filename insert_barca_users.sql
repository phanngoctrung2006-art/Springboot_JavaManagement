-- Script MySQL thêm 10 người dùng cầu thủ FC Barcelona với ảnh từ CDN Unsplash (Không dùng Wikimedia)
-- Cơ sở dữ liệu: Springboot | Bảng: users

-- 1. Mở rộng độ dài cột avatar
ALTER TABLE users MODIFY COLUMN avatar VARCHAR(500);

-- 2. Xóa dữ liệu cũ của các tài khoản này nếu đã tồn tại để tránh trùng lặp
DELETE FROM users WHERE username IN ('messi', 'yamal', 'pedri', 'lewandowski', 'gavi', 'ronaldinho', 'xavi', 'iniesta', 'terstegen', 'dejong');

-- 3. Chèn 10 cầu thủ Barca với ảnh CDN Unsplash tốc độ cao
INSERT INTO users (username, password, email, role, avatar) VALUES 
('messi', '123456', 'messi@barca.com', 'ADMIN', 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400&auto=format&fit=crop&q=80'),
('yamal', '123456', 'yamal@barca.com', 'USER', 'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?w=400&auto=format&fit=crop&q=80'),
('pedri', '123456', 'pedri@barca.com', 'USER', 'https://images.unsplash.com/photo-1517466787929-bc90951d0974?w=400&auto=format&fit=crop&q=80'),
('lewandowski', '123456', 'lewandowski@barca.com', 'USER', 'https://images.unsplash.com/photo-1543351611-c82394862f92?w=400&auto=format&fit=crop&q=80'),
('gavi', '123456', 'gavi@barca.com', 'USER', 'https://images.unsplash.com/photo-1522778119026-d647f0596c20?w=400&auto=format&fit=crop&q=80'),
('ronaldinho', '123456', 'ronaldinho@barca.com', 'ADMIN', 'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=400&auto=format&fit=crop&q=80'),
('xavi', '123456', 'xavi@barca.com', 'ADMIN', 'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?w=400&auto=format&fit=crop&q=80'),
('iniesta', '123456', 'iniesta@barca.com', 'USER', 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=400&auto=format&fit=crop&q=80'),
('terstegen', '123456', 'terstegen@barca.com', 'USER', 'https://images.unsplash.com/photo-1511447333015-45b65e60f6d5?w=400&auto=format&fit=crop&q=80'),
('dejong', '123456', 'dejong@barca.com', 'USER', 'https://images.unsplash.com/photo-1575361204480-aadea25e6e68?w=400&auto=format&fit=crop&q=80');
