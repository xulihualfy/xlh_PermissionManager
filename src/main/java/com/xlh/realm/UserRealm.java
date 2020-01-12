package com.xlh.realm;

import com.xlh.entity.User;
import com.xlh.service.IAuthService;
import com.xlh.service.IMenuService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Set;

public class UserRealm extends AuthorizingRealm {

    @Autowired
    IAuthService authService;

    @Autowired
    IMenuService menuService;


    //权限校验

    /**
     * 授权认证
     * @param principals
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {

        System.out.println("授权认证");
        //获取当前用户
        User user = (User) principals.getPrimaryPrincipal();

        //查询用户拥有的角色
        Set<String> roles=authService.getAuthRoleByUid(user.getId());
       // System.out.println(roles);
        //查询当前用户拥有的权限(获取权限码就可以了)
        Set<String> menuCodes=menuService.getMenuCodeByUid(user.getId());
        //System.out.println(menuCodes);
        //创建对象SimpleAuthorizationInfo
        SimpleAuthorizationInfo info=new SimpleAuthorizationInfo();
        //添加权限

        info.setStringPermissions(menuCodes);
        //添加角色
        info.addRoles(roles);

        return info;
    }

    /**
     * 身份认证
     * @param token
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        System.out.println("身份认证");
        //获取当前的用户名
        String username = (String) token.getPrincipal();
        //通过用户名查询用户
        User user=authService.getUserByUsername(username);

        //封装信息，shiro进行比对（需要接受 当前用户，盐值，realm）
        SimpleAuthenticationInfo info=new SimpleAuthenticationInfo(user,user.getPassword(), ByteSource.Util.bytes(username),getName());
        //返回SimpleAuthenticationInfo对象
        return info;
    }

    /**
     * 清空缓存（在权限修改/添加/删除的时候使用）
     */
    public void clean(){
        super.clearCache(SecurityUtils.getSubject().getPrincipals());
    }

}
