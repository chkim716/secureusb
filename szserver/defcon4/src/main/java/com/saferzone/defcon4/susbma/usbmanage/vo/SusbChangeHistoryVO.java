/**
 * 
 */
package com.saferzone.defcon4.susbma.usbmanage.vo;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractVO;

/**
 *
 * 클래스 용도
 *
 * @author worker
 * @since 2011. 6. 1.
 * @version 1.0
 */
public class SusbChangeHistoryVO extends Defcon4AbstractVO{

	/** 변경이력ID */
	private String changeHistoryId;
	/** USB 시리얼 번호 */
	private String sno;
	/** 변경사유ID */
	private Integer reasonId;
	/** 관리번호 */
	private String managementId;
	/** 사용자사번 */
	private String userEmpId;
	/** 관리책임자사번 */
	private String mngEmpId;
	/** 등급ID */
	private Integer classId;
	/** 매체ID */
	private Integer mediaId;
	/** 상태ID */
	private Integer stateId;
	/** 용량(MB) */
	private Integer capacity;
	/** 비밀번호 */
	private String password;
	/** 변경관리자 */
	private String adminId;
	/** 변경일자 */
	private String changeDate;
	/** 사용기간체크여부 */
	private Integer doCheckUseTerm;
	/** 사용기간_시작일 */
	private String useTermBegin;
	/** 사용기간_종료일 */
	private String useTermEnd;
	/** 정책_데이터삭제 */
	private Integer policyFormat;
	/** 정책_사용금지 */
	private Integer policyDeny;
	/** 정책_메세지 출력여부 */
	private Integer policyMessageOut;
	/** 정책_출력메세지 */
	private String policyMessage;
	private Integer updateType;
	/** 사용자명 */
	private String userEmpName;
	/** 관리책임자명 */
	private String mngEmpName;
	private String stateName;
	private String reasonName;
	private String accountId;
	private Integer isDeptType;
	/** 불용처리사유 */
	private String unUseDesc;
	/** 마지막 사용 에이전트_ID */
	private String assetId;
	/** 마지막 사용 에이전트_ID - OrgId */
	private String pcOrgId;
	
	private String permStartDate;
	
	private String permEndDate;
	
	private int isTimeCheck;
	
	private String orgNameList;
	
	private String reasonState;
	
	private String reasonChange;
	
	public String getOrgNameList() {
		return orgNameList;
	}
	public void setOrgNameList(String orgNameList) {
		this.orgNameList = orgNameList;
	}
	public String getPermStartDate() {
		return permStartDate;
	}
	public void setPermStartDate(String permStartDate) {
		this.permStartDate = permStartDate;
	}
	public String getPermEndDate() {
		return permEndDate;
	}
	public void setPermEndDate(String permEndDate) {
		this.permEndDate = permEndDate;
	}
	public int getIsTimeCheck() {
		return isTimeCheck;
	}
	public void setIsTimeCheck(int isTimeCheck) {
		this.isTimeCheck = isTimeCheck;
	}
	public Integer getIsDeptType() {
		return isDeptType;
	}
	public void setIsDeptType(Integer isDeptType) {
		this.isDeptType = isDeptType;
	}
	public String getChangeHistoryId() {
		return changeHistoryId;
	}
	public void setChangeHistoryId(String changeHistoryId) {
		this.changeHistoryId = changeHistoryId;
	}
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	public Integer getReasonId() {
		return reasonId;
	}
	public void setReasonId(Integer reasonId) {
		this.reasonId = reasonId;
	}
	public String getManagementId() {
		return managementId;
	}
	public void setManagementId(String managementId) {
		this.managementId = managementId;
	}
	public String getUserEmpId() {
		return userEmpId;
	}
	public void setUserEmpId(String userEmpId) {
		this.userEmpId = userEmpId;
	}
	public String getMngEmpId() {
		return mngEmpId;
	}
	public void setMngEmpId(String mngEmpId) {
		this.mngEmpId = mngEmpId;
	}
	public Integer getClassId() {
		return classId;
	}
	public void setClassId(Integer classId) {
		this.classId = classId;
	}
	public Integer getMediaId() {
		return mediaId;
	}
	public void setMediaId(Integer mediaId) {
		this.mediaId = mediaId;
	}
	public Integer getStateId() {
		return stateId;
	}
	public void setStateId(Integer stateId) {
		this.stateId = stateId;
	}
	public Integer getCapacity() {
		return capacity;
	}
	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(String changeDate) {
		this.changeDate = changeDate;
	}
	public Integer getDoCheckUseTerm() {
		return doCheckUseTerm;
	}
	public void setDoCheckUseTerm(Integer doCheckUseTerm) {
		this.doCheckUseTerm = doCheckUseTerm;
	}
	public String getUseTermBegin() {
		return useTermBegin;
	}
	public void setUseTermBegin(String useTermBegin) {
		this.useTermBegin = useTermBegin;
	}
	public String getUseTermEnd() {
		return useTermEnd;
	}
	public void setUseTermEnd(String useTermEnd) {
		this.useTermEnd = useTermEnd;
	}
	public Integer getPolicyFormat() {
		return policyFormat;
	}
	public void setPolicyFormat(Integer policyFormat) {
		this.policyFormat = policyFormat;
	}
	public Integer getPolicyDeny() {
		return policyDeny;
	}
	public void setPolicyDeny(Integer policyDeny) {
		this.policyDeny = policyDeny;
	}
	public Integer getPolicyMessageOut() {
		return policyMessageOut;
	}
	public void setPolicyMessageOut(Integer policyMessageOut) {
		this.policyMessageOut = policyMessageOut;
	}
	public String getPolicyMessage() {
		return policyMessage;
	}
	public void setPolicyMessage(String policyMessage) {
		this.policyMessage = policyMessage;
	}
	public Integer getUpdateType() {
		return updateType;
	}
	public void setUpdateType(Integer updateType) {
		this.updateType = updateType;
	}
	public String getUserEmpName() {
		return userEmpName;
	}
	public void setUserEmpName(String userEmpName) {
		this.userEmpName = userEmpName;
	}
	public String getMngEmpName() {
		return mngEmpName;
	}
	public void setMngEmpName(String mngEmpName) {
		this.mngEmpName = mngEmpName;
	}
	public String getStateName() {
		return stateName;
	}
	public void setStateName(String stateName) {
		this.stateName = stateName;
	}
	public String getReasonName() {
		return reasonName;
	}
	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getUnUseDesc() {
		return unUseDesc;
	}
	public void setUnUseDesc(String unUseDesc) {
		this.unUseDesc = unUseDesc;
	}
	public String getAssetId() {
		return assetId;
	}
	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}
	public String getPcOrgId() {
		return pcOrgId;
	}
	public void setPcOrgId(String pcOrgId) {
		this.pcOrgId = pcOrgId;
	}
	public String getReasonState() {
		return reasonState;
	}
	public void setReasonState(String reasonState) {
		this.reasonState = reasonState;
	}
	public String getReasonChange() {
		return reasonChange;
	}
	public void setReasonChange(String reasonChange) {
		this.reasonChange = reasonChange;
	}
	
}
