package com.xlh.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.xlh.entity.Menu;
import com.xlh.entity.ResultEntity;
import com.xlh.entity.Role;
import com.xlh.entity.User;
import com.xlh.realm.UserRealm;
import com.xlh.service.IAuthService;
import com.xlh.service.IMenuService;
import com.xlh.service.IRoleService;
import com.xlh.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("auth")
public class AuthorizationController {

    @Autowired
    private IRoleService roleService;

    @Autowired
    private IMenuService menuService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IAuthService authService;

    @Autowired
    UserRealm userRealm;
    /**
     * 查询角色，显示在页面中
     * @return
     */
    @RequestMapping("getRoleList")
    public String getRoleList(ModelMap map){
        List<Role> list = roleService.getList();
        //System.out.println(list);
        map.put("role",list);
        return "authorization/authorizationlist";
    }

    /**
     * 根据角色id查询出权限id
     * @param id
     * @return
     */
    @RequestMapping("getAuthByRoleId/{id}")
    public String getMenuByRoleId(@PathVariable Integer id,ModelMap map){
        //调用service层方法
        List<Menu> menus=menuService.getMenuByRoleId(id);
        map.put("menu",menus);
       return "authorization/tablelist";
    }

    /**
     * 通过角色id来查询用户信息
     * @param id
     * @param map
     * @return
     */
    @RequestMapping("getUserByRoleId/{id}")
    public  String getUserByRoleId(@PathVariable Integer id,ModelMap map){

      List<User> users= userService.getUserByRoleId(id);
        //System.out.println(users);
      map.put("user",users);
        return "authorization/authuserlist";
    }

    /**
     * 查询用户列表，给用户授权
     * @param rid
     * @param page
     * @param map
     * @return
     */
    @RequestMapping("toAuthUserList")
    public String toAuthUserList(Integer rid,Page<User> page,User user,ModelMap map){
        EntityWrapper<User> entityWrapper=new EntityWrapper<>();

        entityWrapper.like("username",user.getUsername());
        userService.getPage(page,entityWrapper);
        map.put("rid",rid);
        return "authorization/toauthuserlist";
    }

    /**
     * 给用户授权
     * @return
     */
    @RequestMapping("addAuthToUser")
    @ResponseBody
    public ResultEntity<String> addAuthToUser( @RequestParam("ids[]") List<Integer> ids,Integer rid){

        //判断用户时候已经存在这个角色
        List<Role> roles= authService.queryRoleByUid(ids,rid);
        //System.out.println(roles);
        if (roles.size()>0){//不能使用null来判断
            return ResultEntity.failed_msg("该用户已经授权");
        }else {
            //给角色添加用户
            int i = authService.addAuthToUser(ids, rid);
            if (i>0){
                //授权完之后就清空缓存
                userRealm.clean();
            return ResultEntity.success_msg("授权成功");
            }else {

            return ResultEntity.failed_msg("授权失败");
            }

        }


    }

    /**
     * 查询出这个角色下面有的权限以及所有的权限都需要展现出来，
     * 并且展现形式需要和zNodes里面的参数形式一样
     * @param rid
     * @return
     */
    @RequestMapping("getAuthMenuList/{rid}")
    @ResponseBody
    public List<Map<String,String>>  getAuthMenuList(@PathVariable Integer rid){
        //System.out.println(rid);
        //使用map来装数据，是为了前台能够获取相应属性的相应的值
        List<Map<String,String>> mlist=authService.getAuthMenuList(rid);
        System.out.println(mlist);
        return mlist;
    }

    /**
     * 给某个角色授权菜单权限
     * @param rid
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping("addAuthMenu")
    public ResultEntity<String> addAuthMenu(Integer rid,@RequestParam("ids[]") List<Integer> ids){
        //System.out.println(rid);
        //System.out.println("前台："+ids);
        //查询出已经存在的权限


       List<Integer> isIds= authService.getIsMenu(rid);
       // System.out.println("数据库："+isIds);
        //去重
        if (isIds.size()==0){
            //对角色权限表进行添加
            int add=authService.AuthToMenu(rid,ids);
            if (add>0){

                return ResultEntity.success_msg("授权成功");
            }else {

                return ResultEntity.failed_msg("授权失败");
            }
        }else {


        boolean b = ids.removeAll(isIds);
        if (b){
            //去重之后判断集合里面是否还有数据
            if (ids.size()<=0){

                return ResultEntity.failed_msg("所选的菜单已经全部授权！请重新操作");
            }else {
                //对角色权限表进行添加
                int add=authService.AuthToMenu(rid,ids);
                if (add>0){

                    return ResultEntity.success_msg("授权成功");
                }else {

                    return ResultEntity.failed_msg("授权失败");
                }
            }
        }else {
            return ResultEntity.success_msg("您选择的菜单已经被授权！请重试");
        }
        }
    }

    /**
     * 取消用户权限
     * @param uid
     * @return
     */
    @RequestMapping("delUserAuth")
    @ResponseBody
    public ResultEntity<String> delUserAuth(Integer uid){
        //System.out.println(uid);
        //调用service进行取消用户权限
        int del=authService.delUserAuthByUid(uid);
        if (del>0){

        return ResultEntity.success_msg("取消权限成功");
        }
        return ResultEntity.failed_msg("操作失败");
    }

    /**
     * 取消角色的菜单权限
     * @return
     */
    @RequestMapping("delMenuAuth")
    @ResponseBody
    public ResultEntity<String> delMenuAuth(Integer pid){
        //System.out.println(pid);
        int del=authService.delMenuAuth(pid);
        if (del>0){

        return ResultEntity.success_msg("取消成功");
        }
        return ResultEntity.success_msg("操作失败");
    }

}
