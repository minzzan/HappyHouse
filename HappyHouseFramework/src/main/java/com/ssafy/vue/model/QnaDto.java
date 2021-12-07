package com.ssafy.vue.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "QnaDto : QnA정보", description = "QnA의 상세 정보를 나타낸다.")
public class QnaDto {
	@ApiModelProperty(value = "글번호")
	private int qnano;
	@ApiModelProperty(value = "작성자 아이디")
	private String userid;
	@ApiModelProperty(value = "글제목")
	private String title;
	@ApiModelProperty(value = "글내용")
	private String content;
	@ApiModelProperty(value = "작성일")
	private String regtime;
	@ApiModelProperty(value = "조회수")
	private int hit;
	@ApiModelProperty(value = "답변내용")
	private String answercontent;
	
	public int getQnano() {
		return qnano;
	}
	public void setQnano(int qnano) {
		this.qnano = qnano;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegtime() {
		return regtime;
	}
	public void setRegtime(String regTime) {
		this.regtime = regTime;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getAnswercontent() {
		return answercontent;
	}
	public void setAnswercontent(String answercontent) {
		this.answercontent = answercontent;
	}
	
	
}
