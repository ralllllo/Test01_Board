package com.kedu.controllers;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.kedu.dao.BoardsDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dto.BoardDTO;
import com.kedu.dto.BoardsDTO;
import com.kedu.dto.FilesDTO;
import com.kedu.dto.ReplyDTO;

@Controller
@RequestMapping("/boards")
public class BoardsController {

	@Autowired
	private BoardsDAO boardsDao;

	@Autowired
	private ReplysDAO replyDao;

	@Autowired
	private FilesDAO filesDao;

	@Autowired
	private Gson gson;
	
	@RequestMapping("/list")
	public String toBoard(int cPage, Model model) {

		List<BoardsDTO> list = boardsDao.getFromTo(cPage * 10 - 9, cPage * 10);
		// Board 테이블의 데이터가 총 몇개인지 얻어온다
		//		int recordTotalCount = list.size();
		int recordTotalCount = boardsDao.totalCount();
		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("recordCountPerPage", 10);
		model.addAttribute("recordTotalCount", recordTotalCount);
		model.addAttribute("currentPage", cPage);

		model.addAttribute("list", list);
		return "board/boardMain";
	}

	@RequestMapping("/toBoardPost")
	public String toBoardPost() {
		return "board/boardPost";
	}

	@RequestMapping("/toBoardDetail")
	public String toBoardDetail() {
		return "board/boardDetail";
	}

	// 글 업로드
	@RequestMapping("/postUpload")
	public String postUp(BoardDTO dto, MultipartFile[] files) throws Exception {

		int nextVal = boardsDao.getNextval();
		System.out.println(dto.getWriter());
		System.out.println(dto.getTitle());

		int result = boardsDao.postUpload(nextVal, dto);

		File filePath = new File("c:/files");

		for (MultipartFile file : files) {
			if (!file.isEmpty()) {
				String ori_name = file.getOriginalFilename();
				String sys_name = UUID.randomUUID() + "_" + ori_name;
				file.transferTo(new File("c:files/" + sys_name));

				filesDao.upload(new FilesDTO(0, ori_name, sys_name, nextVal));
			}
		}

		return "redirect:/board/toBoard?currentPage=1";
	}

	
		// 조회수 증가 및 detail 리로드
		@RequestMapping("/detail")
		public String detail(int seq, int currentPage, Model model) {
			// 조회수 증가 dao
			BoardsDTO dto = boardsDao.lookDetail(seq);
			model.addAttribute("dto", dto);
			model.addAttribute("currentPage", currentPage);

			// 파일명 보내주기
			List<FilesDTO> list2 = filesDao.selectFile(seq);
			model.addAttribute("list2", list2);

			// 댓글 dto 댓글목록확인
			List<ReplyDTO> list = replyDao.replyAll();
			model.addAttribute("list", list);

			return "board/boardDetail";

		}
		
		

		

		// 글 삭제
		@RequestMapping("/delete")
		public String del(int seq) {

			int result = boardsDao.deleteContent(seq);

			if (result > 0) {
				System.out.println("삭제성공");
			}
			return "redirect:/board/";
		}

		// 글 수정
		@RequestMapping("/update")
		public String up(BoardDTO dto, int seq, int currentPage) {

			int result = boardsDao.updateContent(dto);

			if (result > 0) {
				System.out.println("게시글 업데이트 성공");
			}
			return "redirect:/board/detail?seq=" + seq + "&currentPage=" + currentPage;
		}

		@ExceptionHandler(Exception.class)
		public String exceptionHandler(Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
