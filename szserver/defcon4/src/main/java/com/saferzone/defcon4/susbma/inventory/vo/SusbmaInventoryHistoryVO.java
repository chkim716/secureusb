/**
 * 세이퍼존 DEFCON4 프로젝트
 * 
 * Copyright (c) 2011-2012 by saferzone, Inc.
 * All rights reserved.
 *
 * Description	 
 * 작성자		: lmj
 * 최초생성일	: Apr 29, 2014 03:15:00 PM
 * Version		: 1.0
 * 
 * [수정사항반영 작성방식]
 * 예 : Revision 1.1  Apr 29, 2014 03:15:00 PM lmj 신규작성
 *
 * [수정사항반영]
 *
 */
package com.saferzone.defcon4.susbma.inventory.vo;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractVO;

/**
*
* USB재고이력 VO
*
* @author lmj
* @since 2014. 04. 29.
* @version 1.0
*/
public class SusbmaInventoryHistoryVO extends Defcon4AbstractVO {

	/** 이력ID */
	private int historyId;
	
	/** USB번호 */
	private String inventorySno;
	
	/** 등록일 */
	private String regDate;
	
	/** 사용자ID */
	private String userEmpId;
	
	/** 사용자명 */
	private String userEmpName;
	
	/** 부서ID */
	private String userOrgId;
	
	/** 부서명 */
	private String userOrgName;
	
	/** 이전상태 */
	private Integer prevState;
	
	/** 다음상태 */
	private Integer nextState;
	
	/** 용량 */
	private Integer capacity;
	
	/** 사유 */
	private String historyReason;
	
	/** 원본시리얼번호 */
	private String sno;

	/** 시작 등록일 */
	private String startRegDate;
	
	/** 종료 등록일 */
	private String endRegDate;
	
	/** 시작 USB번호 */
	private String startInventorySno;
	
	/** 종료 USB번호 */
	private String endInventorySno;
	
	/** 시작 인덱스 */
	private int startIdx;
	
	/** 인덱스 개수 */
	private int topCount;
	
	/** state */
	private int state;
	
	/** 검색결과 개수 */
	private int resultCount;
	
	/** 관리번호 */
	private String managementId;
	
	private int secureUsbType;
	
	private String secureUsbTypeLabel;
	
	private String fullOrgName;
	
	private String accountId;
	
	private int groupType;
	
	private String startCharacter;

	/**
	 * @return the historyId
	 */
	public int getHistoryId() {
		return historyId;
	}

	/**
	 * @param historyId the historyId to set
	 */
	public void setHistoryId(int historyId) {
		this.historyId = historyId;
	}

	/**
	 * @return the inventorySno
	 */
	public String getInventorySno() {
		return inventorySno;
	}

	/**
	 * @param inventorySno the inventorySno to set
	 */
	public void setInventorySno(String inventorySno) {
		this.inventorySno = inventorySno;
	}

	/**
	 * @return the regDate
	 */
	public String getRegDate() {
		return regDate;
	}

	/**
	 * @param regDate the regDate to set
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	/**
	 * @return the userEmpId
	 */
	public String getUserEmpId() {
		return userEmpId;
	}

	/**
	 * @param userEmpId the userEmpId to set
	 */
	public void setUserEmpId(String userEmpId) {
		this.userEmpId = userEmpId;
	}

	/**
	 * @return the userEmpName
	 */
	public String getUserEmpName() {
		return userEmpName;
	}

	/**
	 * @param userEmpName the userEmpName to set
	 */
	public void setUserEmpName(String userEmpName) {
		this.userEmpName = userEmpName;
	}

	/**
	 * @return the userOrgId
	 */
	public String getUserOrgId() {
		return userOrgId;
	}

	/**
	 * @param userOrgId the userOrgId to set
	 */
	public void setUserOrgId(String userOrgId) {
		this.userOrgId = userOrgId;
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

	/**
	 * @return the prevState
	 */
	public Integer getPrevState() {
		return prevState;
	}

	/**
	 * @param prevState the prevState to set
	 */
	public void setPrevState(Integer prevState) {
		this.prevState = prevState;
	}

	/**
	 * @return the nextState
	 */
	public Integer getNextState() {
		return nextState;
	}

	/**
	 * @param nextState the nextState to set
	 */
	public void setNextState(Integer nextState) {
		this.nextState = nextState;
	}

	/**
	 * @return the capacity
	 */
	public Integer getCapacity() {
		return capacity;
	}

	/**
	 * @param capacity the capacity to set
	 */
	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}

	/**
	 * @return the historyReason
	 */
	public String getHistoryReason() {
		return historyReason;
	}

	/**
	 * @param historyReason the historyReason to set
	 */
	public void setHistoryReason(String historyReason) {
		this.historyReason = historyReason;
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
	 * @return the startRegDate
	 */
	public String getStartRegDate() {
		return startRegDate;
	}

	/**
	 * @param startRegDate the startRegDate to set
	 */
	public void setStartRegDate(String startRegDate) {
		this.startRegDate = startRegDate;
	}

	/**
	 * @return the endRegDate
	 */
	public String getEndRegDate() {
		return endRegDate;
	}

	/**
	 * @param endRegDate the endRegDate to set
	 */
	public void setEndRegDate(String endRegDate) {
		this.endRegDate = endRegDate;
	}

	/**
	 * @return the startInventorySno
	 */
	public String getStartInventorySno() {
		return startInventorySno;
	}

	/**
	 * @param startInventorySno the startInventorySno to set
	 */
	public void setStartInventorySno(String startInventorySno) {
		this.startInventorySno = startInventorySno;
	}

	/**
	 * @return the endInventorySno
	 */
	public String getEndInventorySno() {
		return endInventorySno;
	}

	/**
	 * @param endInventorySno the endInventorySno to set
	 */
	public void setEndInventorySno(String endInventorySno) {
		this.endInventorySno = endInventorySno;
	}

	/**
	 * @return the startIdx
	 */
	public int getStartIdx() {
		return startIdx;
	}

	/**
	 * @param startIdx the startIdx to set
	 */
	public void setStartIdx(int startIdx) {
		this.startIdx = startIdx;
	}

	/**
	 * @return the topCount
	 */
	public int getTopCount() {
		return topCount;
	}

	/**
	 * @param topCount the topCount to set
	 */
	public void setTopCount(int topCount) {
		this.topCount = topCount;
	}

	/**
	 * @return the state
	 */
	public int getState() {
		return state;
	}

	/**
	 * @param state the state to set
	 */
	public void setState(int state) {
		this.state = state;
	}

	/**
	 * @return the resultCount
	 */
	public int getResultCount() {
		return resultCount;
	}

	/**
	 * @param resultCount the resultCount to set
	 */
	public void setResultCount(int resultCount) {
		this.resultCount = resultCount;
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
	 * @return the secureUsbType
	 */
	public int getSecureUsbType() {
		return secureUsbType;
	}

	/**
	 * @param secureUsbType the secureUsbType to set
	 */
	public void setSecureUsbType(int secureUsbType) {
		this.secureUsbType = secureUsbType;
	}

	/**
	 * @return the secureUsbTypeLabel
	 */
	public String getSecureUsbTypeLabel() {
		return secureUsbTypeLabel;
	}

	/**
	 * @param secureUsbTypeLabel the secureUsbTypeLabel to set
	 */
	public void setSecureUsbTypeLabel(String secureUsbTypeLabel) {
		this.secureUsbTypeLabel = secureUsbTypeLabel;
	}

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

	public int getGroupType() {
		return groupType;
	}

	public void setGroupType(int groupType) {
		this.groupType = groupType;
	}

	public String getStartCharacter() {
		return startCharacter;
	}

	public void setStartCharacter(String startCharacter) {
		this.startCharacter = startCharacter;
	}
	
	
	
}
