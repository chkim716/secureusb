package com.saferzone.defcon4.susbma.policy.vo;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractVO;

public class SusbmaPolicyGroupUsbVO extends Defcon4AbstractVO {
	private String sno;
	private String regDate;
	private String creator;
	private String startDate;
	private String endDate;
	private Integer grpId;
	private String accountId;
	private String empName;
	private String managementId;
	private String policyValidDate;
	private String startPolDate;
	private String endPolDate;
	private String startPolHours;
	private String startPolMinutes;
	private String endPolHours;
	private String endPolMinutes;
	private Integer chkUnlimited;
	private Integer mediaId;
	
	public String getManagementId() {
		return managementId;
	}
	public void setManagementId(String managementId) {
		this.managementId = managementId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public Integer getGrpId() {
		return grpId;
	}
	public void setGrpId(Integer grpId) {
		this.grpId = grpId;
	}
	public String getPolicyValidDate() {
		return policyValidDate;
	}
	public void setPolicyValidDate(String policyValidDate) {
		this.policyValidDate = policyValidDate;
	}
	public String getStartPolDate() {
		return startPolDate;
	}
	public void setStartPolDate(String startPolDate) {
		this.startPolDate = startPolDate;
	}
	public String getEndPolDate() {
		return endPolDate;
	}
	public void setEndPolDate(String endPolDate) {
		this.endPolDate = endPolDate;
	}
	public String getStartPolHours() {
		return startPolHours;
	}
	public void setStartPolHours(String startPolHours) {
		this.startPolHours = startPolHours;
	}
	public String getStartPolMinutes() {
		return startPolMinutes;
	}
	public void setStartPolMinutes(String startPolMinutes) {
		this.startPolMinutes = startPolMinutes;
	}
	public String getEndPolHours() {
		return endPolHours;
	}
	public void setEndPolHours(String endPolHours) {
		this.endPolHours = endPolHours;
	}
	public String getEndPolMinutes() {
		return endPolMinutes;
	}
	public void setEndPolMinutes(String endPolMinutes) {
		this.endPolMinutes = endPolMinutes;
	}
	public Integer getChkUnlimited() {
		return chkUnlimited;
	}
	public void setChkUnlimited(Integer chkUnlimited) {
		this.chkUnlimited = chkUnlimited;
	}
	public Integer getMediaId() {
		return mediaId;
	}
	public void setMediaId(Integer mediaId) {
		this.mediaId = mediaId;
	}
	
}
