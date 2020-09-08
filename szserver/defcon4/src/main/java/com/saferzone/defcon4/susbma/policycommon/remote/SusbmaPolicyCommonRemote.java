package com.saferzone.defcon4.susbma.policycommon.remote;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Component;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractRemote;
import com.saferzone.defcon4.base.util.ServerConfig;
import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;
import com.saferzone.defcon4.susbma.policycommon.service.SusbmaPolicyCommonService;

@Component("SusbmaPolicyCommonRemote")
@RemotingDestination
public class SusbmaPolicyCommonRemote extends Defcon4AbstractRemote {
	@Autowired
	private SusbmaPolicyCommonService service;
	
	@Autowired
	protected ServerConfig config;
	/** 서버IP */
	protected String serverIp;
	/** 서버PORT */
	protected int serverPort;
	/** remote controll 주소*/
	protected String remoteAddress;
	/**
	 * 환경변수세팅
	 * @throws Exception
	 */
	protected void setConfig() throws Exception{
		serverIp = config.getConfig("COMMAND_SERVER_IP", "127.0.0.1");
		serverPort = Integer.parseInt(config.getConfig("COMMAND_SERVER_PORT", "31010"));
		remoteAddress = config.getConfig("REMOTECONTROL_RELAYSERVER","127.0.0.1:31002");
		
		service.setServerIp(serverIp);
		service.setServerPort(serverPort);
	}
	
	public Map<String, Object> selectSusbmaPolicyCommon() throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("POLICY", service.selectSusbmaPolicyCommon());
		returnMap.put("POPUP", service.selectPopupList(accountId));
		returnMap.put("ADMIN", service.selectSecureAdminInfo());
		
		return returnMap;
	}
	
	public void updateSusbmaPolicyCommon(Map<String, Object> map) throws Exception{
		setConfig();
		
		SusbmaPolicyCommonMasterVO policyVO = (SusbmaPolicyCommonMasterVO) map.get("POLICY");
		SusbmaPolicyCommonMasterVO adminVO = (SusbmaPolicyCommonMasterVO) map.get("ADMIN");
		Map<String, Object> pwdMap1 = (Map<String, Object>) map.get("PWD1");
		Map<String, Object> pwdMap2 = (Map<String, Object>) map.get("PWD2");
		
		String accountId = flexSessionUtils.getAccountId();
		policyVO.setAccountId(accountId);
		
		service.updateSusbmaPolicyCommon(policyVO);
		service.updatePopupList(map);
		service.updateSecureAdminInfo(adminVO);
		service.updateSusbmaInitPassword(pwdMap1);
		service.updateSusbmaInitPassword(pwdMap2);
		
	}

}
