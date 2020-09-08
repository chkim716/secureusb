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
public class SusbUseHistoryNicVO extends Defcon4AbstractVO {
	/** 사용이력 랜카드ID */
	private Integer useHistoryNicId;
	/** 사용이력 ID */
	private Integer useHistoryId;
	/** IP */
	private Double ip;
	/** 서브넷마스크 */
	private Double subnetMask;
	/** 게이트웨이 */
	private Double gateway;
	/** 맥주소 */
	private String macAddress;
	/** 모델 */
	private String model;
	
	/**
	 * @return the useHistoryNicId
	 */
	public Integer getUseHistoryNicId() {
		return useHistoryNicId;
	}
	/**
	 * @param useHistoryNicId the useHistoryNicId to set
	 */
	public void setUseHistoryNicId(Integer useHistoryNicId) {
		this.useHistoryNicId = useHistoryNicId;
	}
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
	 * @return the ip
	 */
	public Double getIp() {
		return ip;
	}
	/**
	 * @param ip the ip to set
	 */
	public void setIp(Double ip) {
		this.ip = ip;
	}
	/**
	 * @return the subnetMask
	 */
	public Double getSubnetMask() {
		return subnetMask;
	}
	/**
	 * @param subnetMask the subnetMask to set
	 */
	public void setSubnetMask(Double subnetMask) {
		this.subnetMask = subnetMask;
	}
	/**
	 * @return the gateway
	 */
	public Double getGateway() {
		return gateway;
	}
	/**
	 * @param gateway the gateway to set
	 */
	public void setGateway(Double gateway) {
		this.gateway = gateway;
	}
	/**
	 * @return the macAddress
	 */
	public String getMacAddress() {
		return macAddress;
	}
	/**
	 * @param macAddress the macAddress to set
	 */
	public void setMacAddress(String macAddress) {
		this.macAddress = macAddress;
	}
	/**
	 * @return the model
	 */
	public String getModel() {
		return model;
	}
	/**
	 * @param model the model to set
	 */
	public void setModel(String model) {
		this.model = model;
	}
}
