package com.xlh.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.xlh.entity.Menu;
import com.xlh.entity.ResultEntity;
import com.xlh.service.IMenuService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("menu")
public class MenuController {

    @Autowired
    IMenuService menuService;

    /**
     * 查询出菜单信息，联表查询，自己写SQL
     * @param page
     * @return
     */
    @RequiresPermissions("user:getUserPage")
    @RequestMapping("getPage")
    public String getPage(Page<Menu> page,ModelMap map){

        //获取数据
       menuService.getMenuPage(page);
       map.put("url","user/getPage");
        return "menu/menulist";
    }

    /**
     * 添加菜单
     * @return
     */
    @RequestMapping("addMenu")
    @ResponseBody
    public ResultEntity<String> addMenu(Menu menu){
        //System.out.println(menu);
        //System.out.println("添加数据中");
        //调用service层方法
        int insert = menuService.insert(menu);
        if (insert>0){

        return ResultEntity.success_msg("添加成功");
        }

        return ResultEntity.failed_msg("添加失败");
    }

    /**
     * 分级查询出父菜单信息，判断是否有子节点
     * @param id
     * @return
     */
    @RequestMapping("getParentMenuById")
    @ResponseBody
    public List<Map<String, Object>> getParentMenuById(Integer id){

        //System.out.println("id"+id);
        //如果前台没有传值过来，设置为0，默认查询目录
        if (id==null){
            id=0;
        }
        //查询父菜单
        List<Menu> menulist = menuService.getParentMenuById(id);
        //System.out.println(menulist);
        //为了让页面能自动识别属性，需要跟页面的属性保持一致，需要把查询到的数据通过键值对的形式传送
        Map<String,Object> map=null;
        List<Map<String,Object>> list=new ArrayList<>();
        //遍历集合
        for (Menu m:menulist) {
            map=new HashMap<>();
            map.put("id",m.getId());
            map.put("name",m.getMenuName());
            map.put("pid",m.getMenuPid());
            //设置是否是父节点，如果查询出来的
            map.put("isParent",m.getIsParent()==null?false:true);
            //把map放到集合里面
            list.add(map);
        }
        return list;
    }

    /**
     * 通过id查询出菜单信息
     * @param id
     * @param map
     * @return
     */

    @RequestMapping("getMenuById/{id}")
    public String getMenuById(@PathVariable Integer id, ModelMap map){
        Menu menu = menuService.selectMenuById(id);
        map.put("menu",menu);
        return  "menu/updmenu";
    }

    /**
     * 编辑菜单
     * @param menu
     * @return
     */
    @RequestMapping("updMenu")
    @ResponseBody
    public ResultEntity<String> updMenu(Menu menu){

        int update = menuService.update(menu);
        if (update>0){

        return ResultEntity.success_msg("编辑成功");
        }
        return ResultEntity.failed_msg("编辑失败");
    }

}
