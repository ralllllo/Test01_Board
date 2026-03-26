package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.kedu.dao.BoardsDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dto.BoardsDTO;

@Controller
@RequestMapping("/boards")
public class BoardsController {

	@Autowired
	private BoardsDAO boardsDao;

	@Autowired
	private FilesDAO filesDao;

	@Autowired
	private Gson gson;
	
	@RequestMapping("/list")
	public String toBoard(int cPage, Model model, HttpSession session) {
		
		
		List<BoardsDTO> list = boardsDao.getFromTo(cPage * 10 - 9, cPage * 10);
		// Board 테이블의 데이터가 총 몇개인지 얻어온다
		//		int recordTotalCount = list.size();
		int recordTotalCount = boardsDao.totalCount();
		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("recordCountPerPage", 10);
		model.addAttribute("recordTotalCount", recordTotalCount);
		model.addAttribute("cPage", cPage);
		session.setAttribute("cPage", cPage);
		model.addAttribute("list", list);
		return "boards/boardsMain";
	}

	@RequestMapping("/toBoardPost")
	public String toBoardPost() {
		return "boards/boardsPost";
	}

	@RequestMapping("/toBoardDetail")
	public String toBoardDetail() {
		return "boards/boardsDetail";
	}

	// 글 업로드
	@RequestMapping("/postUpload")
	public String postUp(BoardsDTO dto) throws Exception {

		int nextVal = boardsDao.getNextval();
		System.out.println(dto.getWriter());
		System.out.println(dto.getTitle());

		int result = boardsDao.postUpload(nextVal, dto);

		// file 올리는 곳

		return "redirect:/boards/list?cPage=1";
	}

	
		// 조회수 증가 및 detail 리로드
		@RequestMapping("/detail")
		public String detail(int seq, Model model) {
			
			// 조회수 증가 dao
			BoardsDTO dto = boardsDao.lookDetail(seq);
			model.addAttribute("dto", dto);
			// 파일명 보내주기

			// 댓글 dto 댓글목록확인
			
			return "boards/boardsDetail";

		}

		// 글 삭제
		@RequestMapping("/delete")
		public String del(int seq,HttpSession session) {
			
			int cPage = (Integer)(session.getAttribute("cPage"));
			int result = boardsDao.deleteContent(seq);

			if (result > 0) {
				System.out.println("삭제성공");
			}
			return "redirect:/boards/list?cPage="+cPage;
		}

		// 글 수정
		@RequestMapping("/update")
		public String up(BoardsDTO dto, int seq) {

			int result = boardsDao.updateContent(dto);

			if (result > 0) {
				System.out.println("게시글 업데이트 성공");
			}
			return "redirect:/boards/detail?seq=" + seq;
		}

		@ExceptionHandler(Exception.class)
		public String exceptionHandler(Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
