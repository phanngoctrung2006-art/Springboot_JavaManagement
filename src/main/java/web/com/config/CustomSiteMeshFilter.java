package web.com.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Áp dụng decorator mặc định cho toàn bộ trang
        builder.addDecoratorPath("/*", "/web.jsp")
               // Decorator riêng cho admin
               .addDecoratorPath("/admin/*", "/admin.jsp")
               // Loại trừ không áp dụng decorator cho các trang login, API
               .addExcludedPath("/login*").addExcludedPath("/login/*");
    }
    
}