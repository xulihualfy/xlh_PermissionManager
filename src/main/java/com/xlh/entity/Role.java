package com.xlh.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

@Data
@TableName("t_roles")
public class Role {

    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    @TableField("role_name")
    private String roleName;
    @TableField("role_desc")
    private String roleDesc;

}
