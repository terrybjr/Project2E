package application.security;

import java.io.IOException;
import java.lang.reflect.Method;
import java.nio.file.AccessDeniedException;
import javax.ws.rs.Priorities;

import javax.annotation.Priority;
import javax.annotation.security.DenyAll;
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.enterprise.context.Dependent;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.ResourceInfo;
import javax.ws.rs.core.Context;
import javax.ws.rs.ext.Provider;

import org.apache.logging.log4j.Logger;

import application.utils.DunGenLogger;
import application.utils.Secure;

@Secure
@Provider
@Dependent
@Priority(Priorities.AUTHORIZATION)
public class AuthorizationFilter implements ContainerRequestFilter {

	@Context
	private ResourceInfo resourceInfo;

	@Override
	public void filter(final ContainerRequestContext requestContext) throws IOException {

		Logger logger = DunGenLogger.getLogger();

		Method method = this.resourceInfo.getResourceMethod();

		// @DenyAll on the method takes precedence over @RolesAllowed and @PermitAll
		if (method.isAnnotationPresent(DenyAll.class)) {
			throw new AccessDeniedException("You don't have permissions to perform this action.");
		}

		// @RolesAllowed on the method takes precedence over @PermitAll
		RolesAllowed rolesAllowed = method.getAnnotation(RolesAllowed.class);
		if (rolesAllowed != null) {
			this.performAuthorization(rolesAllowed.value(), requestContext);
			return;
		}

		// @PermitAll on the method takes precedence over @RolesAllowed on the class
		if (method.isAnnotationPresent(PermitAll.class)) {
			// Do nothing
			return;
		}

		// @DenyAll can't be attached to classes

		// @RolesAllowed on the class takes precedence over @PermitAll on the class
		rolesAllowed = this.resourceInfo.getResourceClass().getAnnotation(RolesAllowed.class);
		if (rolesAllowed != null) {
			this.performAuthorization(rolesAllowed.value(), requestContext);
		}

		// @PermitAll on the class
		if (this.resourceInfo.getResourceClass().isAnnotationPresent(PermitAll.class)) {
			// Do nothing
			return;
		}

		// Authentication is required for non-annotated methods
		if (!this.isAuthenticated(requestContext)) {
			throw new AccessDeniedException("Authentication is required to perform this action.");
		}
	}

	/**
	 * Perform authorization based on roles.
	 *
	 * @param rolesAllowed
	 * @param requestContext
	 * @throws AccessDeniedException
	 */
	private void performAuthorization(final String[] rolesAllowed, final ContainerRequestContext requestContext)
			throws AccessDeniedException {
		if (rolesAllowed.length > 0 && !this.isAuthenticated(requestContext)) {
			throw new AccessDeniedException("Authentication is required to perform this action.");
		}

		for (final String role : rolesAllowed) {
			if (requestContext.getSecurityContext().isUserInRole(role)) {
				return;
			}
		}

		throw new AccessDeniedException("You don't have permissions to perform this action.");
	}

	/**
	 * Check if the user is authenticated.
	 *
	 * @param requestContext
	 * @return
	 */
	private boolean isAuthenticated(final ContainerRequestContext requestContext) {
		return requestContext.getSecurityContext().getUserPrincipal() != null;
	}
}