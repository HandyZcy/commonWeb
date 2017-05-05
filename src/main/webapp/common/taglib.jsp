<%@page import="com.system.bean.Manager"%>
<%@page import="com.system.utils.Constant"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="java.io.Serializable"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="org.apache.shiro.session.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = "";
	String base_path = "";
	final String serverName = request.getServerName();
	path = "http://" + serverName +":"+request.getServerPort() + request.getContextPath() ;
	base_path = path + "/";
	Subject subject = SecurityUtils.getSubject();
	Session session2 = subject.getSession();
	Serializable sessionId = session2.getId();
	Object obj = session2.getAttribute(Constant.MANAGER_SESSION_KEY);
	String mobile = "";
	if(obj != null){
	    Manager manager = (Manager)obj;
		mobile = manager.getMobile(); 
	}
%>
<c:set var="path" value="<%=path%>" />
<c:set var="ctx" value="<%=path%>" />
<c:set var="base_href" value="<%=base_path%>" />
<c:set var="sessionId" value="<%=sessionId%>"/>
<c:set var="mobile" value="<%=mobile%>"/>
 
 