package com.saferzone.defcon4.susbma.usbmanage.common;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Component;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractRemote;
import com.saferzone.defcon4.base.util.Constants;
import com.saferzone.defcon4.susbma.usbmanage.service.SusbmaUsbManageService;

@Component("SusbmaCommonRemote")
@RemotingDestination
public class SusbmaCommonRemote extends Defcon4AbstractRemote {
	
	@Autowired
	private SusbmaUsbManageService service;
	
	public Map<String, Object> selectCommonList(Map<String, Object> map) throws Exception{
		int localeCode = flexSessionUtils.getLocaleCode();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if(map.get(Constants.CLASS_LIST) != null){
			returnMap.put(Constants.CLASS_LIST, service.selectSusbmaClassList(localeCode));
		}
		if(map.get(Constants.STATE_LIST) != null){
			returnMap.put(Constants.STATE_LIST, service.selectSusbmaStateList(localeCode));
		}
		if(map.get(Constants.MEDIA_TYPE_LIST) != null){
			returnMap.put(Constants.MEDIA_TYPE_LIST, service.selectSusbmaMediaList(localeCode));
		}
		if(map.get(Constants.REASON_LIST) != null){
			returnMap.put(Constants.REASON_LIST, service.selectSusbmaReasonList(localeCode));
		}
		if(map.get(Constants.DEPT_TYPE) != null){
			returnMap.put(Constants.DEPT_TYPE, service.selectIsDeptType(map.get("DEPT_TYPE").toString()));
		}
		if(map.get(Constants.ORG_LIST) != null){
			returnMap.put(Constants.ORG_LIST, service.selectSusbmaOrgList(map.get("ORG_LIST").toString()));
		}
		
		
		return returnMap;
	}
}
