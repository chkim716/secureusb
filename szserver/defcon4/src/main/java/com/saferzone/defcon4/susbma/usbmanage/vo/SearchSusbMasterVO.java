/**
 * 세이퍼존 DEFCON4 프로젝트
 * 
 * Copyright (c) 2011-2012 by saferzone, Inc.
 * All rights reserved.
 *
 * Description	 
 * 작성자		: chang
 * 최초생성일	: Nov 22, 2012 2:50:11 PM
 * Version		: 1.0
 * 
 * [수정사항반영 작성방식]
 * 예 : Revision 1.1  Nov 22, 2012 2:50:11 PM chang 신규작성
 *
 * [수정사항반영]
 *
 */
package com.saferzone.defcon4.susbma.usbmanage.vo;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractVO;

/**
 *
 * 보조기억매체 검색VO
 *
 * @author worker
 * @since 2011. 6. 13.
 * @version 1.0
 */
public class SearchSusbMasterVO extends Defcon4AbstractVO {
	/** 부서ID */
	private String orgId;
	/** 탑카운트 */
	private Integer topCount;
	/** 정렬컬럼 */
	private String sortColumn;
	/** 정렬 */
	private String sortOrder;
	/** 로그인ID */
	private String accountId;
	/** 로케일코드 */
	private Integer localeCode;
	/** 등급목록 */
	private String classList;
	/** 그룹타입 */
	private Integer groupType;
	/** 등록일(시작) */
	private String startDate;
	/** 등록일(종료) */
	private String endDate;
	/** 최근접속일(시작) */
	private String startLastConnectDate;
	/** 최근접속일(종료) */
	private String endLastConnectDate;
	/** 시리얼번호 */
	private String sno;
	/** 관리번호 */
	private String managementId;
	/** 사원명 */
	private String empName;
	/** 관리책임자명 */
	private String mngEmpName;
	/** 매체ID */
	private Integer mediaId;
	/** 상태ID */
	private Integer stateId;
	/** 사용자부서명 */
	private String userOrgName;
	
	/** 퇴사자 상태 */
	private Integer retireState;
	
	private Integer startIdx;
	
	private Integer isExportExcel;

	private String startDateStr;
	
	private String endDateStr;

	private Integer deptNameType;
	
	/** iso 버전 */
	private String isoVersion;
	
	/** 사용 상태 */
	private Integer requestState;
	
	public Integer getDeptNameType() {
		return deptNameType;
	}
	public void setDeptNameType(Integer deptNameType) {
		this.deptNameType = deptNameType;
	}
	public String getStartDateStr() {
		return startDateStr;
	}
	public void setStartDateStr(String startDateStr) {
		this.startDateStr = startDateStr;
	}
	public String getEndDateStr() {
		return endDateStr;
	}
	public void setEndDateStr(String endDateStr) {
		this.endDateStr = endDateStr;
	}
	public Integer getIsExportExcel() {
		return isExportExcel;
	}
	public void setIsExportExcel(Integer isExportExcel) {
		this.isExportExcel = isExportExcel;
	}
	public Integer getRetireState() {
		return retireState;
	}
	public void setRetireState(Integer retireState) {
		this.retireState = retireState;
	}
	/**
	 * @return the orgId
	 */
	public String getOrgId() {
		return orgId;
	}
	/**
	 * @param orgId the orgId to set
	 */
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	/**
	 * @return the topCount
	 */
	public Integer getTopCount() {
		return topCount;
	}
	/**
	 * @param topCount the topCount to set
	 */
	public void setTopCount(Integer topCount) {
		this.topCount = topCount;
	}
	/**
	 * @return the sortColumn
	 */
	public String getSortColumn() {
		return sortColumn;
	}
	/**
	 * @param sortColumn the sortColumn to set
	 */
	public void setSortColumn(String sortColumn) {
		this.sortColumn = sortColumn;
	}
	/**
	 * @return the sortOrder
	 */
	public String getSortOrder() {
		return sortOrder;
	}
	/**
	 * @param sortOrder the sortOrder to set
	 */
	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}
	/**
	 * @return the accountId
	 */
	public String getAccountId() {
		return accountId;
	}
	/**
	 * @param accountId the accountId to set
	 */
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	/**
	 * @return the localeCode
	 */
	public Integer getLocaleCode() {
		return localeCode;
	}
	/**
	 * @param localeCode the localeCode to set
	 */
	public void setLocaleCode(Integer localeCode) {
		this.localeCode = localeCode;
	}
	/**
	 * @return the classList
	 */
	public String getClassList() {
		return classList;
	}
	/**
	 * @param classList the classList to set
	 */
	public void setClassList(String classList) {
		this.classList = classList;
	}
	/**
	 * @return the groupType
	 */
	public Integer getGroupType() {
		return groupType;
	}
	/**
	 * @param groupType the groupType to set
	 */
	public void setGroupType(Integer groupType) {
		this.groupType = groupType;
	}
	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	/**
	 * @return the startLastConnectDate
	 */
	public String getStartLastConnectDate() {
		return startLastConnectDate;
	}
	/**
	 * @param startLastConnectDate the startLastConnectDate to set
	 */
	public void setStartLastConnectDate(String startLastConnectDate) {
		this.startLastConnectDate = startLastConnectDate;
	}
	/**
	 * @return the endLastConnectDate
	 */
	public String getEndLastConnectDate() {
		return endLastConnectDate;
	}
	/**
	 * @param endLastConnectDate the endLastConnectDate to set
	 */
	public void setEndLastConnectDate(String endLastConnectDate) {
		this.endLastConnectDate = endLastConnectDate;
	}
	/**
	 * @return the sno
	 */
	public String getSno() {
		return sno;
	}
	/**
	 * @param sno the sno to set
	 */
	public void setSno(String sno) {
		this.sno = sno;
	}
	/**
	 * @return the managementId
	 */
	public String getManagementId() {
		return managementId;
	}
	/**
	 * @param managementId the managementId to set
	 */
	public void setManagementId(String managementId) {
		this.managementId = managementId;
	}
	/**
	 * @return the empName
	 */
	public String getEmpName() {
		return empName;
	}
	/**
	 * @param empName the empName to set
	 */
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	/**
	 * @return the mngEmpName
	 */
	public String getMngEmpName() {
		return mngEmpName;
	}
	/**
	 * @param mngEmpName the mngEmpName to set
	 */
	public void setMngEmpName(String mngEmpName) {
		this.mngEmpName = mngEmpName;
	}
	/**
	 * @return the mediaId
	 */
	public Integer getMediaId() {
		return mediaId;
	}
	/**
	 * @param mediaId the mediaId to set
	 */
	public void setMediaId(Integer mediaId) {
		this.mediaId = mediaId;
	}
	/**
	 * @return the stateId
	 */
	public Integer getStateId() {
		return stateId;
	}
	/**
	 * @param stateId the stateId to set
	 */
	public void setStateId(Integer stateId) {
		this.stateId = stateId;
	}
	/**
	 * @return the userOrgName
	 */
	public String getUserOrgName() {
		return userOrgName;
	}
	/**
	 * @param userOrgName the userOrgName to set
	 */
	public void setUserOrgName(String userOrgName) {
		this.userOrgName = userOrgName;
	}
	
	public Integer getStartIdx() {
		return startIdx;
	}
	public void setStartIdx(Integer startIdx) {
		this.startIdx = startIdx;
	}
	public String getIsoVersion() {
		return isoVersion;
	}
	public void setIsoVersion(String isoVersion) {
		this.isoVersion = isoVersion;
	}
	public Integer getRequestState() {
		return requestState;
	}
	public void setRequestState(Integer requestState) {
		this.requestState = requestState;
	}
	
}
