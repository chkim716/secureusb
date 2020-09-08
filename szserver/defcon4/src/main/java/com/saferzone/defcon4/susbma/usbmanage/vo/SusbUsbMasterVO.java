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
public class SusbUsbMasterVO extends Defcon4AbstractVO {
	/** USB 시리얼 번호 */
	private String sno;
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
	/**전체 용량(GB) */
	private String capacity;
	/**데이터 용량(BB) */
	private Integer dataCapacity;
	/** 비밀번호 */
	private String password;
	/** 생성자 */
	private String creator;
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
	/** 반출승인상태 */
	private Integer outGoApprovedState;
	/** 마지막 접속일 */
	private String latestConnectDate;
	/** 마지막 사용 에이전트_ID */
	private String assetId;
	/** 마지막 사용 에이전트_사용자 사번 */
	private String pcEmpId;
	/** 마지막 사용 에이전트_사용자 이름 */
	private String pcEmpName;
	/** 마지막 사용 에이전트_부서코드 */
	private String pcOrgId;
	/** 마지막 사용 에이전트_부서명 */
	private String pcOrgName;
	/** 검색된개수 */
	private Integer resultCount;
	/** iso 버전 */
	private String isoVersion;
	/** iso 업데이트 시간*/
	private String updateDate;
	/** iso 업데이트 대상*/
	private String updateTarget;
	
	private String className;
	private String userEmpName;
	private String mngEmpName;
	private String mediaName;
	private String stateName;
	private String accountId;
	private String regdate;
	private String userOrgId;
	private String userOrgName;
	/** 부서용 */
	private Integer isDeptType;
	
	private String permStartDate;
	
	private String permEndDate;
	
	private int isTimeCheck;
	
	private int requestState;
	
	private String requestStateLabel;
	
	private String policyDenyName;
	
	private String reason;
	
	private String userFullOrgName;
	
	private String pcFullOrgName;

	private int secureUsbType;
	private String secureUsbTypeLabel;
	private int mediaType;
	private int groupType;
	
	private String isDeptTypeLabel;
	
	private String strClassId;
	
	private String strIsTimeCheck;

	private String returnMsg;
	
	private int returnCode;
	private String orgNameList;
	private int includeSubDept;
	private String orgName;
	private String orgId;
	
	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public int getIncludeSubDept() {
		return includeSubDept;
	}

	public void setIncludeSubDept(int includeSubDept) {
		this.includeSubDept = includeSubDept;
	}

	public String getOrgNameList() {
		return orgNameList;
	}

	public void setOrgNameList(String orgNameList) {
		this.orgNameList = orgNameList;
	}

	public String getSno() {
		return sno;
	}

	public void setSno(String sno) {
		this.sno = sno;
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

	public String getCapacity() {
		return capacity;
	}

	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}

	public Integer getDataCapacity() {
		return dataCapacity;
	}

	public void setDataCapacity(Integer dataCapacity) {
		this.dataCapacity = dataCapacity;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
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

	public Integer getOutGoApprovedState() {
		return outGoApprovedState;
	}

	public void setOutGoApprovedState(Integer outGoApprovedState) {
		this.outGoApprovedState = outGoApprovedState;
	}

	public String getLatestConnectDate() {
		return latestConnectDate;
	}

	public void setLatestConnectDate(String latestConnectDate) {
		this.latestConnectDate = latestConnectDate;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public String getPcEmpId() {
		return pcEmpId;
	}

	public void setPcEmpId(String pcEmpId) {
		this.pcEmpId = pcEmpId;
	}

	public String getPcEmpName() {
		return pcEmpName;
	}

	public void setPcEmpName(String pcEmpName) {
		this.pcEmpName = pcEmpName;
	}

	public String getPcOrgId() {
		return pcOrgId;
	}

	public void setPcOrgId(String pcOrgId) {
		this.pcOrgId = pcOrgId;
	}

	public String getPcOrgName() {
		return pcOrgName;
	}

	public void setPcOrgName(String pcOrgName) {
		this.pcOrgName = pcOrgName;
	}

	public Integer getResultCount() {
		return resultCount;
	}

	public void setResultCount(Integer resultCount) {
		this.resultCount = resultCount;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
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

	public String getMediaName() {
		return mediaName;
	}

	public void setMediaName(String mediaName) {
		this.mediaName = mediaName;
	}

	public String getStateName() {
		return stateName;
	}

	public void setStateName(String stateName) {
		this.stateName = stateName;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getUserOrgId() {
		return userOrgId;
	}

	public void setUserOrgId(String userOrgId) {
		this.userOrgId = userOrgId;
	}

	public String getUserOrgName() {
		return userOrgName;
	}

	public void setUserOrgName(String userOrgName) {
		this.userOrgName = userOrgName;
	}

	public Integer getIsDeptType() {
		return isDeptType;
	}

	public void setIsDeptType(Integer isDeptType) {
		this.isDeptType = isDeptType;
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

	public int getRequestState() {
		return requestState;
	}

	public void setRequestState(int requestState) {
		this.requestState = requestState;
	}

	public String getRequestStateLabel() {
		return requestStateLabel;
	}

	public void setRequestStateLabel(String requestStateLabel) {
		this.requestStateLabel = requestStateLabel;
	}

	public String getPolicyDenyName() {
		return policyDenyName;
	}

	public void setPolicyDenyName(String policyDenyName) {
		this.policyDenyName = policyDenyName;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getUserFullOrgName() {
		return userFullOrgName;
	}

	public void setUserFullOrgName(String userFullOrgName) {
		this.userFullOrgName = userFullOrgName;
	}

	public String getPcFullOrgName() {
		return pcFullOrgName;
	}

	public void setPcFullOrgName(String pcFullOrgName) {
		this.pcFullOrgName = pcFullOrgName;
	}

	public int getSecureUsbType() {
		return secureUsbType;
	}

	public void setSecureUsbType(int secureUsbType) {
		this.secureUsbType = secureUsbType;
	}

	public String getSecureUsbTypeLabel() {
		return secureUsbTypeLabel;
	}

	public void setSecureUsbTypeLabel(String secureUsbTypeLabel) {
		this.secureUsbTypeLabel = secureUsbTypeLabel;
	}

	public int getMediaType() {
		return mediaType;
	}

	public void setMediaType(int mediaType) {
		this.mediaType = mediaType;
	}

	public int getGroupType() {
		return groupType;
	}

	public void setGroupType(int groupType) {
		this.groupType = groupType;
	}

	public String getIsDeptTypeLabel() {
		return isDeptTypeLabel;
	}

	public void setIsDeptTypeLabel(String isDeptTypeLabel) {
		this.isDeptTypeLabel = isDeptTypeLabel;
	}

	public String getStrClassId() {
		return strClassId;
	}

	public void setStrClassId(String strClassId) {
		this.strClassId = strClassId;
	}

	public String getStrIsTimeCheck() {
		return strIsTimeCheck;
	}

	public void setStrIsTimeCheck(String strIsTimeCheck) {
		this.strIsTimeCheck = strIsTimeCheck;
	}

	public String getReturnMsg() {
		return returnMsg;
	}

	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}

	public int getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(int returnCode) {
		this.returnCode = returnCode;
	}

	public String getIsoVersion() {
		return isoVersion;
	}

	public void setIsoVersion(String isoVersion) {
		this.isoVersion = isoVersion;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getUpdateTarget() {
		return updateTarget;
	}

	public void setUpdateTarget(String updateTarget) {
		this.updateTarget = updateTarget;
	}
	
		
}
