/**
 * 
 */
package com.saferzone.defcon4.susbma.usbmanage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Repository;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractDAO;
import com.saferzone.defcon4.base.util.Constants;
import com.saferzone.defcon4.common.cmdclient.CmdClientTargetVO;
import com.saferzone.defcon4.common.commonui.vo.CommonUiSearchVO;
import com.saferzone.defcon4.common.commonui.vo.CommonUiUsbMasterVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SearchSusbMasterVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbChangeHistoryVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbDeleteHistoryVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbUsbMasterVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbUseHistoryNicVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbUseHistoryVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbmaClassVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbmaMediaVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbmaReasonVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbmaStateVO;

/**
 *
 * 클래스 용도
 *
 * @author worker
 * @since 2011. 6. 1.
 * @version 1.0
 */
@SuppressWarnings("unchecked")
@Repository("SusbmaUsbManageDAO")
public class SusbmaUsbManageDAO extends Defcon4AbstractDAO implements ISusbmaUsbManageDAO {

	private final String SQL_ID_PREFIX = "susbma.usbmanage.SusbmaUsbManage."; 

	@Override
	public List<SusbUsbMasterVO> selectSusbmaUsbMasterList(SearchSusbMasterVO vo, int isCountQuery) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaUsbMasterList");
		sqlId.append(dbType);
		
		Map<String, Object> params = vo.properties();
		params.put("isCountQuery", isCountQuery);

		List<SusbUsbMasterVO> result = (List<SusbUsbMasterVO>)selectList(dbType, sqlId.toString(), params);
		return result;    
	}

	@Override
	public Integer selectSUsbMasterCount(SearchSusbMasterVO vo, int isCountQuery) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSUsbMasterCount");
		sqlId.append(dbType);
		
		Map<String, Object> params = vo.properties();
		params.put("isCountQuery", isCountQuery);

		Integer count = 0;
		
		List<SusbUsbMasterVO> result = (List<SusbUsbMasterVO>)selectList(dbType, sqlId.toString(), params);
		
		count = result.get(0).getResultCount();
		return count;  
	}
	
	@Override
	public Integer insertSusbmaUsbHistory(String assetId, SusbUseHistoryVO historyVO) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX).append("insertSusbmaUsbHistory");
		session.insert(sqlId.toString(), historyVO);
		return historyVO.getUseHistoryId();
	}
	
	/* (non-Javadoc)
	 * @see com.saferzone.defcon4.susbma.usbmanage.dao.ISusbmaUsbManageDAO#insertSusbmaUsbHistory(com.saferzone.defcon4.susbma.usbmanage.vo.SUSBUseHistoryVO)
	 */
	@Override
	public void insertSusbmaUsbHistoryNic(SusbUseHistoryNicVO nicVO) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("insertSusbmaUsbHistoryNic");
		
		session.insert(sqlId.toString(),nicVO);
	}
	
	@Override
	public List<SusbmaClassVO> selectSusbmaClassList(Integer localeCode) throws Exception {
		String accountId = flexSessionUtils.getAccountId();
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaClassList");
		sqlId.append(dbType);
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("localeCode", localeCode);
		params.put("accountId", accountId);
		
		List<SusbmaClassVO> result = (List<SusbmaClassVO>)selectList(dbType, sqlId.toString(), params);
		return result;
	}

	@Override
	public void insertUsubmaMaster(SusbUsbMasterVO vo) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("insertUsubmaMaster");
		session.insert(sqlId.toString(),vo);
		
		String errorCode = vo.getErrorCode();
		if(errorCode != null){
			throw new DataAccessResourceFailureException(getExceptionMessage(errorCode));
		}
	}
	
	@Override
	public List<SusbmaReasonVO> selectSusbmaReasonList(Integer localeCode) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaReasonList");
		sqlId.append(dbType);
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("localeCode", localeCode);
		
		List<SusbmaReasonVO> result = (List<SusbmaReasonVO>)selectList(dbType, sqlId.toString(), params);
		return result;
	}

	@Override
	public List<SusbmaStateVO> selectSusbmaStateList(Integer localeCode) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaStateList");
		sqlId.append(dbType);
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("localeCode", localeCode);
		
		List<SusbmaStateVO> result = (List<SusbmaStateVO>)selectList(dbType, sqlId.toString(), params);
		return result;
	}

	@Override
	public List<SusbmaMediaVO> selectSusbmaMediaList(Integer localeCode) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaMediaList");
		sqlId.append(dbType);
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("localeCode", localeCode);
		
		List<SusbmaMediaVO> result = (List<SusbmaMediaVO>)selectList(dbType, sqlId.toString(), params);
		return result;
	}

	@Override
	public void updateSusbMaster(SusbChangeHistoryVO vo) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("updateSusbMaster");
		session.insert(sqlId.toString(),vo);
		String errorCode = vo.getErrorCode();
		if(errorCode != null){
			throw new DataAccessResourceFailureException(getExceptionMessage(errorCode));
		}
	}
	
	@Override
	public void updateMngEmpId(SusbUsbMasterVO vo) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("updateMngEmpId");
		session.insert(sqlId.toString(),vo);
	}
	
	@Override
	public void deleteSusbmaMaster(String sno) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("deleteSusbmaMaster");
		session.insert(sqlId.toString(),sno);
	}
	
	@Override
	public List<SusbUseHistoryVO> selectSusbmaUseList(String sno) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaUseList");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		
		List<SusbUseHistoryVO> result = (List<SusbUseHistoryVO>)selectList(dbType,sqlId.toString(),params);
		
		return result;
	}

	@Override
	public List<SusbChangeHistoryVO> selectSusbmaChangeList(String sno, Integer localeCode) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaChangeList");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		params.put("localeCode", localeCode);
		
		List<SusbChangeHistoryVO> result = (List<SusbChangeHistoryVO>)selectList(dbType,sqlId.toString(),params);
		
		return result;
	}

	@Override
	public void returnSusbmaMaster(SusbUsbMasterVO vo) throws Exception {
		String accountId = flexSessionUtils.getAccountId();
		
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("returnSusbmaMaster");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", vo.getSno());
		params.put("accountId", accountId);
		params.put("reason", vo.getReason());
		
		session.update(sqlId.toString(),params);
		String errorCode = vo.getErrorCode();
		if(errorCode != null){
			throw new DataAccessResourceFailureException(getExceptionMessage(errorCode));
		}
	}
	
	@Override
	public int getGroupType(String accountId) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("getGroupType");
		return (Integer) session.selectOne(sqlId.toString(),accountId);
	}

	@Override
	public List<SusbDeleteHistoryVO> selectSusbmaDeleteList(String sno, int localeCode) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaDeleteList");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		params.put("localeCode", localeCode);
		
		List<SusbDeleteHistoryVO> result = (List<SusbDeleteHistoryVO>)selectList(dbType,sqlId.toString(),params);
		
		return result;
	}

	@Override
	public List<SusbUsbMasterVO> selectMassRegisterForm(SearchSusbMasterVO paramVo) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectMassRegisterForm");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("paramVo", paramVo);
		
		List<SusbUsbMasterVO> result = (List<SusbUsbMasterVO>)selectList(dbType,sqlId.toString(),params);

		return result;
	}

	@Override
	public void insertMassRegister(SusbUsbMasterVO vo) throws Exception {
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);
		
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("insertMassRegister");
		session.insert(sqlId.toString(),vo);
	}

	@Override
	public SusbUsbMasterVO insertMassRegisterFormCheck(SusbUsbMasterVO vo) throws Exception {
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);
		
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("insertMassRegisterFormCheck");
		sqlId.append(dbType);
		SusbUsbMasterVO result = (SusbUsbMasterVO) session.selectOne(sqlId.toString(),vo);
		
		return result;
	}
	
	@Override
	public List<SusbDeleteHistoryVO> selectSusbmaStatusList(String sno, int localeCode, String startDate, String endDate) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaStatusList");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		params.put("localeCode", localeCode);
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		
		List<SusbDeleteHistoryVO> result = (List<SusbDeleteHistoryVO>)selectList(dbType,sqlId.toString(),params);
		
		return result;
	}
	
	@Override
	public List<SusbDeleteHistoryVO> selectSusbmafileDeleteList(String sno, int localeCode, String startDate, String endDate) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmafileDeleteList");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		params.put("localeCode", localeCode);
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		
		List<SusbDeleteHistoryVO> result = (List<SusbDeleteHistoryVO>)selectList(dbType,sqlId.toString(),params);
		
		return result;
	}

	@Override
	public List<SusbUsbMasterVO> selectSusbmaUpdateList(String sno) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaUpdateList");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		
		List<SusbUsbMasterVO> result = (List<SusbUsbMasterVO>)selectList(dbType,sqlId.toString(),params);
		
		return result;
	}

	@Override
	public int selectIsDeptType(String sno) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectIsDeptType");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);

		return (Integer) session.selectOne(sqlId.toString(),sno);
	}
	
	@Override
	public List<SusbUsbMasterVO> selectSusbmaOrgList(String sno) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaOrgList");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		
		List<SusbUsbMasterVO> result = (List<SusbUsbMasterVO>)selectList(dbType,sqlId.toString(),params);
		
		return result;
	}

	@Override
	public List<CommonUiUsbMasterVO> selectUsbList(CommonUiSearchVO vo) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("selectUsbList");
		sqlID.append(dbType);
		
		Map<String, Object> params = vo.properties();
		List<CommonUiUsbMasterVO> result = null;
		if(dbType.equals(Constants.DB_TYPE_ORACLE)){
			session.selectList(sqlID.toString(), params);
			result = (List<CommonUiUsbMasterVO>)params.get(Constants.PROC_ORACLE_KEY_RESULTSET);
		}else{
			result = session.selectList(sqlID.toString(),vo);
		}
		return result;
	}
	
	@Override
	public String initPasswordResult(String sno) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("initPasswordResult");
		sqlId.append(dbType);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		return (String) session.selectOne(sqlId.toString(),sno);
	}

	@Override
	public void updatePasswordInit(String sno) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("updatePasswordInit");
		session.update(sqlId.toString(), sno);
	}
	
	
	public List<CmdClientTargetVO> selectUsbTargetList(String sno) throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectUsbTargetList");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		
		List<CmdClientTargetVO> result = (List<CmdClientTargetVO>)selectList(dbType, sqlId.toString(), params);
		return result;
	}
	
}
