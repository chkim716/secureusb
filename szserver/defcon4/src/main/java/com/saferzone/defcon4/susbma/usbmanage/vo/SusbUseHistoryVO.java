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
 * @since 2011. 6. 2.
 * @version 1.0
 */
public class SusbUseHistoryVO extends Defcon4AbstractVO{
	/** 사용이력ID */
	private Integer useHistoryId;
	/** 사내사용여부 */
	private Integer insideOfCompany;
	/** PC제조사 */
	private String manufacturer;
	/** OS */
	private String os;
	/** CPU이름 */
	private String cpuName;
	/** 디스크 모델 */
	private String diskModel;
	/** 컴퓨터 이름 */
	private String netBiosName;
	/** LAN IP */
	private String lanIp;
	/** 사용일자 */
	private String useDate;
	/** 등록일자 */
	private String regDate;
	/** 이력_관리번호 */
	private String hisManagementId;
	/** 이력_부서코드 */
	private String hisOrgId;
	/** 이력_부서명 */
	private String hisOrgName;
	/** 이력_사번 */
	private String hisUserEmpId;
	/** 이력_사원명 */
	private String hisUserEmpName;
	/** 이력_관리책임자사번 */
	private String hisMngEmpId;
	/** 이력_관리책임자명 */
	private String hisMngEmpName;
	/** 이력_등급코드 */
	private Integer hisClassId;
	/** 이력_매체ID */
	private Integer hisMediaId;
	/** 이력_상태ID */
	private Integer hisStateId;
	/** 전송PC_WAN IP */
	private String spcWanIp;
	/** 전송PC_사번 */
	private String spcEmpId;
	/** 전송PC_사원명 */
	private String spcEmpName;
	/** 전송PC_부서코드 */
	private String spcOrgId;
	/** 전송PC_부서명 */
	private String spcOrgName;
	/** 전송PC_부서명 */
	private String sno;
	/** Agent ID */
	private String assetId;
	
	private String spcFullOrgName;
	/**
	 * @return the useHistoryId
	 */
	public Integer getUseHistoryId() {
		return useHistoryId;
	}
	/**
	 * @param useHistoryId the useHistoryId to set
	 */
	public void setUseHistoryId(Integer useHistoryId) {
		this.useHistoryId = useHistoryId;
	}
	/**
	 * @return the insideOfCompany
	 */
	public Integer getInsideOfCompany() {
		return insideOfCompany;
	}
	/**
	 * @param insideOfCompany the insideOfCompany to set
	 */
	public void setInsideOfCompany(Integer insideOfCompany) {
		this.insideOfCompany = insideOfCompany;
	}
	/**
	 * @return the manufacturer
	 */
	public String getManufacturer() {
		return manufacturer;
	}
	/**
	 * @param manufacturer the manufacturer to set
	 */
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	/**
	 * @return the os
	 */
	public String getOs() {
		return os;
	}
	/**
	 * @param os the os to set
	 */
	public void setOs(String os) {
		this.os = os;
	}
	/**
	 * @return the cpuName
	 */
	public String getCpuName() {
		return cpuName;
	}
	/**
	 * @param cpuName the cpuName to set
	 */
	public void setCpuName(String cpuName) {
		this.cpuName = cpuName;
	}
	/**
	 * @return the diskModel
	 */
	public String getDiskModel() {
		return diskModel;
	}
	/**
	 * @param diskModel the diskModel to set
	 */
	public void setDiskModel(String diskModel) {
		this.diskModel = diskModel;
	}
	/**
	 * @return the netBiosName
	 */
	public String getNetBiosName() {
		return netBiosName;
	}
	/**
	 * @param netBiosName the netBiosName to set
	 */
	public void setNetBiosName(String netBiosName) {
		this.netBiosName = netBiosName;
	}
	/**
	 * @return the lanIp
	 */
	public String getLanIp() {
		return lanIp;
	}
	/**
	 * @param lanIp the lanIp to set
	 */
	public void setLanIp(String lanIp) {
		this.lanIp = lanIp;
	}
	/**
	 * @return the useDate
	 */
	public String getUseDate() {
		return useDate;
	}
	/**
	 * @param useDate the useDate to set
	 */
	public void setUseDate(String useDate) {
		this.useDate = useDate;
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
	 * @return the hisManagementId
	 */
	public String getHisManagementId() {
		return hisManagementId;
	}
	/**
	 * @param hisManagementId the hisManagementId to set
	 */
	public void setHisManagementId(String hisManagementId) {
		this.hisManagementId = hisManagementId;
	}
	/**
	 * @return the hisOrgId
	 */
	public String getHisOrgId() {
		return hisOrgId;
	}
	/**
	 * @param hisOrgId the hisOrgId to set
	 */
	public void setHisOrgId(String hisOrgId) {
		this.hisOrgId = hisOrgId;
	}
	/**
	 * @return the hisOrgName
	 */
	public String getHisOrgName() {
		return hisOrgName;
	}
	/**
	 * @param hisOrgName the hisOrgName to set
	 */
	public void setHisOrgName(String hisOrgName) {
		this.hisOrgName = hisOrgName;
	}
	/**
	 * @return the hisUserEmpId
	 */
	public String getHisUserEmpId() {
		return hisUserEmpId;
	}
	/**
	 * @param hisUserEmpId the hisUserEmpId to set
	 */
	public void setHisUserEmpId(String hisUserEmpId) {
		this.hisUserEmpId = hisUserEmpId;
	}
	/**
	 * @return the hisUserEmpName
	 */
	public String getHisUserEmpName() {
		return hisUserEmpName;
	}
	/**
	 * @param hisUserEmpName the hisUserEmpName to set
	 */
	public void setHisUserEmpName(String hisUserEmpName) {
		this.hisUserEmpName = hisUserEmpName;
	}
	/**
	 * @return the hisMngEmpId
	 */
	public String getHisMngEmpId() {
		return hisMngEmpId;
	}
	/**
	 * @param hisMngEmpId the hisMngEmpId to set
	 */
	public void setHisMngEmpId(String hisMngEmpId) {
		this.hisMngEmpId = hisMngEmpId;
	}
	/**
	 * @return the hisMngEmpName
	 */
	public String getHisMngEmpName() {
		return hisMngEmpName;
	}
	/**
	 * @param hisMngEmpName the hisMngEmpName to set
	 */
	public void setHisMngEmpName(String hisMngEmpName) {
		this.hisMngEmpName = hisMngEmpName;
	}
	/**
	 * @return the hisClassId
	 */
	public Integer getHisClassId() {
		return hisClassId;
	}
	/**
	 * @param hisClassId the hisClassId to set
	 */
	public void setHisClassId(Integer hisClassId) {
		this.hisClassId = hisClassId;
	}
	/**
	 * @return the hisMediaId
	 */
	public Integer getHisMediaId() {
		return hisMediaId;
	}
	/**
	 * @param hisMediaId the hisMediaId to set
	 */
	public void setHisMediaId(Integer hisMediaId) {
		this.hisMediaId = hisMediaId;
	}
	/**
	 * @return the hisStateId
	 */
	public Integer getHisStateId() {
		return hisStateId;
	}
	/**
	 * @param hisStateId the hisStateId to set
	 */
	public void setHisStateId(Integer hisStateId) {
		this.hisStateId = hisStateId;
	}
	/**
	 * @return the spcWanIp
	 */
	public String getSpcWanIp() {
		return spcWanIp;
	}
	/**
	 * @param spcWanIp the spcWanIp to set
	 */
	public void setSpcWanIp(String spcWanIp) {
		this.spcWanIp = spcWanIp;
	}
	/**
	 * @return the spcEmpId
	 */
	public String getSpcEmpId() {
		return spcEmpId;
	}
	/**
	 * @param spcEmpId the spcEmpId to set
	 */
	public void setSpcEmpId(String spcEmpId) {
		this.spcEmpId = spcEmpId;
	}
	/**
	 * @return the spcEmpName
	 */
	public String getSpcEmpName() {
		return spcEmpName;
	}
	/**
	 * @param spcEmpName the spcEmpName to set
	 */
	public void setSpcEmpName(String spcEmpName) {
		this.spcEmpName = spcEmpName;
	}
	/**
	 * @return the spcOrgId
	 */
	public String getSpcOrgId() {
		return spcOrgId;
	}
	/**
	 * @param spcOrgId the spcOrgId to set
	 */
	public void setSpcOrgId(String spcOrgId) {
		this.spcOrgId = spcOrgId;
	}
	/**
	 * @return the spcOrgName
	 */
	public String getSpcOrgName() {
		return spcOrgName;
	}
	/**
	 * @param spcOrgName the spcOrgName to set
	 */
	public void setSpcOrgName(String spcOrgName) {
		this.spcOrgName = spcOrgName;
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
	 * @return the assetId
	 */
	public String getAssetId() {
		return assetId;
	}
	/**
	 * @param assetId the assetId to set
	 */
	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}
	public String getSpcFullOrgName() {
		return spcFullOrgName;
	}
	public void setSpcFullOrgName(String spcFullOrgName) {
		this.spcFullOrgName = spcFullOrgName;
	}
	
	
}
