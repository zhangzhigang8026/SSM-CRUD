package com.zz.service;

import com.zz.mapper.EmployeeMapper;
import com.zz.pojo.Employee;
import com.zz.pojo.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 校验用户名是否可用
     * @param empName
     * @return
     */
    public boolean checkUser(@RequestParam("empName") String empName) {
        EmployeeExample employeeExample =new EmployeeExample();
        EmployeeExample.Criteria criteria =employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count=employeeMapper.countByExample(employeeExample);
        return count ==0 ? true:false;
    }


    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public Employee getEmp(Integer id) {
        Employee employee=employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
       EmployeeExample example =new EmployeeExample();
       EmployeeExample.Criteria criteria =example.createCriteria();
       //delete from xxx where emp_id in (1,2,3)
       criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
