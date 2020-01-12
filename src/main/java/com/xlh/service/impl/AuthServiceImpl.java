package com.xlh.service.impl;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.base.service.impl.BaseServiceImpl;
import com.xlh.dao.IAuthDao;
import com.xlh.entity.AuthMenu;
import com.xlh.entity.Role;
import com.xlh.entity.User;
import com.xlh.service.IAuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class AuthServiceImpl extends BaseServiceImpl<AuthMenu> implements IAuthService {

    @Autowired
    IAuthDao authDao;
    @Override
    public BaseMapper<AuthMenu> getMapper() {
        return authDao;
    }

    @Override
    public int addAuthToUser(List<Integer> ids, Integer rid) {
      return authDao.addAuthToUser(rid,ids);
    }

    @Override
    public List<Role> queryRoleByUid(List<Integer> ids,Integer rid) {
        return authDao.queryRoleByUid(rid,ids);
    }

    @Override
    public List<Map<String, String>> getAuthMenuList(Integer rid) {
        return authDao.getAuthMenuList(rid);
    }

    //查询已经角色已经存在的菜单权限
    @Override
    public List<Integer> getIsMenu(Integer rid) {
        return authDao.getIsMenu(rid);
    }
    //对角色权限表进行添加
    @Override
    public int AuthToMenu(Integer rid, List<Integer> ids) {
        return authDao.AuthToMenu(rid,ids);
    }

    @Override
    public User getUserByUsername(String username) {
        return authDao.getUserByUsername(username);
    }

    @Override
    public Set<String> getAuthRoleByUid(Integer id) {
        return authDao.getAuthRoleByUid(id);
    }

    @Override
    public int delUserAuthByUid(Integer uid) {
        return authDao.delUserAuthByUid(uid);
    }

    @Override
    public int delMenuAuth(Integer pid) {
        return authDao.delMenuAuth(pid);
    }
}
