package com.saferzone.defcon4.susbma.inventory.dao;

import java.util.HashMap;
import java.util.List;

import com.saferzone.defcon4.susbma.inventory.vo.SusbmaInventoryStatusVO;
import com.saferzone.defcon4.susbma.inventory.vo.SusbmaInventoryHistoryVO;

/**
 * 재고관리 dao 인터페이스
 * @author lmj
 * @since April 29, 2014
 * @version 1.0
 */
public interface ISusbmaInventoryDAO {

	/**
	 * 재고 리스트
	 * @param vo
	 * @return List<SusbmaInventoryStatusVO>
	 * @throws Exception
	 */
	public List<SusbmaInventoryStatusVO> selectInventoryStatusList(SusbmaInventoryStatusVO vo, int isCountQuery)throws Exception;	

	/**
	 * 재고 리스트 카운트(무한 페이징)
	 * @param vo
	 * @return List<SusbmaInventoryStatusVO>
	 * @throws Exception
	 */
	public Integer selectInventoryStatusListCount(SusbmaInventoryStatusVO vo, int isCountQuery)throws Exception;	
	
	/**
	 * 재고 등록
	 * @param vo
	 * @return void
	 * @throws Exception
	 */
	public void addInventoryStatus(SusbmaInventoryStatusVO vo)throws Exception;	
	
	/**
	 * 재고 수정
	 * @param vo
	 * @return void
	 * @throws Exception
	 */
	public void modifyInventoryStatus(SusbmaInventoryStatusVO vo)throws Exception;	 
	
	/**
	 * 재고 삭제
	 * @param vo
	 * @return void
	 * @throws Exception
	 */
	public void deleteInventoryStatus(SusbmaInventoryStatusVO vo)throws Exception;
	
	/**
	 * 이력 리스트
	 * @param vo
	 * @return List<SusbmaInventoryHistoryVO>
	 * @throws Exception
	 */
	public List<SusbmaInventoryHistoryVO> selectInventoryHistoryList(SusbmaInventoryHistoryVO vo, int isCountQuery)throws Exception;	
	
	/**
	 * 이력 리스트 카운트(무한 페이징)
	 * @param vo
	 * @return List<SusbmaInventoryHistoryVO>
	 * @throws Exception
	 */
	public Integer selectInventoryHistoryListCount(SusbmaInventoryHistoryVO vo, int isCountQuery)throws Exception;
	
	/**
	 * iso버전 업데이트
	 */
	public HashMap<String, Object> updateIsoVersion(String sno, String isoVersion, int type) throws Exception;

	public HashMap<String, Object> targetCheck(String sno, String updateVersion, int updateId) throws Exception;
}
