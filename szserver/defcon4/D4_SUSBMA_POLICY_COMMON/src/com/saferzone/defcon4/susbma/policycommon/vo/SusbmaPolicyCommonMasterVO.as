package com.saferzone.defcon4.susbma.policycommon.vo
{
	import com.saferzone.defcon4.services.vo.Defcon4AbstractVO;
	
	[Bindable]
	[RemoteClass(alias = "com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO")]
	public class SusbmaPolicyCommonMasterVO extends Defcon4AbstractVO
	{		
		public var usbRegisterAutoApproval:int;
		
		public var approvalSendMail:int;
		
		public var approvalReadyTime:int;

		public var approvalReadyTimeType:int;
		
		public var registerRequestDefaultTime:int;
		
		public var carryoutRequestDefaultTime:int;
		
		public var carryoutRequestIpUse:int;
		
		public var carryoutRequestMacUse:int;
		
		public var carryoutRequestOnOffUse:int;
		
		public var returnApprovalPasswordInit:String;
		
		public var popupContentBit:String;
		
		public var popupFixTypeBit:String;
		
		public var popupId:int;
		
		public var popupContent:String;
		
		public var popupContentDetail:String;
		
		public var popupFix:int;
		
		public var checked:int;
		
		public var popupDuration:int;
		
		public var registerPeriodBeforeEndPopup:int;
		
		public var carryoutPeriodBeforeEndPopup:int;
		
		public var unRegisterSecureUsbRegisterGuide:int;
		
		public var unUseTime:int;
		
		public var secureUsbDataDeleteType:int;
		
		public var fileUnitCompleteDeleteMenu:int;
		
		public var emergencyToolApplyTime:int;
		
		public var emergencyToolApplyTimeType:int;
		
		public var carryoutInsideUse:int;
		
		public var accountId:String;
		
		public var secureAdminName:String;
		
		public var secureAdminDept:String;
		
		public var secureAdminTel:String;
		
		public var secureAdminMail:String;
		
		public var registerRequestPeriodType:int;
		
		public var carryoutOriginalFileSave:int;
		
		public var normalUsbRegistDeny:int;
		
		public var trayIconPasswordInit:int;
		
		public var userModifyAutoCarryIn:int;
		
		public var userDeleteAutoCarryIn:int;
		
		public var userModifyAutoMngCode:int;
		
		public var reqReturnPwdInit:int;
		
		public var reqReturnDataDel:int;
		
		public var reqReturnPwdInitDefault:String;
		
		public var passwordInitDataDelete:int;
		
		public var usbPermOutUseLimit:int;
		
		public var trayApprovalRequest:int;
		public var trayApprovalConfirm:int;
		public var trayApprovalExplorer:int;
		public var trayApprovalEmergency:int;
		public var trayPasswdManagement:int;
		public var trayPolicyInfo:int;
		public var trayDefaultInfo:int;
		// 자동 로그아웃 시간전 사용자알림
		public var alertLogOutTime:int;
		public var alertLogOutTimeType:int;
		public var trayNFCRegist:int;
		public var traySafeRemove:int;
		public var trayAntiForensic:int;
		public var usbTakeOutUseDeny:int;
		public var isUsbDeptPermission:int;
		public var secureUSBReadLogSave:int;
	}
}
