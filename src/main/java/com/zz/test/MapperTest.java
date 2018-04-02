package com.zz.test;

import com.zz.mapper.DepartmentMapper;
import com.zz.mapper.EmployeeMapper;
import com.zz.pojo.Department;
import com.zz.pojo.Employee;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试Dao 层
 * spring 的项目 可以用spring的单元测试，可以自动注入我们需要的组件
 *@ContextConfiguration 指定spring配置文件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    SqlSessionTemplate sqlSessionTemplate;
    @Test
    public void testCURD(){
        System.out.println(departmentMapper);
//        插入部门
//        departmentMapper.insertSelective(new Department(null,"开发部门"));
//        departmentMapper.insertSelective(new Department(null,"测试部门"));
//        插入员工
//        employeeMapper.insertSelective(new Employee(null,"Mary","M","Marry@163.com",2));

     //   批量插入，可以使用SqlSession
//        for(){  //不是批量插入
//            employeeMapper.insertSelective(new Employee(null,"Mary","M","Marry@163.com",2));
//        }
        EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);
        for (int i = 0; i <1000; i++) {
           String uid= UUID.randomUUID().toString().substring(0,5)  +i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@163.com",2));
        }
        System.out.println("执行批量插入完成");

    }




}
