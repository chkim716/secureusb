package com.saferzone.defcon4.susbma.policycommon.dao;

import java.util.List;

import com.saferzone.defcon4.common.cmdclient.CmdClientTargetVO;
import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;

public interface ISusbmaPolicyCommonDAO {
	
	public List<CmdClientTargetVO> selectPolicyTargetList(Integer policyId) throws Exception;

	public SusbmaPolicyCommonMasterVO selectSusbmaPolicyCommon() throws Exception;

	public List<SusbmaPolicyCommonMasterVO> selectPopupList(String accountId) throws Exception;

	public SusbmaPolicyCommonMasterVO selectSecureAdminInfo() throws Exception;
	
	public void updateSusbmaPolicyCommon(SusbmaPolicyCommonMasterVO vo) throws Exception;

	public void updatePopupSelected(SusbmaPolicyCommonMasterVO popupData) throws Exception;

	public void updateSecureAdminInfo(SusbmaPolicyCommonMasterVO vo) throws Exception;
	
	public void updateSusbmaInitPassword(String initPassword, int popupType) throws Exception;

}
