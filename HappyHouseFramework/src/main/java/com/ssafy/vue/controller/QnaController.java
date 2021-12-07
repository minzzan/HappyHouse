package com.ssafy.vue.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.vue.model.QnaDto;
import com.ssafy.vue.model.QnaParameterDto;
import com.ssafy.vue.model.service.QnaService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

//http://localhost:9999/vue/swagger-ui.html
//@CrossOrigin(origins = { "*" }, methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.POST} , maxAge = 6000)
@RestController
@RequestMapping("/qna")
@Api("Qna 컨트롤러  API V1")
public class QnaController {

	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private QnaService qnaService;

	@ApiOperation(value = "Qna 글작성", notes = "새로운 질문 정보를 입력한다. 그리고 DB입력 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PostMapping
	public ResponseEntity<String> writeQna(@RequestBody @ApiParam(value = "질문 정보.", required = true) QnaDto qnaDto) throws Exception {
		logger.info("writeQna - 호출");
		if (qnaService.writeQna(qnaDto)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	@ApiOperation(value = "Qna 답변작성", notes = "새로운 답변 정보를 입력한다. 그리고 DB입력 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PutMapping("/answer")
	public ResponseEntity<String> writeAnswer(@RequestBody @ApiParam(value = "답변 정보.", required = true) QnaDto qnaDto) throws Exception {
		logger.info("writeAnswer - 호출");
		if (qnaService.writeAnswer(qnaDto)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	@ApiOperation(value = "Qna 글목록", notes = "모든 질문의 정보를 반환한다.", response = List.class)
	@GetMapping
	public ResponseEntity<List<QnaDto>> listQna(@ApiParam(value = "질문을 얻기위한 부가정보.", required = true) QnaParameterDto qnaParameterDto) throws Exception {
		logger.info("listQna - 호출");
		return new ResponseEntity<List<QnaDto>>(qnaService.listQna(qnaParameterDto), HttpStatus.OK);
	}
	
	@ApiOperation(value = "Qna 글보기", notes = "글번호에 해당하는 질문의 정보를 반환한다.", response = QnaDto.class)
	@GetMapping("/{qnano}")
	public ResponseEntity<QnaDto> getQna(@PathVariable("qnano") @ApiParam(value = "얻어올 글의 글번호.", required = true) int qnano) throws Exception {
		logger.info("getQna - 호출 : " + qnano);
		qnaService.updateHit(qnano);
		return new ResponseEntity<QnaDto>(qnaService.getQna(qnano), HttpStatus.OK);
	}
	
	@ApiOperation(value = "Qna 글수정", notes = "새로운 질문 정보를 입력한다. 그리고 DB수정 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PutMapping
	public ResponseEntity<String> modifyQna(@RequestBody @ApiParam(value = "수정할 글정보.", required = true) QnaDto qnaDto) throws Exception {
		logger.info("modifyQna - 호출");
		
		if (qnaService.modifyQna(qnaDto)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.OK);
	}
	
	@ApiOperation(value = "Qna 글삭제", notes = "글번호에 해당하는 질문의 정보를 삭제한다. 그리고 DB삭제 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@DeleteMapping("/{qnano}")
	public ResponseEntity<String> deleteQna(@PathVariable("qnano") @ApiParam(value = "삭제할 글의 글번호.", required = true) int qnano) throws Exception {
		logger.info("deleteQna - 호출");
		if (qnaService.deleteQna(qnano)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
}