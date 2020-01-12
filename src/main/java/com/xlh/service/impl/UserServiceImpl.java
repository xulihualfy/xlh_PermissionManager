package com.xlh.service.impl;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.base.service.impl.BaseServiceImpl;
import com.xlh.dao.IUserDao;
import com.xlh.entity.User;
import com.xlh.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl extends BaseServiceImpl<User> implements IUserService {

    @Autowired
    IUserDao userDao;//此处有红线是因为这个接口没有实现它的类，但是我们配置了自动生成dao层的代理，此处报错可忽略
    @Override
    public BaseMapper<User> getMapper() {
        return userDao;
    }

    @Override
    public void batchDel(List<Integer> ids) {
        userDao.deleteBatchIds(ids);
    }

    @Override
    public List<User> getUserByRoleId(Integer id) {
        return userDao.getUserByRoleId(id);
    }
}
