package com.xlh.service;

import com.base.service.BaseService;
import com.xlh.entity.AuthMenu;
import com.xlh.entity.Role;
import com.xlh.entity.User;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface IAuthService extends BaseService<AuthMenu>  {
    int addAuthToUser(List<Integer> ids, Integer rid);

    List<Role> queryRoleByUid(List<Integer> ids,Integer rid);
    //获取菜单信息和角色已有的菜单权限
    List<Map<String, String>> getAuthMenuList(Integer rid);

    //查询角色已经存在的菜单权限
    List<Integer> getIsMenu(Integer rid);
    //对角色权限表进行添加
    int AuthToMenu(Integer rid, List<Integer> ids);

    //登录查询用户
    User getUserByUsername(String username);

    Set<String> getAuthRoleByUid(Integer id);

    //取消用户权限
    int delUserAuthByUid(Integer uid);
    //取消角色的菜单权限
    int delMenuAuth(Integer pid);
}
