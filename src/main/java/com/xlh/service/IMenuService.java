package com.xlh.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.base.service.BaseService;
import com.xlh.entity.Menu;

import java.util.List;
import java.util.Set;

public interface IMenuService extends BaseService<Menu> {
    void getMenuPage(Page<Menu> page);

    List<Menu> getParentMenuById(Integer id);

    Menu selectMenuById(Integer id);

    List<Menu> getMenuByRoleId(Integer id);

    Set<String> getMenuCodeByUid(Integer id);
}
