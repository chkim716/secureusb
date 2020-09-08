package com.saferzone.defcon4.susbma.policy.vo;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractVO;

public class SusbmaPolicyMasterVO extends Defcon4AbstractVO {
	private String accountId;
	private Integer usbPolicyId;
	private Integer policyId;
	private Integer classId;
	private Integer grpId;
	private Integer rangeType;
	private String regDate;
	private String creator;
	private Integer incChild;
	private String orgId;
	private String className;
	private Integer enable;
	private String orgName;
	private String grpName;
	private String fullOrgName;
	
	public String getFullOrgName() {
		return fullOrgName;
	}
	public void setFullOrgName(String fullOrgName) {
		this.fullOrgName = fullOrgName;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public Integer getUsbPolicyId() {
		return usbPolicyId;
	}
	public void setUsbPolicyId(Integer usbPolicyId) {
		this.usbPolicyId = usbPolicyId;
	}
	public Integer getPolicyId() {
		return policyId;
	}
	public void setPolicyId(Integer policyId) {
		this.policyId = policyId;
	}
	public Integer getClassId() {
		return classId;
	}
	public void setClassId(Integer classId) {
		this.classId = classId;
	}
	public Integer getGrpId() {
		return grpId;
	}
	public void setGrpId(Integer grpId) {
		this.grpId = grpId;
	}
	public Integer getRangeType() {
		return rangeType;
	}
	public void setRangeType(Integer rangeType) {
		this.rangeType = rangeType;
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
	public Integer getIncChild() {
		return incChild;
	}
	public void setIncChild(Integer incChild) {
		this.incChild = incChild;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public Integer getEnable() {
		return enable;
	}
	public void setEnable(Integer enable) {
		this.enable = enable;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getGrpName() {
		return grpName;
	}
	public void setGrpName(String grpName) {
		this.grpName = grpName;
	}
}
