package web.com.config;

import org.springframework.boot.tomcat.servlet.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class TomcatJSPConfiguration {

	@Bean
	public WebServerFactoryCustomizer<TomcatServletWebServerFactory> staticResourceCustomizer() {
		return factory -> {
			Map<String, String> jspInitParams = new HashMap<>();
			jspInitParams.put("javaEncoding", "UTF-8");
			factory.setInitParameters(jspInitParams);
			factory.addContextCustomizers(
					context -> context.addLifecycleListener(new JSPStaticResourceConfigurer(context)));
		};
	}
}
