package com.xlh.service.impl;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.base.service.impl.BaseServiceImpl;
import com.xlh.dao.IMenuDao;
import com.xlh.entity.Menu;
import com.xlh.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

@Service
public class MenuServiceImpl extends BaseServiceImpl<Menu> implements IMenuService {
    @Autowired
    IMenuDao menuDao;

    @Override
    public BaseMapper<Menu> getMapper() {
        return menuDao;
    }

    @Override
    public void getMenuPage(Page<Menu> page) {

        //查询总条数：
        page.setTotal(menuDao.getMenuCount());
        //设置页面展示的数据
        page.setRecords(menuDao.getMenuPage((page.getCurrent()-1)*page.getSize(),page.getSize()));

    }

    @Override
    public List<Menu> getParentMenuById(Integer id) {

        return menuDao.getParentMenuById(id);
    }

    @Override
    public Menu selectMenuById(Integer id) {
        return menuDao.selectMenuById(id);
    }

    /**
     * 根据角色id查询出权限信息（菜单信息）
     * @param id
     * @return
     */
    @Override
    public List<Menu> getMenuByRoleId(Integer id) {
        return menuDao.getMenuByRoleId(id);
    }

    @Override
    public Set<String> getMenuCodeByUid(Integer id) {
        return menuDao.getMenuCodeByUid(id);
    }
}
