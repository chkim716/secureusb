package com.saferzone.defcon4.susbma.usbmanage.vo;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractVO;

public class SusbmaReasonVO extends Defcon4AbstractVO {
	private Integer reasonId;
	private String reasonName;
	private String reasonDesc;
	private String creator;
	private Integer isSystemDefault;
	private String regdate;
	public Integer getReasonId() {
		return reasonId;
	}
	public void setReasonId(Integer reasonId) {
		this.reasonId = reasonId;
	}
	public String getReasonName() {
		return reasonName;
	}
	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}
	public String getReasonDesc() {
		return reasonDesc;
	}
	public void setReasonDesc(String reasonDesc) {
		this.reasonDesc = reasonDesc;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public Integer getIsSystemDefault() {
		return isSystemDefault;
	}
	public void setIsSystemDefault(Integer isSystemDefault) {
		this.isSystemDefault = isSystemDefault;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}
