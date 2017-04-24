package com.system.shiro;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import com.system.bean.Manager;
import com.system.bean.Right;
import com.system.bean.Role;
import com.system.service.ManagerService;
import com.system.service.RightService;
import com.system.service.RoleService;
import com.system.utils.Constant;

/**
 * 自定义Realm,进行数据源配置
 * 
 */
public class MyRealm extends AuthorizingRealm {
	
	@Autowired
	private ManagerService managerService;
	
	@Autowired
	private RoleService roleService;

	@Autowired
	private RightService rightService;
	
	/**
	 * 权限认证
	 * 每次需要校验权限时都会执行该方法，需要做缓存或其它方式处理。
     * 只有需要验证权限时才会调用, 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用。
     * 在配有缓存的情况下，只加载一次.
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		Subject subject = SecurityUtils.getSubject();
		String loginName = subject.getPrincipal().toString();
		if (loginName != null) {
			Manager currentUser = (Manager) subject.getSession().getAttribute(Constant.MANAGER_SESSION_KEY);
			if (currentUser == null) {
				subject.logout();
				return null;
			}
			// 权限信息对象info,用来存放查出的用户的所有的角色（role）及权限（permission）
			SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
			// 用户的角色集合
			authorizationInfo.setRoles(currentUser.getRolesDesc());
			// 用户的角色对应的所有权限，如果只使用角色定义访问权限
			List<Right> managerRightList = rightService.getRightByManagerId(currentUser.getId());
			Set<String> myRightDescSet = new HashSet<String>();
			for (Right right : managerRightList) {
				if (StringUtils.isNotEmpty(right.getDescription())) {
					myRightDescSet.add(right.getDescription());
				}
			}
			authorizationInfo.setStringPermissions(myRightDescSet);
			return authorizationInfo;
		}
		return null;
	}

	/**
	 * 登录认证
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) token;
		String userName =  usernamePasswordToken.getUsername();
		JSONObject jsonObject = managerService.getManagerByNickname(userName);
		Manager dbManager = jsonObject.getObject("data", Manager.class);
		if(dbManager != null){
			if (!"1".equals(dbManager.getState())) {
				throw new LockedAccountException(); // 帐号锁定
			}
			
			SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(userName, dbManager.getPwd(), getName());
			//设置加密盐值
			authenticationInfo.setCredentialsSalt(ByteSource.Util.bytes(dbManager.getSalt()));
			
			// 当验证都通过后，把用户信息放在session里
			Session session = SecurityUtils.getSubject().getSession();
			//获取用户拥有角色列表
			List<Role> roleList = roleService.getRoleListByManagerId(dbManager.getId());
			dbManager.setRoleList(roleList);
			session.setAttribute(Constant.MANAGER_SESSION_KEY, dbManager);
			//session.setAttribute("managerSessionId", dbManager.getNickname());
			return authenticationInfo;
		}else {
			throw new UnknownAccountException();// 没找到帐号
		}
	}


}
