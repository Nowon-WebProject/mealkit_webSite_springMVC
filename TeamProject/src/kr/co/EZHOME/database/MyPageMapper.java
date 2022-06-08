package kr.co.EZHOME.database;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import kr.co.EZHOME.dto.UserDTO;

public interface MyPageMapper {
	
	/* MyPageMapper -> UserMapper로 이동하였음
	 * @Delete("delete from usertbl where userid=#{userid}") void
	 * deleteMember(@Param("userid")String userid);
	 * 
	 * @Update("update usertbl set name=#{name},pwd=#{pwd},email=#{email},phone=#{phone},Addr=#{addr} where userid=#{userid}"
	 * ) int updateMember(UserDTO userDTO);
	 */
	
}
