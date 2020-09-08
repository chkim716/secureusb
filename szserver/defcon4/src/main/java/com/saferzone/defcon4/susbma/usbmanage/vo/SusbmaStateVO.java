package com.saferzone.defcon4.susbma.usbmanage.vo;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractVO;

public class SusbmaStateVO extends Defcon4AbstractVO {
	private Integer stateId;
	private String stateName;
	public Integer getStateId() {
		return stateId;
	}
	public void setStateId(Integer stateId) {
		this.stateId = stateId;
	}
	public String getStateName() {
		return stateName;
	}
	public void setStateName(String stateName) {
		this.stateName = stateName;
	}
}
