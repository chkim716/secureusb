//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.view
{
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONEncoder;
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.ISZPopupResponder;
	import com.saferzone.defcon4.common.consts.GlobalConst;
	import com.saferzone.defcon4.common.events.UserSearchPopupEvent;
	import com.saferzone.defcon4.services.vo.AgentMasterVO;
	import com.saferzone.defcon4.services.vo.CommonUiEmployeeVO;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.AddWindow;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageAddPopup;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageMassAddPopup;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.events.FlexMouseEvent;
	import mx.managers.PopUpManager;
	import mx.utils.ObjectUtil;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import spark.components.DataGrid;
	import spark.components.NavigatorContent;
	import spark.components.gridClasses.GridColumn;
	
	/**
	 *
	 * SendMsgSelectWindowMediator
	 *
	 * @version 0.001
	 * @author CyD
	 * @since Aug 6, 2011
	 *
	 * @langversion 3.0
	 * @playerversion Flash 10
	 * @playerversion AIR 2.6
	 * @productversion Flex 4.5
	 *
	 */
	public class AddWindowMediator extends Mediator implements ISZPopupResponder
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = "AddWindowMediator";
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function AddWindowMediator(viewComponent:AddWindow)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get addWindow():AddWindow
		{
			return viewComponent as AddWindow;
		}
		
		
		private var parentWindow:D4_SUSBMA_USBMANAGE;
		
		public function set setParentWindow(_parentWindow:D4_SUSBMA_USBMANAGE):void
		{
			parentWindow = _parentWindow;
		}
	
		override public function listNotificationInterests():Array
		{
			return [
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
			}
		}
		
		private function removeAddPopup():void
		{
			parentWindow.addPop.displayPopUp = false;
			parentWindow.addPop.x = 0;
		}
	
		protected function individualRegister_clickHandler(event:MouseEvent):void
		{
			var popupAdd:SusbmaUsbManageAddPopup;
			var popupAddMediator:SusbmaUsbManageAddPopupMediator;
			popupAdd = PopUpManager.createPopUp(parentWindow, SusbmaUsbManageAddPopup, true) as SusbmaUsbManageAddPopup;
			PopUpManager.centerPopUp(popupAdd);
			
			popupAddMediator = new SusbmaUsbManageAddPopupMediator(popupAdd);
			popupAddMediator.setPopupResponder(this, "ADD");
			
			facade.registerMediator(popupAddMediator);
			
			var addArr:Array = [];
			addArr[GlobalConst.CLASS_LIST] = GlobalConst.CLASS_LIST;
			addArr[GlobalConst.MEDIA_TYPE_LIST] = GlobalConst.MEDIA_TYPE_LIST;
			
			sendNotification(LocalConst.SUSBMA_USBMANAGE_COMMON_LIST, addArr);
			
			removeAddPopup();
		}
		
		protected function massRegister_clickHandler(event:MouseEvent):void
		{
			var popupMassAdd:SusbmaUsbManageMassAddPopup;
			var popupMassAddMediator:SusbmaUsbManageMassAddPopupMediator;
			popupMassAdd = PopUpManager.createPopUp(parentWindow, SusbmaUsbManageMassAddPopup, true) as SusbmaUsbManageMassAddPopup;
			PopUpManager.centerPopUp(popupMassAdd);
			
			popupMassAddMediator = new SusbmaUsbManageMassAddPopupMediator(popupMassAdd);
			popupMassAddMediator.setPopupResponder(this, "MASS_ADD");
			
			facade.registerMediator(popupMassAddMediator);
			
			removeAddPopup();
		}
		
		override public function onRegister():void
		{
			addWindow.individualRegister.addEventListener(MouseEvent.CLICK, individualRegister_clickHandler);
			addWindow.massRegister.addEventListener(MouseEvent.CLICK, massRegister_clickHandler);
		}

		override public function onRemove():void
		{
			addWindow.individualRegister.removeEventListener(MouseEvent.CLICK, individualRegister_clickHandler);
			addWindow.massRegister.removeEventListener(MouseEvent.CLICK, massRegister_clickHandler);
		
		}
		
		public function popupOnOk(popup:Object, context:Object, extra:Object):void
		{
			switch(context.toString())
			{
				case "ADD":
				{
					var addVO:SusbUsbMasterVO = extra as SusbUsbMasterVO;
					sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_ADD, addVO);
					break;
				}
					
				case "MASS_ADD":
				{
					
					parentWindow.reloadBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
					break;
				}
					
				default:
					break;
			}
		}
		
		public function popupOnCancel(popup:Object, context:Object, extra:Object):void
		{
			//Alert.show("OnCancel : " + context + " : " + extra );
		}
	}
}
