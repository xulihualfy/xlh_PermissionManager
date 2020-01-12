package com.xlh.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xlh.entity.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

public interface IMenuDao extends BaseMapper<Menu> {
    List<Menu> getMenuPage(@Param("index") Integer i, @Param("size")Integer size);

    Integer getMenuCount();

    List<Menu> getParentMenuById(Integer id);

    Menu selectMenuById(Integer id);

    List<Menu> getMenuByRoleId(Integer id);

    Set<String> getMenuCodeByUid(Integer uid);
}
