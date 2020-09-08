package com.saferzone.defcon4.susbma.policy.dao;

import java.util.List;

import com.saferzone.defcon4.common.cmdclient.CmdClientTargetVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaCommonPolicyMasterVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyGroupUsbVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyMasterVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyRawVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbmaClassVO;

public interface ISusbmaPolicyDAO {
	
	public List<CmdClientTargetVO> selectPolicyTargetList(Integer policyId) throws Exception;

	public List<SusbmaPolicyMasterVO> selectSusbmaPolicyMasterList(Integer rangeType, Integer localeCode, String accountId) throws Exception;
	
	public SusbmaPolicyRawVO selectSusbmaPolicyRaw(Integer usbPolicyId) throws Exception;
	
	public void insertSusbmaPolicyRaw(Integer usbPolicyId) throws Exception;
	
	public void updateSusbmaPolicyRaw(SusbmaPolicyRawVO vo) throws Exception;
	
	public void deleteSusbmaPolicyRaw(Integer policyId) throws Exception;
	
	public void updateSusbmaPolicyClass(SusbmaClassVO vo) throws Exception;

	public void insertSusbmaPolicyOrg(SusbmaPolicyMasterVO vo) throws Exception;
	
	public void deleteSusbmaPolicyOrg(Integer usbPolicyId) throws Exception;
	
	public void updateSusbmaPolicyOrg(SusbmaPolicyMasterVO vo) throws Exception;

	public void insertSusbmaPolicyGrp(SusbmaPolicyMasterVO vo) throws Exception;

	public void deleteSusbmaPolicyGrp(Integer grpId) throws Exception;

	public void updateSusbmaPolicyGrp(SusbmaPolicyMasterVO vo) throws Exception;

	public List<SusbmaPolicyGroupUsbVO> selectSusbmaPolicyGrpUsbList(Integer grpId) throws Exception;

	public void insertSusbmaPolicyGrpUsb(SusbmaPolicyGroupUsbVO vo) throws Exception;

	public void deleteSusbmaPolicyGrpUsb(String sno) throws Exception;

	public void updateSusbmaPolicyGrpUsb(SusbmaPolicyGroupUsbVO vo) throws Exception;

	public SusbmaCommonPolicyMasterVO selectSusbmaCommonPolicy() throws Exception;

	public void updateSusbmaCommonPolicy(SusbmaCommonPolicyMasterVO vo) throws Exception;

	public void updateSusbmaInitPassword(String initPassword) throws Exception;

	public List<SusbmaCommonPolicyMasterVO> selectPopupList(String accountId) throws Exception;

	public void updatePopupSelected(SusbmaCommonPolicyMasterVO popupData) throws Exception;

	public SusbmaCommonPolicyMasterVO selectSecureAdminInfo() throws Exception;

	public void updateSecureAdminInfo(SusbmaCommonPolicyMasterVO vo) throws Exception;
}
