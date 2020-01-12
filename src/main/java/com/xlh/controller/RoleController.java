package com.xlh.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.xlh.entity.ResultEntity;
import com.xlh.entity.Role;
import com.xlh.service.IRoleService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("role")
public class RoleController {

    @Autowired
    IRoleService roleService;
    /**
     * 获取列表，实现分页
     * @param page
     * @return
     */
    @RequiresPermissions("role:getRolePage")
    @RequestMapping("getRolePge")
    public  String getRolePge(Page<Role> page, ModelMap map){//方法的形参默认是放到ModelMap里面的，所有不需要再传

        //调用service层进行分页查询
        roleService.getPage(page,null);
        EntityWrapper<Role> entityWrapper=new EntityWrapper<>();

        entityWrapper.orderDesc(Collections.singleton("id"));
        map.put("page",page);
        map.put("url","role/getRolePge");
        System.out.println(page.getRecords());
        return "role/rolelist";
    }

    /**
     * 添加角色
     * @param role
     * @return
     */
    @RequestMapping("addRole")
    @ResponseBody
    public ResultEntity<String> addRole(Role role){

        int insert = roleService.insert(role);
        if (insert>0){
        return ResultEntity.success_msg("角色添加成功");

        }else {

        return ResultEntity.success_msg("角色添加失败");
        }
    }

    /**
     * 删除角色
     * @param role
     * @return
     */
    @ResponseBody
    @RequestMapping("delRole")
    public ResultEntity<String> delRole(Role role){

        int i = roleService.deleteById(role.getId());
        if (i>0){

        return  ResultEntity.success_msg("删除成功");
        }else {

        return  ResultEntity.failed_msg("删除失败");
        }

    }

    /**
     * 信息回填
     * @param id
     * @param map
     * @return
     */
    @RequiresPermissions("role:update")
    @RequestMapping("getRoleById/{id}")
    public String getRoleById(@PathVariable Integer id,ModelMap map){

        Role role = roleService.selectById(id);
        map.put("role",role);
        return "role/updrole";
    }

    /**
     * 修改角色
     * @param role
     * @return
     */
    @RequestMapping("updRole")
    @ResponseBody
    public ResultEntity<String> updRole(Role role){

        int update = roleService.update(role);
        if (update>0){
            return ResultEntity.success_msg("编辑成功");
        }
            return ResultEntity.failed_msg("编辑失败");

    }

    /**
     * 批量删除
     * @param ids
     */
    @ResponseBody
    @RequestMapping("batchDel")
    public void batchDel(@RequestParam("ids[]") List<Integer> ids){

        roleService.batchDel(ids);
    }
}
