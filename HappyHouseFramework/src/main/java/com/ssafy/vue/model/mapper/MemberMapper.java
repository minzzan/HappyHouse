package com.ssafy.vue.model.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.vue.model.MemberDto;

@Mapper
public interface MemberMapper {

	public MemberDto login(MemberDto memberDto) throws SQLException;
	public MemberDto userInfo(String userid) throws SQLException;
	public int signUp(MemberDto memberDto) throws SQLException;
	public int modifyUser(MemberDto memberDto) throws SQLException;
	public int deleteUser(String userid) throws SQLException;
	public String findPassword(MemberDto memberDto);
	
}
