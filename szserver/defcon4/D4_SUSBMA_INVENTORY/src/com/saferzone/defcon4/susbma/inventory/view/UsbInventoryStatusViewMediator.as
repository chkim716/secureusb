package com.saferzone.defcon4.susbma.inventory.view
{
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONEncoder;
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.ISZPopupResponder;
	import com.saferzone.defcon4.common.consts.CustomerId;
	import com.saferzone.defcon4.common.events.ColumnChangeEvent;
	import com.saferzone.defcon4.common.events.ColumnResizedEvent;
	import com.saferzone.defcon4.common.events.CustomTreeItemClickEvent;
	import com.saferzone.defcon4.common.utils.classes.LabelFunctionData;
	import com.saferzone.defcon4.services.vo.SusbmaInventoryStatusVO;
	import com.saferzone.defcon4.susbma.inventory.ApplicationFacade;
	import com.saferzone.defcon4.susbma.inventory.consts.LocalConst;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryStatusAddPopup;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryStatusDelPopup;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryStatusModPopup;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryStatusSchPopup;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryStatusView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import spark.components.VScrollBar;
	import spark.components.gridClasses.GridColumn;
	import spark.events.GridSelectionEvent;
	
	/**
	 * USB재고현황 미디에이터
	 * 재고현황 관련 중재자 역할
	 * @author lmj
	 */	
	public class UsbInventoryStatusViewMediator extends Mediator implements ISZPopupResponder
	{
		/**
		 * Constants 
		 */		
		public static const NAME:String = "UsbInventoryStatusViewMediator";
		
		/**
		 * 스크롤 이동 시 데이터 조회
		 * 스크롤 이동 시 DB에서 읽어올 ROW 수가 null이 아니면 값할당
		 * null 일 시 100 할당
		 */		
		private var _pageSize:uint = DmosFramework.getInstance().CONFIG("LOAD_PAGE_SIZE")!=null?int(DmosFramework.getInstance().CONFIG("LOAD_PAGE_SIZE")):100;		
		private var _loadedCnt:uint = 0;
		private var _startIdx:uint = 0;
		
		/**
		 * Constructor
		 * @param viewComponent
		 */		
		public function UsbInventoryStatusViewMediator(viewComponent:Object)
		{
			super(NAME,viewComponent);
		}
		
		/**
		 * 컴포넌트 get 함수
		 * @return viewComponent
		 */		
		public function get myWindow():UsbInventoryStatusView
		{
			return viewComponent as UsbInventoryStatusView;
		}
		
		/**
		 * 버튼 클릭 Event Listener
		 */
		protected function onBtnClickHandler(event:MouseEvent):void
		{
			switch(event.currentTarget.id) 
			{
				case "searchBtn" :						//재고검색 버튼 클릭 시
				{
					var schPopup:UsbInventoryStatusSchPopup;
					var schPopupMediator:UsbInventoryStatusSchPopupMediator;
					schPopup = PopUpManager.createPopUp(myWindow, UsbInventoryStatusSchPopup,
						true) as UsbInventoryStatusSchPopup;
					PopUpManager.centerPopUp(schPopup);
					
					schPopupMediator = new UsbInventoryStatusSchPopupMediator(schPopup);
					schPopupMediator.setPopupResponder(this, "SEARCH");
					
					facade.registerMediator(schPopupMediator);
					
					schPopupMediator.setSearchCondition(ApplicationFacade(facade).statusVo);
					break;
				}
				
				case "addBtn" :				//재고등록 버튼 클릭 시
				{
					var addPopup:UsbInventoryStatusAddPopup;
					var addPopupMediator:UsbInventoryStatusAddPopupMediator;
					
					addPopup = PopUpManager.createPopUp(myWindow, UsbInventoryStatusAddPopup,
						true) as UsbInventoryStatusAddPopup;
					PopUpManager.centerPopUp(addPopup);
					
					addPopupMediator = new UsbInventoryStatusAddPopupMediator(addPopup);
					addPopupMediator.setPopupResponder(this, "ADD");
					
					facade.registerMediator(addPopupMediator);
					break;
				}
					
				case "modBtn" :			//재고수정 버튼 클릭 시
				{
					if(myWindow.statusVWGrid.selectedIndex < 0)
						return;
					
					var modPopup:UsbInventoryStatusModPopup;
					var modPopupMediator:UsbInventoryStatusModPopupMediator;
					modPopup = PopUpManager.createPopUp(myWindow, UsbInventoryStatusModPopup,
						true) as UsbInventoryStatusModPopup;
					PopUpManager.centerPopUp(modPopup);
					
					modPopupMediator = new UsbInventoryStatusModPopupMediator(modPopup);
					modPopupMediator.setPopupResponder(this, "MODIFY");
					
					modPopupMediator.setSearchCondition(ApplicationFacade(facade).selectedVo);
					
					facade.registerMediator(modPopupMediator);
					break;
				}
				
				case "excelBtn":
				{
					exportToExcel();
					break;
				}
					
				case "delBtn" :			//재고삭제 버튼 클릭 시
				{
					if(DmosFramework.getInstance().CUSTOMERID != CustomerId.SFA)
					{
						if(myWindow.statusVWGrid.selectedIndex < 0)
							return;
						
						var delPopup:UsbInventoryStatusDelPopup;
						var delPopupMediator:UsbInventoryStatusDelPopupMediator;
						delPopup = PopUpManager.createPopUp(myWindow, UsbInventoryStatusDelPopup,
							true) as UsbInventoryStatusDelPopup;
						PopUpManager.centerPopUp(delPopup);
						
						delPopupMediator = new UsbInventoryStatusDelPopupMediator(delPopup);
						delPopupMediator.setPopupResponder(this, "DELETE");
						
						delPopupMediator.setSearchCondition(ApplicationFacade(facade).selectedVo);
						
						facade.registerMediator(delPopupMediator);	
					}
					else
					{
						if(ApplicationFacade(facade).selectedVo.sfa_state != 0)
						{
							Alert.show(DmosFramework.getInstance().SNL("SC_UNUSE_USB_DELETE_POSSIBLE"), DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_INVENTORY"));
							return;
						}
						
						Alert.show(DmosFramework.getInstance().SNL('SC_ENTER_SNO_DELETE'), DmosFramework.getInstance().SNL('SC_DELETE_THE_STOC_D4'),
							Alert.OK | Alert.CANCEL, myWindow.parentApplication as Sprite,
							sfa_deleteEventHandler, null, Alert.OK);
						
					}
					break;
				}
				
				case "reloadBtn" :			//새로고침 버튼 클릭 시
				{
					if(ApplicationFacade(facade).statusVo == null) return;
					
					myWindow.reloadBtn.enabled = false;
					initializeScrollData();
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
					break;
				}
				
				case "initBtn" :			//초기화 버튼 클릭 시
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_INITIALIZE"), DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_INVENTORY"));
					ApplicationFacade(facade).statusVo.topCount = _pageSize;
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					ApplicationFacade(facade).statusVo.state = -1;
					initialize();
					myWindow.initBtn.enabled = false;
					initializeScrollData();
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
					break;
				}	
					
				default : break;
			}
		}
		
		private function sfa_deleteEventHandler(event:CloseEvent):void
		{
			if(event.detail == Alert.OK)
			{
				var sno:String = ApplicationFacade(facade).selectedVo.inventorySno;

				var statusVO:SusbmaInventoryStatusVO = new SusbmaInventoryStatusVO;
				statusVO.startInventorySno = sno.substr(sno.length-6, 6);
				facade.sendNotification(LocalConst.USB_INVENTORY_STATUS_DELETE, statusVO);
			}
		}
		
		private function exportToExcel():void
		{
			var request:URLRequest = new URLRequest("/usbInventoryStatusExportExcel.htm");
			request.method = URLRequestMethod.POST;
			
			var params:URLVariables = new URLVariables();
			var columns:IList = myWindow.statusVWGrid.columns;
			var column:GridColumn;
			var titles:Array = [];
			var props:Array = [];
			var length:int = columns.length;
			
			var nowDate:Date = new Date();
			var monthStr:String = ( (nowDate.month+1)<10 ? "0" : "") +  (nowDate.month+1);
			var dayStr:String = (nowDate.date<10 ? "0" : "") + nowDate.date;
			var fileName:String;
			
			for(var i:int = 0; i < length; i++)
			{
				column = columns.getItemAt(i) as GridColumn;
				
				//20130305 김정욱 엑셀 출력 시  column중 dummy column으로 인해 저장 시 에러 수정 START
				if(column.dataField == myWindow.statusVWGrid.FIX_LAST_DATA) continue;
				//20130305 김정욱 엑셀 출력 시  column중 dummy column으로 인해 저장 시 에러 수정 END
				
				titles.push(column.headerText);
				if(column.dataField == "secureUsbType"){
					props.push("secureUsbTypeLabel");
				}else if(column.dataField == "isUsed"){
					props.push("isUsedLabel");
				}else if(column.dataField == "receive"){
					props.push("receiveLabel");
				}else if(column.dataField == "sfa_state"){
					props.push("sfa_stateLabel");
				}else if(column.dataField == "sfa_office"){
					props.push("sfa_officeName");
				}else{
					props.push(column.dataField);	
				}
				
			}
			
			params.titleName = titles;
			params.titleProperty = props;
			params.searchVo = com.adobe.serialization.json.JSON.encode(ApplicationFacade(facade).statusVo);
			
			fileName = DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_INVENTORY') + "_" + nowDate.fullYear + monthStr + dayStr + ".xls";
			params.fileName = fileName;
			
			request.data = params;
			navigateToURL(request, "_self");
		}
		
		/**
		 * mediator 등록 시
		 */
		override public function onRegister():void
		{
			myWindow.searchBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.addBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.modBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.initBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.excelBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.statusVWGrid.addEventListener(GridSelectionEvent.SELECTION_CHANGE, selectionChangeHandler);
			loadColumnSetting();

			ApplicationFacade(facade).statusVo.topCount = _pageSize;
			ApplicationFacade(facade).statusVo.startIdx = _startIdx;

			initialize();
			sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
			
			initializeScrollData();			
			myWindow.statusVWGrid.scroller.verticalScrollBar.addEventListener(Event.CHANGE, viewChangeHandler);
			
			myWindow.isUsed.labelFunction = isUsed_labelFunction;
			myWindow.receive.labelFunction = receive_labelFunction;
			myWindow.capacity.labelFunction = capacityLabelFunction;
			myWindow.dataCapacity.labelFunction = dataCapacityLabelFunction;
			myWindow.secureUsbType.labelFunction = secureUsbTypeLabelFunction;
			myWindow.sfa_state.labelFunction = sfa_stateLabelFunction;
			myWindow.sfa_office.labelFunction = sfa_officeLabelFunction;
			
			if(DmosFramework.getInstance().PERMISSION("D4_SUSBMA_INVENTORY"))
			{
				myWindow.addBtn.includeInLayout = myWindow.addBtn.visible = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_INVENTORY").isAbleCreate();
				myWindow.modBtn.includeInLayout = myWindow.modBtn.visible = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_INVENTORY").isAbleUpdate();
				myWindow.delBtn.includeInLayout = myWindow.delBtn.visible = DmosFramework.getInstance().PERMISSION("D4_SUSBMA_INVENTORY").isAbleDelete();
			}
		}
		
		/**
		 * mediator 제거 시
		 */
		override public function onRemove():void
		{
			myWindow.searchBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.addBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.modBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.delBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.initBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.excelBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.statusVWGrid.removeEventListener(GridSelectionEvent.SELECTION_CHANGE, selectionChangeHandler);
			myWindow.statusVWGrid.scroller.verticalScrollBar.removeEventListener(Event.CHANGE, viewChangeHandler);
			myWindow.receive.labelFunction = null;
			myWindow.capacity.labelFunction = null;
			myWindow.dataCapacity.labelFunction = null;
			myWindow.secureUsbType.labelFunction = null;
			myWindow.sfa_state.labelFunction = null;
			myWindow.sfa_office.labelFunction = null;
		}
		
		private function sfa_officeLabelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			switch(value)
			{
				case 0:
				{
					return DmosFramework.getInstance().SNL('SFA_INVENTORY_STRING_000001');
					break;
				}
				case 1:
				{
					return DmosFramework.getInstance().SNL('SFA_OFFICE_ASAN');
					break;
				}
				case 2:
				{
					return DmosFramework.getInstance().SNL('SFA_OFFICE_HWASUNG');
					break;
				}
				default:
				{
					return ""
					break;
				}
			}
		}
		
		private function sfa_stateLabelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			switch(value)
			{
				case 0:
				{
					return DmosFramework.getInstance().SNL('SFA_STATE_0');
					break;
				}
				case 1:
				{
					return DmosFramework.getInstance().SNL('SFA_STATE_1');
					break;
				}
				case 2:
				{
					return DmosFramework.getInstance().SNL('SFA_STATE_2');
					break;
				}
				case 3:
				{
					return DmosFramework.getInstance().SNL('SFA_STATE_3');
					break;
				}
				default:
				{
					return ""
					break;
				}
			}
		}
		
		private function secureUsbTypeLabelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			switch(value)
			{
				case 0:
				{
					return DmosFramework.getInstance().SNL('SC_SECUREUSB_2.0');
					break;
				}
				case 1:
				{
					return DmosFramework.getInstance().SNL('SC_SECURE_SSD_PW');
					break;
				}
				case 2:
				{
					return DmosFramework.getInstance().SNL('SC_SECURE_SSD_NFC');
					break;
				}
				case 3:
				{
					return DmosFramework.getInstance().SNL('SC_SECUREUSB_3.0');
					break;
				}
				case 4:
				{
					return DmosFramework.getInstance().SNL('SC_SECURE_SSD_PW_NFC');
					break;
				}
				case 5:
				{
					return DmosFramework.getInstance().SNL('SC_SECURE_HDD') + ' 3.1';
					break;
				}
				case 6:
				{
					return DmosFramework.getInstance().SNL('SC_SECURESSD') + ' 3.1';
					break;
				}
				default:
				{
					return ""
					break;
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
		/**
		 * 관심있는 notification
		 */
		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.USB_INVENTORY_STATUS_LIST_RESULT,				//성공 시
				LocalConst.USB_INVENTORY_STATUS_ADD_RESULT,
				LocalConst.USB_INVENTORY_STATUS_MODIFY_RESULT,
				LocalConst.USB_INVENTORY_STATUS_DELETE_RESULT,
				LocalConst.USB_INVENTORY_STATUS_LIST_FAULT,					//실패 시
				LocalConst.USB_INVENTORY_STATUS_ADD_FAULT,
				LocalConst.USB_INVENTORY_STATUS_MODIFY_FAULT,
				LocalConst.USB_INVENTORY_STATUS_DELETE_FAULT
			];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LocalConst.USB_INVENTORY_STATUS_LIST_RESULT :				//재고 리스트 성공
				{
					getLogList(notification.getBody().LIST);
					myWindow.searchResultCount = notification.getBody().COUNT as int;
					
					if(myWindow.statusArr.length > 0) {
						myWindow.statusVWGrid.enabled = true;
						
						//셀렉션
						myWindow.statusVWGrid.selectedIndex = 0;
						var statusVo:SusbmaInventoryStatusVO = myWindow.statusVWGrid.selectedItem as SusbmaInventoryStatusVO;
						ApplicationFacade(facade).selectedVo = statusVo;
						myWindow.statusVWGrid.setFocus();
						
						myWindow.modBtn.enabled = true;							//20140826추가 데이터있을 시 수정버튼 활성화 처리
						myWindow.delBtn.enabled = true;							//20140826추가 데이터있을 시 삭제버튼 활성화 처리
					} else {
						myWindow.statusVWGrid.enabled = false;
						myWindow.modBtn.enabled = false;						//20140826추가 데이터없을 시 수정버튼 비활성화 처리
						myWindow.delBtn.enabled = false;						//20140826추가 데이터없을 시 삭제버튼 비활성화 처리
					}
					
					myWindow.reloadBtn.enabled = true;
					myWindow.initBtn.enabled = true;
					break;
				}
				
				case LocalConst.USB_INVENTORY_STATUS_LIST_RESULT : break;			//재고 리스트 실패
			
				case LocalConst.USB_INVENTORY_STATUS_ADD_RESULT :					//재고 등록 성공
				{
					ApplicationFacade(facade).statusVo.topCount = _pageSize;
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					ApplicationFacade(facade).statusVo.state = -1;
					initialize();
					myWindow.initBtn.enabled = false;
					initializeScrollData();
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
					break;
				}
					
				case LocalConst.USB_INVENTORY_STATUS_ADD_FAULT :					//재고 등록 실패
				{
					ApplicationFacade(facade).statusVo.topCount = _pageSize;
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					ApplicationFacade(facade).statusVo.state = -1;
					initialize();
					myWindow.initBtn.enabled = false;
					initializeScrollData();
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
					break;
				}					
					
				case LocalConst.USB_INVENTORY_STATUS_MODIFY_RESULT :			//재고 수정 성공
				{
					ApplicationFacade(facade).statusVo.topCount = _pageSize;
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					ApplicationFacade(facade).statusVo.state = -1;
					initialize();
					myWindow.initBtn.enabled = false;
					initializeScrollData();
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
					break;
				}
					
				case LocalConst.USB_INVENTORY_STATUS_MODIFY_FAULT :				//재고 수정 실패
				{
					ApplicationFacade(facade).statusVo.topCount = _pageSize;
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					ApplicationFacade(facade).statusVo.state = -1;
					initialize();
					myWindow.initBtn.enabled = false;
					initializeScrollData();
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
					break;
				}
					
				case LocalConst.USB_INVENTORY_STATUS_DELETE_RESULT :			//재고 삭제 성공
				{
					ApplicationFacade(facade).statusVo.topCount = _pageSize;
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					ApplicationFacade(facade).statusVo.state = -1;
					initialize();
					myWindow.initBtn.enabled = false;
					initializeScrollData();
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
					break;
				}	
				
				case LocalConst.USB_INVENTORY_STATUS_DELETE_FAULT :				//재고 삭제 실패
				{
					ApplicationFacade(facade).statusVo.topCount = _pageSize;
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					ApplicationFacade(facade).statusVo.state = -1;
					initialize();
					myWindow.initBtn.enabled = false;
					initializeScrollData();
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
					break;
				}
					
				default : break;
			}
		}
		
		private function selectionChangeHandler(event:GridSelectionEvent):void 
		{
			var statusVo:SusbmaInventoryStatusVO = myWindow.statusVWGrid.selectedItem as SusbmaInventoryStatusVO;
			ApplicationFacade(facade).selectedVo = statusVo;
			
			var statusList:IList = new ArrayList();
			
			if(myWindow.statusVWGrid.selectedItems == null)
				return;
			
			var length:int = myWindow.statusVWGrid.selectedItems.length;
			var item:SusbmaInventoryStatusVO;
			for(var i:int = 0; i < length; i++)
			{
				item = myWindow.statusVWGrid.selectedItems[i] as SusbmaInventoryStatusVO;
			}
			ApplicationFacade(facade).selectedVo = item;
			
		}
		
		/**
		 * 최신리스트 불러오는 메소드 
		 */		
		private function updateNewList():void
		{
			sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
		}
		
		/**
		 * ISZPopupResponder 의 메소드
		 * SZPopupMediator로 만든 팝업창에서의 OK callback을 받기 위함
		 */
		public function popupOnOk(popup:Object, context:Object, extra:Object):void
		{
			var statusVo:SusbmaInventoryStatusVO;
			
			switch(context.toString())
			{
				case "SEARCH" :													//재고검색 팝업 - 검색버튼 클릭 시
				{
					statusVo = extra as SusbmaInventoryStatusVO;
					ApplicationFacade(facade).statusVo = statusVo;
					initializeScrollData();
					statusVo.startIdx = _startIdx;
					sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, statusVo);
					break;
				}
				
				case "ADD" :													//재고등록 팝업 - 확인버튼 클릭 시
				{
					facade.sendNotification(LocalConst.USB_INVENTORY_STATUS_ADD, ApplicationFacade(facade).statusVo);
					break;
				}
				
				case "MODIFY" :													//재고수정 팝업 - 확인버튼 클릭 시
				{
					facade.sendNotification(LocalConst.USB_INVENTORY_STATUS_MODIFY, ApplicationFacade(facade).statusVo);
					break;
				}	
					
				case "DELETE" :													//재고삭제 팝업 - 삭제버튼 클릭 시
				{
					Alert.show(DmosFramework.getInstance().SNL('SC_ENTER_SNO_DELETE'),
						DmosFramework.getInstance().SNL('SC_DELETE_THE_STOC_D4'),
						Alert.OK | Alert.CANCEL, myWindow.parentApplication as Sprite,
						deleteEventHandler, null, Alert.OK);
					break;
				}	
				
				default : break;
			}
		}
		
		/**
		 * ISZPopupResponder 의 메소드
		 * SZPopupMediator로 만든 팝업창에서의 Cancel callback을 받기 위함
		 */
		public function popupOnCancel(popup:Object, context:Object, extra:Object):void
		{
			
		}
		
		//_____________________________________________________________________________________________________________
		
		//스크롤 이동 시 데이터 조회
		protected function viewChangeHandler(evnet:Event):void 
		{
			var vscrollbar:VScrollBar = myWindow.statusVWGrid.scroller.verticalScrollBar;
			if(myWindow.searchResultCount > _loadedCnt) //로드된 데이터 수보다 검색결과 수가 많을 때
			{
				if(0.9 * vscrollbar.maximum < vscrollbar.viewport.verticalScrollPosition)
				{
					myWindow.statusArr.disableAutoUpdate();
					_startIdx += _pageSize;
					ApplicationFacade(facade).statusVo.startIdx = _startIdx;
					facade.sendNotification(LocalConst.USB_INVENTORY_STATUS_LIST, ApplicationFacade(facade).statusVo);
					vscrollbar.viewport.verticalScrollPosition = vscrollbar.maximum;
					myWindow.statusArr.enableAutoUpdate();
				}
			}
		}
		
		private function getLogList(list:IList):void {
			_loadedCnt += _pageSize;
			
			if(myWindow.statusArr == null) myWindow.statusArr = new ArrayCollection();
			
			if(list != null) {
				for(var i:int=0; i<list.length; i++) {
					myWindow.statusArr.addItem(list.getItemAt(i));
				}
				
			}
		}
		
		private function initializeScrollData():void 
		{
			var vscrollbar:VScrollBar = myWindow.statusVWGrid.scroller.verticalScrollBar;
			
			_loadedCnt = 0;
			_startIdx = 0;
			
			vscrollbar.viewport.verticalScrollPosition = 0;
			
			if(myWindow.statusArr == null) myWindow.statusArr = new ArrayCollection();
			else myWindow.statusArr.removeAll();
		}
		
		private function initialize():void
		{
			ApplicationFacade(facade).statusVo.inventorySno = null;
			ApplicationFacade(facade).statusVo.stockDate = null;
			ApplicationFacade(facade).statusVo.targetCode = null;
			ApplicationFacade(facade).statusVo.capacity = -1;
			ApplicationFacade(facade).statusVo.inventoryReason = null;
			ApplicationFacade(facade).statusVo.creator = null;
			ApplicationFacade(facade).statusVo.updator = null;
			ApplicationFacade(facade).statusVo.sno = null;
			ApplicationFacade(facade).statusVo.releaseDate = null;
			ApplicationFacade(facade).statusVo.isUsed = -1;
			ApplicationFacade(facade).statusVo.receive = -1;
			ApplicationFacade(facade).statusVo.totalDelete = 0;
			ApplicationFacade(facade).statusVo.startInventorySno = null;
			ApplicationFacade(facade).statusVo.endInventorySno = null;
			ApplicationFacade(facade).statusVo.startStockDate = null;
			ApplicationFacade(facade).statusVo.endStockDate = null;
			ApplicationFacade(facade).statusVo.resultCount = 0;
			ApplicationFacade(facade).statusVo.secureUsbType = -1;
			ApplicationFacade(facade).statusVo.sfa_mngCode = null;
			ApplicationFacade(facade).statusVo.sfa_office = -1;
			ApplicationFacade(facade).statusVo.sfa_state = -1;
			ApplicationFacade(facade).statusVo.startCharacter = null;
			ApplicationFacade(facade).statusVo.isoVersion = null;
		}
		
		private function loadColumnSetting():void
		{
			//labelFunction 정보를 넘겨 준다. labelFunction이 없으면 안주면 또는 null을 주면 된다.
			var labelFunctionDatas:Vector.<LabelFunctionData> = new Vector.<LabelFunctionData>();
		}
		
		private function isUsed_labelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			switch(value)
			{
				case 0: return DmosFramework.getInstance().SNL('SC_STOCK_D4'); break;
				case 1: return DmosFramework.getInstance().SNL('SC_REQUEST'); break; 
				case 2: return DmosFramework.getInstance().SNL('SC_USE'); break; 
				case 3: return DmosFramework.getInstance().SNL('SC_DISU_D4'); break; 
				case 4: return DmosFramework.getInstance().SNL('SC_EXPIRE_PERIOD'); break; 
				default: return ""; break;
			}
		}
		
		private function receive_labelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			switch(value)
			{
				case 0: return DmosFramework.getInstance().SNL('SC_NOT_RECE_D4'); break;
				case 1: return DmosFramework.getInstance().SNL('SC_RECE_D4'); break;  
				default: return ""; break;
			}
		}
		private function deleteEventHandler(event:CloseEvent):void
		{
			if(event.detail == Alert.OK)
			{
				facade.sendNotification(LocalConst.USB_INVENTORY_STATUS_DELETE, ApplicationFacade(facade).statusVo);
			}
		}
		//_____________________________________________________________________________________________________________
	}
}