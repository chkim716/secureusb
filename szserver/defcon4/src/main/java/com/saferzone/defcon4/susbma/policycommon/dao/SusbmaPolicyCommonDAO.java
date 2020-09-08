package com.saferzone.defcon4.susbma.policycommon.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.saferzone.defcon4.base.abstracts.Defcon4AbstractDAO;
import com.saferzone.defcon4.common.cmdclient.CmdClientTargetVO;
import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;

@Repository("SusbmaPolicyCommonDAO")
public class SusbmaPolicyCommonDAO extends Defcon4AbstractDAO implements ISusbmaPolicyCommonDAO {

	private final String SQL_ID_PREFIX = "susbma.policy.susbmaPolicyCommon."; 
	
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
	public SusbmaPolicyCommonMasterVO selectSusbmaPolicyCommon() throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSusbmaPolicyCommon");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();

		SusbmaPolicyCommonMasterVO result = (SusbmaPolicyCommonMasterVO)session.selectOne(sqlId.toString(),params);
		return result;
	}
	
	@Override
	public List<SusbmaPolicyCommonMasterVO> selectPopupList(String accountId) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("selectPopupList");
		sqlID.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("accountId", accountId);
		
		List<SusbmaPolicyCommonMasterVO> result = session.selectList(sqlID.toString(),params);

		return result;
	}
	
	@Override
	public SusbmaPolicyCommonMasterVO selectSecureAdminInfo() throws Exception {
		StringBuilder sqlId = new StringBuilder();
		sqlId.append(SQL_ID_PREFIX);
		sqlId.append("selectSecureAdminInfo");
		sqlId.append(dbType);
		
		Map<String, Object> params = new HashMap<String, Object>();

		SusbmaPolicyCommonMasterVO result = (SusbmaPolicyCommonMasterVO)session.selectOne(sqlId.toString(),params);
		return result;
	}

	@Override
	public void updateSusbmaPolicyCommon(SusbmaPolicyCommonMasterVO vo) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSusbmaPolicyCommon");
		
		session.update(sqlID.toString(), vo);
	}

	@Override
	public void updatePopupSelected(SusbmaPolicyCommonMasterVO vo) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updatePopupSelected");
		
		Map<String, Object> params = vo.properties();
		
		session.update(sqlID.toString(), params);
		
	}
	
	@Override
	public void updateSecureAdminInfo(SusbmaPolicyCommonMasterVO vo) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSecureAdminInfo");
		
		Map<String, Object> params = vo.properties();
		
		session.update(sqlID.toString(), params);		
	}
	
	@Override
	public void updateSusbmaInitPassword(String initPassword, int popupType) throws Exception {
		StringBuilder sqlID = new StringBuilder();
		sqlID.append(SQL_ID_PREFIX);
		sqlID.append("updateSusbmaInitPassword");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("initPassword", initPassword);
		params.put("popupType", popupType);
		
		session.update(sqlID.toString(), params);
		
	}

}
