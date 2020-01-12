package com.xlh.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xlh.entity.User;

import java.util.List;

public interface IUserDao extends BaseMapper<User> {
    List<User> getUserByRoleId(Integer id);
}
