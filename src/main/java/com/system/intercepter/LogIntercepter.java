package com.system.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.system.utils.Constant;

public class LogIntercepter implements HandlerInterceptor {

	private String name = null;
	
	Logger logger = LoggerFactory.getLogger(LogIntercepter.class);
	
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
//		logger.info("afterCompletion");
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
//		logger.info("postHandle");
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
//		logger.info("preHandle" + name);
		if(arg2 instanceof HandlerMethod){
			HandlerMethod targetMethod = (HandlerMethod) arg2;
			String targetMethodName = targetMethod.getMethod().getName();
			logger.info(targetMethodName);
			if (!"toLogin".equals(targetMethodName) && !"login".equals(targetMethodName)) {
				Subject subject = SecurityUtils.getSubject();
				Object sessionManager = subject.getSession().getAttribute(Constant.MANAGER_SESSION_KEY);
				if (sessionManager == null) {
					//如果Session中获取不到用户信息，则手动到登录页面
					subject.logout();
//					response.sendRedirect("index.jsp");
					return false;
				}
			}
		}
		return true;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	

}
