package com.saferzone.defcon4.susbma.inventory.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractDAO;
import com.saferzone.defcon4.base.exception.DuplicatedRecordException;
import com.saferzone.defcon4.susbma.inventory.vo.SusbmaInventoryStatusVO;
import com.saferzone.defcon4.susbma.inventory.vo.SusbmaInventoryHistoryVO;

/**
 * 재고관리 dao 클래스
 * @author lmj
 * @since April 29, 2014
 * @version 1.0
 */
@SuppressWarnings("unchecked")
@Repository("SusbmaInventoryDAO")
public class SusbmaInventoryDAO extends Defcon4AbstractDAO implements ISusbmaInventoryDAO 
{
	private final String SQL_ID_PREFIX = "susbma.inventory.SusbmaInventory.";
	
	@Override
	public List<SusbmaInventoryStatusVO> selectInventoryStatusList(SusbmaInventoryStatusVO vo, int isCountQuery) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("selectInventoryStatusList");
		sqlID.append(dbType);
		
		Map<String, Object> params = vo.properties();
		params.put("isCountQuery", isCountQuery);
		
		List<SusbmaInventoryStatusVO> result = (List<SusbmaInventoryStatusVO>)selectList(dbType, sqlID.toString(), params);
		
		return result;
	}	
	
	@Override
	public Integer selectInventoryStatusListCount(SusbmaInventoryStatusVO vo, int isCountQuery) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("selectInventoryStatusList");
		sqlID.append(dbType);
		
		Map<String, Object> params = vo.properties();
		params.put("isCountQuery", isCountQuery);
		
		List<SusbmaInventoryStatusVO> result = (List<SusbmaInventoryStatusVO>)selectList(dbType, sqlID.toString(), params);
		int count = result.get(0).getResultCount();
		return count;
	}	

	@Override
	public void addInventoryStatus(SusbmaInventoryStatusVO vo) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("insertInventoryStatus");
		session.insert(sqlId.toString(), vo);
		
		String errorCode = vo.getErrorCode();
		if(errorCode != null)
		{
			throw new DuplicatedRecordException(getExceptionMessage(errorCode));	//DB에러 발생 시
		}
	}
	
	@Override
	public void modifyInventoryStatus(SusbmaInventoryStatusVO vo) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("updateInventoryStatus");
		session.update(sqlId.toString(), vo);

		String errorCode = vo.getErrorCode();
		String errorSno = vo.getErrorSno();
		if(errorCode != null){
			throw new Exception(errorSno + " " + getExceptionMessage(errorCode));	//DB에러 발생 시
		}
	}
	
	@Override
	public void deleteInventoryStatus(SusbmaInventoryStatusVO vo) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("deleteInventoryStatus");
		session.delete(sqlId.toString(), vo);

		String errorCode = vo.getErrorCode();
		String errorSno = vo.getErrorSno();
		if(errorCode != null){
			throw new Exception(errorSno + " " + getExceptionMessage(errorCode));	//DB에러 발생 시
		}
	}
	
	@Override
	public List<SusbmaInventoryHistoryVO> selectInventoryHistoryList(SusbmaInventoryHistoryVO vo, int isCountQuery) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("selectInventoryHistoryList");
		sqlID.append(dbType);
		
		Map<String, Object> params = vo.properties();
		params.put("isCountQuery", isCountQuery);
		
		List<SusbmaInventoryHistoryVO> result = (List<SusbmaInventoryHistoryVO>)selectList(dbType, sqlID.toString(), params);
		
		return result;
	}	
	
	@Override
	public Integer selectInventoryHistoryListCount(SusbmaInventoryHistoryVO vo, int isCountQuery) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("selectInventoryHistoryList");
		sqlID.append(dbType);
		
		Map<String, Object> params = vo.properties();
		params.put("isCountQuery", isCountQuery);
		
		List<SusbmaInventoryHistoryVO> result = (List<SusbmaInventoryHistoryVO>)selectList(dbType, sqlID.toString(), params);
		int count = result.get(0).getResultCount();
		return count;
	}

	@Override
	public HashMap<String, Object> updateIsoVersion(String sno, String isoVersion, int type) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("updateIsoVersion");

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		params.put("isoVersion", isoVersion);
		params.put("type", type);
		
		
		return (HashMap<String, Object>) session.selectOne(sqlId.toString(), params);
	}

	@Override
	public HashMap<String, Object> targetCheck(String sno, String updateVersion, int updateId) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("targetCheck");

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		params.put("updateVersion", updateVersion);
		params.put("updateId", updateId);
		
		return (HashMap<String, Object>) session.selectOne(sqlId.toString(), params);

	}	
}
