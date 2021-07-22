package application.rest;

import javax.servlet.ServletConfig;
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.Context;

import io.swagger.annotations.Contact;
import io.swagger.annotations.SwaggerDefinition;
import io.swagger.jaxrs.config.BeanConfig;
import io.swagger.annotations.Info;

/**
 * Get to the swagger page by using the following url
 * http://localhost:8080/project-2e-ws/api/apiee 
 * Access Rest points by using the following path 
 * localhost:8080/project-2e-ws/api/...
 * 
 * @author brianterry
 *
 */
@ApplicationPath("/api")
public class Project2EConfig extends Application {

	public Project2EConfig(@Context final ServletConfig servletConfig) {
		super();

		//		BeanConfig beanConfig = new BeanConfig();
		//
		//		beanConfig.setVersion("1.0.0");
		//		beanConfig.setTitle("Project2E API");
		//		beanConfig.setBasePath("/Project2E/api");
		//		beanConfig.setResourcePackage("com.synaptik.javaee");
		//		beanConfig.setScan(true);
	}

}