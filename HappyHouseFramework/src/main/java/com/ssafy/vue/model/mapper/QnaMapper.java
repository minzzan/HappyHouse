package com.ssafy.vue.model.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.vue.model.QnaDto;
import com.ssafy.vue.model.QnaParameterDto;

@Mapper
public interface QnaMapper {
	
	public int writeQna(QnaDto qnaDto) throws SQLException;
	public List<QnaDto> listQna(QnaParameterDto qnaParameterDto) throws SQLException;
	public int getTotalCount(QnaParameterDto qnaParameterDto) throws SQLException;
	public QnaDto getQna(int qnano) throws SQLException;
	public void updateHit(int qnano) throws SQLException;
	public int modifyQna(QnaDto qnaDto) throws SQLException;
	public int deleteQna(int qnano) throws SQLException;
	public int writeAnswer(QnaDto qnaDto) throws SQLException;
	
}