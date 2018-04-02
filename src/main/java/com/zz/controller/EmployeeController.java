package com.zz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zz.pojo.Employee;
import com.zz.pojo.Msg;
import com.zz.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.naming.Binding;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @RequestMapping("/q")
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        List<Employee> emps=employeeService.getAll();
        PageInfo pageInfo = new PageInfo(emps,5);

        return Msg.success().add("pageInfo",pageInfo);
    }
@RequestMapping("/checkUser")
@ResponseBody
    public Msg checkUser(String empName){
        //
        String  regName =  "(^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){5,16})|(^[\u2e80-\u9fff]{2,5})$";
        if(!empName.matches(regName)){return Msg.fail().add("va_msg","用户名必须是2-5位中文或6-16位英文和数字的合法组合");}
    boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }
        else {return Msg.fail().add("va_msg","用户名已存在");}
    }

    /**
     * 支持JSR303校验
     *导入Hibernate-Validator
     *
     * @param employee
     * @return
     */
    @RequestMapping(value = "/addemp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败,应该返回失败信息
            Map<String,Object>map=new HashMap<>();
            List<FieldError> errors =result.getFieldErrors();
            for (FieldError fieldError :errors) {
                System.out.println("错误的字段名: "+fieldError.getField());
                System.out.println("错误的字段名: "+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){

        Employee employee =employeeService.getEmp(id);

        return Msg.success().add("emp",employee);
    }

    /**
     * 要能支持直接发送PUT之类的请求还要封装请求体中的数据
     * 1.配置上HttpPutFormContentFilter
     * 2.他的作用是 将请求体中的数据解析包装成一个map
     * 3.request 被重新包装,request.getParameter()被重写,会从自己封装的map中取出
     * @param employee
     * @return
     */
    //更新员工信息
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public  Msg updateEmp(Employee employee){
        System.out.println("将要更新的数据"+employee.toString());
        employeeService.updateEmp(employee);
        return Msg.success();
    }

//    删除员工

    /**
     * 单个或批量删除
     * 批量:1-2-3
     * 单个: 1
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deletEempById(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            //批量删除
            List<Integer> del_ids =new ArrayList<>();
            String[] str_ids=ids.split("-");
            //组装id的集合
            for(String s : str_ids){
                del_ids.add(Integer.parseInt(s));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            Integer id=Integer.parseInt(ids);
            employeeService.deleteEmp(id);

        }

        return Msg.success();
    }

}
