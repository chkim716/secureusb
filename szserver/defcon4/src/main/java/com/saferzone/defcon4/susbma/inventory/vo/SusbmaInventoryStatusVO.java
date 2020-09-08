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
* USB재고현황 VO
*
* @author lmj
* @since 2014. 04. 29.
* @version 1.0
*/
public class SusbmaInventoryStatusVO extends Defcon4AbstractVO {

	/** USB번호 */
	private String inventorySno;
	
	/** 입고날짜 */
	private String stockDate;
	
	/** 발급대상ID */
	private String targetCode;
	
	/** 발급대상명 */
	private String targetName;
	
	/** 전체 용량(GB) */
	private Integer capacity;
	
	/** 데이터 용량(GB) */
	private Integer dataCapacity;
	
	/** 사유 */
	private String inventoryReason;
	
	/** 생성자 */
	private String creator;
	
	/** 수정자 */
	private String updator;
	
	/** 원본시리얼번호 */
	private String sno;
	
	/** 출고날짜 */
	private String releaseDate;
	
	/** 사용여부 */
	private Integer isUsed;
	
	/** 전체삭제(체크박스) */
	private Integer totalDelete;
	
	/** 시작 USB번호 */
	private String startInventorySno;
	
	/** 종료 USB번호 */
	private String endInventorySno;
	
	/** 시작 입고날짜 */
	private String startStockDate;
	
	/** 종료 입고날짜 */
	private String endStockDate;
	
	/** 시작 인덱스 */
	private Integer startIdx;
	
	/** 인덱스 개수 */
	private Integer topCount;
	
	/** state */
	private Integer state;
	
	/** 검색결과 개수 */
	private Integer resultCount;
	
	/** VO 현재 Length */
	private Integer currentLength;
	
	/** VO 총 Length */
	private Integer totalLength;
	
	/** 에러 USB번호 */
	private String errorSno;
	
	/** 반납 상태*/
	private Integer receive;

	/** 관리 번호*/
	private String managementId;
	
	/** 그룹타입 */
	private Integer groupType;
	
	/** 접속계정아이디 */
	private String accountId;
	
	private String  isUsedLabel;
	
	private String  receiveLabel;
	
	private String  lastUser;

	private int secureUsbType;
	
	private String  secureUsbTypeLabel;
	
	private String  fullOrgName;
	
	private int  sfa_office;
	
	private String  sfa_officeName;
	
	private int  sfa_state;
	
	private String   sfa_stateLabel;
	
	private String  sfa_mngCode;

	private String startCharacter;
	
	private String isoVersion;
	
	public String getInventorySno() {
		return inventorySno;
	}

	public void setInventorySno(String inventorySno) {
		this.inventorySno = inventorySno;
	}

	public String getStockDate() {
		return stockDate;
	}

	public void setStockDate(String stockDate) {
		this.stockDate = stockDate;
	}

	public String getTargetCode() {
		return targetCode;
	}

	public void setTargetCode(String targetCode) {
		this.targetCode = targetCode;
	}

	public String getTargetName() {
		return targetName;
	}

	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}

	public Integer getCapacity() {
		return capacity;
	}

	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}

	public Integer getDataCapacity() {
		return dataCapacity;
	}

	public void setDataCapacity(Integer dataCapacity) {
		this.dataCapacity = dataCapacity;
	}

	public String getInventoryReason() {
		return inventoryReason;
	}

	public void setInventoryReason(String inventoryReason) {
		this.inventoryReason = inventoryReason;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getUpdator() {
		return updator;
	}

	public void setUpdator(String updator) {
		this.updator = updator;
	}

	public String getSno() {
		return sno;
	}

	public void setSno(String sno) {
		this.sno = sno;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public Integer getIsUsed() {
		return isUsed;
	}

	public void setIsUsed(Integer isUsed) {
		this.isUsed = isUsed;
	}

	public Integer getTotalDelete() {
		return totalDelete;
	}

	public void setTotalDelete(Integer totalDelete) {
		this.totalDelete = totalDelete;
	}

	public String getStartInventorySno() {
		return startInventorySno;
	}

	public void setStartInventorySno(String startInventorySno) {
		this.startInventorySno = startInventorySno;
	}

	public String getEndInventorySno() {
		return endInventorySno;
	}

	public void setEndInventorySno(String endInventorySno) {
		this.endInventorySno = endInventorySno;
	}

	public String getStartStockDate() {
		return startStockDate;
	}

	public void setStartStockDate(String startStockDate) {
		this.startStockDate = startStockDate;
	}

	public String getEndStockDate() {
		return endStockDate;
	}

	public void setEndStockDate(String endStockDate) {
		this.endStockDate = endStockDate;
	}

	public Integer getStartIdx() {
		return startIdx;
	}

	public void setStartIdx(Integer startIdx) {
		this.startIdx = startIdx;
	}

	public Integer getTopCount() {
		return topCount;
	}

	public void setTopCount(Integer topCount) {
		this.topCount = topCount;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getResultCount() {
		return resultCount;
	}

	public void setResultCount(Integer resultCount) {
		this.resultCount = resultCount;
	}

	public Integer getCurrentLength() {
		return currentLength;
	}

	public void setCurrentLength(Integer currentLength) {
		this.currentLength = currentLength;
	}

	public Integer getTotalLength() {
		return totalLength;
	}

	public void setTotalLength(Integer totalLength) {
		this.totalLength = totalLength;
	}

	public String getErrorSno() {
		return errorSno;
	}

	public void setErrorSno(String errorSno) {
		this.errorSno = errorSno;
	}

	public Integer getReceive() {
		return receive;
	}

	public void setReceive(Integer receive) {
		this.receive = receive;
	}

	public String getManagementId() {
		return managementId;
	}

	public void setManagementId(String managementId) {
		this.managementId = managementId;
	}

	public Integer getGroupType() {
		return groupType;
	}

	public void setGroupType(Integer groupType) {
		this.groupType = groupType;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public String getIsUsedLabel() {
		return isUsedLabel;
	}

	public void setIsUsedLabel(String isUsedLabel) {
		this.isUsedLabel = isUsedLabel;
	}

	public String getReceiveLabel() {
		return receiveLabel;
	}

	public void setReceiveLabel(String receiveLabel) {
		this.receiveLabel = receiveLabel;
	}

	public String getLastUser() {
		return lastUser;
	}

	public void setLastUser(String lastUser) {
		this.lastUser = lastUser;
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

	public String getFullOrgName() {
		return fullOrgName;
	}

	public void setFullOrgName(String fullOrgName) {
		this.fullOrgName = fullOrgName;
	}

	public int getSfa_office() {
		return sfa_office;
	}

	public void setSfa_office(int sfa_office) {
		this.sfa_office = sfa_office;
	}

	public String getSfa_officeName() {
		return sfa_officeName;
	}

	public void setSfa_officeName(String sfa_officeName) {
		this.sfa_officeName = sfa_officeName;
	}

	public int getSfa_state() {
		return sfa_state;
	}

	public void setSfa_state(int sfa_state) {
		this.sfa_state = sfa_state;
	}

	public String getSfa_stateLabel() {
		return sfa_stateLabel;
	}

	public void setSfa_stateLabel(String sfa_stateLabel) {
		this.sfa_stateLabel = sfa_stateLabel;
	}

	public String getSfa_mngCode() {
		return sfa_mngCode;
	}

	public void setSfa_mngCode(String sfa_mngCode) {
		this.sfa_mngCode = sfa_mngCode;
	}

	public String getStartCharacter() {
		return startCharacter;
	}

	public void setStartCharacter(String startCharacter) {
		this.startCharacter = startCharacter;
	}

	public String getIsoVersion() {
		return isoVersion;
	}

	public void setIsoVersion(String isoVersion) {
		this.isoVersion = isoVersion;
	}
	
		
}
