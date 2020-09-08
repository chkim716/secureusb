/**
 * 
 */
package com.saferzone.defcon4.susbma.usbmanage.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saferzone.defcon4.common.cmdclient.CmdClientTargetVO;
import com.saferzone.defcon4.common.commonui.vo.CommonUiSearchVO;
import com.saferzone.defcon4.common.commonui.vo.CommonUiUsbMasterVO;
import com.saferzone.defcon4.susbma.usbmanage.dao.ISusbmaUsbManageDAO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SearchSusbMasterVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbChangeHistoryVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbDeleteHistoryVO;
import com.saferzone.defcon4.susbma.usbmanage.vo.SusbUsbMasterVO;
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
@Service("SusbmaUsbManageService")
public class SusbmaUsbManageService {
	
	@Autowired
	private ISusbmaUsbManageDAO dao;
	
	/**
	 * <p>사용자에게 조회가 허용된 부서들 중, 화면에서 선택된 부서내에서 
	 *    Defcon에 등록된 USB 마스터정보 목록을 취득한다.</p>
	 * @param accountId	사용자ID
	 * @param orgId		화면에서 선택된 부서ID
	 * @return			USB 마스터 목록
	 * @throws Exception
	 */
	public List<SusbUsbMasterVO> selectSUsbMasterList(SearchSusbMasterVO vo, int isCountQuery) throws Exception{
		List<SusbUsbMasterVO> result = dao.selectSusbmaUsbMasterList(vo, isCountQuery);
		return result;
	}
	
	/**
	 * <p>사용자에게 조회가 허용된 부서들 중, 화면에서 선택된 부서내에서 
	 *    Defcon에 등록된 USB 마스터정보 목록을 취득한다.</p>
	 * @param accountId	사용자ID
	 * @param orgId		화면에서 선택된 부서ID
	 * @return			USB 마스터 목록
	 * @throws Exception
	 */
	public Integer selectSUsbMasterCount(SearchSusbMasterVO vo, int isCountQuery) throws Exception{
		Integer result = dao.selectSUsbMasterCount(vo, isCountQuery);
		return result;
	}
	
	/**
	 * <p>
	 * USB의 사용시점의 Agent정보 및 PC정보를 이력으로 저장한다.<br/>
	 * Agent와 통신하는 서버에 의해 호출된다.<br/>
	 * </p>
	 * @param assetId
	 * @param histVO
	 * @param histNicList
	 * @throws Exception
	 */
//	public void tranInsertSUsbUseHistory(String assetId,SusbUseHistoryVO histVO, List<SusbUseHistoryNicVO> histNicList) throws Exception{
//		Integer useHistoryId = dao.insertSusbmaUsbHistory(assetId, histVO);
//		if(useHistoryId.intValue() > 0){
//			for(SusbUseHistoryNicVO nicVO : histNicList){
//				nicVO.setUseHistoryId(useHistoryId);
//				dao.insertSusbmaUsbHistoryNic(nicVO);	
//			}
//		}
//	}
	
	/**
	 * 등급목록을 리턴한다
	 * @param localeCode
	 * @return
	 * @throws Exception
	 */
	public List<SusbmaClassVO> selectSusbmaClassList(Integer localeCode) throws Exception{
		List<SusbmaClassVO> result = dao.selectSusbmaClassList(localeCode);
		return result;
	}
	
	/**
	 * 
	 * @param localeCode
	 * @return
	 * @throws Exception
	 */
	public List<SusbmaStateVO> selectSusbmaStateList(Integer localeCode) throws Exception{
		List<SusbmaStateVO> result = dao.selectSusbmaStateList(localeCode);
		return result;
	}
	
	/**
	 * 상태목록을 리턴한다
	 * @param localeCode
	 * @return
	 * @throws Exception
	 */
	public List<SusbmaMediaVO> selectSusbmaMediaList(Integer localeCode) throws Exception{
		List<SusbmaMediaVO> result = dao.selectSusbmaMediaList(localeCode);
		return result;
	}
	
	/**
	 * 변경사유목록을 리턴한다
	 * @param localeCode
	 * @return
	 * @throws Exception
	 */
	public List<SusbmaReasonVO> selectSusbmaReasonList(Integer localeCode) throws Exception{
		List<SusbmaReasonVO> result = dao.selectSusbmaReasonList(localeCode);
		return result;
	}
	
	/**
	 * usbMaster 를 등록한다
	 * @param vo
	 * @throws Exception
	 */
	public void insertUsubmaMaster(SusbUsbMasterVO vo) throws Exception{
		// CD만 자동 생성
		if(vo.getMediaType() == 3){
			vo.setSno(UUID.randomUUID().toString().replace("-", "").toUpperCase());
		}
		dao.insertUsubmaMaster(vo);
	}
	
	/**
	 * usbMaster 를 수정한다
	 * @param vo
	 * @throws Exception
	 */
	public void updateSusbMaster(SusbChangeHistoryVO vo) throws Exception {
		dao.updateSusbMaster(vo);
	}
	
	/**
	 * usbMaster - MngEmpId만 일괄변경
	 * @param vo
	 */
	public void updateMngEmpId(SusbUsbMasterVO vo) throws Exception {
		dao.updateMngEmpId(vo);
	}
	
	/**
	 * usbMaster를 삭제한다
	 * @param sno
	 * @throws Exception
	 */
	public void tranDeleteSusbmaMaster(List<SusbUsbMasterVO> list) throws Exception{
		for(SusbUsbMasterVO vo : list){
			dao.deleteSusbmaMaster(vo.getSno());
		}
	}
	
	/**
	 * 사용이력목록을 리턴한다
	 * @param sno
	 * @return
	 * @throws Exception
	 */
	public List<SusbUseHistoryVO> selectSusbmaUseList(String sno) throws Exception{
		List<SusbUseHistoryVO> result = dao.selectSusbmaUseList(sno);
		return result;
	}
	
	/**
	 * 변경이력목록을 리턴한다
	 * @param sno
	 * @param localeCode
	 * @return
	 * @throws Exception
	 */
	public List<SusbChangeHistoryVO> selectSusbmaChangeList(String sno, Integer localeCode) throws Exception{
		List<SusbChangeHistoryVO> result = dao.selectSusbmaChangeList(sno, localeCode);
		return result;
	}

	/**
	 * USB를 반납합니다.
	 * @param SusbUsbMasterVO
	 * @return 
	 * @throws Exception
	 */
	public void returnSusbmaMaster(SusbUsbMasterVO vo) throws Exception{
		dao.returnSusbmaMaster(vo);
	}
	
	public int getGroupType(String accountId) throws Exception{
		return dao.getGroupType(accountId);
	}

	public List<SusbDeleteHistoryVO> selectSusbmaDeleteList(String sno, int localeCode) throws Exception {
		return dao.selectSusbmaDeleteList(sno, localeCode);
	}

	public List<SusbUsbMasterVO> selectMassRegisterForm(SearchSusbMasterVO paramVo) throws Exception {
		return dao.selectMassRegisterForm(paramVo);
	}
	
	public void insertMassRegister(SusbUsbMasterVO vo) throws Exception {
		dao.insertMassRegister(vo);
	}

	public SusbUsbMasterVO insertMassRegisterFormCheck(SusbUsbMasterVO vo) throws Exception {
		return dao.insertMassRegisterFormCheck(vo);
	}

	public List<SusbDeleteHistoryVO> selectSusbmaStatusList(String sno, int localeCode, String startDate, String endDate) throws Exception {
		return dao.selectSusbmaStatusList(sno, localeCode, startDate, endDate);
	}
	
	public List<SusbDeleteHistoryVO> selectSusbmafileDeleteList(String sno, int localeCode, String startDate, String endDate) throws Exception {
		return dao.selectSusbmafileDeleteList(sno, localeCode, startDate, endDate);
	}
	
	public List<SusbUsbMasterVO> selectSusbmaUpdateList(String sno) throws Exception{
		return dao.selectSusbmaUpdateList(sno);
	}

	public int selectIsDeptType(String sno) throws Exception{
		return dao.selectIsDeptType(sno);
	}
	
	public List<SusbUsbMasterVO> selectSusbmaOrgList(String sno) throws Exception{
		List<SusbUsbMasterVO> result = dao.selectSusbmaOrgList(sno);
		return result;
	}
	
	public List<CommonUiUsbMasterVO> selectUsbList(CommonUiSearchVO vo) throws Exception{
		return dao.selectUsbList(vo);
	}
	
	public String initPasswordResult(String sno) throws Exception{
		return dao.initPasswordResult(sno);
	}
	
	public void updatePasswordInit(String sno) throws Exception{
		dao.updatePasswordInit(sno);
	}
	
	public List<CmdClientTargetVO> selectUsbTargetList(String sno) throws Exception{
		return dao.selectUsbTargetList(sno);
	}
	
}
