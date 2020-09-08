/**
 * 
 */
package com.saferzone.defcon4.susbma.usbmanage.remote;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Component;

import com.opencsv.CSVReader;
import com.saferzone.defcon4.agntma.emergencykeylog.vo.AgntmaEmergencyKeyLogVO;
import com.saferzone.defcon4.base.abstracts.Defcon4AbstractRemote;
import com.saferzone.defcon4.base.util.ServerConfig;
import com.saferzone.defcon4.common.cipher.SZCipher;
import com.saferzone.defcon4.common.cmdclient.CmdClient;
import com.saferzone.defcon4.common.cmdclient.CmdClientTargetVO;
import com.saferzone.defcon4.common.commonui.vo.CommonUiSearchVO;
import com.saferzone.defcon4.common.commonui.vo.CommonUiUsbMasterVO;
import com.saferzone.defcon4.susbma.usbemergency.service.SusbmaUsbEmergencyService;
import com.saferzone.defcon4.susbma.usbemergency.vo.SusbmaUsbEmergencyVO;
import com.saferzone.defcon4.susbma.usbmanage.service.SusbmaUsbManageService;
import com.saferzone.defcon4.susbma.usbmanage.vo.SearchSusbMasterVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbChangeHistoryVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbDeleteHistoryVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbUsbMasterVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbUseHistoryVO;

/**
 *
 * Usb정보 취득용 Flex Client 연동 Remote Class
 *
 * @author worker
 * @since 2011. 6. 1.
 * @version 1.0
 */
@Component("SusbmaUsbManageRemote")
@RemotingDestination
public class SusbmaUsbManageRemote extends Defcon4AbstractRemote{
	@Autowired
	private SusbmaUsbManageService service;
	@Autowired
	private  SusbmaUsbEmergencyService service2;
	/** 서버 환결성정 클래스 */
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
	}
	
	/**
	 * 보조기억매체현황
	 * @param 보조기억매체현황VO
	 * @return 보조기억매체목록 카운트, 보조기억매체목록
	 * @throws Exception
	 */
	public Map<String, Object> selectSusbMasterList(SearchSusbMasterVO vo) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		vo.setAccountId(flexSessionUtils.getAccountId());
		vo.setLocaleCode(flexSessionUtils.getLocaleCode());
		vo.setGroupType(flexSessionUtils.getGroupType());
		vo.setIsExportExcel(0);
		vo.setDeptNameType(0);
		resultMap.put("LIST", (List<SusbUsbMasterVO>)service.selectSUsbMasterList(vo, 0));
		resultMap.put("COUNT", (Integer)service.selectSUsbMasterCount(vo, 1));
		return resultMap;
	}
	
	/**
	 * 보조기억매체저장
	 * @param vo 보조기억매체정보
	 * @throws Exception
	 */
	public void insertUsubmaMaster(SusbUsbMasterVO vo) throws Exception{
		vo.setAccountId(flexSessionUtils.getAccountId());
		service.insertUsubmaMaster(vo);
	}
	
	/**
	 * 보조기억매체수정
	 * @param vo 보조기억매체정보
	 * @throws Exception
	 */
	public void updateSusbMaster(SusbChangeHistoryVO vo) throws Exception {
		
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);
		service.updateSusbMaster(vo);
		
		CmdClientTargetVO cmdVo = new CmdClientTargetVO();
		cmdVo.setCompanyId("2");
		cmdVo.setRange(3);
		cmdVo.setOrgId(vo.getPcOrgId());
		cmdVo.setAssetId(vo.getAssetId());
		
		setConfig();
		List<CmdClientTargetVO> targets = Arrays.asList(new CmdClientTargetVO[]{cmdVo});	
		CmdClient.sendCommand(targets, "BROADCAST", CmdClient.COMMAND_POLICYCHANGE_USB, serverIp, serverPort);
		
	}
	
	/** 보조기억매체 - 일괄변경
	 * 	@param vo 보조기억매체정보
	 */
	public void updateMngEmpId(SusbUsbMasterVO vo) throws Exception {
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);
		service.updateMngEmpId(vo);
	}
	
	/**
	 * 보조기억매체삭제
	 * @param list 선택한 보조기억매체정보
	 * @throws Exception
	 */
	public void deleteSusbmaMaster(List<SusbUsbMasterVO> list) throws Exception{
		service.tranDeleteSusbmaMaster(list);
	}
	
	/**
	 * 보조기억매체 사용이력조회
	 * @param sno 보조기억매체 시리얼번호
	 * @return 보조기억매체 사용이력목록
	 * @throws Exception
	 */
	public List<SusbUseHistoryVO> selectSusbmaUseList(String sno) throws Exception{
		List<SusbUseHistoryVO> result = service.selectSusbmaUseList(sno);
		return result;
	}
	
	/**
	 * 보조기억매체 변경이력조회
	 * @param sno 보조기억매체 시리얼번호
	 * @return 보조기억매체 사용이력목록
	 * @throws Exception
	 */
	public List<SusbChangeHistoryVO> selectSusbmaChangeList(String sno) throws Exception{
		int localeCode = flexSessionUtils.getLocaleCode();
		List<SusbChangeHistoryVO> result = service.selectSusbmaChangeList(sno, localeCode);
		return result;
	}
	
	/**
	 * 보조기억매체 패스워드변경
	 * @param targets
	 * @param sno
	 * @param pwd
	 * @throws Exception
	 */
	//orgId, assetId, companyid=2, rangeType=3
	public String changeUsbPassword( List<CmdClientTargetVO> targets, String sno, String pwd, int isDataDelete, int isFirst)throws Exception{
		
		if(isFirst == 1){
			service.updatePasswordInit(sno);
			
			String contents = "";
			setConfig();
			
			pwd = pwd.replaceAll("&", "##SZAMP##");
			
			if(isDataDelete == 1)
			{
				contents = "MJC=FIREEVENT&ID=SECUREUSBPWDDATARESET&CONTENTS=" + pwd + "&RESERVED="+ sno;
			}
			else
			{
				contents = "MJC=FIREEVENT&ID=SECUREUSBPWDRESET&CONTENTS=" + pwd + "&RESERVED="+ sno;
			}
			
			List<CmdClientTargetVO> nTargets = (List<CmdClientTargetVO>) service.selectUsbTargetList(sno);
			
			for(int i=0; i<nTargets.size(); i++){
				if(nTargets.get(i).getAssetId() == null){
					return "3";
				}
			}
			 
			CmdClient.sendCommand(nTargets, CmdClient.CMDTYPE_BROADCAST, contents, serverIp, serverPort);
			return "2";
		}else{
			
			String result  = service.initPasswordResult(sno);	
			
			if(result.equals("1")) 
				return "1";	
			else
				return "0";
			
		}
		
	}
	
	/**
	 * USB를 반납합니다.
	 * @param SusbUsbMasterVO
	 * @return 
	 * @throws Exception
	 */
	public void returnSusbmaMaster(SusbUsbMasterVO vo) throws Exception{
		service.returnSusbmaMaster(vo);
	}
	 
	public String makeEmergencyKey(AgntmaEmergencyKeyLogVO vo) throws Exception{
		String newAuthKey ="";
		newAuthKey = SZCipher.makeEmergencyKey(vo.getAuthCode(), vo.getKeyType());
		
		SusbmaUsbEmergencyVO usbEmergencyVO = new SusbmaUsbEmergencyVO();
		usbEmergencyVO.setReason(vo.getReasonDesc());
		usbEmergencyVO.setCertifyKey(vo.getAuthCode());
		usbEmergencyVO.setAuthCode(newAuthKey);
		if(vo.getKeyType() == 2){
			usbEmergencyVO.setType(1);
		}else{
			usbEmergencyVO.setType(0);
		}
		usbEmergencyVO.setIssueAccountId(flexSessionUtils.getAccountId());
		usbEmergencyVO.setTransType(0);
		if(newAuthKey.equals("")){
			usbEmergencyVO.setReturnCode(6);//관리자 화면 비상키 생성 실패
		}else{
			usbEmergencyVO.setReturnCode(5); //관리자 화면 비상키 생성 성공
		}
		service2.insertRequestPasswordInitLog(usbEmergencyVO);
		
		//return SZCipher.makeEmergencyKey(vo.getAuthCode(), vo.getKeyType());
		return newAuthKey;
	}
	
	public int getGroupType() throws Exception{
		return flexSessionUtils.getGroupType();
	}
	
	public List<SusbDeleteHistoryVO> selectSusbmaDeleteList(String sno) throws Exception{
		int localeCode = flexSessionUtils.getLocaleCode();
		List<SusbDeleteHistoryVO> result = service.selectSusbmaDeleteList(sno, localeCode);
		return result;
	}

	public Map<String, Object> usbMassRegister(String tempFileName) throws Exception{
		
		String upload_dir = System.getProperty("catalina.home") + "/webapps/ROOT/Agent_Download/upload/";
		
		System.out.println("Upload Directory : " + upload_dir);
		System.out.println("Temp Filename : " + tempFileName);
		
		char seprator =',';
		 
		Map<String, Object> resultMap = new HashMap<String, Object>();
		


		//CSVReader reader = new CSVReader(new FileReader(upload_dir+tempFileName));
		CSVReader reader = new CSVReader(new BufferedReader(new InputStreamReader(new FileInputStream(upload_dir+tempFileName),"MS949")), seprator);
		String[] nextLine;
		while((nextLine = reader.readNext()) != null)
		{
			System.out.println("NextLine : " + nextLine);
			if(nextLine.length == 7)
			{
				SusbUsbMasterVO rv = new SusbUsbMasterVO();
				SusbUsbMasterVO vo = new SusbUsbMasterVO();
				if(reader.getLinesRead() != 1)
				{
					vo.setSno(nextLine[0]);
					vo.setUserEmpId(nextLine[1]);
					if(nextLine[2].equals(""))
					{
						resultMap.put("ERRORCODE", 1);
						resultMap.put("ERRORMSG", "SC_REQUIRE_DATA_EMPTY");
						resultMap.put("ERRORLINE", reader.getLinesRead() );
						break;
					}
					
					if(!nextLine[2].matches("^[0-9]*$"))
					{
						resultMap.put("ERRORCODE", 1);
						resultMap.put("ERRORMSG", "SC_CLASSID_FORMAT_WRONG");
						resultMap.put("ERRORLINE", reader.getLinesRead() );
						break;
					}
					
					vo.setClassId(Integer.parseInt(nextLine[2]));
					vo.setMngEmpId(nextLine[3]);
					vo.setPermStartDate(nextLine[4]);
					vo.setPermEndDate(nextLine[5]);
					vo.setIsTimeCheck(Integer.parseInt(nextLine[6].equals("1")?"1":"0"));
								
					rv = service.insertMassRegisterFormCheck(vo);
					
					if(rv.getReturnCode() == 1)
					{
						System.out.println("rv.getReturnCode() = " + rv.getReturnCode());
						System.out.println("rv.getReturnMsg() = " + rv.getReturnMsg() );
						System.out.println("reader.getLinesRead()  = " + reader.getLinesRead() );
						resultMap.put("ERRORCODE", rv.getReturnCode() );
						resultMap.put("ERRORMSG", rv.getReturnMsg() );
						resultMap.put("ERRORLINE", reader.getLinesRead() );
						break;
					}
				}else{
					Integer localeCode = flexSessionUtils.getLocaleCode();
					
					if(nextLine[0].equals(config.getString(localeCode, "SC_SERIAL_NO")) == false
					|| nextLine[1].equals(config.getString(localeCode, "SC_USER_ID")) == false
					|| nextLine[2].equals(config.getString(localeCode, "SC_CLASS")) == false
					|| nextLine[3].equals(config.getString(localeCode, "SC_MANAGER_ID")) == false
					|| nextLine[4].equals(config.getString(localeCode, "SC_START_PERIOD")) == false
					|| nextLine[5].equals(config.getString(localeCode, "SC_END_PERIOD")) == false
					|| nextLine[6].equals(config.getString(localeCode, "SC_USE_PERIOD_RESTRICTION")) == false
					)
					{
						System.out.println("Line 1 - Form Error");
						resultMap.put("ERRORCODE", "2");
						resultMap.put("ERRORMSG", "SC_MASS_REGISTER_FORM_WRONG");
						break;
					}
				}
			}
			else
			{
				System.out.println("Form Error");
				resultMap.put("ERRORCODE", "2");
				resultMap.put("ERRORMSG", "SC_MASS_REGISTER_FORM_WRONG");
				break;
			}
			
		}
		//CSVReader reader2 = new CSVReader(new FileReader(upload_dir+tempFileName));
		CSVReader reader2 = new CSVReader(new BufferedReader(new InputStreamReader(new FileInputStream(upload_dir+tempFileName),"MS949")), seprator);
		String[] nextLine2;
		if(resultMap.get("ERRORCODE") == null){
			while((nextLine2 = reader2.readNext()) != null)
			{
				SusbUsbMasterVO vo = new SusbUsbMasterVO();
				if(reader2.getLinesRead() != 1)
				{
					vo.setSno(nextLine2[0]);
					vo.setUserEmpId(nextLine2[1]);
					vo.setClassId(Integer.parseInt(nextLine2[2]));
					vo.setMngEmpId(nextLine2[3]);
					vo.setPermStartDate(nextLine2[4]);
					vo.setPermEndDate(nextLine2[5]);
					vo.setIsTimeCheck(Integer.parseInt(nextLine2[6].equals("1")?"1":"0"));
								
					service.insertMassRegister(vo);
					
				}
			}
		
			resultMap.put("SUCCESSMSG", "SC_MASS_REGISTER_SUCCESS");
		}

    	return resultMap;
	}
	
	
	public List<SusbDeleteHistoryVO> selectSusbmaStatusList(String sno, String startDate, String endDate) throws Exception{
		int localeCode = flexSessionUtils.getLocaleCode();
		List<SusbDeleteHistoryVO> result = service.selectSusbmaStatusList(sno, localeCode, startDate, endDate);
		return result;
	}
	
	public List<SusbDeleteHistoryVO> selectSusbmafileDeleteList(String sno, String startDate, String endDate) throws Exception{
		int localeCode = flexSessionUtils.getLocaleCode();
		List<SusbDeleteHistoryVO> result = service.selectSusbmafileDeleteList(sno, localeCode, startDate, endDate);
		return result;
	}
	
	public List<SusbUsbMasterVO> selectSusbmaUpdateList(String sno) throws Exception{
		List<SusbUsbMasterVO> result = service.selectSusbmaUpdateList(sno);	
		return result;
	}
	
	public List<CommonUiUsbMasterVO> selectUsbList(CommonUiSearchVO vo) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		int localeCode = flexSessionUtils.getLocaleCode();
		vo.setAccountId(accountId);
		vo.setLocaleCode(localeCode);
		return service.selectUsbList(vo);
	}
	
	public String initPasswordResult(String sno) throws Exception{
		return service.initPasswordResult(sno);	
	}

	public void updatePasswordInit(String sno) throws Exception{
		service.updatePasswordInit(sno);	
	}
	
}
