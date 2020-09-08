/**
 * 
 */
package com.saferzone.defcon4.susbma.usbmanage.dao;

import java.util.List;

import com.saferzone.defcon4.base.abstracts.IDefcon4DAO;
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
public interface ISusbmaUsbManageDAO extends IDefcon4DAO {
	/**
	 * <p>Defon4에 등록된 USB들 중에서 지정된 부서에 소속된 것들을 취득한다.</p>
	 * </pre>
	 * </p>
	 * @param accountId 조작자의 계정ID
	 * @param orgId		화면상의 조직트리에서 선택된 부서ID
	 * @return 조작자의 권한으로 화면상에서 선택된 부서에 소속된 USB목록
	 */
	public List<SusbUsbMasterVO> selectSusbmaUsbMasterList(SearchSusbMasterVO vo, int isCountQuery) throws Exception;
	
	/**
	 * <p>Defon4에 등록된 USB들 중에서 지정된 부서에 소속된 것들을 취득한다.</p>
	 * </pre>
	 * </p>
	 * @param accountId 조작자의 계정ID
	 * @param orgId		화면상의 조직트리에서 선택된 부서ID
	 * @return 조작자의 권한으로 화면상에서 선택된 부서에 소속된 USB목록
	 */
	public Integer selectSUsbMasterCount(SearchSusbMasterVO vo, int isCountQuery) throws Exception;
	
	/**
	 * <p>USB 의 사용에 따른 이력을 기록한다.</p>
	 * @param assetId	에이전트 ID
	 * @param history	USB사용이력정보
	 * @throws Exception
	 */
	public Integer insertSusbmaUsbHistory(String assetId,SusbUseHistoryVO history) throws Exception;
	
	/**
	 * <p>USB 가 사용된 PC의 랜카드 정보를 기록한다.</p>
	 * @param nicVO
	 * @throws Exception
	 */
	public void insertSusbmaUsbHistoryNic(SusbUseHistoryNicVO nicVO) throws Exception;
	
	/**
	 * 등급목록을 리턴한다
	 * @param localeCode
	 * @return
	 * @throws Exception
	 */
	public List<SusbmaClassVO> selectSusbmaClassList(Integer localeCode) throws Exception;
	
	/**
	 * 
	 * @param localeCode
	 * @return
	 * @throws Exception
	 */
	public List<SusbmaStateVO> selectSusbmaStateList(Integer localeCode) throws Exception;
	
	/**
	 * 상태목록을 리턴한다
	 * @param localeCode
	 * @return
	 * @throws Exception
	 */
	public List<SusbmaMediaVO> selectSusbmaMediaList(Integer localeCode) throws Exception;
	
	/**
	 * 변경사유목록을 리턴한다
	 * @param localeCode
	 * @return
	 * @throws Exception
	 */
	public List<SusbmaReasonVO> selectSusbmaReasonList(Integer localeCode) throws Exception;
	
	/**
	 * usbMaster 를 등록한다
	 * @param vo
	 * @throws Exception
	 */
	public void insertUsubmaMaster(SusbUsbMasterVO vo) throws Exception;
	
	/**
	 * usbMaster 를 수정한다
	 * @param vo
	 * @throws Exception
	 */
	public void updateSusbMaster(SusbChangeHistoryVO vo) throws Exception;
	

	
	/**
	 * usbMaster를 삭제한다
	 * @param sno
	 * @throws Exception
	 */
	public void deleteSusbmaMaster(String sno) throws Exception;
	
	/**
	 * 사용이력목록을 리턴한다
	 * @param sno
	 * @return
	 * @throws Exception
	 */
	public List<SusbUseHistoryVO> selectSusbmaUseList(String sno) throws Exception;
	
	/**
	 * 변경이력목록을 리턴한다
	 * @param sno
	 * @param localeCode
	 * @return
	 * @throws Exception
	 */
	public List<SusbChangeHistoryVO> selectSusbmaChangeList(String sno, Integer localeCode) throws Exception;
	
	/** 보조기억매체 - 일괄변경
	 * 	@param vo 보조기억매체정보
	 */
	public void updateMngEmpId(SusbUsbMasterVO vo) throws Exception;
	
	/**
	 * USB를 반납합니다.
	 * @param SusbUsbMasterVO
	 * @return 
	 * @throws Exception
	 */
	public void returnSusbmaMaster(SusbUsbMasterVO vo) throws Exception;
	
	public int getGroupType(String accountId) throws Exception;

	public List<SusbDeleteHistoryVO> selectSusbmaDeleteList(String sno, int localeCode) throws Exception;

	public List<SusbUsbMasterVO> selectMassRegisterForm(SearchSusbMasterVO paramVo) throws Exception;

	public void insertMassRegister(SusbUsbMasterVO vo) throws Exception;

	public SusbUsbMasterVO insertMassRegisterFormCheck(SusbUsbMasterVO vo)throws Exception;
	public List<SusbDeleteHistoryVO> selectSusbmaStatusList(String sno, int localeCode, String startDate, String endDate) throws Exception;
	public List<SusbDeleteHistoryVO> selectSusbmafileDeleteList(String sno, int localeCode, String startDate, String endDate) throws Exception;

	public List<SusbUsbMasterVO> selectSusbmaUpdateList(String sno) throws Exception;
	public List<SusbUsbMasterVO> selectSusbmaOrgList(String sno) throws Exception;
	public int selectIsDeptType(String sno) throws Exception;
	
	public List<CommonUiUsbMasterVO> selectUsbList(CommonUiSearchVO vo) throws Exception;
	
	public String initPasswordResult(String sno) throws Exception;
	
	public void updatePasswordInit(String sno) throws Exception;
	
	public List<CmdClientTargetVO> selectUsbTargetList(String sno) throws Exception;
}
