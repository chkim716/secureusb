package com.saferzone.defcon4.susbma.inventory.remote;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Component;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractRemote;
import com.saferzone.defcon4.susbma.inventory.vo.SusbmaInventoryStatusVO;
import com.saferzone.defcon4.susbma.inventory.vo.SusbmaInventoryHistoryVO;
import com.saferzone.defcon4.susbma.inventory.service.SusbmaInventoryService;

/**
 * 재고관리 remote 클래스
 * @author lmj
 * @since April 29, 2014
 * @version 1.0
 */
@Component("SusbmaInventoryRemote")
@RemotingDestination
public class SusbmaInventoryRemote extends Defcon4AbstractRemote{
		
	@Autowired
	private SusbmaInventoryService service;

	/**
	 * 재고 리스트
	 * @param vo
	 * @return List<SusbmaInventoryStatusVO>
	 * @throws Exception
	 */
	public Map<String, Object> selectInventoryStatusList(SusbmaInventoryStatusVO vo) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		vo.setGroupType(flexSessionUtils.getGroupType());
		vo.setAccountId(flexSessionUtils.getAccountId());
		resultMap.put("LIST", service.selectInventoryStatusList(vo, 0));
		resultMap.put("COUNT", service.selectInventoryStatusListCount(vo, 1));
		return resultMap;
	}	
	
	/**
	 * 재고 등록
	 * @param vo
	 * @return void
	 * @throws Exception
	 */
	public void addInventoryStatus(SusbmaInventoryStatusVO vo) throws Exception{	
		String manageAccountId = flexSessionUtils.getAccountId();
		vo.setCreator(manageAccountId);
		service.addInventoryStatus(vo);
	}
	
	/**
	 * 재고 수정
	 * @param vo
	 * @return void
	 * @throws Exception
	 */
	public void modifyInventoryStatus(SusbmaInventoryStatusVO vo) throws Exception{	
		String manageAccountId = flexSessionUtils.getAccountId();
		vo.setUpdator(manageAccountId);
		service.modifyInventoryStatus(vo);
	}
	
	/**
	 * 재고 삭제
	 * @param vo
	 * @return void
	 * @throws Exception
	 */
	public void deleteInventoryStatus(SusbmaInventoryStatusVO vo) throws Exception{	
		service.deleteInventoryStatus(vo);
	}
	
	/**
	 * 이력 리스트
	 * @param vo
	 * @return List<SusbmaInventoryHistoryVO>
	 * @throws Exception
	 */
	public Map<String, Object> selectInventoryHistoryList(SusbmaInventoryHistoryVO vo) throws Exception{
		vo.setGroupType(flexSessionUtils.getGroupType());
		vo.setAccountId(flexSessionUtils.getAccountId());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("LIST", service.selectInventoryHistoryList(vo, 0));
		resultMap.put("COUNT", service.selectInventoryHistoryListCount(vo, 1));
		return resultMap;
	}	
}
