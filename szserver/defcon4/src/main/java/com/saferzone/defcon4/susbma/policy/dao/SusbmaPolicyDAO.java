package com.saferzone.defcon4.susbma.policy.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractDAO;
import com.saferzone.defcon4.base.exception.DuplicatedRecordException;
import com.saferzone.defcon4.base.util.Constants;
import com.saferzone.defcon4.common.cmdclient.CmdClientTargetVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaCommonPolicyMasterVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyGroupUsbVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyMasterVO;
import com.saferzone.defcon4.susbma.policy.vo.SusbmaPolicyRawVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbmaClassVO;

@SuppressWarnings("unchecked")
@Repository("SusbmaPolicyDAO")
public class SusbmaPolicyDAO extends Defcon4AbstractDAO implements ISusbmaPolicyDAO {
	private final String SQL_ID_PREFIX = "susbma.policy.susbmaPolicy."; 
	

	@Override
	public List<CmdClientTargetVO> selectPolicyTargetList(Integer policyId) throws Exception{
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectPolicyTargetList");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("policyId", policyId);
		
		List<CmdClientTargetVO> result = (List<CmdClientTargetVO>)selectList(dbType, sqlId.toString(), params);
		return result;
	}
	
	@Override
	public List<SusbmaPolicyMasterVO> selectSusbmaPolicyMasterList(Integer rangeType, Integer localeCode, String accountId) throws Exception{
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("selectSusbmaPolicyMasterList");
		sqlID.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("rangeType", rangeType);
		params.put("localeCode", localeCode);
		params.put("accountId", accountId);
		List<SusbmaPolicyMasterVO> result = null;
		if(dbType.equals(Constants.DB_TYPE_ORACLE)){
			session.selectList(sqlID.toString(), params);
			result = (List<SusbmaPolicyMasterVO>)params.get(Constants.PROC_ORACLE_KEY_RESULTSET);
		}else{
			result = session.selectList(sqlID.toString(),params);
		}
		return result;
	}
	
	@Override
	public SusbmaPolicyRawVO selectSusbmaPolicyRaw(Integer usbPolicyId) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("selectSusbmaPolicyRaw");
		sqlID.append(dbType);
		
		SusbmaPolicyRawVO result = new SusbmaPolicyRawVO();
		result.setUsbPolicyId(usbPolicyId);
		if((dbType.equals(Constants.DB_TYPE_ORACLE))|| dbType.equals(Constants.DB_TYPE_MYSQL)){
			session.selectOne(sqlID.toString(), result);
		}else{
			result = (SusbmaPolicyRawVO)session.selectOne(sqlID.toString(),usbPolicyId);
		}
		
		return result;
	}
	
	@Override
	public void insertSusbmaPolicyRaw(Integer usbPolicyId) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("insertSusbmaPolicyRaw");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("usbPolicyId", usbPolicyId);
		params.put("accountId", accountId);
		
		session.insert(sqlID.toString(), params);
	}
	
	@Override
	public void updateSusbmaPolicyRaw(SusbmaPolicyRawVO vo) throws Exception {
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);

		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSusbmaPolicyRaw");
		
		session.update(sqlID.toString(), vo);
	}
	
	@Override
	public void deleteSusbmaPolicyRaw(Integer policyId) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("deleteSusbmaPolicyRaw");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("policyId", policyId);
		params.put("accountId", accountId);

		
		session.delete(sqlID.toString(), params);
	}
	
	
	@Override
	public void updateSusbmaPolicyClass(SusbmaClassVO vo) throws Exception {
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);
		
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSusbmaPolicyClass");

		session.update(sqlID.toString(), vo);
	}
	
	public void insertSusbmaPolicyOrg(SusbmaPolicyMasterVO vo) throws Exception{
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("insertSusbmaPolicyOrg");
		
		session.insert(sqlID.toString(), vo);
		
		//이미 해당 부서를 추가했을시
		String errorCode = vo.getErrorCode();
		if(errorCode != null){
			throw new DuplicatedRecordException(getExceptionMessage(errorCode));
		}
	}
	
	public void deleteSusbmaPolicyOrg(Integer usbPolicyId) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("deleteSusbmaPolicyOrg");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("usbPolicyId", usbPolicyId);
		params.put("accountId", accountId);
		
		session.update(sqlID.toString(), params);
	}
	
	public void updateSusbmaPolicyOrg(SusbmaPolicyMasterVO vo) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);
		
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSusbmaPolicyOrg");
		
		session.update(sqlID.toString(), vo);
	}

	public void insertSusbmaPolicyGrp(SusbmaPolicyMasterVO vo) throws Exception{
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("insertSusbmaPolicyGrp");
		
		session.insert(sqlID.toString(), vo);
		String errorCode = vo.getErrorCode();
		if(errorCode != null){
			throw new DuplicatedRecordException(getExceptionMessage(errorCode));
		}
	}

	public void deleteSusbmaPolicyGrp(Integer grpId) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("deleteSusbmaPolicyGrp");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("grpId", grpId);
		params.put("accountId", accountId);
		
		
		session.delete(sqlID.toString(), params);
	}

	public void updateSusbmaPolicyGrp(SusbmaPolicyMasterVO vo) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		vo.setAccountId(accountId);
		
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSusbmaPolicyGrp");
		
		session.update(sqlID.toString(), vo);
		String errorCode = vo.getErrorCode();
		if(errorCode != null){
			throw new DuplicatedRecordException(getExceptionMessage(errorCode));
		}
	}
	
	public List<SusbmaPolicyGroupUsbVO> selectSusbmaPolicyGrpUsbList(Integer grpId) throws Exception{
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("selectSusbmaPolicyGrpUsbList");
		sqlID.append(dbType);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("grpId", grpId);
		List<SusbmaPolicyGroupUsbVO> result = null;
		if(dbType.equals(Constants.DB_TYPE_ORACLE)){
			session.selectList(sqlID.toString(), params);
			result = (List<SusbmaPolicyGroupUsbVO>)params.get(Constants.PROC_ORACLE_KEY_RESULTSET);
		}else{
			result = session.selectList(sqlID.toString(),params);
		}
		
		return result;
	}

	public void insertSusbmaPolicyGrpUsb(SusbmaPolicyGroupUsbVO vo) throws Exception{
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("insertSusbmaPolicyGrpUsb");
		
		session.insert(sqlID.toString(), vo);
		
		//이미 추가한 usb일때
		String errorCode = vo.getErrorCode();
		if(errorCode != null){
			throw new DuplicatedRecordException(getExceptionMessage(errorCode));
		}
	}

	public void deleteSusbmaPolicyGrpUsb(String sno) throws Exception{
		String accountId = flexSessionUtils.getAccountId();
		
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("deleteSusbmaPolicyGrpUsb");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sno", sno);
		params.put("accountId",accountId);
		
		session.delete(sqlID.toString(), params);
	}

	@Override
	public void updateSusbmaPolicyGrpUsb(SusbmaPolicyGroupUsbVO vo) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSusbmaPolicyGrpUsb");
		
		session.update(sqlID.toString(), vo);
	}

	@Override
	public SusbmaCommonPolicyMasterVO selectSusbmaCommonPolicy() throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaCommonPolicy");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();

		SusbmaCommonPolicyMasterVO result = (SusbmaCommonPolicyMasterVO)session.selectOne(sqlId.toString(),params);
		return result;
	}

	@Override
	public void updateSusbmaCommonPolicy(SusbmaCommonPolicyMasterVO vo) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSusbmaCommonPolicy");
		
		session.update(sqlID.toString(), vo);
	}

	@Override
	public void updateSusbmaInitPassword(String initPassword) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSusbmaInitPassword");
		
		session.update(sqlID.toString(), initPassword);
		
	}

	@Override
	public List<SusbmaCommonPolicyMasterVO> selectPopupList(String accountId) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("selectPopupList");
		sqlID.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("accountId", accountId);
		
		List<SusbmaCommonPolicyMasterVO> result = session.selectList(sqlID.toString(),params);

		return result;
	}

	@Override
	public void updatePopupSelected(SusbmaCommonPolicyMasterVO vo) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updatePopupSelected");
		
		Map<String, Object> params = vo.properties();
		
		session.update(sqlID.toString(), params);
		
	}

	@Override
	public SusbmaCommonPolicyMasterVO selectSecureAdminInfo() throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSecureAdminInfo");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();

		SusbmaCommonPolicyMasterVO result = (SusbmaCommonPolicyMasterVO)session.selectOne(sqlId.toString(),params);
		return result;
	}

	@Override
	public void updateSecureAdminInfo(SusbmaCommonPolicyMasterVO vo) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSecureAdminInfo");
		
		Map<String, Object> params = vo.properties();
		
		session.update(sqlID.toString(), params);		
	}
}
