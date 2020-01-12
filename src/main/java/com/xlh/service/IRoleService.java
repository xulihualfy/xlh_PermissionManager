package com.xlh.service;

import com.base.service.BaseService;
import com.xlh.entity.Role;

import java.util.List;

public interface IRoleService extends BaseService<Role> {
    void batchDel(List<Integer> ids);
}
