package com.xlh.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xlh.entity.AuthMenu;
import com.xlh.entity.Role;
import com.xlh.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface IAuthDao extends BaseMapper<AuthMenu> {
    //给角色添加用户
    int addAuthToUser(@Param("rid") Integer rid, @Param("ids") List<Integer> ids);

    List<Role> queryRoleByUid(@Param("rid") Integer rid, @Param("ids") List<Integer> ids);

    List<Map<String, String>> getAuthMenuList(Integer rid);

    List<Integer> getIsMenu(Integer rid);

    int AuthToMenu(@Param("rid") Integer rid, @Param("ids") List<Integer> ids);

    User getUserByUsername(String username);

    Set<String> getAuthRoleByUid(Integer uid);

    int delUserAuthByUid(Integer uid);

    int delMenuAuth(Integer pid);
}
