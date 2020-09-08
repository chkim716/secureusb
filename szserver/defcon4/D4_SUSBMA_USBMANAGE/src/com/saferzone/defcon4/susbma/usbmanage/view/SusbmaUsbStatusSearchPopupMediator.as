//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.common.consts.GlobalConst;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.services.vo.SearchSusbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.ApplicationFacade;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbStatusSearchPopup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.IList;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import spark.events.IndexChangeEvent;
	
	public class SusbmaUsbStatusSearchPopupMediator extends SZPopupMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SusbmaUsbStatusSearchPopupMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaUsbStatusSearchPopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():SusbmaUsbStatusSearchPopup
		{
			return viewComponent as SusbmaUsbStatusSearchPopup;
		}
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Event Handlers 
		//--------------------------------------
		
		protected function okClickEventHandler(event:MouseEvent):void
		{
			ApplicationFacade(facade).searchVO.startDate = SZUtil.replaceAll(myWindow.fromDate.text, '-', '');
			ApplicationFacade(facade).searchVO.endDate = SZUtil.replaceAll(myWindow.toDate.text, '-', '');
			callPopupOnOk(ApplicationFacade(facade).searchVO);
			closeMyWindow();
		}
		
		protected function cancelClickEventHandler(event:MouseEvent):void
		{
			callPopupOnCancel("test-cancel");
			closeMyWindow();
		}
		
		private function closeHandler(event:Event):void
		{
			callPopupOnCancel("test-cancel");
			closeMyWindow();
		}
		
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		/**
		 * 관심있는 notification
		 */
		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.SUSBMA_USBMANAGE_COMMON_LIST_LOADSUCCESS
				];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LocalConst.SUSBMA_USBMANAGE_COMMON_LIST_LOADSUCCESS:
				{
//					var dataProvider:IList = notification.getBody().CLASSLIST as IList;
//					dataProvider.addItemAt(
//						{className:DmosFramework.getInstance().SNL("SC_ALL")}, 0);
//					myWindow.classNM.dataProvider = dataProvider;
//					myWindow.classNM.selectedIndex = 0;
					setSearchCondition(ApplicationFacade(facade).searchVO);
					break;
				}
			}
		}
		
		override public function onRegister():void
		{
			//컨트롤 초기화 루틴은 여기서
			myWindow.okBtn.addEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.addEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
//			
//			myWindow.classNM.labelField = "className";
//			getClassList();
		}
		
		override public function onRemove():void
		{
			myWindow.okBtn.removeEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.removeEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.removeEventListener(Event.CLOSE, closeHandler);
		}
		
		
		//--------------------------------------
		// public 
		//--------------------------------------
		
		public function setSearchCondition(vo:SearchSusbMasterVO):void
		{
			if(vo.startDate == null || vo.startDate == "")
			{
				myWindow.fromDate.selectedDate = SZUtil.dateAdd("YYYY", -5);
			}
			else
			{
				myWindow.fromDate.selectedDate = new Date(vo.startDate.substr(0,
																				 4),
														  int(vo.startDate.substr(4,
																					 2)) - 1,
														  vo.startDate.substr(6,
																				 2));
			}
			
			if(vo.endDate == null || vo.endDate == "")
			{
				myWindow.toDate.selectedDate = SZUtil.dateAdd("YYYY");
			}
			else
			{
				myWindow.toDate.selectedDate = new Date(vo.endDate.substr(0, 4),
														int(vo.endDate.substr(4,
																				 2)) - 1,
														vo.endDate.substr(6, 2));
			}
//			myWindow.sno.text = vo.sno;
//			myWindow.manageNo.text = vo.managementId;
//			var selectedClass:Object = setSelectedClassByName(vo.className);
//			myWindow.classNM.selectedItem = selectedClass ? selectedClass : myWindow.classNM.dataProvider.getItemAt(0);
//			myWindow.userEmpName.text = vo.userEmpName;
//			myWindow.mngEmpName.text = vo.mngEmpName;
		}
		
		//--------------------------------------
		// private 
		//--------------------------------------
		
		
		private function closeMyWindow():void
		{
			PopUpManager.removePopUp(myWindow);
			facade.removeMediator(NAME);
		}
	}
}
