package application.utils;

import java.lang.reflect.Method;
import java.util.Iterator;

/**
 * Credit goes to Joseph Witherspoon for the generalization of the persistence
 * process.
 *
 */
public class MiscUtils {

	public static boolean hasValue(final String val) {
		if (val == null || val.trim().isEmpty()) {
			return false;
		}
		return true;
	}

	public static String getParmString(final String parm) {
		if (parm != null) {
			return parm.trim();
		} else {
			return "";
		}
	}

	public static Method matchMethod(final Method[] list, final String methodName) {
		if (methodName == null) {
			return null;
		}
		for (Method meth : list) {
			if (meth.getName().equalsIgnoreCase(methodName)) {
				return meth;
			}
		}
		return null;

	}

}
