package com.saferzone.defcon4.susbma.inventory.controller;

import java.io.PrintWriter;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.arnx.jsonic.JSON;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractController;
import com.saferzone.defcon4.base.util.CommonUtil;
import com.saferzone.defcon4.base.util.ServerConfig;
import com.saferzone.defcon4.susbma.inventory.service.SusbmaInventoryService;
import com.saferzone.defcon4.susbma.inventory.vo.SusbmaInventoryStatusVO;


@Controller
public class SusbmaInventoryController extends Defcon4AbstractController {

	@Autowired
	private SusbmaInventoryService service;
	
	@Autowired
	private ServerConfig config;
	
	@RequestMapping("/usbInventoryStatusExportExcel.htm")
	public ModelAndView excel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		setSession(request);
		
		String accountId = flexSessionUtils.getAccountId();
		int groupType = flexSessionUtils.getGroupType();
		SusbmaInventoryStatusVO paramVo = JSON.decode(CommonUtil.parameterArrayToString(request.getParameter("searchVo")), SusbmaInventoryStatusVO.class);
		paramVo.setAccountId(accountId);
		paramVo.setGroupType(groupType);
		List<SusbmaInventoryStatusVO> list = service.selectInventoryStatusList(paramVo, 99);
		String[] title = request.getParameterValues("titleName");
		String[] titleProperty = request.getParameterValues("titleProperty");
		String[] fileName = request.getParameterValues("fileName");
		ModelAndView mav = new ModelAndView(exportExcelView);
		mav.addObject("list", list);
		mav.addObject("title", title);
		mav.addObject("titleProperty", titleProperty);
		mav.addObject("fileName", fileName);
		return mav;
	}
	
	@RequestMapping("/UpdateIsoVersion.htm")
	public void updateIsoVersion(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String sno = "";
		String isoVersion = "";
		int type = 0;
		
		if(request.getParameter("SNO") != null){
			sno = request.getParameter("SNO");
		}
		
		if(request.getParameter("VER") != null){
			isoVersion = request.getParameter("VER");
		}
	
		if(request.getParameter("TYPE") != null){
			type = Integer.parseInt(request.getParameter("TYPE"));
		}

		// Type = 1 USB VersionCheck returnCode = 1 > USB UPDATE(Agent) > Complete >  Type = 0  호출 > 이력
		//							 returnCode = 0 ---------------------------------------------------
		
		System.out.println(sno);
		System.out.println(isoVersion);
		System.out.println(type);
		
		InetAddress ip = InetAddress.getLocalHost();
		String hostAddress = ip.getHostAddress();
		System.out.println("hostAddress : " + hostAddress);
		
		/** 서버IP */
		String serverIp;
		/** 서버PORT */
		int serverPort;
		/** remote controll 주소*/
		String remoteAddress;
		
		serverIp = config.getConfig("COMMAND_SERVER_IP", "127.0.0.1");
		serverPort = Integer.parseInt(config.getConfig("COMMAND_SERVER_PORT", "31010"));
		
		System.out.println("serverIp : " + serverIp);
		
		HashMap<String, Object> returnMap = service.updateIsoVersion(sno, isoVersion, type);
		
		StringBuilder sb = new StringBuilder();
		if(returnMap.get("RETURNCODE").toString().equals("SUCCESS")) {
			
			String IsoVer = returnMap.get("ISOVERSION").toString();
			int updateId = Integer.parseInt(returnMap.get("UPDATEID").toString());
			
			HashMap<String, Object> targetCheck = service.targetCheck(sno, IsoVer, updateId);
			
			if( targetCheck.get("RESULTCODE").toString().equals("SUCCESS")){
				sb.append("RESULT=");
				sb.append(targetCheck.get("RESULTCODE"));
				sb.append("&");
				sb.append("DOWNPATH=https://");
				sb.append(serverIp);
//				sb.append("58.87.34.95");		//현대기아 DNS
				sb.append("/usbupdate");
//				sb.append("/Enterprise/");
				sb.append("/" + returnMap.get("FOLDERNAME") + "/");
				sb.append(returnMap.get("CUSTOMERID") + "/");
				sb.append(returnMap.get("ISOVERSION"));
				sb.append("&UPDATEVERSION=");
				sb.append(returnMap.get("ISOVERSION"));
			}else{
				sb.append("RESULT=");
				sb.append(targetCheck.get("RESULTCODE"));
			}
		}else{
			sb.append("RESULT=");
			sb.append(returnMap.get("RETURNCODE"));
		}
				

		PrintWriter write = response.getWriter();
		write.write(sb.toString());
	}
}
