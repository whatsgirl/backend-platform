package com.platform.authorization.model;

import com.platform.authorization.dto.GroupDto;

/**
 * 
 * @author yang.li
 *
 */
public class GroupModel extends GroupDto {
	
	// 用户是否存在于角色 0-不存在 1-存在
	private String exist = "";
	
	private String sys_user_id = "";
	
	private String groupname = "";
	
	private String sys_group_id = "";
	
	private String memo = "";
	
	private String ids = "";

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getExist() {
		return exist;
	}

	public void setExist(String exist) {
		this.exist = exist;
	}

	public String getSys_user_id() {
		return sys_user_id;
	}

	public void setSys_user_id(String sys_user_id) {
		this.sys_user_id = sys_user_id;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getSys_group_id() {
		return sys_group_id;
	}

	public void setSys_group_id(String sys_group_id) {
		this.sys_group_id = sys_group_id;
	}

	public String getGroupname() {
		return groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

}
