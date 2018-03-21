package com.zz.service;

import com.zz.mapper.DepartmentMapper;
import com.zz.pojo.Department;
import com.zz.pojo.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getAll(){
      List<Department>list= departmentMapper.selectByExample(null);
        return list;
    }
}
