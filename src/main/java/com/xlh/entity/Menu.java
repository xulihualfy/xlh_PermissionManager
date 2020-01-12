package com.xlh.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

@Data
@TableName("t_menu")
public class Menu {

    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;
    @TableField("menu_name")
    private String menuName;
    @TableField("menu_url")
    private String menuUrl;
    @TableField("menu_type")
    private Integer menuType;//1：目录；2：菜单；3：按钮
    @TableField("menu_code")
    private String menuCode;
    @TableField("menu_desc")
    private String menuDesc;
    @TableField(exist = false)
    private String menuPname;

    @TableField("menu_pid")
    private Integer menuPid;
    @TableField(exist = false)
    private Integer isParent;
}
