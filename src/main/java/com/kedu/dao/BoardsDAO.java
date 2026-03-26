package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardsDTO;

@Repository
public class BoardsDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	// 게시판 글 업로드
		public int postUpload(int nextVal,BoardsDTO dto){
			String sql = "insert into boards values(?,?,?,?,0,sysdate)";
			
			return jdbc.update(sql,nextVal,dto.getWriter(),dto.getTitle(),dto.getContents());
			
		}
		
		//nextval 얻어오기
		
		public int getNextval() {
			
			String sql = "select boards_seq.nextval from dual";
			return jdbc.queryForObject(sql, Integer.class);
		}
		
		
		//db 리스트로 반환
		
		public List<BoardsDTO> selectAll(){
			String sql = "select * from boards order by seq desc";
			return jdbc.query(sql, new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class));
		}
		public int totalCount(){
			String sql = "select count(*) from boards";
			return jdbc.queryForObject(sql,Integer.class);
		}
		public List<BoardsDTO> getFromTo(int start, int end){
			String sql = "SELECT * FROM(SELECT BOARDS.*,ROW_NUMBER() OVER(ORDER BY SEQ DESC) NUM FROM BOARDS) WHERE NUM BETWEEN ? AND ?";
			return jdbc.query(sql,new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),start,end);
			
		}
		
		
		
		//조회수 증가
		public BoardsDTO lookDetail(int seq) {
			
			
			String sql2 = "select * from boards where seq=?";
			BoardsDTO dto1 = jdbc.queryForObject(sql2, new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),seq);
			dto1.setView_count(dto1.getView_count()+1);
			
			String sql1 = "update boards set view_count=? where seq=?";
			jdbc.update(sql1,dto1.getView_count(),seq);
			
			return dto1;
		}
		
		// 댓글 수정후 리로드
		public BoardsDTO reroad(int seq) {
			String sql = "select * from boards where seq=?";
			return jdbc.queryForObject(sql, new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),seq);
		}
		
		//글 삭제
		public int deleteContent(int seq) {
			
			String sql = "delete from boards where seq=?";
			
			return jdbc.update(sql,seq);
			
		}
		
		//게시글 업데이트
		public int updateContent(BoardsDTO dto){
			String sql = "update boards set title=?,contents=? where seq=?";
			
			return jdbc.update(sql,dto.getTitle(),dto.getContents(),dto.getSeq());
		}
		
	
}