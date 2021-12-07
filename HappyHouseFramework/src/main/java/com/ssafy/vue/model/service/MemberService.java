package com.ssafy.vue.model.service;

import com.ssafy.vue.model.MemberDto;

public interface MemberService {

	public MemberDto login(MemberDto memberDto) throws Exception;
	public MemberDto userInfo(String userid) throws Exception;
	public boolean signUp(MemberDto memberDto) throws Exception;
	public boolean modifyUser(MemberDto memberDto) throws Exception;
	public boolean deleteUser(String userid) throws Exception;
	public String findPassword(MemberDto memberDto) throws Exception;
	
}
