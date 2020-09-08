package com.saferzone.defcon4.susbma.policycommon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saferzone.defcon4.common.cmdclient.CmdClient;
import com.saferzone.defcon4.common.cmdclient.CmdClientTargetVO;
import com.saferzone.defcon4.susbma.policycommon.dao.ISusbmaPolicyCommonDAO;
import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;

@Service("SusbmaPolicyCommonService")
public class SusbmaPolicyCommonService {

	private String serverIp;
	private int serverPort;
	
	/**
	 * @return the serverIp
	 */
	public String getServerIp() {
		return serverIp;
	}

	/**
	 * @param serverIp the serverIp to set
	 */
	public void setServerIp(String serverIp) {
		this.serverIp = serverIp;
	}

	/**
	 * @return the serverPort
	 */
	public int getServerPort() {
		return serverPort;
	}

	/**
	 * @param serverPort the serverPort to set
	 */
	public void setServerPort(int serverPort) {
		this.serverPort = serverPort;
	}
	
	@Autowired
	private ISusbmaPolicyCommonDAO dao;
	
	public void sendPolicyChangeCommand(Integer policyId) throws Exception {
		List<CmdClientTargetVO> targets = (List<CmdClientTargetVO>)dao.selectPolicyTargetList(policyId);
		CmdClient.sendCommand(targets, "BROADCAST", CmdClient.COMMAND_POLICYCHANGE_ALL, serverIp, serverPort);
	}
	
	public SusbmaPolicyCommonMasterVO selectSusbmaPolicyCommon() throws Exception{
		return dao.selectSusbmaPolicyCommon();
	}
	
	public List<SusbmaPolicyCommonMasterVO> selectPopupList(String accountId) throws Exception{
		return dao.selectPopupList(accountId);
	}

	public SusbmaPolicyCommonMasterVO selectSecureAdminInfo() throws Exception{
		return dao.selectSecureAdminInfo();
	}
	
	public void updateSusbmaPolicyCommon(SusbmaPolicyCommonMasterVO vo) throws Exception{
		dao.updateSusbmaPolicyCommon(vo);
		sendPolicyChangeCommand(0);
	}
	
	public void updatePopupList(Map<String, Object> popupMap) throws Exception{
		List<SusbmaPolicyCommonMasterVO> popupList = (List<SusbmaPolicyCommonMasterVO>) popupMap.get("POPUP");
		
		SusbmaPolicyCommonMasterVO popupData;
		if(popupList != null)
		{
			for(int i=0;i<popupList.size();i++)
			{
				popupData = popupList.get(i);
				dao.updatePopupSelected(popupData);
			}
		}
	}
	
	public void updateSecureAdminInfo(SusbmaPolicyCommonMasterVO vo) throws Exception {
		dao.updateSecureAdminInfo(vo);
	}

	public void updateSusbmaInitPassword(Map<String, Object> pwdMap) throws Exception{
		String initPassword = (String) pwdMap.get("initPassword");
		int popupType = (Integer) pwdMap.get("popupType");
		
		dao.updateSusbmaInitPassword(initPassword, popupType);
	}

}
