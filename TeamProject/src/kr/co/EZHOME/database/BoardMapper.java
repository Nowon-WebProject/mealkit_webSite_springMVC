package kr.co.EZHOME.database;

import java.util.Vector;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.EZHOME.dto.BbsDTO;

public interface BoardMapper {
	
	@Select("select * from bbs order by bbsid desc")
	Vector<BbsDTO> getBBSList();
	
	@Insert("insert into bbs values(bbs_seq.nextval,#{userid},#{bbstitle},#{bbscontent},default,#{bbsimg},default)")
	void bbsWrite(BbsDTO bdto);
	
	@Select("select * from bbs where bbsid=#{bbsid}")
	BbsDTO findBoard(String bbsid);
	
	@Update("update bbs set bbscount = #{bbscount} where bbsid = #{bbsid}")
	void updateBBSCount(BbsDTO bdto);
	
	@Delete("delete from bbs where bbsid = #{bbsid}")
	void deleteMember(@Param("bbsid")String bbsid);
	
	@Update("update bbs set bbstitle = #{bbstitle}, bbscontent = #{bbscontent}, bbsimg = #{bbsimg} where bbsid = #{bbsid}")
	void updateMember(BbsDTO bdto);
}
