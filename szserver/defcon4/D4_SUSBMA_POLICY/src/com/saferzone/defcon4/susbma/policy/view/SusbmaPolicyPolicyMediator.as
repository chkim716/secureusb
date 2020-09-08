//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.ISZPopupResponder;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.common.components.USBSearchPopupEx;
	import com.saferzone.defcon4.common.events.USBSearchPopupEvent;
	import com.saferzone.defcon4.services.vo.CommonUiUsbMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyGroupUsbVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyMasterVO;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.view.comp.SusbmaPolicyGroupPopup;
	import com.saferzone.defcon4.susbma.policy.view.comp.SusbmaPolicyPolicyView;
	import com.saferzone.defcon4.susbma.policy.view.comp.SnoUpdatePopup;
	import com.saferzone.defcon4.susbma.policy.view.SnoUpdatePopupMediator;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.CellRegion;
	import spark.events.GridSelectionEvent;
	
	public class SusbmaPolicyPolicyMediator extends Mediator implements ISZPopupResponder
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SusbmaPolicyPolicyMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaPolicyPolicyMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():SusbmaPolicyPolicyView
		{
			return viewComponent as SusbmaPolicyPolicyView;
		}
		
		//------------------------------------------------------------------------------
		//
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * 버튼클릭 Listener
		 */
		private var popup:USBSearchPopupEx;
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Event Handlers 
		//--------------------------------------
		
//		private function okGroupCloseEventHandler(event:CloseEvent):void
//		{
//			facade.sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST,
//									myWindow.rangeType);
//		}
		
		protected function onBtnClickHandler(event:MouseEvent):void
		{
			var popupGroup:SusbmaPolicyGroupPopup;
			var popupGroupMediator:SusbmaPolicyGroupPopupMediator;
			switch(event.currentTarget.id)
			{
				case "addBtnT":
				{
					popupGroup = PopUpManager.createPopUp(myWindow.parentApplication as DisplayObject,
														  SusbmaPolicyGroupPopup,
														  true) as SusbmaPolicyGroupPopup;
					
					PopUpManager.centerPopUp(popupGroup);
					
					popupGroupMediator = new SusbmaPolicyGroupPopupMediator(popupGroup);
					popupGroupMediator.setPopupResponder(this, "ADD");
					
					facade.registerMediator(popupGroupMediator);
					break;
				}
				
				case "modBtnT":
				{
					if(myWindow.groupDG.selectedIndex < 0)
						return;
					popupGroup = PopUpManager.createPopUp(myWindow.parentApplication as DisplayObject,
														  SusbmaPolicyGroupPopup,
														  true) as SusbmaPolicyGroupPopup;
					PopUpManager.centerPopUp(popupGroup);
					
					popupGroupMediator = new SusbmaPolicyGroupPopupMediator(popupGroup);
					popupGroupMediator.setPopupResponder(this, "MODIFY");
					popupGroupMediator.groupName = (myWindow.groupDG.selectedItem as SusbmaPolicyMasterVO).grpName;
					
					facade.registerMediator(popupGroupMediator);
					break;
				}
				
				case "delBtnT":
				{
					if(myWindow.groupDG.selectedIndex < 0)
						return;
//					facade.sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_DELETE,
//											(myWindow.groupDG.selectedItem as SusbmaPolicyMasterVO).grpId);
					Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_DELETE"),
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY"), 
						Alert.OK | Alert.CANCEL, myWindow.parentApplication as Sprite, deleteBtn_closeHandler, null, Alert.OK);
					break;
				}
				
				case "reloadBtnT":
				{
					facade.sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST,
											myWindow.rangeType);
					break;
				}
				
				case "addBtnB":
				{
					if(myWindow.groupDG.selectedIndex < 0)
						return;
					popup = PopUpManager.createPopUp(myWindow.parentApplication as DisplayObject,
													 USBSearchPopupEx, true) as USBSearchPopupEx;
					popup.addEventListener(USBSearchPopupEvent.CONFIRM, addUsbHandler);
					popup.addEventListener(CloseEvent.CLOSE, closeUsbSearchHandler);
					popup.width = 950;
					popup.useMultipleSelection = true;
					PopUpManager.centerPopUp(popup);
					break;
				}
					
				case "modBtnB":
				{
					var popup:SnoUpdatePopup;
					var popupMediator:SnoUpdatePopupMediator;
					var nullChk:String = (myWindow.usbDG.selectedItem as SusbmaPolicyGroupUsbVO).policyValidDate;
					if(nullChk != null){
						var startDateValue:String = SZUtil.replaceAll((myWindow.usbDG.selectedItem as SusbmaPolicyGroupUsbVO).policyValidDate.substr(0,10),'-','');
						var endDateValue:String =  SZUtil.replaceAll((myWindow.usbDG.selectedItem as SusbmaPolicyGroupUsbVO).policyValidDate.substr(20,10),'-','');
						var startHourValue:String = (myWindow.usbDG.selectedItem as SusbmaPolicyGroupUsbVO).policyValidDate.substr(11,2);
						var startMinuteValue:String = (myWindow.usbDG.selectedItem as SusbmaPolicyGroupUsbVO).policyValidDate.substr(14,2);
						var endHourValue:String = (myWindow.usbDG.selectedItem as SusbmaPolicyGroupUsbVO).policyValidDate.substr(31,2);
						var endMinuteValue:String = (myWindow.usbDG.selectedItem as SusbmaPolicyGroupUsbVO).policyValidDate.substr(34,2);
					}
					
					if(myWindow.usbDG.selectedIndex < 0)
						return;
					
					popup = PopUpManager.createPopUp(myWindow.parentApplication as DisplayObject,
						SnoUpdatePopup, true) as SnoUpdatePopup;
					PopUpManager.centerPopUp(popup);
					
					popup.txtEmpName.text = (myWindow.usbDG.selectedItem as SusbmaPolicyGroupUsbVO).empName;
					popup.txtSno.text = (myWindow.usbDG.selectedItem as SusbmaPolicyGroupUsbVO).sno;
					
					if(nullChk != null){
						popup.startPolicyDate.selectedDate = new Date(startDateValue.substr(0, 4),
							int(startDateValue.substr(4, 2)) - 1,
							startDateValue.substr(6, 2));
						popup.endPolicyDate.selectedDate = new Date(endDateValue.substr(0, 4),
							int(endDateValue.substr(4, 2)) - 1,
							endDateValue.substr(6, 2));
						popup.startHour.value = int(startHourValue);
						popup.startMinute.value   = int(startMinuteValue);
						popup.endMinute.value   = int(endMinuteValue);	
						popup.endHour.value   = int(endHourValue);	
					}
					if(nullChk == null) {
						popup.chkUnlimitDate.selected = true;
						popup.startPolicyDate.enabled = popup.endPolicyDate.enabled = popup.startHour.enabled 
							= popup.startMinute.enabled = popup.endMinute.enabled = popup.endHour.enabled = false;
					}
					
					popupMediator = new SnoUpdatePopupMediator(popup);
					popupMediator.setPopupResponder(this, "MODIFYB");
					facade.registerMediator(popupMediator);
					popupMediator.myWindow.startPolicyDate.setFocus();
					
					break;
				}
				
				case "delBtnB":
				{
					if(myWindow.usbDG.selectedIndex < 0)
						return;
					Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_DELETE"),
							   DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY"),
							   Alert.OK | Alert.CANCEL, myWindow.parentApplication as Sprite,
							   usbDeleteEventHandler, null, Alert.OK);
					break;
				}
				
				case "reloadBtnB":
				{
					if(myWindow.groupDG.selectedIndex < 0)
						return;
					var optionMediator:SusbmaPolicyOptionMediator = facade.retrieveMediator(SusbmaPolicyOptionMediator.NAME) as SusbmaPolicyOptionMediator;
					sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST,
									 optionMediator.selectMasterVO);
					break;
				}
				
				default:
					break;
			}
		}
		
		protected function deleteBtn_closeHandler(event:CloseEvent):void
		{
			if(event.detail == Alert.OK)
			{
				facade.sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_DELETE,
					(myWindow.groupDG.selectedItem as SusbmaPolicyMasterVO).grpId);
			}
		}
		
		/**
		 * 그룹선택이벤트
		 */
		private function selectionChangeHandler(event:GridSelectionEvent):void
		{
			var optionMediator:SusbmaPolicyOptionMediator = facade.retrieveMediator(SusbmaPolicyOptionMediator.NAME) as SusbmaPolicyOptionMediator;
			optionMediator.selectMasterVO = (event.currentTarget as DataGrid).selectedItem as SusbmaPolicyMasterVO;
			
			sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST, optionMediator.selectMasterVO);
		}
		
		
		private function addUsbHandler(event:USBSearchPopupEvent):void
		{
			popup.removeEventListener(USBSearchPopupEvent.CONFIRM, addUsbHandler);
			var list:IList = new ArrayList();
			var masterVO:SusbmaPolicyMasterVO = myWindow.groupDG.selectedItem as SusbmaPolicyMasterVO;
			var usbVO:SusbmaPolicyGroupUsbVO;
			var length:int = event.selectedItems.length;
			
			for(var i:int = 0; i < length; i++)
			{
				usbVO = new SusbmaPolicyGroupUsbVO();
				usbVO.grpId = masterVO.grpId;
				usbVO.regDate = CommonUiUsbMasterVO(event.selectedItems.getItemAt(i)).regDate;
				usbVO.sno = CommonUiUsbMasterVO(event.selectedItems.getItemAt(i)).sno;
				
				if(CommonUiUsbMasterVO(event.selectedItems.getItemAt(i)).chkUnlimited == 1)	//무제한
				{
					usbVO.startDate	= null;
					usbVO.endDate= null;
				}
				else
				{
					usbVO.startDate = CommonUiUsbMasterVO(event.selectedItems.getItemAt(i)).startPolDate
						+ CommonUiUsbMasterVO(event.selectedItems.getItemAt(i)).startPolHours
						+ CommonUiUsbMasterVO(event.selectedItems.getItemAt(i)).startPolMinutes;
					
					usbVO.endDate = CommonUiUsbMasterVO(event.selectedItems.getItemAt(i)).endPolDate
						+ CommonUiUsbMasterVO(event.selectedItems.getItemAt(i)).endPolHours
						+ CommonUiUsbMasterVO(event.selectedItems.getItemAt(i)).endPolMinutes;
					
					//시작일자가 종료일자보다 클 경우 return 처리 //////// START
					if(Number(usbVO.startDate) > Number(usbVO.endDate))
					{
						Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_INVALID_PERIOD"), 
							DmosFramework.getInstance().SNL("SC_SEARCH"));
						return;
					}
				}
				
				list.addItem(usbVO);
			}
			
			sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_USB_ADD, list);
		}
		
		private function closeUsbSearchHandler(event:CloseEvent):void
		{
			popup.removeEventListener(CloseEvent.CLOSE, closeUsbSearchHandler);
			PopUpManager.removePopUp(popup);
		}
		
		private function usbDeleteEventHandler(event:CloseEvent):void
		{
			if(event.detail == Alert.OK)
			{
				var sno:String = (myWindow.usbDG.selectedItem as SusbmaPolicyGroupUsbVO).sno;
				facade.sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_USB_DELETE,
										sno);
			}
		}
		
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		override public function onRegister():void
		{
			//컨트롤 초기화 루틴은 여기서
			myWindow.addBtnT.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.modBtnT.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtnT.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtnT.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			
			myWindow.addBtnB.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.modBtnB.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtnB.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtnB.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			
			
			//권한설정
			if(DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY"))
			{
				myWindow.addBtnT.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleCreate();
				myWindow.modBtnT.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleUpdate();
				myWindow.delBtnT.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleDelete();
				
				myWindow.addBtnB.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleCreate();
				myWindow.delBtnB.enabled = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_POLICY").isAbleDelete();
			}
			
			myWindow.groupDG.addEventListener(GridSelectionEvent.SELECTION_CHANGE,
				selectionChangeHandler);
		}
		
		override public function onRemove():void
		{
			myWindow.addBtnT.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.modBtnT.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtnT.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtnT.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			
			myWindow.addBtnB.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.modBtnB.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtnB.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtnB.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			
			myWindow.groupDG.removeEventListener(GridSelectionEvent.SELECTION_CHANGE,
				selectionChangeHandler);
		}
		
		/**
		 * 관심있는 notification
		 */
		override public function listNotificationInterests():Array
		{
			return [
				//성공 notify
				LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_POLIICY_POLICY_GROUP_ADDSUCCESS,
				LocalConst.SUSBMA_POLIICY_POLICY_GROUP_MODIFYSUCCESS,
				LocalConst.SUSBMA_POLIICY_POLICY_GROUP_DELETESUCCESS,
				LocalConst.SUSBMA_POLIICY_POLICY_USB_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_POLIICY_POLICY_USB_ADDSUCCESS,
				LocalConst.SUSBMA_POLIICY_POLICY_USB_DELETESUCCESS,
				LocalConst.SUSBMA_POLIICY_POLICY_USB_MODIFYSUCCESS,
				
				//실패 notify
				LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADFAIL,
				LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADFAIL,
				LocalConst.SUSBMA_POLIICY_POLICY_GROUP_ADDFAIL,
				LocalConst.SUSBMA_POLIICY_POLICY_GROUP_MODIFYFAIL,
				LocalConst.SUSBMA_POLIICY_POLICY_GROUP_DELETEFAIL,
				LocalConst.SUSBMA_POLIICY_POLICY_USB_LIST_LOADFAIL,
				LocalConst.SUSBMA_POLIICY_POLICY_USB_ADDFAIL,
				LocalConst.SUSBMA_POLIICY_POLICY_USB_DELETEFAIL,
				LocalConst.SUSBMA_POLIICY_POLICY_USB_MODIFYFAIL
				];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			var optionMediator:SusbmaPolicyOptionMediator
			switch(notification.getName())
			{
				//Grid에 저장될 데이터 로드 성공
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADSUCCESS:
				{
					myWindow.groupArr = notification.getBody() as ArrayCollection;
					if(myWindow.groupArr.length > 0)
					{
						myWindow.groupDG.enabled = true;
						myWindow.usbDG.enabled = true;
						myWindow.modBtnT.enabled = true;
						myWindow.delBtnT.enabled = true;
						myWindow.usbToolbar.enabled = true;
						
						myWindow.groupDG.selectedIndex = 0;
						myWindow.groupDG.dispatchEvent(new GridSelectionEvent(GridSelectionEvent.SELECTION_CHANGE,
																			  false,
																			  false,
																			  null,
																			  new CellRegion(0,
																							 0)));
						myWindow.groupDG.setFocus();
						
						
					}
					else
					{
						myWindow.groupDG.enabled = false;
						myWindow.usbDG.enabled = false;
						myWindow.modBtnT.enabled = false;
						myWindow.delBtnT.enabled = false;
						myWindow.usbToolbar.enabled = false;
						if(myWindow.usbArr != null) myWindow.usbArr.removeAll();
					}
					if(myWindow.groupDG.dataProviderLength == 0)
						sendNotification(LocalConst.SUSBMA_POLIICY_RAW_LIST, -1);
					setRangeType();
					break;
				}
				
				//Grid에 저장될 데이터 로드 실패
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADFAIL:
				{
					break;
				}
				
				//새항목 추가 성공
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_ADDSUCCESS:
				{
					facade.sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST,
											myWindow.rangeType);
					break;
				}
				
				//새항목 추가 실패
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_ADDFAIL:
				{
					break;
				}
				
				//항목 수정 성공
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_MODIFYSUCCESS:
				{
					facade.sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST,
											myWindow.rangeType);
					break;
				}
				
				//항목 수정 성공
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_MODIFYFAIL:
				{
					break;
				}
				
				//항목 삭제 성공
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_DELETESUCCESS:
				{
					facade.sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST,
											myWindow.rangeType);
					break;
				}
				
				//항목 삭제 실패
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_DELETEFAIL:
				{
					break;
				}
				
				//Grid에 저장될 데이터 로드 성공
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADSUCCESS:
				{
					
					optionMediator = facade.retrieveMediator(SusbmaPolicyOptionMediator.NAME) as SusbmaPolicyOptionMediator;
					optionMediator.setRawList(notification.getBody().grpRaw);
					
					if(notification.getBody().grpUsb)
					{
						myWindow.usbArr = notification.getBody().grpUsb as ArrayCollection;
						
						if(myWindow.usbArr.length > 0)
						{
							myWindow.usbDG.selectedIndex = 0;
							myWindow.addBtnB.enabled = true;
							myWindow.modBtnB.enabled = true;
							myWindow.delBtnB.enabled = true;
							
						}else{
							myWindow.addBtnB.enabled = true;
							myWindow.modBtnB.enabled = false;
							myWindow.delBtnB.enabled = false;
						}
					}
					break;
				}
				
				//Grid에 저장될 데이터 로드 실패
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADFAIL:
				{
					break;
				}
				
				//새항목 추가 성공
				case LocalConst.SUSBMA_POLIICY_POLICY_USB_ADDSUCCESS:
				{
					okUsbCloseEventHandler();
					break;
				}
				
				//새항목 추가 실패
				case LocalConst.SUSBMA_POLIICY_POLICY_USB_ADDFAIL:
				{
					break;
				}
				
				//항목 삭제 성공
				case LocalConst.SUSBMA_POLIICY_POLICY_USB_DELETESUCCESS:
				{
					okUsbCloseEventHandler();
					break;
				}
				
				//항목 삭제 실패
				case LocalConst.SUSBMA_POLIICY_POLICY_USB_DELETEFAIL:
				{
					break;
				}
					
				//항목 수정 성공
				case LocalConst.SUSBMA_POLIICY_POLICY_USB_MODIFYSUCCESS:
				{
					okUsbCloseEventHandler();
					break;
				}
					
				//항목 수정 실패
				case LocalConst.SUSBMA_POLIICY_POLICY_USB_MODIFYFAIL:
				{
					break;
				}
				
				default:
					break;
				
			}
		}
		
		//--------------------------------------
		// public 
		//--------------------------------------
		
		/**
		 * Popup창의 "OK" callback
		 */
		public function popupOnOk(popup:Object, context:Object, extra:Object):void
		{
			var masterVO:SusbmaPolicyMasterVO
			switch(context.toString())
			{
				case "ADD":
				{
					masterVO = new SusbmaPolicyMasterVO();
					masterVO.grpName = extra as String;
					masterVO.rangeType = myWindow.rangeType;
					
					facade.sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_ADD,
											masterVO);
					break;
				}
				
				case "MODIFY":
				{
					masterVO = myWindow.groupDG.selectedItem as SusbmaPolicyMasterVO;
					masterVO.grpName = extra as String;
					sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_MODIFY,
									 masterVO);
					break;
				}
					
				case "MODIFYB":
				{
					var searchVO:SusbmaPolicyGroupUsbVO = extra as SusbmaPolicyGroupUsbVO;
					var modVO:SusbmaPolicyGroupUsbVO;
					modVO = searchVO;
					modVO.startDate = searchVO.startPolDate + searchVO.startPolHours + searchVO.startPolMinutes;
					modVO.endDate = searchVO.endPolDate + searchVO.endPolHours + searchVO.endPolMinutes;
					
					sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_USB_MODIFY, modVO);
					
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
			//Alert.show("OnCancel : " + context + " : " + extra );
		}
		
		//--------------------------------------
		// private 
		//--------------------------------------
		
		private function okUsbCloseEventHandler():void
		{
			if(myWindow.groupDG.selectedIndex < 0)
				return;
			var optionMediator:SusbmaPolicyOptionMediator = facade.retrieveMediator(SusbmaPolicyOptionMediator.NAME) as SusbmaPolicyOptionMediator;
			sendNotification(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST, optionMediator.selectMasterVO);
		}
		
		private function setRangeType():void
		{
			var optionMediator:SusbmaPolicyOptionMediator = facade.retrieveMediator(SusbmaPolicyOptionMediator.NAME) as SusbmaPolicyOptionMediator;
			
			optionMediator.selectMasterVO.rangeType = 3;
			
			/**
			 * 20130227 김정욱 보조기억매체정책 비정상 정책 화면 출력현상 수정 START
			 */ 
			if(myWindow.groupDG.dataProviderLength == 0){
				optionMediator.selectMasterVO.grpId = 0;
				optionMediator.selectMasterVO.usbPolicyId = -1;
			}
			/**
			 * 20130227 김정욱 보조기억매체정책 비정상 정책 화면 출력현상 수정 END
			 */ 
		}
	}
}
