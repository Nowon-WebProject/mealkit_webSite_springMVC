package kr.co.EZHOME.database;

import java.sql.Date;
import java.util.List;
import java.util.Vector;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Component;

import kr.co.EZHOME.domain.DAOResult;
import kr.co.EZHOME.dto.CoolSMSKey;
import kr.co.EZHOME.dto.UserDTO;

public interface UserMapper {

	@Select("select * from usertbl where userid=#{userid}")
	UserDTO findUser(@Param("userid")String userid);
	
	@Select("select * from smsapikey")
	CoolSMSKey getCoolSMS();
	
	@Select("select userid from usertbl where phone=#{phone}")
	String checkUserPhone(@Param("phone")String phone);
	
	@Select("select userid from usertbl where phone=#{phone} AND name=#{name}")
	String checkUserPhoneName(@Param("phone")String phone, @Param("name")String name);
	
	@Select("select userid from usertbl where phone=#{phone} AND name=#{name} AND userid=#{userid}")
	String checkUserPhoneNameId(@Param("phone")String phone, @Param("name")String name, @Param("userid")String userid);
	
	@Update("update usertbl set pwd=#{password} where userid=#{userid}")
	int updatePassword(@Param("userid")String userid, @Param("password")String password);
	
	@Insert("insert into usertbl values(#{name}, #{userid}, #{pwd}, #{birth, jdbcType=DATE}, #{email, jdbcType=VARCHAR}, #{phone}, default, #{addr}, #{deli, jdbcType=VARCHAR}, #{point}, #{admin})")
	int insertMember(UserDTO userDTO);
	
	@Update("update usertbl set point = point - #{usePoint} + #{addPoint} where userid=#{userid}")
	void applyPoint(@Param("usePoint")int usePoint, @Param("addPoint")int addPoint, @Param("userid")String userid);
	
	///////////////////////////////////////
	
	@Select("select * from usertbl where userid=#{userid}")
	UserDTO getMember(@Param("userid")String userid);
	
	@Select("select pwd from usertbl where userid=#{userid}")
	String userCheck(@Param("userid")String userid);
	
	@Delete("delete from usertbl where userid=#{userid}")
	int deleteMember(@Param("userid")String userid);
	
	@Update("update usertbl set name=#{name},pwd=#{pwd},email=#{email},phone=#{phone},Addr=#{addr} where userid=#{userid}")
	int updateMember(UserDTO userDTO);
	
	@Select("select * from usertbl")
	Vector<UserDTO> allSelect();
	
//	@Update("update usertbl set name = #{name}, pwd = #{pwd}, email = #{email, jdbcType=VARCHAR}, phone = #{phone, jdbcType=VARCHAR}, birth = #{birth, jdbcType=DATE}, addr = #{addr} where userid = #{userid}")
//	int updateMember(UserDTO userDTO);

	@Select("select * from usertbl where ${type} like #{key}")
	Vector<UserDTO> likeFind(@Param("type")String type, @Param("key")String key);

}
