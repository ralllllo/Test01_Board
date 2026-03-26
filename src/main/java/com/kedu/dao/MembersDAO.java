package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.commons.EncryptionUtils;
import com.kedu.dto.MembersDTO;

@Repository
public class MembersDAO {
	
		@Autowired
		private JdbcTemplate jdbc;
	
		EncryptionUtils eu = new EncryptionUtils();
	
		// 회원가입 정보 입력
		public int insert(MembersDTO dto) {
			String sql = "insert into members values(?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		
			return jdbc.update(sql, dto.getId(), eu.getSha512(dto.getPw()), dto.getName(), dto.getPhone(), dto.getEmail(), dto.getZipcode(), dto.getAddress1(), dto.getAddress2());
		}
	
	 	// 로그인 아이디, 비밀번호 입력
		public boolean login(String id, String pw) {
	
			String sql = "select count(*) from members where id = ? and pw = ?";
			
			return jdbc.queryForObject(sql, Integer.class, id, eu.getSha512(pw)) > 0;
		}
	
		// 로그인 중복 체크
		public boolean check(String id) {
	
			String sql = "select count(*) from members where id = ?";
			
			return jdbc.queryForObject(sql, Integer.class, id) > 0;
		}
	
		// 마이페이지
		public List<MembersDTO> mypage(String id) throws Exception { // 마이페이지에 정보 가져오기
	
			String sql = "select * from members where id = ?";
			
			return jdbc.query(sql, new BeanPropertyRowMapper<MembersDTO>(MembersDTO.class), id);
		}
	
		// 회원 탈퇴
		public int withdraw(String id) throws Exception { 
	
			String sql = "delete from members where id = ?";
			
			return jdbc.update(sql, id);
		}
		
		// 마이페이지 수정
		public int update(MembersDTO dto, String id) throws Exception {
			
			String sql = "update members set phone = ?, email = ? , zipcode = ? , address1 = ?, address2 = ? where id = ?";
			
			return jdbc.update(sql, dto.getPhone(), dto.getEmail(), dto.getZipcode(), dto.getAddress1(), dto.getAddress2(), id);
		}	
}
