package com.saferzone.defcon4.susbma.policy.remote;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Component;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractRemote;
import com.saferzone.defcon4.base.util.ServerConfig;
import com.saferzone.defcon4.susbma.policy.service.SusbmaPolicyService;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaCommonPolicyMasterVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyGroupUsbVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyMasterVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyRawVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbmaClassVO;

@Component("SusbmaPolicyRemote")
@RemotingDestination
public class SusbmaPolicyRemote extends Defcon4AbstractRemote {
	@Autowired
	private SusbmaPolicyService service;
	
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
	
	
	/**
	 * rangeType=1 : 등급리스트
	 * rangeType=2 : 부서리스트
	 * rangeType=3 : 그룹리스트
	 * @param rangeType
	 * @return
	 * @throws Exception
	 */
	public List<SusbmaPolicyMasterVO> selectSusbmaPolicyMasterList(Integer rangeType) throws Exception{
		int localeCode = flexSessionUtils.getLocaleCode();
		String accountId = flexSessionUtils.getAccountId();
		return service.selectSusbmaPolicyMasterList(rangeType, localeCode, accountId);
	}

	/**
	 * 마스터정책을 불러온다(등급,부서,그룹)
	 * @param classId
	 * @param rangeType
	 * @return
	 * @throws Exception
	 */
	public SusbmaPolicyRawVO selectSusbmaPolicyRaw(Integer usbPolicyId) throws Exception{
		setConfig();
		return service.selectSusbmaPolicyRaw(usbPolicyId);
	}
	
	/**
	 * 마스터정책을 추가한다(부서,그룹) (추가버튼)
	 * @param vo
	 * @param classId
	 * @param rangeType
	 * @throws Exception
	 */
	public void insertSusbmaPolicyRaw(Integer usbPolicyId) throws Exception{
		setConfig();
		service.insertSusbmaPolicyRaw(usbPolicyId);
	}
	
	/**
	 * 마스터정책을 저장한다(등급,부서,그룹) (저장버튼)
	 * @param vo
	 * @param classId
	 * @param rangeType
	 * @throws Exception
	 */
	public void updateSusbmaPolicyRaw(SusbmaPolicyRawVO vo) throws Exception{
		setConfig();
		service.updateSusbmaPolicyRaw(vo);
	}
	
	/**
	 * 마스터정책을 삭제한다(부서,그룹) (삭제버튼)
	 * @param vo
	 * @param classId
	 * @param rangeType
	 * @throws Exception
	 */
	public void deleteSusbmaPolicyRaw(SusbmaPolicyRawVO vo) throws Exception{
		setConfig();
		service.deleteSusbmaPolicyRaw(vo);
	}
	
	
	/**
	 * 등급명, 사용여부를 업데이트한다
	 * @param vo
	 * @throws Exception
	 */
	public void updateSusbmaPolicyClass(SusbmaClassVO vo) throws Exception{
		service.updateSusbmaPolicyClass(vo);
	}
	
	
	/**
	 * 부서를 추가한다
	 * @param vo
	 * @throws Exception
	 */
	public void insertSusbmaPolicyOrg(SusbmaPolicyMasterVO vo) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);
		service.insertSusbmaPolicyOrg(vo);
	}
	
	/**
	 * 부서를 삭제한다
	 * @param usbPolicyId
	 * @throws Exception
	 */
	public void deleteSusbmaPolicyOrg(Integer usbPolicyId) throws Exception{
		service.deleteSusbmaPolicyOrg(usbPolicyId);
	}
	
	/**
	 * 하위부서포함을 업데이트한다
	 * @param vo
	 * @throws Exception
	 */
	public void updateSusbmaPolicyOrg(SusbmaPolicyMasterVO vo) throws Exception{
		service.updateSusbmaPolicyOrg(vo);
	}
	
	/**
	 * 그룹을 추가한다
	 * @param vo
	 * @throws Exception
	 */
	public void insertSusbmaPolicyGrp(SusbmaPolicyMasterVO vo) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);
		service.insertSusbmaPolicyGrp(vo);
	}
	
	/**
	 * 그룹을 삭제한다
	 * @param grpId
	 * @throws Exception
	 */
	public void deleteSusbmaPolicyGrp(Integer grpId) throws Exception{
		service.deleteSusbmaPolicyGrp(grpId);
	}
	
	/**
	 * 그룹명을 업데이트한다
	 * @param vo
	 * @throws Exception
	 */
	public void updateSusbmaPolicyGrp(SusbmaPolicyMasterVO vo) throws Exception{
		service.updateSusbmaPolicyGrp(vo);
	}
	
	/**
	 * 그룹정책,usb목록을 불러온다
	 * @param grpId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectSusbmaPolicyGrpRaw(Integer grpId, Integer usbPolicyId) throws Exception{
		return service.selectSusbmaPolicyGrpRaw(grpId, usbPolicyId);
	}
	
	/**
	 * usb를 추가한다
	 * @param vo
	 * @throws Exception
	 */
	public void insertSusbmaPolicyGrpUsb(List<SusbmaPolicyGroupUsbVO> vos) throws Exception{
		String accountId = flexSessionUtils.getAccountId();

		for(SusbmaPolicyGroupUsbVO vo : vos){
			vo.setAccountId(accountId);
			service.insertSusbmaPolicyGrpUsb(vo);
		}
	}
	
	/**
	 * usb를 삭제한다
	 * @param sno
	 * @throws Exception
	 */
	public void deleteSusbmaPolicyGrpUsb(String sno) throws Exception{
		service.deleteSusbmaPolicyGrpUsb(sno);
	}
	
	/**
	 * usb를 수정한다
	 * @param sno
	 * @throws Exception
	 */
	public void updateSusbmaPolicyGrpUsb(SusbmaPolicyGroupUsbVO vo) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);
		service.updateSusbmaPolicyGrpUsb(vo);
	}
	
	public SusbmaCommonPolicyMasterVO selectSusbmaCommonPolicy() throws Exception{
		return service.selectSusbmaCommonPolicy();
	}
	
	public void updateSusbmaCommonPolicy(SusbmaCommonPolicyMasterVO vo) throws Exception{
		service.updateSusbmaCommonPolicy(vo);
	}
	
	public void updateSusbmaInitPassword(String initPassword) throws Exception{
		service.updateSusbmaInitPassword(initPassword);
	}
	
	public List<SusbmaCommonPolicyMasterVO> selectPopupList() throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		return service.selectPopupList(accountId);
	}
	
	public void updatePopupList(Map<String, Object> popupMap) throws Exception{
		service.updatePopupList(popupMap);
	}
	
	public SusbmaCommonPolicyMasterVO selectSecureAdminInfo() throws Exception{
		return service.selectSecureAdminInfo();
	}
	
	public void updateSecureAdminInfo(SusbmaCommonPolicyMasterVO vo) throws Exception{
		service.updateSecureAdminInfo(vo);
	}
	
	public int selectGroupType() throws Exception{
		return flexSessionUtils.getGroupType();
	}
	
}
