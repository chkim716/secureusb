package com.saferzone.defcon4.susbma.policy.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.ISZPopupResponder;
	import com.saferzone.defcon4.common.consts.CustomerId;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.services.vo.SusbmaCommonPolicyMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyRawVO;
	import com.saferzone.defcon4.susbma.policy.ApplicationFacade;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.view.comp.AlertChoicePopup;
	import com.saferzone.defcon4.susbma.policy.view.comp.PasswordInitializePopup;
	import com.saferzone.defcon4.susbma.policy.view.comp.SecureAdminInfoPopup;
	import com.saferzone.defcon4.susbma.policy.view.comp.SusbmaCommonPolicyOptionView;
	
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
	
	public class SusbmaCommonPolicyOptionMediator extends Mediator  implements ISZPopupResponder
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SusbmaCommonPolicyOptionMediator';
		
		public function SusbmaCommonPolicyOptionMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		public function get myWindow():SusbmaCommonPolicyOptionView
		{
			return viewComponent as SusbmaCommonPolicyOptionView;
		}
		
		/**
		 * 버튼클릭 Listener
		 */
		protected function onBtnClickHandler(event:MouseEvent):void
		{
			switch(event.currentTarget.id)
			{
					
				case "saveBtn":
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_SAVE_COMMON_POLICY"),
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY"), 
						Alert.OK | Alert.CANCEL, myWindow.parentApplication as Sprite, commonPolicy_saveHandler, null, Alert.OK);
					
					break;	
						
				}
					
				case "reloadBtn":
				{
					sendNotification(LocalConst.SUSBMA_COMMON_POLICY_LOAD);
					break;
				}
					
				case "returnApprovalPasswordInit":
				{
					
					var passwordInitializePopup:PasswordInitializePopup = PopUpManager.createPopUp(myWindow.parentApplication as DisplayObject,
																			PasswordInitializePopup,
																			true) as PasswordInitializePopup;
					PopUpManager.centerPopUp(passwordInitializePopup);
					
					var passwordInitializeMediator:PasswordInitializeMediator = new PasswordInitializeMediator(passwordInitializePopup);
					passwordInitializePopup.passwordInput.text =  myWindow.returnApprovalPassword.text;
					passwordInitializeMediator.setPopupResponder(this, "PASSWORDINIT");
					
					facade.registerMediator(passwordInitializeMediator);

					break;
				}
				
				case "popupUseChoice":
				{
					var alertChoicePopup:AlertChoicePopup = PopUpManager.createPopUp(myWindow.parentApplication as DisplayObject,
						AlertChoicePopup,
						true) as AlertChoicePopup;
					PopUpManager.centerPopUp(alertChoicePopup);
					
					var alertChoicePopupMediator:AlertChoicePopupMediator = new AlertChoicePopupMediator(alertChoicePopup);
					alertChoicePopupMediator.setPopupResponder(this, "POPUPCHOICE");
					
					facade.registerMediator(alertChoicePopupMediator);
					break;
				}
					
				case "secureAdminInfo":
				{
					var secureAdminInfoPopup:SecureAdminInfoPopup = PopUpManager.createPopUp(myWindow.parentApplication as DisplayObject,
						SecureAdminInfoPopup,
						true) as SecureAdminInfoPopup;
					PopUpManager.centerPopUp(secureAdminInfoPopup);
					
					var secureAdminInfoPopupMediator:SecureAdminInfoPopupMediator = new SecureAdminInfoPopupMediator(secureAdminInfoPopup);
					secureAdminInfoPopupMediator.setPopupResponder(this, "SECUREADMININFO");
					
					facade.registerMediator(secureAdminInfoPopupMediator);
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
				if(myWindow.registerRequestDefaultTime.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT01"), 
					DmosFramework.getInstance().SNL("SC_COMMON_POLICY"));
					myWindow.registerRequestDefaultTime.setFocus();
					return;
				}
				
				if(myWindow.carryoutRequestDefaultTime.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT02"), 
						DmosFramework.getInstance().SNL("SC_COMMON_POLICY"));
					myWindow.carryoutRequestDefaultTime.setFocus();
					return;
				}
				
				if(myWindow.popupDuration.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT03"), 
						DmosFramework.getInstance().SNL("SC_COMMON_POLICY"));
					myWindow.popupDuration.setFocus();
					return;
				}
				
				if(myWindow.registerPeriodBeforeEndPopup.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT04"), 
						DmosFramework.getInstance().SNL("SC_COMMON_POLICY"));
					myWindow.registerPeriodBeforeEndPopup.setFocus();
					return;
				}
				
				if(myWindow.carryoutPeriodBeforeEndPopup.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT05"), 
						DmosFramework.getInstance().SNL("SC_COMMON_POLICY"));
					myWindow.carryoutPeriodBeforeEndPopup.setFocus();
					return;
				}
				
				if(myWindow.unUseTime.text == "0")
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_COMMON_POLICY_ALERT06"), 
						DmosFramework.getInstance().SNL("SC_COMMON_POLICY"));
					myWindow.unUseTime.setFocus();
					return;
				}
				
				var commonPolicyVo:SusbmaCommonPolicyMasterVO  = getCommonPolicyValue();
				facade.sendNotification(LocalConst.SUSBMA_COMMON_POLICY_SAVE, commonPolicyVo);
			}
		}
		private function getCommonPolicyValue():SusbmaCommonPolicyMasterVO
		{
			var commonPolicyVo:SusbmaCommonPolicyMasterVO = new SusbmaCommonPolicyMasterVO();
			
			commonPolicyVo.usbRegisterAutoApproval = int(myWindow.usbRegisterAutoApproval.selected);
			commonPolicyVo.approvalSendMail = int(myWindow.approvalSendMail.selected);
			commonPolicyVo.approvalReadyTime = int(myWindow.approvalReadyTime.selectedItem.value);
			commonPolicyVo.approvalReadyTimeType = int(myWindow.approvalReadyTimeType.selectedItem.value);
			commonPolicyVo.registerRequestDefaultTime = myWindow.registerRequestDefaultTime.text.length==0?0:int(myWindow.registerRequestDefaultTime.text);
			commonPolicyVo.carryoutRequestDefaultTime = myWindow.carryoutRequestDefaultTime.text.length==0?0:int(myWindow.carryoutRequestDefaultTime.text);
			commonPolicyVo.carryoutRequestIpUse = int(myWindow.carryoutRequestIpUse.selected);
			commonPolicyVo.carryoutRequestMacUse = int(myWindow.carryoutRequestMacUse.selected);
			commonPolicyVo.carryoutRequestOnOffUse = int(myWindow.carryoutRequestOnOffUse.selected);
			commonPolicyVo.carryoutInsideUse = int(myWindow.carryoutInsideUse.selected);
			
			commonPolicyVo.popupDuration = myWindow.popupDuration.text.length==0?0:int(myWindow.popupDuration.text);
			commonPolicyVo.registerPeriodBeforeEndPopup = myWindow.registerPeriodBeforeEndPopup.text.length==0?0:int(myWindow.registerPeriodBeforeEndPopup.text);
			commonPolicyVo.carryoutPeriodBeforeEndPopup = myWindow.carryoutPeriodBeforeEndPopup.text.length==0?0:int(myWindow.carryoutPeriodBeforeEndPopup.text);
			commonPolicyVo.unRegisterSecureUsbRegisterGuide = int(myWindow.unRegisterSecureUsbRegisterGuide.selected);
			
			commonPolicyVo.unUseTime = myWindow.unUseTime.text.length==0?0:int(myWindow.unUseTime.text);
			
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

			commonPolicyVo.emergencyToolApplyTime = int(myWindow.emergencyToolApplyTime.selectedItem.value);
			commonPolicyVo.emergencyToolApplyTimeType = int(myWindow.emergencyToolApplyTimeType.selectedItem.value);
			
			return commonPolicyVo;
		}
		
		private function setCommonPolicyValue(object:Object):void
		{
			var commonPolicyVo:SusbmaCommonPolicyMasterVO = object as  SusbmaCommonPolicyMasterVO;
		
			myWindow.usbRegisterAutoApproval.selected = Boolean(commonPolicyVo.usbRegisterAutoApproval);
			myWindow.approvalSendMail.selected = Boolean(commonPolicyVo.approvalSendMail);
			myWindow.approvalReadyTime.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.approvalReadyTime), ArrayCollection(myWindow.approvalReadyTime.dataProvider), "value");
			myWindow.approvalReadyTimeType.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.approvalReadyTimeType), ArrayCollection(myWindow.approvalReadyTimeType.dataProvider), "value");
			myWindow.registerRequestDefaultTime.text = String(commonPolicyVo.registerRequestDefaultTime);
			myWindow.carryoutRequestDefaultTime.text = String(commonPolicyVo.carryoutRequestDefaultTime);
			myWindow.carryoutRequestIpUse.selected = Boolean(commonPolicyVo.carryoutRequestIpUse);
			myWindow.carryoutRequestMacUse.selected = Boolean(commonPolicyVo.carryoutRequestMacUse);
			myWindow.carryoutRequestOnOffUse.selected = Boolean(commonPolicyVo.carryoutRequestOnOffUse);
			myWindow.carryoutInsideUse.selected = Boolean(commonPolicyVo.carryoutInsideUse);
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
			
			myWindow.emergencyToolApplyTime.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.emergencyToolApplyTime), ArrayCollection(myWindow.emergencyToolApplyTime.dataProvider), "value");
			myWindow.emergencyToolApplyTimeType.selectedIndex = SZUtil.getIndexItem(String(commonPolicyVo.emergencyToolApplyTimeType), ArrayCollection(myWindow.emergencyToolApplyTimeType.dataProvider), "value");
			
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.SUSBMA_COMMON_POLICY_SAVESUCCESS,
				LocalConst.SUSBMA_COMMON_POLICY_LOADSUCCESS,
				LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT,
				
				LocalConst.SUSBMA_COMMON_POLICY_SAVEFAIL,
				LocalConst.SUSBMA_COMMON_POLICY_LOADFAIL,
				LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT
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
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY"),
						Alert.OK);
					break;
				}
					
				case LocalConst.SUSBMA_COMMON_POLICY_LOADSUCCESS:
				{
					setCommonPolicyValue(notification.getBody() as Object);
					break;
				}
					
				case LocalConst.SUSBMA_COMMON_POLICY_LOADSUCCESS:
				{
					break;
				}
					
				case LocalConst.SUSBMA_COMMON_POLICY_SAVEFAIL:
				{
					
					break;
				}

				case LocalConst.SUSBMA_COMMON_POLICY_LOADFAIL:
				{
					break;
				}
					
				case LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT:
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
					myWindow.returnApprovalPassword.text = extra as String;
					sendNotification(LocalConst.D4LC_CMD_PASSWORD_INITIALIZE, extra as String);
					break;
				}
					
				case "POPUPCHOICE":
				{
					var popupObj:Object = new Object();
					popupObj.popupList = extra as ArrayCollection;
					sendNotification(LocalConst.D4LC_CMD_POPUP_LIST_SAVE, popupObj);
					break;
				}
					
				case "SECUREADMININFO":
				{
					sendNotification(LocalConst.D4LC_CMD_SECURE_ADMIN_INFO_SAVE, extra as SusbmaCommonPolicyMasterVO);
					break;
				}
					
					
				default:
					break;
			}
		}
		
		/**
		 * Popup창의 "Cancel" callback
		 */
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
		}
		
		override public function onRemove():void
		{
			myWindow.saveBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.returnApprovalPasswordInit.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.popupUseChoice.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.secureAdminInfo.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
		}
		
	}
}