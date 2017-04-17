package com.system.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.system.bean.Right;
import com.system.service.RightService;

@Controller
@RequestMapping(value = "/right")
public class RightController {

	@Resource(name = "rightService")
	private RightService rightService;

	@RequestMapping("/list")
	public String toRightList(){
		
		return "system/rightmanage";
	}
	
	@RequestMapping(value = "/getAllRight")
	@ResponseBody
	public JSONObject getAllRight(Model model) throws Exception {
		JSONObject jo = new JSONObject();
		jo.put("status", 1);
		List<Right> list = rightService.getAllRight();
		jo.put("data", list);
		return jo;
	}

	/**
	 * 根据id获取权限的详细信息
	 * @param funcId
	 * @param model
	 * @return
	 * @author Handy
	 */
	@RequestMapping(value = "/getFuncInfoById")
	@ResponseBody
	public JSONObject getFuncInfoById(Integer funcId, Integer parentId, Integer type, Model model) {
		JSONObject jo = new JSONObject();
		Right right = null;
		if (funcId != null) {//修改
			right = rightService.getRightById(funcId);
		} else {//新增
			right = new Right();
			right.setType(type);
			right.setParentId(parentId);
		}
		jo.put("status", 1);
		jo.put("data", right);
		return jo;
	}

	/**
	 * 保存权限的信息
	 * @param right
	 * @return
	 * @author Handy
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public JSONObject saveOrUpdate(Right right) {
		return rightService.saveOrUpdateRight(right);
	}

	/**
	 * 根据id删除指定功能
	 * @param funcId
	 * @return
	 * @author Handy
	 */
	@RequestMapping(value = "/delById")
	@ResponseBody
	public JSONObject delFuncById(Integer funcId) {
		return rightService.delRightById(funcId);
	}

	/**
	 * 样式选择页面
	 * @param model
	 * @return
	 * @author Handy
	 * @date 2016年4月12日 上午11:00:12 
	 * @throws Exception
	 */
	@RequestMapping(value = "/iconSelect")
	public String iconSelect(Model model) throws Exception {
		return "/system/function/icon-select";
	}

}
