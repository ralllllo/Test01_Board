package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kedu.dao.MembersDAO;
import com.kedu.dto.MembersDTO;

@Controller
	@RequestMapping("/members")
public class MembersController {
	
		@Autowired
		private MembersDAO dao;

		@Autowired
		private Gson gson;

		// 로그인 창 띄우기
		//			@RequestMapping("/Home")
		//			public String home() {
		//				return "members/home";
		//			}

		// 회원가입 버튼 누르면 회원가입 창 띄우기
		@RequestMapping("/join")
		public String join() { 

			return "members/joinform"; 
		}

		// 회원가입 버튼 누르면 처음 로그인 화면으로 돌아가기
		@RequestMapping("/joinUpdate")
		public String join(MembersDTO dto) throws Exception {

			dao.insert(dto);

			return "redirect:/";
		}

		// 로그인 버튼 누르면 목록 창 띄우기
		@RequestMapping("/login")
		public String login(String id, String pw, HttpSession session) throws Exception {

			boolean result = dao.login(id, pw);
			if(result) {
				session.setAttribute("loginId", id);
			}
			return "redirect:/";
		}

		// 로그아웃 버튼 누르고 로그아웃 하기
		@RequestMapping("/logout")
		public String logout(HttpSession session) throws Exception {

			session.invalidate();

			return "redirect:/";
		}

		// 아이디 중복 체크하기
		@ResponseBody
		@RequestMapping("/Duplicate") 
		public String duplicate(String id) throws Exception {

			boolean dup = dao.check(id);

			return gson.toJson(dup);
		}

		// 마이페이지 이동하기
		@RequestMapping("/myPage")
		public String mypage(Model model, HttpSession session) throws Exception {

			String id = (String)session.getAttribute("loginId");

			List<MembersDTO> mypage = dao.mypage(id);

			model.addAttribute("mypage", mypage);

			return "members/mypage";
		}

		// 마이페이지에서 뒤로가기 버튼 누르면 목록 화면으로 돌아가기
		@RequestMapping("/updateBack")
		public String mypageback() throws Exception {

			return "redirect:/";
		}

		// 회원탈퇴 버튼 누르면 확인 페이지로 이동
		@RequestMapping("/deleteAccount")
		public String withdraw2(HttpSession session) throws Exception {

			String id = (String)session.getAttribute("loginId");

			dao.withdraw(id);

			session.invalidate();

			return "redirect:/";
		}

		// 마이페이지에서 수정 버튼 누르면 수정 하고 저장
		@RequestMapping("/update")
		public String update(MembersDTO dto, HttpSession session) throws Exception {

			String id = (String)session.getAttribute("loginId");

			dao.update(dto, id);

			return "redirect:/members/myPage";
		}

		@ExceptionHandler(Exception.class) 
		public String exceptionHandler(Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
