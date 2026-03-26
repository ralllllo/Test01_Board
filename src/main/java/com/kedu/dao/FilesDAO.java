package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FilesDTO;

@Repository
public class FilesDAO {
	
	@Autowired
	private JdbcTemplate jdbc;

	public int insertFile(FilesDTO dto){
		String sql = "insert into files values(files_seq.nextval, ?, ?, ?)";
		return jdbc.update(sql, dto.getOri_name(), dto.getSys_name(), dto.getParent_seq());
	};
	
	
	public List<FilesDTO> selectAll(){
		String sql = "select * from files order by seq";
		return jdbc.query(sql, new BeanPropertyRowMapper<FilesDTO>(FilesDTO.class));
	};
	
	public List<FilesDTO> selectFileName(int seq){
		String sql = "select * from files where parent_seq = ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<FilesDTO>(FilesDTO.class), seq);
	};
	
	
}
