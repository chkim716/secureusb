package com.saferzone.defcon4.susbma.policycommon.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.ISZPopupResponder;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.susbma.policycommon.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policycommon.view.comp.AlertChoicePopup;
	import com.saferzone.defcon4.susbma.policycommon.view.comp.PasswordInitializePopup;
	import com.saferzone.defcon4.susbma.policycommon.view.comp.SecureAdminInfoPopup;
	import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator  implements ISZPopupResponder
	{
		public static const NAME:String = 'ApplicationMediator';
		
		public var _popupList:ArrayCollection;
		public var _secureAdmin:SusbmaPolicyCommonMasterVO;
		public var _pwdObj1:Object;
		public var _pwdObj2:Object;
		
		public function ApplicationMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		public function get myWindow():D4_SUSBMA_POLICY_COMMON
		{
			return viewComponent as D4_SUSBMA_POLICY_COMMON;
		}
		
		protected function onBtnClickHandler(event:MouseEvent):void
		{
			switch(event.currentTarget.id)
			{
				
				case "saveBtn":
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_SAVE_COMMON_POLICY"),
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY_COMMON"), 
						Alert.OK | Alert.CANCEL, myWindow as Sprite, commonPolicy_saveHandler, null, Alert.OK);
					
					break;	
					
				}
					
				case "reloadBtn":
				{
					sendNotification(LocalConst.SUSBMA_COMMON_POLICY_LOAD);
					break;
				}
					
				case "returnApprovalPasswordInit":
				{
					
					var passwordInitializePopup:PasswordInitializePopup = PopUpManager.createPopUp(myWindow, PasswordInitializePopup, true) as PasswordInitializePopup;
					PopUpManager.centerPopUp(passwordInitializePopup);
					
					var passwordInitializeMediator:PasswordInitializeMediator = new PasswordInitializeMediator(passwordInitializePopup);
					passwordInitializePopup.passwordInput.text =  myWindow.returnApprovalPassword.text;
					passwordInitializePopup.title = DmosFramework.getInstance().SNL('SC_RETURN_APPROVAL_INIT_PASSWORD_SETTING');
					passwordInitializeMediator.popupType = 0;
					passwordInitializeMediator.setPopupResponder(this, "PASSWORDINIT");
					
					facade.registerMediator(passwordInitializeMediator);
					
					break;
				}
					
				case "popupUseChoice":
				{
					var alertChoicePopup:AlertChoicePopup = PopUpManager.createPopUp(myWindow, AlertChoicePopup, true) as AlertChoicePopup;
					PopUpManager.centerPopUp(alertChoicePopup);
					
					var alertChoicePopupMediator:AlertChoicePopupMediator = new AlertChoicePopupMediator(alertChoicePopup);
					alertChoicePopupMediator.setPopupResponder(this, "POPUPCHOICE");
					alertChoicePopupMediator.data(_popupList);
					facade.registerMediator(alertChoicePopupMediator);
					break;
				}
					
				case "secureAdminInfo":
				{
					var secureAdminInfoPopup:SecureAdminInfoPopup = PopUpManager.createPopUp(myWindow, SecureAdminInfoPopup, true) as SecureAdminInfoPopup;
					PopUpManager.centerPopUp(secureAdminInfoPopup);
					
					var secureAdminInfoPopupMediator:SecureAdminInfoPopupMediator = new SecureAdminInfoPopupMediator(secureAdminInfoPopup);
					secureAdminInfoPopup.secureAdminName.text = _secureAdmin.secureAdminName;
					secureAdminInfoPopup.secureAdminDept.text = _secureAdmin.secureAdminDept;
					secureAdminInfoPopup.secureAdminTel.text = _secureAdmin.secureAdminTel;
					secureAdminInfoPopup.secureAdminMail.text = _secureAdmin.secureAdminMail;
					
					secureAdminInfoPopupMediator.setPopupResponder(this, "SECUREADMININFO");
					
					facade.registerMediator(secureAdminInfoPopupMediator);
					break;
				}
					
				case "reqReturnPwdInitDefaultBtn":
				{
					
					var passwordInitializePopup:PasswordInitializePopup = PopUpManager.createPopUp(myWindow, PasswordInitializePopup, true) as PasswordInitializePopup;
					PopUpManager.centerPopUp(passwordInitializePopup);
					
					var passwordInitializeMediator:PasswordInitializeMediator = new PasswordInitializeMediator(passwordInitializePopup);
					passwordInitializePopup.passwordInput.text =  myWindow.reqReturnPwdInitDefault.text;
					passwordInitializePopup.title = DmosFramework.getInstance().SNL('SC_RETURN_REQUEST_INIT_PASSWORD_SETTING');
					passwordInitializeMediator.popupType = 1;
					passwordInitializeMediator.setPopupResponder(this, "PASSWORDINIT");
					
					facade.registerMediator(passwordInitializeMediator);
					
					break;
				}
					
					
				default:
					break;
			}
		}
		
		
		protected function commonPolicy_saveHandler(event:CloseEvent):void
		{
			if(event.detail == Alert.OK)
			{
				if(myWindow.popupDuration.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT03"), 
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY_COMMON"));
//					myWindow.popupDuration.setFocus();
				}
				else if(myWindow.registerPeriodBeforeEndPopup.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT04"), 
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY_COMMON"));
					myWindow.registerPeriodBeforeEndPopup.setFocus();
				}
				else if(myWindow.carryoutPeriodBeforeEndPopup.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT05"), 
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY_COMMON"));
					myWindow.carryoutPeriodBeforeEndPopup.setFocus();
				}
				/*
				else if(myWindow.unUseTime.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT06"), 
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY_COMMON"));
					myWindow.unUseTime.setFocus();
				}*/
				else if(myWindow.registerRequestDefaultTime.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT01"), 
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY_COMMON"));
					myWindow.registerRequestDefaultTime.setFocus();
				}
				else if(myWindow.carryoutRequestDefaultTime.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT02"), 
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY_COMMON"));
					myWindow.carryoutRequestDefaultTime.setFocus();
				}
				else
				{
					var commonPolicyVo:SusbmaPolicyCommonMasterVO  = getCommonPolicyValue();
					var secureAdmin:SusbmaPolicyCommonMasterVO = _secureAdmin;
					
					var obj:Object = new Object();
					obj.POLICY = commonPolicyVo;
					obj.POPUP = _popupList;
					obj.ADMIN = _secureAdmin;
					obj.PWD1 = _pwdObj1;
					obj.PWD2 = _pwdObj2;
					
					facade.sendNotification(LocalConst.SUSBMA_COMMON_POLICY_SAVE, obj);	
				}
			}
		}
		
		protected function alertLogOutTimeDataSet():void
		{
			var returnArr:ArrayCollection = new ArrayCollection();
			
			if(myWindow.alertLogOutTimeType.selectedIndex == 0) 
			{
				for(var i=0; i < 60; i++) {
					if(i%10 == 0 ){
						returnArr.addItem({label:i, value:i});
					}
				}
			}else
			{
				for(var i=0; i < 24; i++) { returnArr.addItem({label:i, value:i}); }
			}
			
			myWindow.alertTimeArr = returnArr;
			myWindow.alertLogOutTime.selectedIndex = 0;
		}		
		
		protected function emergencyToolApplyTimeDataSet():void
		{
			var returnArr:ArrayCollection = new ArrayCollection();
			
			if(myWindow.emergencyToolApplyTimeType.selectedIndex == 0) 
			{
				for(var i=0; i < 60; i++) {
					if(i%10 == 0 ){
						returnArr.addItem({label:i, value:i});
					}
				}
			}else
			{
				for(var i=0; i < 24; i++) { returnArr.addItem({label:i, value:i}); }
			}
			
			myWindow.emergencyToolApplyTimeArr = returnArr;
			myWindow.emergencyToolApplyTime.selectedIndex = 0;
		}		
		
		protected function approvalReadyTimeDataSet():void
		{
			var returnArr:ArrayCollection = new ArrayCollection();
			
			if(myWindow.approvalReadyTimeType.selectedIndex == 0) 
			{
				for(var i=0; i < 60; i++) {
					if(i%10 == 0 ){
						returnArr.addItem({label:i, value:i});
					}
				}
			}else if(myWindow.approvalReadyTimeType.selectedIndex == 1)
			{
				for(var i=0; i < 24; i++) { returnArr.addItem({label:i, value:i}); }
			}else
			{
				for(var i=0; i < 31; i++) { returnArr.addItem({label:i, value:i}); }
			}
			
			myWindow.approvalReadyTimeArr = returnArr;
			myWindow.approvalReadyTime.selectedIndex = 0;
			
		}		
		
		private function getCommonPolicyValue():SusbmaPolicyCommonMasterVO
		{
			var commonPolicyVo:SusbmaPolicyCommonMasterVO = new SusbmaPolicyCommonMasterVO();
			
			commonPolicyVo.usbRegisterAutoApproval = int(myWindow.usbRegisterAutoApproval.selected);
			commonPolicyVo.approvalSendMail = int(myWindow.approvalSendMail.selected);
			
			commonPolicyVo.approvalReadyTime = int(myWindow.approvalReadyTime.selectedItem.value);
			commonPolicyVo.approvalReadyTimeType = int(myWindow.approvalReadyTimeType.selectedItem.value);
			commonPolicyVo.registerRequestDefaultTime = myWindow.registerRequestDefaultTime.text.length==0?0:int(myWindow.registerRequestDefaultTime.text);
			commonPolicyVo.carryoutRequestDefaultTime = myWindow.carryoutRequestDefaultTime.text.length==0?0:int(myWindow.carryoutRequestDefaultTime.text);
			commonPolicyVo.carryoutRequestIpUse = int(myWindow.carryoutRequestIpUse.selected);
			commonPolicyVo.carryoutRequestMacUse = int(myWindow.carryoutRequestMacUse.selected);
			commonPolicyVo.carryoutRequestOnOffUse = int(myWindow.carryoutRequestOnOffUse.selected);
//			commonPolicyVo.carryoutInsideUse = int(myWindow.carryoutInsideUse.selected);
			
			commonPolicyVo.popupDuration = myWindow.popupDuration.text.length==0?0:int(myWindow.popupDuration.text);
			commonPolicyVo.registerPeriodBeforeEndPopup = myWindow.registerPeriodBeforeEndPopup.text.length==0?0:int(myWindow.registerPeriodBeforeEndPopup.text);
			commonPolicyVo.carryoutPeriodBeforeEndPopup = myWindow.carryoutPeriodBeforeEndPopup.text.length==0?0:int(myWindow.carryoutPeriodBeforeEndPopup.text);
			commonPolicyVo.unRegisterSecureUsbRegisterGuide = int(myWindow.unRegisterSecureUsbRegisterGuide.selected);
			
			commonPolicyVo.unUseTime = int(myWindow.unUseTime.text);
//myWindow.unUseTime.text.length==0?0:int(myWindow.unUseTime.text);
			
			if(myWindow.completeErase.selected){
				commonPolicyVo.secureUsbDataDeleteType = 1;
			}else{
				commonPolicyVo.secureUsbDataDeleteType = 0;
			}
			if(myWindow.fileUnitCompleteDeleteMenuYES.selected){
				commonPolicyVo.fileUnitCompleteDeleteMenu = 1;
			}else{
				commonPolicyVo.fileUnitCompleteDeleteMenu = 0;
			}
			
			commonPolicyVo.alertLogOutTime = int(myWindow.alertLogOutTime.selectedItem.value);
			commonPolicyVo.alertLogOutTimeType = int(myWindow.alertLogOutTimeType.selectedItem.value);
			
			commonPolicyVo.emergencyToolApplyTime = int(myWindow.emergencyToolApplyTime.selectedItem.value);
			commonPolicyVo.emergencyToolApplyTimeType = int(myWindow.emergencyToolApplyTimeType.selectedItem.value);
			
			commonPolicyVo.registerRequestPeriodType = int(myWindow.registerRequestPeriodType.selectedItem.value);
			
			commonPolicyVo.carryoutOriginalFileSave = int(myWindow.carryoutOriginalFileSave.selected);
			commonPolicyVo.normalUsbRegistDeny = int(myWindow.normalUsbRegistDeny.selected);
			commonPolicyVo.trayIconPasswordInit = int(myWindow.trayIconPasswordInit.selected);
			commonPolicyVo.userDeleteAutoCarryIn = int(myWindow.userDeleteAutoCarryIn.selectedItem.value);
			commonPolicyVo.userModifyAutoCarryIn = int(myWindow.userModifyAutoCarryIn.selectedItem.value);
			commonPolicyVo.userModifyAutoMngCode = int(myWindow.userModifyAutoMngCode.selected);
			
			commonPolicyVo.reqReturnPwdInit = int(myWindow.reqReturnPwdInit.selectedItem.value);
			commonPolicyVo.reqReturnDataDel = int(myWindow.reqReturnDataDel.selectedItem.value);
			
			commonPolicyVo.reqReturnDataDel = int(myWindow.reqReturnDataDel.selectedItem.value);
			commonPolicyVo.reqReturnDataDel = int(myWindow.reqReturnDataDel.selectedItem.value);
			
			
			commonPolicyVo.passwordInitDataDelete = int(myWindow.passwordInitDataDelete.selectedItem.value);
			commonPolicyVo.usbPermOutUseLimit = int(myWindow.usbPermOutUseLimit.selectedItem.value);
			commonPolicyVo.usbTakeOutUseDeny = int(myWindow.usbTakeOutUseDeny.selected);
			
			commonPolicyVo.trayApprovalRequest = int(myWindow.trayApprovalRequest.selected);
			commonPolicyVo.trayApprovalConfirm = int(myWindow.trayApprovalConfirm.selected);
			commonPolicyVo.trayApprovalExplorer = int(myWindow.trayApprovalExplorer.selected);
			commonPolicyVo.trayApprovalEmergency = int(myWindow.trayApprovalEmergency.selected);
			commonPolicyVo.trayPasswdManagement = int(myWindow.trayPasswdManagement.selected);
			commonPolicyVo.trayPolicyInfo = int(myWindow.trayPolicyInfo.selected);
			commonPolicyVo.trayDefaultInfo = int(myWindow.trayDefaultInfo.selected);
			commonPolicyVo.trayNFCRegist = int(myWindow.trayNFCRegist.selected);
			commonPolicyVo.traySafeRemove = int(myWindow.traySafeRemove.selected);
			commonPolicyVo.trayAntiForensic = int(myWindow.trayAntiForensic.selected);
			commonPolicyVo.isUsbDeptPermission = int(myWindow.isDeptTypeUsb.selected);
			commonPolicyVo.secureUSBReadLogSave = int(myWindow.secureUSBReadLogSave.selected)
			return commonPolicyVo;
		}
		
		private function setCommonPolicyValue(object:Object):void
		{
			var commonPolicyVo:SusbmaPolicyCommonMasterVO = object.POLICY as SusbmaPolicyCommonMasterVO;
			_popupList = object.POPUP as ArrayCollection;
			_secureAdmin = object.ADMIN as SusbmaPolicyCommonMasterVO;
			var pwd1:Object = new Object();
			pwd1.initPassword = commonPolicyVo.returnApprovalPasswordInit;
			pwd1.popupType = 0;
			_pwdObj1 = pwd1;
				
			var pwd2:Object = new Object();
			pwd2.initPassword = commonPolicyVo.reqReturnPwdInitDefault;
			pwd2.popupType = 1;
			_pwdObj2 = pwd2;
				
			myWindow.usbRegisterAutoApproval.selected = Boolean(commonPolicyVo.usbRegisterAutoApproval);
			myWindow.approvalSendMail.selected = Boolean(commonPolicyVo.approvalSendMail);
			myWindow.approvalReadyTimeType.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.approvalReadyTimeType), ArrayCollection(myWindow.approvalReadyTimeType.dataProvider), "value");
			approvalReadyTimeDataSet();
			myWindow.approvalReadyTime.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.approvalReadyTime), ArrayCollection(myWindow.approvalReadyTime.dataProvider), "value");
			myWindow.registerRequestDefaultTime.text = String(commonPolicyVo.registerRequestDefaultTime);
			myWindow.carryoutRequestDefaultTime.text = String(commonPolicyVo.carryoutRequestDefaultTime);
			myWindow.carryoutRequestIpUse.selected = Boolean(commonPolicyVo.carryoutRequestIpUse);
			myWindow.carryoutRequestMacUse.selected = Boolean(commonPolicyVo.carryoutRequestMacUse);
			myWindow.carryoutRequestOnOffUse.selected = Boolean(commonPolicyVo.carryoutRequestOnOffUse);
//			myWindow.carryoutInsideUse.selected = Boolean(commonPolicyVo.carryoutInsideUse);
			myWindow.returnApprovalPassword.text = commonPolicyVo.returnApprovalPasswordInit;
			
			myWindow.popupDuration.text = String(commonPolicyVo.popupDuration);
			myWindow.registerPeriodBeforeEndPopup.text = String(commonPolicyVo.registerPeriodBeforeEndPopup);
			myWindow.carryoutPeriodBeforeEndPopup.text = String(commonPolicyVo.carryoutPeriodBeforeEndPopup);
			myWindow.unRegisterSecureUsbRegisterGuide.selected = Boolean(commonPolicyVo.unRegisterSecureUsbRegisterGuide);
			
			myWindow.unUseTime.text = String(commonPolicyVo.unUseTime);
			
			if(commonPolicyVo.secureUsbDataDeleteType == 1){
				myWindow.completeErase.selected = true;
			}else{
				myWindow.normalErase.selected = true;
			}
			if(commonPolicyVo.fileUnitCompleteDeleteMenu == 0){
				myWindow.fileUnitCompleteDeleteMenuNo.selected = true;
			}else{
				myWindow.fileUnitCompleteDeleteMenuYES.selected = true;
			}
			
			myWindow.emergencyToolApplyTimeType.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.emergencyToolApplyTimeType), ArrayCollection(myWindow.emergencyToolApplyTimeType.dataProvider), "value");
			emergencyToolApplyTimeDataSet();
			myWindow.emergencyToolApplyTime.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.emergencyToolApplyTime), ArrayCollection(myWindow.emergencyToolApplyTime.dataProvider), "value");
			
			myWindow.alertLogOutTimeType.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.alertLogOutTimeType), ArrayCollection(myWindow.alertLogOutTimeType.dataProvider), "value");
			alertLogOutTimeDataSet();
			myWindow.alertLogOutTime.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.alertLogOutTime), ArrayCollection(myWindow.alertLogOutTime.dataProvider), "value");
			
			
			myWindow.registerRequestPeriodType.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.registerRequestPeriodType), ArrayCollection(myWindow.registerRequestPeriodType.dataProvider), "value");
			
			myWindow.carryoutOriginalFileSave.selected = Boolean(commonPolicyVo.carryoutOriginalFileSave);
			myWindow.normalUsbRegistDeny.selected = Boolean(commonPolicyVo.normalUsbRegistDeny);
			myWindow.usbRegisterAutoApproval.selected = Boolean(commonPolicyVo.usbRegisterAutoApproval);
			myWindow.trayIconPasswordInit.selected = Boolean(commonPolicyVo.trayIconPasswordInit);
			
			myWindow.userDeleteAutoCarryIn.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.userDeleteAutoCarryIn), ArrayCollection(myWindow.userDeleteAutoCarryIn.dataProvider), "value");
			myWindow.userModifyAutoCarryIn.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.userModifyAutoCarryIn), ArrayCollection(myWindow.userModifyAutoCarryIn.dataProvider), "value");
			myWindow.userModifyAutoMngCode.selected = Boolean(commonPolicyVo.userModifyAutoMngCode);
			
			myWindow.reqReturnPwdInit.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.reqReturnPwdInit), ArrayCollection(myWindow.reqReturnPwdInit.dataProvider), "value");
			myWindow.reqReturnDataDel.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.reqReturnDataDel), ArrayCollection(myWindow.reqReturnDataDel.dataProvider), "value");
			myWindow.reqReturnPwdInitDefault.text = commonPolicyVo.reqReturnPwdInitDefault;
			
			myWindow.passwordInitDataDelete.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.passwordInitDataDelete), ArrayCollection(myWindow.passwordInitDataDelete.dataProvider), "value");
			myWindow.usbPermOutUseLimit.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.usbPermOutUseLimit), ArrayCollection(myWindow.usbPermOutUseLimit.dataProvider), "value");
			myWindow.usbTakeOutUseDeny.selected = Boolean(commonPolicyVo.usbTakeOutUseDeny);
			
			myWindow.trayApprovalRequest.selected = Boolean(commonPolicyVo.trayApprovalRequest);
			myWindow.trayApprovalConfirm.selected = Boolean(commonPolicyVo.trayApprovalConfirm);
			myWindow.trayApprovalExplorer.selected = Boolean(commonPolicyVo.trayApprovalExplorer);
			myWindow.trayApprovalEmergency.selected = Boolean(commonPolicyVo.trayApprovalEmergency);
			myWindow.trayPasswdManagement.selected = Boolean(commonPolicyVo.trayPasswdManagement);
			myWindow.trayPolicyInfo.selected = Boolean(commonPolicyVo.trayPolicyInfo);
			myWindow.trayDefaultInfo.selected = Boolean(commonPolicyVo.trayDefaultInfo);
			myWindow.trayNFCRegist.selected = Boolean(commonPolicyVo.trayNFCRegist);
			myWindow.traySafeRemove.selected = Boolean(commonPolicyVo.traySafeRemove);
			myWindow.trayAntiForensic.selected = Boolean(commonPolicyVo.trayAntiForensic);
			myWindow.isDeptTypeUsb.selected = Boolean(commonPolicyVo.isUsbDeptPermission);
			myWindow.secureUSBReadLogSave.selected = Boolean(commonPolicyVo.secureUSBReadLogSave);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.SUSBMA_COMMON_POLICY_SAVESUCCESS,
				LocalConst.SUSBMA_COMMON_POLICY_LOADSUCCESS,
				
				LocalConst.SUSBMA_COMMON_POLICY_SAVEFAIL,
				LocalConst.SUSBMA_COMMON_POLICY_LOADFAIL
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LocalConst.SUSBMA_COMMON_POLICY_SAVESUCCESS:
				{
					sendNotification(LocalConst.SUSBMA_COMMON_POLICY_LOAD);
					
					Alert.show(DmosFramework.getInstance().SNL("SC_SAVE_COMMON_POLICY"),
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY_COMMON"),
						Alert.OK);
					break;
				}
					
				case LocalConst.SUSBMA_COMMON_POLICY_LOADSUCCESS:
				{
					setCommonPolicyValue(notification.getBody() as Object);
					break;
				}
					
				case LocalConst.SUSBMA_COMMON_POLICY_SAVEFAIL:
				case LocalConst.SUSBMA_COMMON_POLICY_LOADFAIL:
				{
					break;
				}
					
			}
		}
		
		public function popupOnOk(popup:Object, context:Object, extra:Object):void
		{
			switch(context.toString())
			{
				case "PASSWORDINIT":
				{
					var obj:Object = extra as Object;
					
					if( int(obj.popupType) == 0 )
					{
						myWindow.returnApprovalPassword.text = String(obj.initPassword);
						_pwdObj1 = obj;
					}
					else
					{
						myWindow.reqReturnPwdInitDefault.text = String(obj.initPassword);
						_pwdObj2 = obj;
					}
					break;
				}
					
				case "POPUPCHOICE":
				{
					var popupList:ArrayCollection = extra.popupList as ArrayCollection;
					
					if( popupList.length > 0 )
					{
						_popupList.removeAll();
						
						for( var i:int = 0 ; i < popupList.length ; i++ )
						{
							var tempVO:SusbmaPolicyCommonMasterVO = new SusbmaPolicyCommonMasterVO();
							tempVO.checked = popupList.getItemAt(i).checked;
							tempVO.popupId = popupList.getItemAt(i).popupId;
							tempVO.popupContent = popupList.getItemAt(i).popupContent;
							tempVO.popupContentDetail = popupList.getItemAt(i).popupContentDetail;
							tempVO.popupFix = popupList.getItemAt(i).popupFix;
			
							_popupList.addItemAt(tempVO, i);
						}
					}
					break;
				}
					
				case "SECUREADMININFO":
				{
					_secureAdmin = extra as SusbmaPolicyCommonMasterVO
					break;
				}
					
					
				default:
					break;
			}
		}

		public function popupOnCancel(popup:Object, context:Object, extra:Object):void
		{
		}
		
		override public function onRegister():void
		{
			myWindow.saveBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.returnApprovalPasswordInit.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.popupUseChoice.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.secureAdminInfo.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reqReturnPwdInitDefaultBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
		}
		
		override public function onRemove():void
		{
			myWindow.saveBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.returnApprovalPasswordInit.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.popupUseChoice.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.secureAdminInfo.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reqReturnPwdInitDefaultBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
		}
	}
}