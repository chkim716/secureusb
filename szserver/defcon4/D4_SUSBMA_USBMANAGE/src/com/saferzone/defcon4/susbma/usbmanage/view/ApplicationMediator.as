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
	import com.saferzone.defcon4.common.components.ColumnSettingWindow;
	import com.saferzone.defcon4.common.components.SZExcelExportWindow;
	import com.saferzone.defcon4.common.components.Widget.Connect.Applicationfacade;
	import com.saferzone.defcon4.common.consts.CustomerId;
	import com.saferzone.defcon4.common.consts.GlobalConst;
	import com.saferzone.defcon4.common.events.CustomTreeItemClickEvent;
	import com.saferzone.defcon4.common.utils.classes.LabelFunctionData;
	import com.saferzone.defcon4.services.vo.SearchSusbMasterVO;
	import com.saferzone.defcon4.services.vo.SusbChangeHistoryVO;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.ApplicationFacade;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.PasswordInitializePopup;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageAddPopup;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageDelPopup;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageModPopup;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageSearchPopup;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageUnUsePopup;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbSearchWindow;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbStatusSearchPopup;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.utils.Timer;
	
	import flashx.textLayout.elements.BreakElement;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.IndexChangedEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import spark.components.Button;
	import spark.components.NavigatorContent;
	import spark.components.PopUpAnchor;
	import spark.components.VScrollBar;
	import spark.components.gridClasses.CellRegion;
	import spark.components.gridClasses.GridColumn;
	import spark.events.GridSelectionEvent;
	import spark.events.IndexChangeEvent;
	
	public class ApplicationMediator extends Mediator implements ISZPopupResponder
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * Name
		 */
		public static const NAME:String = 'ApplicationMediator';
		
		//스크롤 이동 시 데이터 조회
		private var _pageSize:uint = DmosFramework.getInstance().CONFIG("LOAD_PAGE_SIZE")!=null?int(DmosFramework.getInstance().CONFIG("LOAD_PAGE_SIZE")):100;		
		private var _loadedCnt:uint = 0;
		private var _startIdx:uint = 0;
		private var isRefresh:Boolean;
		public  var tmTimer  : Timer;
		public  var time:int = 0;
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function ApplicationMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * 이 Mediator의 제어대상 윈도우
		 */
		public function get myWindow():D4_SUSBMA_USBMANAGE
		{
			return viewComponent as D4_SUSBMA_USBMANAGE;
		}
		
		//------------------------------------------------------------------------------
		//
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		private var firstTime:Boolean = true;
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Event Handlers 
		//--------------------------------------
		
		//		private function okCloseEventHandler(event:CloseEvent):void
		//		{
		//			facade.sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, getSearchCondition());
		//		}
		
		
		
		/**
		 * 버튼클릭 Listener
		 */
		protected function onBtnClickHandler(event:MouseEvent):void
		{
			switch(event.currentTarget.id)
			{
				case "searchBtn":
				{
					var popupSearch:SusbmaUsbSearchWindow;
					var popupSearchMediator:SearchWindowMediator;
					popupSearch = PopUpManager.createPopUp(myWindow, SusbmaUsbSearchWindow,
						true) as SusbmaUsbSearchWindow;
					PopUpManager.centerPopUp(popupSearch);
					
					popupSearchMediator = new SearchWindowMediator(popupSearch);
					popupSearchMediator.setPopupResponder(this, "SEARCH");
			
					facade.registerMediator(popupSearchMediator);
					
					var params:Object = {};
					params.CLASSLIST = GlobalConst.CLASS_LIST;
					params.STATELIST = GlobalConst.STATE_LIST;
					params.MEDIATYPELIST = GlobalConst.MEDIA_TYPE_LIST;
					
					sendNotification(LocalConst.SUSBMA_USBMANAGE_COMMON_LIST, params);
					break;
				}
					
				case "excelBtn":
				{
					if(DmosFramework.getInstance().CUSTOMERID == CustomerId.MMA){
						if(!myWindow.fileExportPop.displayPopUp)
						{
							myWindow.fileExportPop.x = myWindow.excelBtn.x +myWindow.deptNavigator.width + 40;
							myWindow.fileExportPop.y = myWindow.toolBar.height + 1;
							myWindow.fileExportPop.displayPopUp = true;
						}	
					}else{
//						exportToExcel(1);
						excelExportWindowPopup();
					}
					break;
				}
					/**
					 * 20121015 김정욱 CSV 저장 추가 Start
					 * 
					 */
				case "saveCsvBtn":
				{
					
					var nowDate:Date = new Date();
					var monthStr:String = ( (nowDate.month+1)<10 ? "0" : "") +  (nowDate.month+1);
					var dayStr:String = (nowDate.date<10 ? "0" : "") + nowDate.date;
					var fileName:String;
					fileName = DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE") + "_" + nowDate.fullYear + monthStr + dayStr + ".csv";
					
					myWindow.usbDG.saveToCSV(fileName);
					break;
				}		
					
					/**
					 * 20121015 김정욱 CSV 저장 추가 End
					 * 
					 */
					
				case "addBtn":
				{
					var pt:Point = new Point(myWindow.contentMouseX, myWindow.contentMouseY);
					
					if(!myWindow.addPop.displayPopUp)
					{
						myWindow.addPop.x = pt.x + 10;
						myWindow.addPop.y = pt.y + 10;
						myWindow.addPop.displayPopUp = true;
					}
					break;
					
//					var popupAdd:SusbmaUsbManageAddPopup;
//					var popupAddMediator:SusbmaUsbManageAddPopupMediator;
//					popupAdd = PopUpManager.createPopUp(myWindow, SusbmaUsbManageAddPopup,
//						true) as SusbmaUsbManageAddPopup;
//					PopUpManager.centerPopUp(popupAdd);
//					
//					popupAddMediator = new SusbmaUsbManageAddPopupMediator(popupAdd);
//					popupAddMediator.setPopupResponder(this, "ADD");
//					
//					facade.registerMediator(popupAddMediator);
//					
//					var addArr:Array = [];
//					addArr[GlobalConst.CLASS_LIST] = GlobalConst.CLASS_LIST;
//					sendNotification(LocalConst.SUSBMA_USBMANAGE_COMMON_LIST, addArr);
//					break;
				}
					
				case "modBtn":
				{
					var vo:SusbUsbMasterVO = myWindow.usbDG.selectedItem as SusbUsbMasterVO;
					
					if(myWindow.usbDG.selectedIndex < 0)
						return;
					
					if(DmosFramework.getInstance().CUSTOMERID == CustomerId.WOORIBANK){
						if(vo.requestState == 0) {
							Alert.show(DmosFramework.getInstance().SNL('DEFCON4-ERR-5009'), DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_USBMANAGE'));
							return;
						}
					}
					
					var popupMod:SusbmaUsbManageModPopup;
					var popupModMediator:SusbmaUsbManageModPopupMediator;
					ApplicationFacade(facade).selectedUsbCount = ApplicationFacade(facade).selectedUSBList.length;
					popupMod = PopUpManager.createPopUp(myWindow, SusbmaUsbManageModPopup,
						true) as SusbmaUsbManageModPopup;
					PopUpManager.centerPopUp(popupMod);
					
					popupModMediator = new SusbmaUsbManageModPopupMediator(popupMod);
					popupModMediator.setPopupResponder(this, "MODIFY");
					popupModMediator.opener = myWindow;
					popupModMediator.usbMasterVo = vo;
					facade.registerMediator(popupModMediator);
					
					var modArr:Array = [];
					modArr[GlobalConst.CLASS_LIST] = GlobalConst.CLASS_LIST;
					modArr[GlobalConst.MEDIA_TYPE_LIST] = GlobalConst.MEDIA_TYPE_LIST;
					modArr[GlobalConst.REASON_LIST] = GlobalConst.REASON_LIST;
					modArr[GlobalConst.STATE_LIST] = GlobalConst.STATE_LIST;
					modArr[GlobalConst.DEPT_TYPE] = String(vo.sno);
					modArr[GlobalConst.ORG_LIST] = String(vo.sno);
					sendNotification(LocalConst.SUSBMA_USBMANAGE_COMMON_LIST, modArr);
					break;
				}
					
					
				case "delBtn":
				{
//					var SaferZoneVersion:int= int(DmosFramework.getInstance().CONFIG("SAFERZONE_VERSION"));
					var isSecureUsbDelete:int= int(DmosFramework.getInstance().CONFIG("SUSB_DELETE_USB"));
					var isNonActiveX:int= int(DmosFramework.getInstance().CONFIG("NON_ACTIVEX"));
					
					if(isNonActiveX == 0){
						isSecureUsbDelete = 1;
					}else{
						isSecureUsbDelete = 0;
					}
					
					if(isSecureUsbDelete == 1){
						isSecureUsbDelete = 0;
					}
					
					if(isSecureUsbDelete == 0){ // || DmosFramework.getInstance().CUSTOMERID == CustomerId.SFA){
						if(myWindow.usbDG.selectedIndex < 0)
							return;
							Alert.show(DmosFramework.getInstance().SNL('SC_PROMPT_DELETE'),
							DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_USBMANAGE'),
							Alert.OK | Alert.CANCEL, myWindow.parentApplication as Sprite,
							usbDeleteEventHandler, null, Alert.OK);	
					}
					else{
						var vo:SusbUsbMasterVO = myWindow.usbDG.selectedItem as SusbUsbMasterVO;
						if(myWindow.usbDG.selectedIndex < 0)
							return;
						
						if(vo.requestState == 1) {
							Alert.show(DmosFramework.getInstance().SNL('DEFCON4-ERR-6003'), DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_USBMANAGE'));
							return;
						}
						
						var popupDel:SusbmaUsbManageDelPopup;
						var popupDelMediator:SusbmaUsbManageDelPopupMediator;
						popupDel = PopUpManager.createPopUp(myWindow, SusbmaUsbManageDelPopup, true) as SusbmaUsbManageDelPopup;
						PopUpManager.centerPopUp(popupDel);
						
						popupDelMediator = new SusbmaUsbManageDelPopupMediator(popupDel);
						popupDelMediator.setPopupResponder(this, "DELETE");
						popupDelMediator.data = vo;
						
						facade.registerMediator(popupDelMediator);
					}
					
					break;
				}
					
				case "reloadBtn":
				{
					if(getSearchCondition() == null)
						return;
					//20130409 김정욱 새로고침을 반복적으로 클릭 시 조회 범위보다 많이 불러오는 현상을 막기 위해 새로고침 버튼 disable 처리 - START
					myWindow.reloadBtn.enabled = false;
					//20130409 김정욱 새로고침을 반복적으로 클릭 시 조회 범위보다 많이 불러오는 현상을 막기 위해 새로고침 버튼 disable 처리 - END
					initializeScrollData();
					getSearchCondition().startIdx = _startIdx;
					facade.sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST,
						getSearchCondition());
					break;
				}
				case "initBtn":
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_INITIALIZE"), DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
					initialize();
					initializeDeptNavigator();
					//20130409 김정욱 새로고침을 반복적으로 클릭 시 조회 범위보다 많이 불러오는 현상을 막기 위해 새로고침 버튼 disable 처리 - START
					myWindow.reloadBtn.enabled = false;
					//20130409 김정욱 새로고침을 반복적으로 클릭 시 조회 범위보다 많이 불러오는 현상을 막기 위해 새로고침 버튼 disable 처리 - END
					initializeScrollData();
					getSearchCondition().startIdx = _startIdx;
					facade.sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, getSearchCondition());
					break;
				}
				case "unUseBtn":
				{
					var vo:SusbUsbMasterVO = myWindow.usbDG.selectedItem as SusbUsbMasterVO;
					if(myWindow.usbDG.selectedIndex < 0) return;
					
					if(DmosFramework.getInstance().CUSTOMERID == CustomerId.WOORIBANK){
						if(vo.requestState == 0) {
							Alert.show(DmosFramework.getInstance().SNL('DEFCON4-ERR-5011'), DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_USBMANAGE'));
							return;
						}
					}
					var popupUnUse:SusbmaUsbManageUnUsePopup;
					var popupUnUseMediator:SusbmaUsbManageUnUsePopupMediator;
					popupUnUse = PopUpManager.createPopUp(myWindow, SusbmaUsbManageUnUsePopup,
						true) as SusbmaUsbManageUnUsePopup;
					PopUpManager.centerPopUp(popupUnUse);
					
					popupUnUseMediator = new SusbmaUsbManageUnUsePopupMediator(popupUnUse);
					popupUnUseMediator.setPopupResponder(this, "MODIFY");
					
					popupUnUseMediator.usbData = vo;
					facade.registerMediator(popupUnUseMediator);
					break;
				}
					
				case "pwdInitBtn":
				{
					if(myWindow.usbDG.selectedIndex < 0)
						return;
					
					var vo:SusbUsbMasterVO = myWindow.usbDG.selectedItem as SusbUsbMasterVO;
					if(DmosFramework.getInstance().CUSTOMERID == CustomerId.WOORIBANK){
						if(vo.requestState ==0) {
							Alert.show(DmosFramework.getInstance().SNL('DEFCON4-ERR-5011'), DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_USBMANAGE'));
							return;
						}
					}
					
					if(!facade.hasMediator(PasswordInitializeMediator.NAME))
					{
						myWindow.pwdInitBtn.enabled = false;
						var passwordInitializePopup:PasswordInitializePopup =
							new PasswordInitializePopup();
						var passwordInitializeMediator:PasswordInitializeMediator =
							new PasswordInitializeMediator(passwordInitializePopup);
						passwordInitializeMediator.setPopupResponder(this, "INITPWD");
						passwordInitializeMediator.setData = vo;
						facade.registerMediator(passwordInitializeMediator);
					}
					break;
				}
					
				case "returnBtn":
				{
					if(myWindow.usbDG.selectedIndex < 0)
						return;
					var vo:SusbUsbMasterVO = myWindow.usbDG.selectedItem as SusbUsbMasterVO;
					if(DmosFramework.getInstance().CUSTOMERID == CustomerId.WOORIBANK){
						if(vo.requestState == 0) {
							Alert.show(DmosFramework.getInstance().SNL('DEFCON4-ERR-5011'), DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_USBMANAGE'));
							return;
						}
					}
					
					Alert.show(DmosFramework.getInstance().SNL('DEFCON4-ERR-5012'),
						DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_USBMANAGE'),
						Alert.OK | Alert.CANCEL, myWindow.parentApplication as Sprite,
						usbReturnEventHandler, null, Alert.OK);
					break;
				}
					
				case "emergencyToolBtn":
				{
					myWindow.popEmergencyKeyWindow.horizontalCenter = 0;
					myWindow.popEmergencyKeyWindow.verticalCenter = 0;
					myWindow.popEmergencyKeyWindow.displayPopUp = true;
					
					var emergencyKeyMediator:EmergenyToolPopupMediator = new EmergenyToolPopupMediator(myWindow.emergencyKeyWindow);
					facade.registerMediator(emergencyKeyMediator);
					
					emergencyKeyMediator.myWindow.authCodeInput.setFocus();
					break;
				}	
					
				case "searchBtn2":
				{
					var popupSearch2:SusbmaUsbStatusSearchPopup;
					var popupSearchMediator2:SusbmaUsbStatusSearchPopupMediator;
					popupSearch2 = PopUpManager.createPopUp(myWindow, SusbmaUsbStatusSearchPopup,
						true) as SusbmaUsbStatusSearchPopup;
					PopUpManager.centerPopUp(popupSearch2);
					popupSearchMediator2 = new SusbmaUsbStatusSearchPopupMediator(popupSearch2);
					popupSearchMediator2.setPopupResponder(this, "SEARCH2");
					facade.registerMediator(popupSearchMediator2);
					popupSearchMediator2.setSearchCondition(ApplicationFacade(facade).searchVO);
					break;
				}
					
				case "excelBtn2":
				{
					exportToExcel(2);
					break;
				}
					
				case "searchBtn3":
				{
					var popupSearch2:SusbmaUsbStatusSearchPopup;
					var popupSearchMediator2:SusbmaUsbStatusSearchPopupMediator;
					popupSearch2 = PopUpManager.createPopUp(myWindow, SusbmaUsbStatusSearchPopup,
						true) as SusbmaUsbStatusSearchPopup;
					PopUpManager.centerPopUp(popupSearch2);
					popupSearchMediator2 = new SusbmaUsbStatusSearchPopupMediator(popupSearch2);
					popupSearchMediator2.setPopupResponder(this, "SEARCH3");
					facade.registerMediator(popupSearchMediator2);
					popupSearchMediator2.setSearchCondition(ApplicationFacade(facade).searchVO);
					break;
				}
					
				case "excelBtn3":
				{
					exportToExcel(3);
					break;
				}
					
				case "reloadBtn2":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_STATUS_LIST, {sno:myWindow.usbDG.selectedItem.sno, startDate:ApplicationFacade(facade).searchVO.startDate, endDate:ApplicationFacade(facade).searchVO.endDate});
					break;
				}
					
				case "reloadBtn3":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LIST, {sno:myWindow.usbDG.selectedItem.sno, startDate:ApplicationFacade(facade).searchVO.startDate, endDate:ApplicationFacade(facade).searchVO.endDate});
					break;
				}
					
				default:
					break;
			}
		}
		
		private function usbReturnEventHandler(event:CloseEvent):void
		{
			var vo:SusbUsbMasterVO = myWindow.usbDG.selectedItem as SusbUsbMasterVO;
			if(event.detail == Alert.OK)
			{
				ExternalInterface.call("usbReturn", vo.sno, vo.managementId);
			}
		}
		
		private function onTabChangeHandler(event:IndexChangedEvent):void
		{
			if(myWindow.usbDG.selectedIndex < 0)
				return;
			var masterVo:SusbUsbMasterVO = myWindow.usbDG.selectedItem as SusbUsbMasterVO;
			var sno:String = "";
			var startDate:String = "";
			var endDate:String = "";
			
//			switch(event.currentTarget.selectedIndex)
			switch((event.relatedObject as NavigatorContent).id)
			{
				case "changeHistoryTab":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST, masterVo.sno);
					break;
				}
					
				case "useHistoryTab":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_USE_LIST, masterVo.sno);
					break;
				}
					
				case "deleteHistoryTab":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_DELETE_LIST, {sno:masterVo.sno});
					break;
				}
					
				case "usbFileListTab":
				{
//					startDate = "20160101";
//					endDate   = "20170124";
					sendNotification(LocalConst.SUSBMA_USBMANAGE_STATUS_LIST, {sno:masterVo.sno, startDate:startDate, endDate:endDate});
					break;
				}
					
				case "remoteDeleteTab":
				{
//					startDate = "20160101";
//					endDate   = "20170124";
					sendNotification(LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LIST, {sno:masterVo.sno, startDate:startDate, endDate:endDate});
					break;
				}	
					
				case "updateHistoryTab":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST, masterVo.sno);
					break;
				}
					
				default:
					break;
			}
		}
		
		private function treeItemClickHandler(event:CustomTreeItemClickEvent):void
		{
			myWindow.changeHistoryDG.dataProvider = null;
			myWindow.useHistoryDG.dataProvider = null;
			initializeScrollData();
			getSearchCondition().startIdx = _startIdx;
			ApplicationFacade(facade).searchVO.orgId = myWindow.deptNavigator.deptTree.selectedItem.orgId;
			sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, getSearchCondition());
		}
		
		
		private function selectionChangeHandler(event:GridSelectionEvent):void
		{
			
			var masterVo:SusbUsbMasterVO = myWindow.usbDG.selectedItem as SusbUsbMasterVO;
			
			facade.sendNotification(GlobalConst.D4GC_NOTIFY_DEPTTREEEXPAND, masterVo.userOrgId);
			
//			switch(myWindow.tabNavi.selectedIndex)
			switch((myWindow.tabNavi.selectedChild as NavigatorContent).id)
			{
				case "changeHistoryTab":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST, masterVo.sno);
					break;
				}
					
				case "useHistoryTab":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_USE_LIST, masterVo.sno);
					break;
				}
					
				case "deleteHistoryTab":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_DELETE_LIST, {sno:masterVo.sno});
					break;
				}
					
				case "usbFileListTab":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_STATUS_LIST, {sno:masterVo.sno, startDate:ApplicationFacade(facade).searchVO.startDate, endDate:ApplicationFacade(facade).searchVO.endDate});
					break;
				}
					
				case "remoteDeleteTab":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LIST, {sno:masterVo.sno, startDate:ApplicationFacade(facade).searchVO.startDate, endDate:ApplicationFacade(facade).searchVO.endDate});
					break;
				}	
					
				case "updateHistoryTab":
				{
					sendNotification(LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST, masterVo.sno);
					break;
				}
					
				default:
					break;
			}
			
			var usbList:IList = new ArrayList();
			var length:int = myWindow.usbDG.selectedItems.length;
			var item:SusbUsbMasterVO;
			for(var i:int = 0; i < length; i++)
			{
				item = myWindow.usbDG.selectedItems[i] as SusbUsbMasterVO;
				usbList.addItem(item);
			}
			ApplicationFacade(facade).selectedUSB = masterVo;
			ApplicationFacade(facade).selectedUSBList = usbList;
			
		}
		
		
		private function usbDeleteEventHandler(event:CloseEvent):void
		{
			if(event.detail == Alert.OK)
			{
//				sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_DELETE, ApplicationFacade(facade).selectedUSBList);
				var usbList:IList = new ArrayList();
				var length:int = myWindow.usbDG.selectedItems.length;
				var item:SusbUsbMasterVO;
				for(var i:int = 0; i < length; i++)
				{
					item = myWindow.usbDG.selectedItems[i] as SusbUsbMasterVO;
					usbList.addItem(item);
				}
				sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_DELETE, usbList);
			}
		}
		
		protected function emergencyKeyWindow_closeHandler(event:CloseEvent):void
		{
			myWindow.emergencyKeyWindow.authCodeInput.text = "";
			myWindow.emergencyKeyWindow.txtReason.text = "";
			myWindow.emergencyKeyWindow.emergencyKeyLabel.text = "";
			myWindow.popEmergencyKeyWindow.displayPopUp = false;
		}
		
		protected function emergencyKeyWindow_mouseDownOutsideHandler(event:FlexMouseEvent):void
		{
			myWindow.emergencyKeyWindow.authCodeInput.text = "";
			myWindow.emergencyKeyWindow.txtReason.text = "";
			myWindow.emergencyKeyWindow.emergencyKeyLabel.text = "";
			myWindow.popEmergencyKeyWindow.displayPopUp = false;
		}
		
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		protected function addWindow_closeHandler(event:CloseEvent):void
		{
			removeAddPopup();
		}
		
		protected function addWindow_mouseDownOutsideHandler(event:FlexMouseEvent):void
		{
			removeAddPopup();
		}
		
		protected function addWindow_creationCompleteHandler(event:FlexEvent):void
		{
			myWindow.addWindow.removeEventListener(FlexEvent.CREATION_COMPLETE, addWindow_creationCompleteHandler);
			var addWindowMediator:AddWindowMediator = new AddWindowMediator(myWindow.addWindow);
			addWindowMediator.setParentWindow = myWindow;			
			facade.registerMediator(addWindowMediator);
		}
		
		private function removeAddPopup():void
		{
			myWindow.addPop.displayPopUp = false;
			myWindow.addPop.x = 0;
		}
		
		/**
		 * mediator 등록시
		 */
		override public function onRegister():void
		{
			initializeDeptNavigator();
			myWindow.searchBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			//			myWindow.excelBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.addBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.modBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.unUseBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.pwdInitBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.initBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.returnBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.emergencyToolBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.emergencyKeyWindow.addEventListener(CloseEvent.CLOSE, emergencyKeyWindow_closeHandler);
			myWindow.emergencyKeyWindow.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, emergencyKeyWindow_mouseDownOutsideHandler);
			//			myWindow.isTimeCheck.labelFunction = stateLabelFunction;
			
			
			//myWindow.searchWindow.addEventListener(CloseEvent.CLOSE, searchWindow_closeHandler);
			//myWindow.searchWindow.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, searchWindow_mouseDownOutsideHandler);
			
			//권한설정
			var programName:String = "D4_SUSBMA_USBMANAGE";
			
			if(DmosFramework.getInstance().PERMISSION(programName))
			{
				myWindow.addBtn.includeInLayout = myWindow.addBtn.visible = DmosFramework.getInstance().PERMISSION(programName).isAbleCreate();
				myWindow.modBtn.includeInLayout = myWindow.modBtn.visible = DmosFramework.getInstance().PERMISSION(programName).isAbleUpdate();
				myWindow.delBtn.includeInLayout = myWindow.delBtn.visible = DmosFramework.getInstance().PERMISSION(programName).isAbleDelete();
			}
			
			var subProgramName:String = "POL_UNUSE";
			if(DmosFramework.getInstance().PERMISSION(programName).getSubProgramPermission(subProgramName)) {
				myWindow.unUseBtn.visible = true;
				myWindow.unUseBtn.includeInLayout = true;
			}else{
				myWindow.unUseBtn.visible = false;
				myWindow.unUseBtn.includeInLayout = false;
			}
			
			subProgramName = "POL_PWDINIT";
			if(DmosFramework.getInstance().PERMISSION(programName).getSubProgramPermission(subProgramName)) {
				myWindow.pwdInitBtn.visible = true;
				myWindow.pwdInitBtn.includeInLayout = true;
			}else{
				myWindow.pwdInitBtn.visible = false;
				myWindow.pwdInitBtn.includeInLayout = false;
			}
			
			subProgramName = "POL_EMGTOOL";
			if(DmosFramework.getInstance().PERMISSION(programName).getSubProgramPermission(subProgramName)) {
				myWindow.emergencyToolBtn.visible = true;
				myWindow.emergencyToolBtn.includeInLayout = true;
			}else{
				myWindow.emergencyToolBtn.visible = false;
				myWindow.emergencyToolBtn.includeInLayout = false;
			}
			
			subProgramName = "LOG_CHANGEHISTORY";
			if(!DmosFramework.getInstance().PERMISSION(programName).getSubProgramPermission(subProgramName))
				myWindow.tabNavi.removeChild(myWindow.changeHistoryTab);
			
			subProgramName = "LOG_USEHISTORY";
			if(!DmosFramework.getInstance().PERMISSION(programName).getSubProgramPermission(subProgramName))
				myWindow.tabNavi.removeChild(myWindow.useHistoryTab);
			
			subProgramName = "LOG_DELETEHISTORY";
			if(!DmosFramework.getInstance().PERMISSION(programName).getSubProgramPermission(subProgramName))
				myWindow.tabNavi.removeChild(myWindow.deleteHistoryTab);
			
			subProgramName = "LOG_USBFILEINFO";
			if(!DmosFramework.getInstance().PERMISSION(programName).getSubProgramPermission(subProgramName))
				myWindow.tabNavi.removeChild(myWindow.usbFileListTab);
			
			subProgramName = "LOG_REMOTEDELHISTORY";
			if(!DmosFramework.getInstance().PERMISSION(programName).getSubProgramPermission(subProgramName))
				myWindow.tabNavi.removeChild(myWindow.remoteDeleteTab);
			
			subProgramName = "LOG_UPDATEHISTORY";
			if(!DmosFramework.getInstance().PERMISSION(programName).getSubProgramPermission(subProgramName))
				myWindow.tabNavi.removeChild(myWindow.updateHistoryTab);
			
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.GS){
				myWindow.addBtn.includeInLayout = myWindow.addBtn.visible = false;
				myWindow.delBtn.includeInLayout = myWindow.delBtn.visible = false;
			}
			
			myWindow.deptNavigator.addEventListener(CustomTreeItemClickEvent.CUSTOM_TREEITEM_CLICK,
				treeItemClickHandler);
			myWindow.usbDG.addEventListener(GridSelectionEvent.SELECTION_CHANGE,
				selectionChangeHandler);
			myWindow.tabNavi.addEventListener(IndexChangedEvent.CHANGE, onTabChangeHandler);
			
			/**
			 * 20121015 김정욱 CSV 저장 추가 Start
			 * 
			 */
			myWindow.excelBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			/**
			 * 20121015 김정욱 CSV 저장 추가 End
			 * 
			 */
			loadColumnSetting();
			
			initializeScrollData();			
			myWindow.usbDG.scroller.verticalScrollBar.addEventListener(Event.CHANGE, viewChangeHandler);
			
			/**파일 Export 팝업 **/
			myWindow.fileExportWindow.addEventListener(CloseEvent.CLOSE, fileExportWindow_closeHandler);			
			myWindow.fileExportWindow.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, fileExportWindow_mouseDownOutsideHandler);			
			myWindow.fileExportWindow.addEventListener(FlexEvent.CREATION_COMPLETE, fileExportWindow_creationCompleteHandler);
			
			
			/** LabelFunction **/
			myWindow.capacity.labelFunction = capacityLabelFunction;
			myWindow.dataCapacity.labelFunction = dataCapacityLabelFunction;
			
			myWindow.addWindow.addEventListener(CloseEvent.CLOSE, addWindow_closeHandler);			
			myWindow.addWindow.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, addWindow_mouseDownOutsideHandler);			
			myWindow.addWindow.addEventListener(FlexEvent.CREATION_COMPLETE, addWindow_creationCompleteHandler);
			
			
			myWindow.searchBtn2.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.excelBtn2.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.searchBtn3.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.excelBtn3.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn2.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn3.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadMode.addEventListener(IndexChangeEvent.CHANGE, onReloadModeChanged);
		}
		
		protected var _refreshTimer:Timer = null;
		
		protected function set refreshTimer(timer:Timer):void
		{
			if( _refreshTimer )
			{
				_refreshTimer.stop();
				_refreshTimer.removeEventListener( TimerEvent.TIMER, onRefreshTimer );
				_refreshTimer = null;
			}
			
			_refreshTimer = timer;
		}
		
		protected function get refreshTimer():Timer
		{
			return _refreshTimer;
		}
		
		protected function onRefreshTimer(event:TimerEvent):void
		{
			myWindow.reloadBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		public function removeTimer():void {
			refreshTimer = null;
		}
		
		protected function onReloadModeChanged(event:IndexChangeEvent):void
		{
			var time:int = myWindow.reloadMode.selectedItem.value;
			
			refreshTimer = null;
			
			if(time != 0)
			{
				refreshTimer = new Timer(time*1000*60, 0);
				refreshTimer.addEventListener(TimerEvent.TIMER, onRefreshTimer );
				refreshTimer.start();
			}
		}
		
		protected function onInitTimer(event:TimerEvent):void
		{
			var params:Object = {};
			var sno:String = ApplicationFacade(facade).selectedInitSNO;
			
			if(time < 60){
				params.sno = sno;
				params.isFirst = 0;
				params.isDataDelete = 0; 
				params.pwd = "";
				sendNotification(LocalConst.D4LC_CMD_PASSWORD_INITIALIZE, params);
				time = time + 10;
			}else{
				Alert.show(DmosFramework.getInstance().SNL('SC_CMD_FAIL') + ' (' + DmosFramework.getInstance().SNL('SC_SERIAL_NO') + ' : ' + String(sno).substr(String(sno).length - 6 ,6) + ')', DmosFramework.getInstance().SNL('SC_PASSWORD_INITIALIZE'));	
				myWindow.pwdInitBtn.enabled = true;
				tmTimer.stop();
			}
		}
		/*
		protected function searchWindow_mouseDownOutsideHandler(event:FlexMouseEvent):void
		{
		myWindow.popSearchWindow.displayPopUp = false;
		}
		
		protected function searchWindow_closeHandler(event:CloseEvent):void
		{
		myWindow.popSearchWindow.displayPopUp = false;
		}
		*/
		/**
		 * mediator 제거시
		 */
		override public function onRemove():void
		{
			myWindow.searchBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			//			myWindow.excelBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.addBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.modBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.unUseBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.pwdInitBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.initBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.returnBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.emergencyToolBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			//myWindow.searchWindow.removeEventListener(CloseEvent.CLOSE, searchWindow_closeHandler);
			//myWindow.searchWindow.removeEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, searchWindow_mouseDownOutsideHandler);
			myWindow.emergencyKeyWindow.removeEventListener(CloseEvent.CLOSE, emergencyKeyWindow_closeHandler);
			myWindow.emergencyKeyWindow.removeEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, emergencyKeyWindow_mouseDownOutsideHandler);
			myWindow.deptNavigator.removeEventListener(CustomTreeItemClickEvent.CUSTOM_TREEITEM_CLICK,
				treeItemClickHandler);
			myWindow.usbDG.removeEventListener(GridSelectionEvent.SELECTION_CHANGE,
				selectionChangeHandler);
			myWindow.tabNavi.removeEventListener(IndexChangedEvent.CHANGE, onTabChangeHandler);
			
			//labelFunction
			myWindow.insideOfCompany.labelFunction = null;
			//			myWindow.isTimeCheck.labelFunction = null;
			/**
			 * 20121015 김정욱 CSV 저장 추가 Start
			 * 
			 */
			myWindow.excelBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			/**
			 * 20121015 김정욱 CSV 저장 추가 End
			 * 
			 */
			
			myWindow.usbDG.scroller.verticalScrollBar.removeEventListener(Event.CHANGE, viewChangeHandler);
			
			/**파일 Export 팝업 **/
			myWindow.fileExportWindow.removeEventListener(CloseEvent.CLOSE, fileExportWindow_closeHandler);			
			myWindow.fileExportWindow.removeEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, fileExportWindow_mouseDownOutsideHandler);
			myWindow.fileExportWindow.removeEventListener(FlexEvent.CREATION_COMPLETE, fileExportWindow_creationCompleteHandler);
			
			/** LabelFunction **/
			myWindow.capacity.labelFunction = null;
			myWindow.dataCapacity.labelFunction = null;
			
			myWindow.addWindow.removeEventListener(CloseEvent.CLOSE, addWindow_closeHandler);			
			myWindow.addWindow.removeEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, addWindow_mouseDownOutsideHandler);			
			myWindow.addWindow.removeEventListener(FlexEvent.CREATION_COMPLETE, addWindow_creationCompleteHandler);
		}
		
		protected function fileExportWindow_creationCompleteHandler(event:FlexEvent):void
		{
			myWindow.fileExportWindow.removeEventListener(FlexEvent.CREATION_COMPLETE, fileExportWindow_creationCompleteHandler);
			var fileExportWindowMediator:FileExportWindowMediator = new FileExportWindowMediator(myWindow.fileExportWindow);
			fileExportWindowMediator.setParentWindow = myWindow;			
			facade.registerMediator(fileExportWindowMediator);
		}
		
		protected function fileExportWindow_closeHandler(event:CloseEvent):void
		{
			removeFileExportPopup();
		}
		
		protected function fileExportWindow_mouseDownOutsideHandler(event:FlexMouseEvent):void
		{
			removeFileExportPopup();
		}
		
		private function removeFileExportPopup():void
		{
			myWindow.fileExportPop.displayPopUp = false;
			myWindow.fileExportPop.x = 0;
		}
		
		/**
		 * 관심있는 notification
		 */
		override public function listNotificationInterests():Array
		{
			return [
				//성공 notify
				LocalConst.SUSBMA_USBMANAGE_USB_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_USBMANAGE_USB_ADDSUCCESS,
				LocalConst.SUSBMA_USBMANAGE_USB_MODIFYSUCCESS,
				LocalConst.SUSBMA_USBMANAGE_USB_DELETESUCCESS,
				LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_USBMANAGE_USE_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_USBMANAGE_MNGEMPID_MODIFYSUCCESS,
				LocalConst.D4LC_NOTIFY_USB_RETURN_SUCCESS,
				LocalConst.D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL_SUCCESS,
				LocalConst.SUSBMA_USBMANAGE_DELETE_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_USBMANAGE_STATUS_LIST_LOADSUCCESS,
				LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LISTLOADSUCCESS,
				LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST_LOADSUCCESS,
				
				LocalConst.SUSBMA_USBMANAGE_MNGEMPID_MODIFYFAIL,
				LocalConst.SUSBMA_USBMANAGE_USB_LIST_LOADFAIL,
				LocalConst.SUSBMA_USBMANAGE_USB_ADDFAIL,
				LocalConst.SUSBMA_USBMANAGE_USB_MODIFYFAIL,
				LocalConst.SUSBMA_USBMANAGE_USB_DELETEFAIL,
				LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST_LOADFAIL,
				LocalConst.SUSBMA_USBMANAGE_USE_LIST_LOADFAIL,
				LocalConst.D4LC_NOTIFY_USB_RETURN_FAIL,
				LocalConst.SUSBMA_USBMANAGE_DELETE_LIST_LOADFAIL,
				LocalConst.SUSBMA_USBMANAGE_STATUS_LIST_LOADFAIL,
				LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LISTLOADFAIL,
				LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST_LOADFAIL,
				LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT
				
			];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				//Grid에 저장될 데이터 로드 성공
				case LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT:
				{
					var sno:String = ApplicationFacade(facade).selectedInitSNO;
					
					if(notification.getBody() == "3"){
						Alert.show(DmosFramework.getInstance().SNL('SC_COMMAND_FAIL') + ' (' + DmosFramework.getInstance().SNL('SC_SERIAL_NO') + ' : ' + String(sno).substr(String(sno).length - 6 ,6) + ')', DmosFramework.getInstance().SNL('SC_PASSWORD_INITIALIZE'));	
						myWindow.pwdInitBtn.enabled = true;
					}else{
						if(int(DmosFramework.getInstance().CONFIG('SUSB_PASSWDINIT_TYPE')) == 1){
							if(notification.getBody() == "2"){
								time = 0;
								tmTimer = new Timer( (10 * 1000) );
								tmTimer.addEventListener(TimerEvent.TIMER, onInitTimer);
								tmTimer.start();
							}else if(notification.getBody() == "1"){
								Alert.show(DmosFramework.getInstance().SNL('SC_CMD_COMP_D4') + ' (' + DmosFramework.getInstance().SNL('SC_SERIAL_NO') + ' : ' + String(sno).substr(String(sno).length - 6 ,6) + ')', DmosFramework.getInstance().SNL('SC_PASSWORD_INITIALIZE'));	
								tmTimer.stop();
								myWindow.pwdInitBtn.enabled = true;
							}
						}else{
							Alert.show(DmosFramework.getInstance().SNL('SC_CMD_COMP_D4') + ' (' + DmosFramework.getInstance().SNL('SC_SERIAL_NO') + ' : ' + String(sno).substr(String(sno).length - 6 ,6) + ')', DmosFramework.getInstance().SNL('SC_PASSWORD_INITIALIZE'));	
							myWindow.pwdInitBtn.enabled = true;
						}
					}
					
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_USB_LIST_LOADSUCCESS:
				{
					changeToolbarEnable(LocalConst.BTN_SEARCH, true);
					changeToolbarEnable(LocalConst.BTN_EXCEL, false);
					changeToolbarEnable(LocalConst.BTN_ADD, true);
					changeToolbarEnable(LocalConst.BTN_MOD, false);
					changeToolbarEnable(LocalConst.BTN_DEL, false);
					changeToolbarEnable(LocalConst.BTN_UNUSE, false);
					changeToolbarEnable(LocalConst.BTN_PWDINIT, false);
					changeToolbarEnable(LocalConst.BTN_RELOAD, true);
					
					var result:Object = notification.getBody();
					if(result == null) return;
					if(result.hasOwnProperty("LIST") && result.hasOwnProperty("COUNT"))
					{
						//myWindow.usbArr = result.LIST as ArrayCollection;
						getLogList(notification.getBody().LIST);
						myWindow.searchResultCount = int(result.COUNT);
					}
					
					if(myWindow.usbArr.length > 0)
					{
						myWindow.usbDG.enabled = true;
						myWindow.tabNavi.enabled = true;
						//20130409 김정욱 데이터가 있을 경우 엑셀 저장 버튼 활성화 - START
						myWindow.excelBtn.enabled = true;
						//20130409 김정욱 데이터가 있을 경우 엑셀 저장 버튼 활성화 - END
						
						
						myWindow.usbDG.selectedIndex = 0;
						/*
						myWindow.usbDG.dispatchEvent(new GridSelectionEvent(GridSelectionEvent.SELECTION_CHANGE,
						false,
						false,
						null,
						new CellRegion(0,
						0)));
						*/
						
						var masterVo:SusbUsbMasterVO = myWindow.usbDG.selectedItem as SusbUsbMasterVO;
						
						if(isRefresh) {
							switch(myWindow.tabNavi.selectedIndex)
							{
								case 0:
								{
									sendNotification(LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST, masterVo.sno);
									break;
								}
									
								case 1:
								{
									sendNotification(LocalConst.SUSBMA_USBMANAGE_USE_LIST, masterVo.sno);
									break;
								}
									
								case 2:
								{
									sendNotification(LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST, masterVo.sno);
									break;
								}
									
								case 3:
								{
									var startDate:String = null;
									var endDate:String = null;
									sendNotification(LocalConst.SUSBMA_USBMANAGE_STATUS_LIST, {sno:masterVo.sno, startDate:null, endDate:null});
									break;
								}
									
								case 4:
								{
									var startDate:String = null;
									var endDate:String = null;
									sendNotification(LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LIST, {sno:masterVo.sno, startDate:null, endDate:null});
									break;
								}
									
								case 5:
								{
									sendNotification(LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST, masterVo.sno);
									break;
								}
									
								default:
									break;
							}
						}
						
						var usbList:IList = new ArrayList();
						var length:int = myWindow.usbDG.selectedItems.length;
						var item:SusbUsbMasterVO;
						for(var i:int = 0; i < length; i++)
						{
							item = myWindow.usbDG.selectedItems[i] as SusbUsbMasterVO;
							usbList.addItem(item);
						}
						ApplicationFacade(facade).selectedUSB = masterVo;
						ApplicationFacade(facade).selectedUSBList = usbList;
						
						changeToolbarEnable(LocalConst.BTN_EXCEL, true);
						changeToolbarEnable(LocalConst.BTN_MOD, true);
						changeToolbarEnable(LocalConst.BTN_DEL, true);
						changeToolbarEnable(LocalConst.BTN_UNUSE, true);
						changeToolbarEnable(LocalConst.BTN_PWDINIT, true);
						myWindow.usbDG.setFocus();
					}else{
						
						myWindow.usbDG.enabled = false;
						myWindow.tabNavi.enabled = false;
						//20130409 김정욱 데이터가 있을 경우 엑셀 저장 버튼 활성화 - START
						myWindow.excelBtn.enabled = false;
						//20130409 김정욱 데이터가 있을 경우 엑셀 저장 버튼 활성화 - END
						
						//선택된 USB 정보가 없으면 이력 정보도 clear 한다.
						if(myWindow.changeHistoryDG.dataProvider != null 
							&& myWindow.changeHistoryDG.dataProvider.length > 0) myWindow.changeHistoryDG.dataProvider.removeAll();
						if(myWindow.useHistoryDG.dataProvider != null 
							&& myWindow.useHistoryDG.dataProvider.length > 0) myWindow.useHistoryDG.dataProvider.removeAll();
					}
					//20130409 김정욱 새로고침을 반복적으로 클릭 시 조회 범위보다 많이 불러오는 현상을 막기 위해 새로고침 버튼 disable 처리 - START
					myWindow.reloadBtn.enabled = true;
					//20130409 김정욱 새로고침을 반복적으로 클릭 시 조회 범위보다 많이 불러오는 현상을 막기 위해 새로고침 버튼 disable 처리 - END
					//sendNotification(LocalConst.D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL);
					break;
				}
					
					//Grid에 저장될 데이터 로드 실패
				case LocalConst.SUSBMA_USBMANAGE_USB_LIST_LOADFAIL:
				{
					break;
				}
					
					//새항목 추가 성공
				case LocalConst.SUSBMA_USBMANAGE_USB_ADDSUCCESS:
				{
					initialize();
					initializeScrollData();
					getSearchCondition().startIdx = _startIdx;
					facade.sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, getSearchCondition());
					break;
				}
					
					//새항목 추가 실패
				case LocalConst.SUSBMA_USBMANAGE_USB_ADDFAIL:
				{
					break;
				}
					
					//항목 수정 성공
				case LocalConst.SUSBMA_USBMANAGE_USB_MODIFYSUCCESS:
				{
					facade.sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, getSearchCondition());
					break;
				} 
					//일괄변경성공
				case LocalConst.SUSBMA_USBMANAGE_MNGEMPID_MODIFYSUCCESS:
				{
					initializeScrollData();
					getSearchCondition().startIdx = _startIdx;
					facade.sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, getSearchCondition());
					break;
				} 
					
					//항목 수정 성공
				case LocalConst.SUSBMA_USBMANAGE_USB_MODIFYFAIL:
				{
					break;
				}
					
					//항목 삭제 성공
				case LocalConst.SUSBMA_USBMANAGE_USB_DELETESUCCESS:
				{
					//20130411 김정욱 데이터가 있을 경우 엑셀 저장 버튼 활성화 - START
					initializeScrollData();
					getSearchCondition().startIdx = _startIdx;
					//20130411 김정욱 데이터가 있을 경우 엑셀 저장 버튼 활성화 - END
					facade.sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, getSearchCondition());
					break;
				}
					
					//항목 삭제 실패
				case LocalConst.SUSBMA_USBMANAGE_USB_ADDFAIL:
				{
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST_LOADSUCCESS:
				{
					myWindow.changeHistoryDG.dataProvider = notification.getBody() as ArrayCollection;
					if(myWindow.changeHistoryDG.dataProvider.length == 0)
					{
						myWindow.changeHistoryDG.enabled = false;
					}else{
						myWindow.changeHistoryDG.enabled = true;
					}
					sendNotification(LocalConst.D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL);
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST_LOADFAIL:
				{
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_USE_LIST_LOADSUCCESS:
				{
					myWindow.useHistoryDG.dataProvider = notification.getBody() as ArrayCollection;
					if(myWindow.useHistoryDG.dataProvider.length == 0)
					{
						myWindow.useHistoryDG.enabled = false;
					}else{
						myWindow.useHistoryDG.enabled = true;
					}
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_USB_LIST_LOADFAIL:
				{
					break;
				}
				
				case LocalConst.D4LC_NOTIFY_USB_RETURN_SUCCESS:
				{
					initializeScrollData();
					getSearchCondition().startIdx = _startIdx;
					facade.sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, getSearchCondition());
					break;
				}
				
				case LocalConst.D4LC_NOTIFY_USB_RETURN_FAIL:
				{
					break;
				}
				
				case LocalConst.D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL_SUCCESS:
				{
					var data:int = 0;
					data = notification.getBody() as int;
					if(DmosFramework.getInstance().CUSTOMERID == 188){
						if(data == 2){
							myWindow.delBtn.visible = false;
							myWindow.addBtn.visible = false;
							myWindow.delBtn.includeInLayout = false;
							myWindow.addBtn.includeInLayout = false;
						}
					}
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_DELETE_LIST_LOADSUCCESS:
				{
					myWindow.deleteHistoryDG.dataProvider = notification.getBody() as ArrayCollection;
					if(myWindow.deleteHistoryDG.dataProvider.length == 0)
					{
						myWindow.deleteHistoryDG.enabled = false;
					}else{
						myWindow.deleteHistoryDG.enabled = true;
					}
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_DELETE_LIST_LOADFAIL:
				{
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_STATUS_LIST_LOADSUCCESS:
				{
					myWindow.statusDG.dataProvider = notification.getBody() as ArrayCollection;
					myWindow.searchResultCount2 = myWindow.statusDG.dataProvider.length;
					if(myWindow.statusDG.dataProvider.length == 0)
					{
						myWindow.statusDG.enabled = false;
						myWindow.excelBtn2.enabled = false;
					}else{
						myWindow.statusDG.enabled = true;
						myWindow.excelBtn2.enabled = true;
					}
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_STATUS_LIST_LOADFAIL:
				{
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LISTLOADSUCCESS:
				{
					myWindow.remoteDeleteHistoryDG.dataProvider = notification.getBody() as ArrayCollection;
					myWindow.searchResultCount3 = myWindow.remoteDeleteHistoryDG.dataProvider.length;
					if(myWindow.remoteDeleteHistoryDG.dataProvider.length == 0)
					{
						myWindow.remoteDeleteHistoryDG.enabled = false;
						myWindow.excelBtn3.enabled = false;
					}else{
						myWindow.remoteDeleteHistoryDG.enabled = true;
						myWindow.excelBtn3.enabled = true;
					}
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LISTLOADFAIL:
				{
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST_LOADSUCCESS:
				{
					myWindow.updateHistoryDG.dataProvider = notification.getBody() as ArrayCollection;
					
					if(myWindow.updateHistoryDG.dataProvider.length == 0)
					{
						myWindow.updateHistoryDG.enabled = false;
					}else{
						myWindow.updateHistoryDG.enabled = true;
					}					
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST_LOADFAIL:
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
			switch(context.toString())
			{
//				case "ADD":
//				{
//					var addVO:SusbUsbMasterVO = extra as SusbUsbMasterVO;
//					sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_ADD, addVO);
//					break;
//				}
				case "MODIFY":
				{
					var length:int = ApplicationFacade(facade).selectedUSBList.length;
					
					/*	2014.01.16
					*   관리번호 일괄변경 
					*/
					if(length > 1)
					{
						for(var i:int = 0; i < length; i++)
						{		
							var selectedUsbVO:SusbUsbMasterVO;	 					// 선택한 USB의 정보	
							var chgVO:SusbChangeHistoryVO = extra as SusbChangeHistoryVO;  
							
							selectedUsbVO = myWindow.usbDG.selectedItems[i] as SusbUsbMasterVO;
							selectedUsbVO.mngEmpId = chgVO.mngEmpId;
							selectedUsbVO.isDeptType = chgVO.isDeptType;
							selectedUsbVO.orgNameList = chgVO.orgNameList;
							sendNotification(LocalConst.SUSBMA_USBMANAGE_MNGEMPID_MODIFY, selectedUsbVO);  //	일괄변경 호출
						} 
					}else{
						var modVO:SusbChangeHistoryVO = extra as SusbChangeHistoryVO;
						//20130410 김정욱 검색창에서  이전 데이터 지워지지 않는 현상 수정  #1647 - START
						initializeScrollData();
						getSearchCondition().startIdx = _startIdx;
						//20130410 김정욱 검색창에서  이전 데이터 지워지지 않는 현상 수정  #1647 - END
						sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_MODIFY, modVO);
						break;
					}
					
					break;
				}
					
				case "SEARCH":
				{
					var searchVO:SearchSusbMasterVO = extra as SearchSusbMasterVO;
					ApplicationFacade(facade).searchVO = searchVO;
					initializeScrollData();
					searchVO.startIdx = _startIdx;
					sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, searchVO);
					break;
				}
					
				case "SEARCH2":
				{
					var searchVO:SearchSusbMasterVO = extra as SearchSusbMasterVO;
					ApplicationFacade(facade).searchVO2 = searchVO;
					searchVO.startIdx = _startIdx;
					sendNotification(LocalConst.SUSBMA_USBMANAGE_STATUS_LIST,  {sno:myWindow.usbDG.selectedItem.sno, startDate:ApplicationFacade(facade).searchVO.startDate, endDate:ApplicationFacade(facade).searchVO.endDate});
					break;
				}
					
				case "SEARCH3":
				{
					var searchVO:SearchSusbMasterVO = extra as SearchSusbMasterVO;
					ApplicationFacade(facade).searchVO2 = searchVO;
					searchVO.startIdx = _startIdx;
					sendNotification(LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LIST,  {sno:myWindow.usbDG.selectedItem.sno, startDate:ApplicationFacade(facade).searchVO.startDate, endDate:ApplicationFacade(facade).searchVO.endDate});
					break;
				}
					
				case "DELETE":
				{
					var masterVO:SusbUsbMasterVO = extra as SusbUsbMasterVO;
					sendNotification(LocalConst.D4LC_CMD_USB_RETURN, masterVO);
					break;
				}
				
				case "INITPWD":
				{
					var rt:int = extra as Number;
					if(rt == 0){
						myWindow.pwdInitBtn.enabled = true;
					}
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
		
		private function loadColumnSetting():void
		{
			//labelFunction
			myWindow.insideOfCompany.labelFunction = insideOfCompanyLabelFunction;
			//myWindow.isDeptType.labelFunction = isDeptTypeLabelFunction;
			/*
			var labelFunctionDatas:Vector.<LabelFunctionData> = new Vector.<LabelFunctionData>();
			
			
			
			var insideOfCompanyColumn:LabelFunctionData = new LabelFunctionData();
			insideOfCompanyColumn.column = myWindow.insideOfCompany;
			insideOfCompanyColumn.labelFunction = insideOfCompanyLabelFunction;
			labelFunctionDatas.push(insideOfCompanyColumn);
			
			var fileName:String;
			
			fileName = ApplicationFacade.NAME + "_" + myWindow.usbDG.id + "_" + ApplicationFacade(facade).userId;
			myWindow.columnSettingBtn.load(fileName,labelFunctionDatas);*/
		}
		
		protected var _excelExportWindow:SZExcelExportWindow = null;
		
		protected function set excelExportWindow(wnd:SZExcelExportWindow):void
		{
			_excelExportWindow = wnd;
		}
		
		protected function get excelExportWindow():SZExcelExportWindow
		{
			return _excelExportWindow;
		}
		
		protected function excelExportWindow_closeHandler(event:Event):void
		{
			excelExportWindowClose();
		}
		
		protected function excelExportWindowClose():void
		{
			excelExportWindow.removeEventListener( SZExcelExportWindow.EXCEL_EXPORT_WND_CLOSE, excelExportWindow_closeHandler );
			excelExportWindow.removeEventListener( SZExcelExportWindow.EXCEL_EXPORT_WND_EXECUTE, excelExportWindow_executeHandler );
			
			PopUpManager.removePopUp(excelExportWindow);
			
			excelExportWindow = null;
		}
		
		public function excelExportWindow_executeHandler(event:Event):void
		{
			exportToExcel(1);
		}
		
		private function excelExportWindowPopup():void
		{
			
			excelExportWindow = PopUpManager.createPopUp( myWindow, SZExcelExportWindow, true ) as SZExcelExportWindow;
			
			PopUpManager.centerPopUp(excelExportWindow);
			
			var nowDate:Date = new Date();
			var monthStr:String = ( (nowDate.month+1)<10 ? "0" : "") +  (nowDate.month+1);
			var dayStr:String = (nowDate.date<10 ? "0" : "") + nowDate.date;
			var excelFileName:String = DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE") + "_" + nowDate.fullYear + monthStr + dayStr;
			
			excelExportWindow.$excelFileName = excelFileName;
			
			excelExportWindow.addEventListener( SZExcelExportWindow.EXCEL_EXPORT_WND_CLOSE, excelExportWindow_closeHandler );
			excelExportWindow.addEventListener( SZExcelExportWindow.EXCEL_EXPORT_WND_EXECUTE, excelExportWindow_executeHandler);
		}
		
		private function exportToExcel(type:int):void
		{
			var request:URLRequest;
			var params:URLVariables = new URLVariables();
			var columns:IList;
			
			if(type == 1){ 
				columns = myWindow.usbDG.columns;
				request = new URLRequest("/usbMasterExportExcel.htm");
			}else if(type == 2){  
				columns = myWindow.statusDG.columns;
				request = new URLRequest("/usbMasterStatusExportExcel.htm");
			}else if(type == 3){  
				columns = myWindow.remoteDeleteHistoryDG.columns;
				request = new URLRequest("/usbMasterDeleteRemoteExportExcel.htm");
			}
			request.method = URLRequestMethod.POST;
			
			var column:GridColumn;
			var titles:Array = [];
			var props:Array = [];
			var length:int = columns.length;
			
			var nowDate:Date = new Date();
			var monthStr:String = ( (nowDate.month+1)<10 ? "0" : "") +  (nowDate.month+1);
			var dayStr:String = (nowDate.date<10 ? "0" : "") + nowDate.date;
			var fileName:String = '';
			var extension:String = '';
			
			for(var i:int = 0; i < length; i++)
			{
				column = columns.getItemAt(i) as GridColumn;
				
				//20130305 김정욱 엑셀 출력 시  column중 dummy column으로 인해 저장 시 에러 수정 START
				if(type == 1)
					if(column.dataField == myWindow.usbDG.FIX_LAST_DATA) continue;
				else if(type == 2)
					if(column.dataField == myWindow.statusDG.FIX_LAST_DATA) continue;
				else if(type == 3)
					if(column.dataField == myWindow.remoteDeleteHistoryDG.FIX_LAST_DATA) continue;
				//20130305 김정욱 엑셀 출력 시  column중 dummy column으로 인해 저장 시 에러 수정 END
				
				titles.push(column.headerText);
				props.push(column.dataField);
			}
			
			if(type == 1){
				extension = String(excelExportWindow.extGroup.selectedValue);
				fileName = excelExportWindow.excelFileName.text + "." + extension;
				params.rowCount = excelExportWindow.lineCount.text;
				params.deptNameType = excelExportWindow.deptNameGroup.selectedValue;
				params.searchVo = com.adobe.serialization.json.JSON.encode(ApplicationFacade(facade).searchVO);
			}else if(type == 2){
				params.rowCount = 0;
				fileName = DmosFramework.getInstance().SNL('SC_USB_FILE_LIST_STATUS') + "_" + nowDate.fullYear + monthStr + dayStr + ".xls";
				ApplicationFacade(facade).searchVO2.sno = myWindow.usbDG.selectedItem.sno;
				ApplicationFacade(facade).searchVO2.startDateStr = ApplicationFacade(facade).searchVO.startDate;
				ApplicationFacade(facade).searchVO2.endDateStr = ApplicationFacade(facade).searchVO.endDate;
				params.rowCount = 0;
				params.deptNameType = 0;
				params.searchVo2 = com.adobe.serialization.json.JSON.encode(ApplicationFacade(facade).searchVO);
			}else if(type == 3){
				fileName = DmosFramework.getInstance().SNL('SC_REMOTE_DELETE_LIST_STATUS') + "_" + nowDate.fullYear + monthStr + dayStr + ".xls";
				ApplicationFacade(facade).searchVO2.sno = myWindow.usbDG.selectedItem.sno;
				ApplicationFacade(facade).searchVO2.startDateStr = ApplicationFacade(facade).searchVO.startDate;
				ApplicationFacade(facade).searchVO2.endDateStr = ApplicationFacade(facade).searchVO.endDate;
				params.rowCount = 0;
				params.deptNameType = 0;
				params.searchVo2 = com.adobe.serialization.json.JSON.encode(ApplicationFacade(facade).searchVO);
			}
			
			
			params.titleName = titles;
			params.titleProperty = props;
			params.fileName = fileName;
			params.extension = extension;
			request.data = params;
			navigateToURL(request, "_self");
		}
		
		/**
		 * deptNavigator의 초기화
		 */
		private function initializeDeptNavigator():void
		{
			myWindow.deptNavigator.facade = facade;
			if(int(DmosFramework.getInstance().CONFIG('ORGTREE_INCLUDE_RESIGNORG')) == 1){
				myWindow.deptNavigator.mode = int(DmosFramework.getInstance().CONFIG('ORGTREE_QUERYID_RESIGNORG')); // n > 100 
			}else{
				myWindow.deptNavigator.mode = 0;
			}
			
			myWindow.deptNavigator.queryOrgTree();
		}
		
		private function getSearchCondition():SearchSusbMasterVO
		{
//			if(myWindow.deptNavigator.deptTree.selectedIndex > -1)
//				ApplicationFacade(facade).searchVO.orgId = myWindow.deptNavigator.deptTree.selectedItem.orgId;
			
			return ApplicationFacade(facade).searchVO;
		}
		
		
		private function insideOfCompanyLabelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			switch(value)
			{
				case 0:
				{
					//사외
					return DmosFramework.getInstance().SNL('SC_OUTSIDE_COMPANY');
					break;
				}
					
				case 1:
				{
					//사내
					return DmosFramework.getInstance().SNL('SC_INSIDE_COMPANY');
					break;
				}
					
				default:
				{
					return "";
				}
			}
		}
		
		private function dataCapacityLabelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			if(value != 0) return value + "GB";
			else return "";
		}
		
		private function capacityLabelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			return value + "GB";
		}
		
		private function isDeptTypeLabelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			switch(value)
			{
				case 0:
				{
					return '';
					break;
				}
					
				case 1:
				{
					// 1값은 부서용
					return DmosFramework.getInstance().SNL('SC_DEPT_TYPE');
					break;
				}
					
				default:
				{
					return "";
				}
			}
		}
		
		public function changeToolbarEnable(btn:int, enable:Boolean):void
		{
			switch(btn)
			{
				case LocalConst.BTN_SEARCH:
				{
					myWindow.searchBtn.enabled = enable;
					break;
				}
				case LocalConst.BTN_EXCEL:
				{
					//					myWindow.excelBtn.enabled = enable;
					break;
				}
				case LocalConst.BTN_ADD:
				{
					myWindow.addBtn.enabled = enable;
					break;
				}
				case LocalConst.BTN_MOD:
				{
					myWindow.modBtn.enabled = enable;
					break;
				}
					
				case LocalConst.BTN_DEL:
				{
					myWindow.delBtn.enabled = enable;
					break;
				}
					
				case LocalConst.BTN_UNUSE:
				{
					myWindow.unUseBtn.enabled = enable;
					break;
				}
					
				case LocalConst.BTN_PWDINIT:
				{
					myWindow.pwdInitBtn.enabled = enable;
					break;
				}
					
				case LocalConst.BTN_RELOAD:
				{
					myWindow.reloadBtn.enabled = enable;
					break;
				}
			}
			
		}
		
		//스크롤 이동 시 데이터 조회
		protected function viewChangeHandler(evnet:Event):void {
			var vscrollbar:VScrollBar = myWindow.usbDG.scroller.verticalScrollBar;
			if(myWindow.searchResultCount > _loadedCnt){
				if(0.9 * vscrollbar.maximum < vscrollbar.viewport.verticalScrollPosition){
					myWindow.usbArr.disableAutoUpdate();
					isRefresh = false;
					_startIdx += _pageSize;
					ApplicationFacade(facade).searchVO.startIdx = _startIdx;
					facade.sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, ApplicationFacade(facade).searchVO);
					vscrollbar.viewport.verticalScrollPosition = vscrollbar.maximum;
					myWindow.usbArr.enableAutoUpdate();
				}
			}
		}
		
		private function getLogList(list:IList):void {
			_loadedCnt += _pageSize;
			
			if(myWindow.usbArr == null) myWindow.usbArr = new ArrayCollection();
			
			if( list != null){
				for(var i:int=0;i<list.length;i++) {
					myWindow.usbArr.addItem(list.getItemAt(i));
				}
				
			}
		}
		
		private function initializeScrollData():void {
			var vscrollbar:VScrollBar = myWindow.usbDG.scroller.verticalScrollBar;
			
			_loadedCnt = 0;
			_startIdx = 0;
			isRefresh = true;
			
			vscrollbar.viewport.verticalScrollPosition = 0;
			
			if(myWindow.usbArr == null) myWindow.usbArr = new ArrayCollection();
			else myWindow.usbArr.removeAll();
		}
		
		private function stateLabelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			switch(value)
			{
				/**
				 * Agent 상태 값과 맞춤
				 * 0: 무제한
				 * 1: 기간만료
				 * 2: 기간 내
				 * */
				case 1:
				{
					return DmosFramework.getInstance().SNL('SC_EXPIRE_PERIOD');
					break;
				}
				case 2:
				{
					return "";
					break;
				}
				default:
				{
					return DmosFramework.getInstance().SNL('SC_SAHRE_UNLIMITED');
				}
			}
		}
		
		private function initialize():void{
			ApplicationFacade(facade).searchVO.startDate 		= null;
			ApplicationFacade(facade).searchVO.endDate 		= null;
			ApplicationFacade(facade).searchVO.startLastConnectDate = null;
			ApplicationFacade(facade).searchVO.endLastConnectDate   = null;
			ApplicationFacade(facade).searchVO.sno 			= null;
			ApplicationFacade(facade).searchVO.managementId 	= null;
			ApplicationFacade(facade).searchVO.empName 		= null
			ApplicationFacade(facade).searchVO.userOrgName   	= null;
			ApplicationFacade(facade).searchVO.mngEmpName  	= null;
			ApplicationFacade(facade).searchVO.mediaId     	= -1;
			ApplicationFacade(facade).searchVO.stateId   	 	= -1;
			ApplicationFacade(facade).searchVO.classList	 	= null;
			ApplicationFacade(facade).searchVO.retireState = 0;
			ApplicationFacade(facade).searchVO.orgId = null;
			ApplicationFacade(facade).searchVO.userOrgName = null;
			ApplicationFacade(facade).searchVO.isoVersion = null;
			ApplicationFacade(facade).searchVO.requestState = -1;
		}
		
	}
}

