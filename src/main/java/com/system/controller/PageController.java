package com.system.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 
 */
@Controller
public class PageController {

	private static final String PREFIX = "page";
//	private static final String SUFFIX = ".shtml";
	
	@RequestMapping("/page/**")
	public String page(HttpServletRequest request){
		//get page value
		String url = request.getRequestURI();
		
    	String page = url.substring(url.indexOf(PREFIX) + PREFIX.length()/*, url.indexOf(SUFFIX)*/);
    	
    	//for admin pages
        if (page != null && page.startsWith("/admin")){
            //check if login
//            Adminuser u = SessionUtil.getLoginAdminuser(request);
//            if (u == null){
//            	return "/admin/login";
//            } else {
//                if (page.contains("login")){
//                    return "/admin/index";
//                }
//                return page;
//            }
        }
    	
    	//for auto login
        return page;
	}
}
