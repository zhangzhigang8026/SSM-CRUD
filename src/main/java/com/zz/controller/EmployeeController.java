package com.zz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zz.pojo.Employee;
import com.zz.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * 处理员工信息请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 分页查询
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue="1")Integer pn, Model model){
        System.out.println("QQQQQ");
            //        引入分页插件
            //        在查询之前调用，传入页码，以及每页大小
        PageHelper.startPage(pn,5);
            //        startPage紧跟的查询语句就是分页查询
        List<Employee> emps=employeeService.getAll();
            //        使用PageInfo来包装查询结果,封装了分页信息和数据，传入连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);
        return "/list";
    }

}
