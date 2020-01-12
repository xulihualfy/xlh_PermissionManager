package com.xlh.service;

import com.base.service.BaseService;
import com.xlh.entity.User;

import java.util.List;

public interface IUserService extends BaseService<User> {

    void batchDel(List<Integer> ids);

    List<User> getUserByRoleId(Integer id);
}
