package com.xlh.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.xlh.entity.ResultEntity;
import com.xlh.entity.User;
import com.xlh.service.IUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Wrapper;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    IUserService userService;

    /**
     * 可实现条件查询
     * @param page
     * @param map
     * @return
     */
    @RequiresPermissions("user:getUserPage")
    @RequestMapping(value = "/getPage")
    public String getPage(Page<User> page, ModelMap map,User user) {

        //System.err.println(user);
        EntityWrapper<User> entityWrapper=new EntityWrapper<>();
        entityWrapper.like("username",user.getUsername());
        entityWrapper.like("email",user.getEmail());
        //按照时间降序排序
        entityWrapper.orderDesc(Collections.singleton("create_time"));


        //调用service层方法
        userService.getPage(page,entityWrapper);
        map.put("page",page);
        map.put("url","user/getPage");
        return "user/userlist";
    }

    /**
     * 添加用户
     * @param user
     * @return
     */
    @ResponseBody
    @RequiresPermissions("user:add")
    @RequestMapping("addUser")
    public  ResultEntity<String> addUser(User user){
        user.setCreateTime(new Date());
        //对密码进行加密
        Object bytes = ByteSource.Util.bytes(user.getUsername());
        SimpleHash simpleHash=new SimpleHash("MD5",user.getPassword(),bytes,1024);
        user.setPassword(simpleHash.toString());
        //添加用户
        int insert = userService.insert(user);
        if (insert>0){

        return ResultEntity.success_msg("用户添加成功");
        }

        return ResultEntity.failed_msg("用户添加失败");
    }

    /**
     * 通过id查询用户，表单回填
     * @param id
     * @param map
     * @return
     */
    @RequiresPermissions("user:update")
    @RequestMapping("getUserById/{id}")
    public  String getUserById(@PathVariable Integer id,ModelMap map){

        //System.out.println(id);
        //根据用户id查询信息
        User user = userService.selectById(id);
        map.put("user",user);
        //跳转到编辑页面
        return "user/upduser";
    }


    /**
     * 编辑用户信息
     * @param user
     * @return
     */
    @RequiresPermissions("user:update")
    @RequestMapping("updUser")
    @ResponseBody
    public  ResultEntity<String> updUser(User user){

        //进行修改
        int update = userService.update(user);

        if (update>0){

        return ResultEntity.success_msg("用户编辑成功");
        }else {

        return ResultEntity.success_msg("用户编辑失败");
        }

    }

    /**
     *批量删除
     * @param ids:接受一个集合，在springMVC中，方法形参需要与页面name属性保持一致，需要加注解
     */
    @RequiresPermissions("user:delete")
    @ResponseBody
    @RequestMapping("batchDel")
    public void batchDel(@RequestParam("ids[]") List<Integer> ids){

        userService.batchDel(ids);
    }

    /*
    删除单个用户
     */
    @RequiresPermissions("user:delete")
    @RequestMapping("delUser")
    @ResponseBody
    public ResultEntity<String> delUser(@RequestParam("uid") Integer id){

        int i = userService.deleteById(id);
        if (i>0){

        return ResultEntity.success_msg("删除成功");
        }
        return ResultEntity.failed_msg("删除失败");
    }

    /**
     * 登录
     * @param user
     * @return
     */
    @RequestMapping("login")
    public String login(User user,ModelMap map){
        //获取到当前的主体
        Subject subject = SecurityUtils.getSubject();
        //System.out.println(user.getPassword());
        //判断当前用户是否登录
        if (!subject.isAuthenticated()){
            //封装
            UsernamePasswordToken token=new UsernamePasswordToken(user.getUsername(),user.getPassword());
            try {

            subject.login(token);
            }catch (UnknownAccountException uae){//账号错误
                map.put("msg","账号认证错误");
                return "user/login";
            }catch (IncorrectCredentialsException ice){//账号错误
                map.put("msg","密码认证错误");
                return "user/login";
            }
            catch (AuthenticationException ae){//所有认证异常的父类
                map.put("msg","认证不成功");
                return "user/login";
            }
        }
        return "../index";
    }

}
