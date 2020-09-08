package com.saferzone.defcon4.susbma.policy.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saferzone.defcon4.common.cmdclient.CmdClient;
import com.saferzone.defcon4.common.cmdclient.CmdClientTargetVO;
import com.saferzone.defcon4.susbma.policy.dao.ISusbmaPolicyDAO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaCommonPolicyMasterVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyGroupUsbVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyMasterVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyRawVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbmaClassVO;

@Service("SusbmaPolicyService")
public class SusbmaPolicyService {
	
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
	private ISusbmaPolicyDAO dao;
	
	public void sendPolicyChangeCommand(Integer policyId, String command) throws Exception {
		List<CmdClientTargetVO> targets = (List<CmdClientTargetVO>)dao.selectPolicyTargetList(policyId);
		CmdClient.sendCommand(targets, "BROADCAST", command, serverIp, serverPort);
		
	}
	
	public List<SusbmaPolicyMasterVO> selectSusbmaPolicyMasterList(Integer rangeType, Integer localeCode, String accountId) throws Exception{
		return dao.selectSusbmaPolicyMasterList(rangeType, localeCode, accountId);
	}
	
	public SusbmaPolicyRawVO selectSusbmaPolicyRaw(Integer usbPolicyId) throws Exception{
		return dao.selectSusbmaPolicyRaw(usbPolicyId);
	}
	
	public void insertSusbmaPolicyRaw(Integer usbPolicyId) throws Exception{
		dao.insertSusbmaPolicyRaw(usbPolicyId);
		sendPolicyChangeCommand(usbPolicyId, CmdClient.COMMAND_POLICYCHANGE_USB);
	}
	
	public void updateSusbmaPolicyRaw(SusbmaPolicyRawVO vo) throws Exception{
		dao.updateSusbmaPolicyRaw(vo);
		sendPolicyChangeCommand(vo.getUsbPolicyId(), CmdClient.COMMAND_POLICYCHANGE_USB);
	}

	public void deleteSusbmaPolicyRaw(SusbmaPolicyRawVO vo) throws Exception{
		sendPolicyChangeCommand(vo.getUsbPolicyId(), CmdClient.COMMAND_POLICYCHANGE_USB);
		dao.deleteSusbmaPolicyRaw(vo.getPolicyId());
	}
	
	
	public void updateSusbmaPolicyClass(SusbmaClassVO vo) throws Exception{
		dao.updateSusbmaPolicyClass(vo);
	}
	
	public void insertSusbmaPolicyOrg(SusbmaPolicyMasterVO vo) throws Exception{
		dao.insertSusbmaPolicyOrg(vo);
	}
	
	public void deleteSusbmaPolicyOrg(Integer usbPolicyId) throws Exception{
		dao.deleteSusbmaPolicyOrg(usbPolicyId);
	}
	
	public void updateSusbmaPolicyOrg(SusbmaPolicyMasterVO vo) throws Exception{
		dao.updateSusbmaPolicyOrg(vo);
	}

	public void insertSusbmaPolicyGrp(SusbmaPolicyMasterVO vo) throws Exception{
		dao.insertSusbmaPolicyGrp(vo);
	}

	public void deleteSusbmaPolicyGrp(Integer grpId) throws Exception{
		dao.deleteSusbmaPolicyGrp(grpId);
	}

	public void updateSusbmaPolicyGrp(SusbmaPolicyMasterVO vo) throws Exception{
		dao.updateSusbmaPolicyGrp(vo);
	}

	public Map<String, Object> selectSusbmaPolicyGrpRaw(Integer grpId, Integer usbPolicyId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("grpRaw", dao.selectSusbmaPolicyRaw(usbPolicyId));
		map.put("grpUsb", dao.selectSusbmaPolicyGrpUsbList(grpId));
		return map;
	}

	public void insertSusbmaPolicyGrpUsb(SusbmaPolicyGroupUsbVO vo) throws Exception{
		dao.insertSusbmaPolicyGrpUsb(vo);
	}

	public void deleteSusbmaPolicyGrpUsb(String sno) throws Exception{
		dao.deleteSusbmaPolicyGrpUsb(sno);
	}

	public void updateSusbmaPolicyGrpUsb(SusbmaPolicyGroupUsbVO vo) throws Exception{
		dao.updateSusbmaPolicyGrpUsb(vo);
	}

	public SusbmaCommonPolicyMasterVO selectSusbmaCommonPolicy() throws Exception{
		return dao.selectSusbmaCommonPolicy();
	}

	public void updateSusbmaCommonPolicy(SusbmaCommonPolicyMasterVO vo) throws Exception{
		dao.updateSusbmaCommonPolicy(vo);
		sendPolicyChangeCommand(0, CmdClient.COMMAND_POLICYCHANGE_ALL);
	}

	public void updateSusbmaInitPassword(String initPassword) throws Exception{
		dao.updateSusbmaInitPassword(initPassword);
	}

	public List<SusbmaCommonPolicyMasterVO> selectPopupList(String accountId) throws Exception{
		return dao.selectPopupList(accountId);
	}

	public void updatePopupList(Map<String, Object> popupMap) throws Exception{
		List<SusbmaCommonPolicyMasterVO> popupList = (List<SusbmaCommonPolicyMasterVO>) popupMap.get("popupList");
		
		SusbmaCommonPolicyMasterVO popupData;
		if(popupList != null)
		{
			for(int i=0;i<popupList.size();i++)
			{
				popupData = popupList.get(i);
				dao.updatePopupSelected(popupData);
			}
		}
		
	}

	public SusbmaCommonPolicyMasterVO selectSecureAdminInfo() throws Exception{
		return dao.selectSecureAdminInfo();
	}

	public void updateSecureAdminInfo(SusbmaCommonPolicyMasterVO vo) throws Exception {
		dao.updateSecureAdminInfo(vo);
		
	}
}
