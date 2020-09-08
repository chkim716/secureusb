/**
 * <pre>
 * 세이퍼존 DEFCON4 프로젝트
 * 
 * Copyright (c) 2011 by saferzone, Inc.
 * All rights reserved.
 *
 * Description	 
 * 작성자		: chang
 * 최초생성일	: 2011. 10. 17. 오후 3:59:58
 * Version		: 1.0
 * 
 * [수정사항반영 작성방식]
 * 예 : Revision 1.1  2011. 10. 17. 오후 3:59:58 chang 신규작성
 *
 * [수정사항반영]
 * </pre>
 */
package com.saferzone.defcon4.susbma.usbmanage.controller;

import java.io.File;
import java.util.Map;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.arnx.jsonic.JSON;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractController;
import com.saferzone.defcon4.base.util.CommonUtil;
import com.saferzone.defcon4.susbma.usbmanage.service.SusbmaUsbManageService;
import com.saferzone.defcon4.susbma.usbmanage.vo.SearchSusbMasterVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbDeleteHistoryVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbUsbMasterVO;

/**
 * usb목록 엑셀출력 Controller
 * @author chang
 * @since 2011. 10. 17.
 * @version 1.0
 */
@Controller
public class SusbmaUsbManageController extends Defcon4AbstractController {
	@Autowired
	private SusbmaUsbManageService service;
	
	/**
	 * usb목록 엑셀출력
	 * @param request
	 * @param response
	 * @return ModelAndView mav
	 * @throws Exception
	 */
	@RequestMapping("/usbMasterExportExcel.htm")
	public ModelAndView excel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		setSession(request);

		Map requestMap = request.getParameterMap();
		String[] title = (String[])requestMap.get("titleName");
		String[] titleProperty = (String[])requestMap.get("titleProperty");
		String[] fileName = (String[])requestMap.get("fileName");
		String[] rowCount = (String[])requestMap.get("rowCount");
		String[] deptNameType = (String[])requestMap.get("deptNameType");
		String[] extension = (String[])requestMap.get("extension");
		
		String accountId = flexSessionUtils.getAccountId();
		int localeCode = flexSessionUtils.getLocaleCode();
		int groupType = flexSessionUtils.getGroupType();
		
		SearchSusbMasterVO paramVo = JSON.decode(CommonUtil.parameterArrayToString(request.getParameter("searchVo")), SearchSusbMasterVO.class);
		paramVo.setAccountId(accountId);
		paramVo.setGroupType(groupType);
		paramVo.setLocaleCode(localeCode);
		paramVo.setStartIdx(0);
		paramVo.setTopCount(Integer.parseInt(rowCount[0]));
		paramVo.setDeptNameType(Integer.parseInt(deptNameType[0]));
		paramVo.setIsExportExcel(1);
		List<SusbUsbMasterVO> list = service.selectSUsbMasterList(paramVo, 0);
		
		ModelAndView mav = null;
		if(extension[0].equals("csv")){
			mav = new ModelAndView(exportCsvView);
		}else{
			mav = new ModelAndView(exportExcelView);
		}
		mav.addObject("list", list);
		mav.addObject("title", title);
		mav.addObject("titleProperty", titleProperty);
		mav.addObject("fileName", fileName);
		return mav;
	}
	
	@RequestMapping("/usbMasterStatusExportExcel.htm")
	public ModelAndView excel2(HttpServletRequest request, HttpServletResponse response) throws Exception{
		setSession(request);
		
		String accountId = flexSessionUtils.getAccountId();
		int localeCode = flexSessionUtils.getLocaleCode();
		int groupType = flexSessionUtils.getGroupType();
		SusbDeleteHistoryVO paramVo = JSON.decode(CommonUtil.parameterArrayToString(request.getParameter("searchVo2")), SusbDeleteHistoryVO.class);
		List<SusbDeleteHistoryVO> list = service.selectSusbmaStatusList(paramVo.getSno(), flexSessionUtils.getLocaleCode(), paramVo.getStartDateStr(), paramVo.getEndDateStr());
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
	
	@RequestMapping("/usbMasterDeleteRemoteExportExcel.htm")
	public ModelAndView excel3(HttpServletRequest request, HttpServletResponse response) throws Exception{
		setSession(request);
		
		String accountId = flexSessionUtils.getAccountId();
		int localeCode = flexSessionUtils.getLocaleCode();
		int groupType = flexSessionUtils.getGroupType();
		SusbDeleteHistoryVO paramVo = JSON.decode(CommonUtil.parameterArrayToString(request.getParameter("searchVo2")), SusbDeleteHistoryVO.class);
		List<SusbDeleteHistoryVO> list = service.selectSusbmafileDeleteList(paramVo.getSno(), flexSessionUtils.getLocaleCode(), paramVo.getStartDateStr(),paramVo.getEndDateStr());
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
	
	@RequestMapping("/UsbMassRegisterFormDownload.htm")
	public ModelAndView usbMassRegFormDown(HttpServletRequest request, HttpServletResponse response) throws Exception{
		setSession(request);
		
		String accountId = flexSessionUtils.getAccountId();
		ModelAndView mav = new ModelAndView();
		
//		if(accountId != null) {
			
			int groupType = flexSessionUtils.getGroupType();
		
			SearchSusbMasterVO paramVo = new SearchSusbMasterVO();
			paramVo.setAccountId(accountId);
			paramVo.setGroupType(groupType);
			
			List<SusbUsbMasterVO> list = service.selectMassRegisterForm(paramVo);
			
			String[] title = request.getParameterValues("titleName");
			String[] titleProperty = request.getParameterValues("titleProperty");
			String[] fileName = request.getParameterValues("fileName");
			
			mav.addObject("list", list);
			mav.addObject("title", title);
			mav.addObject("titleProperty", titleProperty);
			mav.addObject("fileName", fileName);
			mav.setViewName("csvDownload");
//		}
//		else {
//			mav.setViewName("");
//		}

		return mav;
	}
	
	@RequestMapping("/massRegisterUpload.htm")
	public void usbMassRegUpload(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		setSession(request);
		
		String accountId = flexSessionUtils.getAccountId();
		
		if(accountId != null) {
			
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			//String upload_dir = "E:\\manual\\";
			String upload_dir = System.getProperty("catalina.home") + "/webapps/ROOT/Agent_Download/upload/";
			
			System.out.println(upload_dir);
			String fileString = "";

			try{
				if(isMultipart)
				{
					int yourMaxMemorySize = 1024 * 10;
					long yourMaxRequestSize = 1024 * 1024 * 200;
					
					File uploadDirectory = new File(upload_dir);
					
					DiskFileItemFactory factory = new DiskFileItemFactory();
					factory.setSizeThreshold(yourMaxMemorySize);
					factory.setRepository(uploadDirectory);
					
					ServletFileUpload upload = new ServletFileUpload(factory);
					upload.setSizeMax(yourMaxRequestSize);
					upload.setHeaderEncoding("UTF-8");
					
					List list = upload.parseRequest(request);
		            for (int i=0,ii=list.size();i<ii;i++) {
		            	FileItem fileItem = (FileItem)list.get(i);
		            	//첨부파일 체크
		            	if(fileItem.isFormField())
		            	{
		            		if("fileString".equals(fileItem.getFieldName()))
		                	{
		            			fileString = fileItem.getString();
		                	}
		            	}
		            	else
		            	{
		            		if("Filedata".equals(fileItem.getFieldName()))
		                    {
		            			File uploadfile = new File(upload_dir + fileString);

		                		File uploadDir = uploadfile.getParentFile();
		                        if(!uploadDir.isDirectory())
		                        {
		                        	uploadDir.mkdirs();
		                        }       
		                        fileItem.write(uploadfile);
		                    }
		            	}
		            }
				}

			} catch (Exception e){
				e.printStackTrace();
			}
		}
		
	}
	
	
}
