package com.ssafy.vue.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.vue.model.service.EmailService;
import com.ssafy.vue.model.service.EmailServiceImpl;

import io.swagger.annotations.ApiParam;

@RestController
//@Controller
@RequestMapping("/service")
public class ServiceController {
	 @Autowired
	 EmailService service;
	 
	 private static final Logger logger = LoggerFactory.getLogger(ServiceController.class);
	 
//		@PostMapping("/mail")
//		@ResponseBody
//		public void emailConfirm(String userId)throws Exception{
//			logger.info("post emailConfirm");
//			System.out.println("전달 받은 이메일 : "+userId);
//			service.sendSimpleMessage(userId);	
//		}
//		@PostMapping("/verifyCode")
//		@ResponseBody
//		public int verifyCode(String code) {
//			logger.info("Post verifyCode");
//			
//			int result = 0;
//			System.out.println("code : "+code);
//			System.out.println("code match : "+ EmailServiceImpl.ePw.equals(code));
//			if(EmailServiceImpl.ePw.equals(code)) {
//				result =1;
//			}
//			
//			return result;
//		}
		@PostMapping("/mail")
		@ResponseBody
		public void emailConfirm(@RequestBody Map<String, String> Map)throws Exception{
			logger.info("post emailConfirm");
			String userId = Map.get("userEmail");
			System.out.println("전달 받은 이메일 : "+userId);
			service.sendSimpleMessage(userId);	
		}
		
		@PostMapping("/verifyCode")
		@ResponseBody
		public int verifyCode(@RequestBody Map<String, String> Map) {
			logger.info("Post verifyCode");
			System.out.println(Map.get("inputCode"));
			int result = 0;
			String code = Map.get("inputCode");
			System.out.println("code : "+code);
			System.out.println("code match : "+ EmailServiceImpl.ePw.equals(code));
			if(EmailServiceImpl.ePw.equals(code)) {
				result =1;
			}
			
			return result;
		}
	 
//		@PostMapping("/mail")
//		@ResponseBody
//		public ResponseEntity<Map<String, Object>> emailConfirm(
//				@PathVariable("userid") @ApiParam(value = "인증할 회원의 아이디.", required = true) String userid,
//				HttpServletRequest request)throws Exception{
//			logger.info("post emailConfirm");
//			System.out.println("전달 받은 이메일 : "+userId);
//			service.sendSimpleMessage(userId);
//		}
//		
//		
//		@PostMapping("/verifyCode")
//		@ResponseBody
//		public int verifyCode(String code) {
//			logger.info("Post verifyCode");
//			
//			int result = 0;
//			System.out.println("code : "+code);
//			System.out.println("code match : "+ EmailServiceImpl.ePw.equals(code));
//			if(EmailServiceImpl.ePw.equals(code)) {
//				result =1;
//			}
//			
//			return result;
//		}
}