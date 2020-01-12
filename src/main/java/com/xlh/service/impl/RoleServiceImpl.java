package com.xlh.service.impl;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.base.service.impl.BaseServiceImpl;
import com.xlh.dao.IRoleDao;
import com.xlh.entity.Role;
import com.xlh.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl extends BaseServiceImpl<Role> implements IRoleService {

    @Autowired
    IRoleDao roleDao;
    @Override
    public BaseMapper<Role> getMapper() {
        return roleDao;
    }

    @Override
    public void batchDel(List<Integer> ids) {
        roleDao.deleteBatchIds(ids);
    }
}
