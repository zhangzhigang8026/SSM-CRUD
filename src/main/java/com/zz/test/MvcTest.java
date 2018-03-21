package com.zz.test;

import com.github.pagehelper.PageInfo;
import com.zz.pojo.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.Result;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;

import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用spring测试模块提供的请求功能，测试CURD 请求的正确性
 *spring4测试需要servlet3.0支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:dispatcherServlet-servlet.xml"})
public class MvcTest {
    //传入Springmvc的ioc

    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求
    MockMvc mockMvc ;
    @Before
    public void initMockMvc(){
        mockMvc= MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
       MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","5")).andReturn();
        //请求成功后，PageInfo
        MockHttpServletRequest request=result.getRequest();
        PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页码："+pi.getPageNum());
        System.out.println("总页码："+pi.getPages());
        System.out.println("总记录数："+pi.getTotal());
        int [] nums = pi.getNavigatepageNums();
        for (int i : nums) {
            System.out.print(" "+i);
        }

        //获取员工数据
        List<Employee> list=pi.getList();
        for(Employee e : list){
            System.out.println("ID:"+e.getEmpId()+"==>Name :"+e.getEmpName());
        }



    }
}
