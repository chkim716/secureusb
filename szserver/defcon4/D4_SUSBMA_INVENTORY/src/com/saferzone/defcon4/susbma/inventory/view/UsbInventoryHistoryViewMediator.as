package com.saferzone.defcon4.susbma.inventory.view
{
	import com.adobe.serialization.json.JSON;
	import com.adobe.serialization.json.JSONEncoder;
	
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.ISZPopupResponder;
	import com.saferzone.defcon4.common.events.ColumnChangeEvent;
	import com.saferzone.defcon4.common.events.ColumnResizedEvent;
	import com.saferzone.defcon4.common.events.CustomTreeItemClickEvent;
	import com.saferzone.defcon4.common.utils.classes.LabelFunctionData;
	import com.saferzone.defcon4.services.vo.SusbmaInventoryHistoryVO;
	import com.saferzone.defcon4.susbma.inventory.ApplicationFacade;
	import com.saferzone.defcon4.susbma.inventory.consts.LocalConst;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryHistorySchPopup;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryHistoryView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import spark.components.VScrollBar;
	import spark.components.gridClasses.GridColumn;
	import spark.events.GridSelectionEvent;
	
	/**
	 * USB재고이력 미디에이터 
	 * 재고이력 관련 중재자 역할
	 * @author lmj
	 */	
	public class UsbInventoryHistoryViewMediator extends Mediator implements ISZPopupResponder
	{
		/**
		 * Constants 
		 */	
		public static const NAME:String = "UsbInventoryHistoryViewMediator";
		
		/**
		 * 스크롤 이동 시 데이터 조회
		 * 스크롤 이동 시 DB에서 읽어올 ROW 수가 null이 아니면 값할당
		 * null 일 경우 100 할당
		 */
		private var _pageSize:uint = DmosFramework.getInstance().CONFIG("LOAD_PAGE_SIZE")!=null?int(DmosFramework.getInstance().CONFIG("LOAD_PAGE_SIZE")):100;		
		private var _loadedCnt:uint = 0;
		private var _startIdx:uint = 0;
		
		/**
		 * Constructor
		 * @param viewComponent
		 */	
		public function UsbInventoryHistoryViewMediator(viewComponent:Object)
		{
			super(NAME,viewComponent);
		}
		
		/**
		 * 컴포넌트 get 함수
		 * @return viewComponent
		 */	
		public function get myWindow():UsbInventoryHistoryView
		{
			return viewComponent as UsbInventoryHistoryView;
		}
		
		/**
		 * 버튼클릭 Event Listener
		 */
		
		protected function onBtnClickHandler(event:MouseEvent):void
		{
			switch(event.currentTarget.id) 
			{
				case "searchBtn":
				{
					var searchPopup:UsbInventoryHistorySchPopup;
					var searchPopupMediator:UsbInventoryHistorySchPopupMediator;
					searchPopup = PopUpManager.createPopUp(myWindow, UsbInventoryHistorySchPopup,
						true) as UsbInventoryHistorySchPopup;
					PopUpManager.centerPopUp(searchPopup);
					
					searchPopupMediator = new UsbInventoryHistorySchPopupMediator(searchPopup);
					searchPopupMediator.setPopupResponder(this, "SEARCH");
					
					facade.registerMediator(searchPopupMediator);
					
					searchPopupMediator.setSearchCondition(ApplicationFacade(facade).historyVo);
					break;
				}
					
				case "initBtn":
				{
					initializeScrollData();
					ApplicationFacade(facade).historyVo.startIdx = _startIdx;
					Alert.show(DmosFramework.getInstance().SNL("SC_INITIALIZE"), DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_INVENTORY"));
					
					initialize();
					
					sendNotification(LocalConst.USB_INVENTORY_HISTORY_LIST, ApplicationFacade(facade).historyVo);
					break;
				}
					
				case "excelBtn":
				{
					exportToExcel();
					break;
				}
					
				case "reloadBtn":
				{
					myWindow.reloadBtn.enabled = false;
					initializeScrollData();
					ApplicationFacade(facade).historyVo.startIdx = _startIdx;
					sendNotification(LocalConst.USB_INVENTORY_HISTORY_LIST, ApplicationFacade(facade).historyVo);
					break;
				}
					
				default : break;
			}
		}
		
		private function exportToExcel():void
		{
			var request:URLRequest = new URLRequest("/usbInventoryHistoryExportExcel.htm");
			request.method = URLRequestMethod.POST;
			
			var params:URLVariables = new URLVariables();
			var columns:IList = myWindow.historyVWGrid.columns;
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
				if(column.dataField == myWindow.historyVWGrid.FIX_LAST_DATA) continue;
				//20130305 김정욱 엑셀 출력 시  column중 dummy column으로 인해 저장 시 에러 수정 END
				
				titles.push(column.headerText);
				if(column.dataField == "isUsed"){
					props.push("isUsedLabel");
				}else if(column.dataField == "receive"){
					props.push("receiveLabel");
				}else{
					props.push(column.dataField);	
				}
				
			}
			
			params.titleName = titles;
			params.titleProperty = props;
			params.searchVo = com.adobe.serialization.json.JSON.encode(ApplicationFacade(facade).historyVo);
			
			fileName = DmosFramework.getInstance().SNL('PROGRAMTITLE_D4_SUSBMA_INVENTORY_HISTORY') + "_" + nowDate.fullYear + monthStr + dayStr + ".xls";
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
			myWindow.initBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.excelBtn.addEventListener(MouseEvent.CLICK, onBtnClickHandler);
			loadColumnSetting();
			
			ApplicationFacade(facade).historyVo.topCount = _pageSize;
			ApplicationFacade(facade).historyVo.startIdx = _startIdx;
			//ApplicationFacade(facade).historyVo.secureUsbType = -1;
			initialize();
			sendNotification(LocalConst.USB_INVENTORY_HISTORY_LIST, ApplicationFacade(facade).historyVo);
			
			initializeScrollData();			
			myWindow.historyVWGrid.scroller.verticalScrollBar.addEventListener(Event.CHANGE, viewChangeHandler);
			
			myWindow.prevState.labelFunction = prevState_labelFunction;
			myWindow.nextState.labelFunction = nextState_labelFunction;
			
		}
		
		/**
		 * mediator 제거 시
		 */
		override public function onRemove():void
		{
			myWindow.searchBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.initBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.reloadBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.excelBtn.removeEventListener(MouseEvent.CLICK, onBtnClickHandler);
			myWindow.historyVWGrid.scroller.verticalScrollBar.removeEventListener(Event.CHANGE, viewChangeHandler);
		}
		
		/**
		 * 관심있는 notification
		 */
		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.USB_INVENTORY_HISTORY_LIST_RESULT,		//성공 시
				LocalConst.USB_INVENTORY_HISTORY_LIST_FAULT			//실패 시
			];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LocalConst.USB_INVENTORY_HISTORY_LIST_RESULT :				//이력 리스트 성공
				{
					getLogList(notification.getBody().LIST);
					myWindow.searchResultCount = notification.getBody().COUNT as int;
					
					if(myWindow.historyArr.length > 0) {
						myWindow.historyVWGrid.enabled = true;
						myWindow.historyVWGrid.selectedIndex = 0;
						myWindow.historyVWGrid.setFocus();
					} else {
						myWindow.historyVWGrid.enabled = false;
					}
					myWindow.reloadBtn.enabled = true;
					myWindow.initBtn.enabled = true;
					break;
				}
					
				case LocalConst.USB_INVENTORY_HISTORY_LIST_FAULT : break;		//이력 리스트 실패
				
				default : break;
			}
		}
		
		/**
		 * ISZPopupResponder 의 메소드
		 * SZPopupMediator로 만든 팝업창에서의 OK callback을 받기 위함
		 */
		public function popupOnOk(popup:Object, context:Object, extra:Object):void
		{
			switch(context.toString())
			{
				case "SEARCH" :				//이력검색 팝업창에서 검색버튼 클릭 시
				{
					initializeScrollData();
					ApplicationFacade(facade).historyVo.startIdx = _startIdx;
					ApplicationFacade(facade).historyVo.topCount = _pageSize;
					facade.sendNotification(LocalConst.USB_INVENTORY_HISTORY_LIST, ApplicationFacade(facade).historyVo);
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
		
		/**
		 * 스크롤 이동 시 데이터 조회
		 * @param event
		 */		
		protected function viewChangeHandler(event:Event):void 
		{
			var vscrollbar:VScrollBar = myWindow.historyVWGrid.scroller.verticalScrollBar;
			if(myWindow.searchResultCount > _loadedCnt)										//DG에 로드된 데이터 수보다 검색결과 수가 많을 때
			{
				if(0.9 * vscrollbar.maximum < vscrollbar.viewport.verticalScrollPosition)
				{
					myWindow.historyArr.disableAutoUpdate();
					_startIdx += _pageSize;
					ApplicationFacade(facade).historyVo.startIdx = _startIdx;
					facade.sendNotification(LocalConst.USB_INVENTORY_HISTORY_LIST, ApplicationFacade(facade).historyVo);
					vscrollbar.viewport.verticalScrollPosition = vscrollbar.maximum;
					myWindow.historyArr.enableAutoUpdate();
				}
			}
		}
	
		private function getLogList(list:IList):void 
		{
			_loadedCnt += _pageSize;
			
			if(myWindow.historyArr == null) myWindow.historyArr = new ArrayCollection();
			
			if(list != null)
			{
				for(var i:int=0; i<list.length; i++) 
				{
					myWindow.historyArr.addItem(list.getItemAt(i));
				}
			}
		}
		
		private function initializeScrollData():void 
		{
			var vscrollbar:VScrollBar = myWindow.historyVWGrid.scroller.verticalScrollBar;
			
			_loadedCnt = 0;
			_startIdx = 0;
			
			vscrollbar.viewport.verticalScrollPosition = 0;
			
			if(myWindow.historyArr == null) myWindow.historyArr = new ArrayCollection();
			else myWindow.historyArr.removeAll();
		}
		
		private function initialize():void
		{
			ApplicationFacade(facade).historyVo.historyId = -1;
			ApplicationFacade(facade).historyVo.inventorySno = null;
			ApplicationFacade(facade).historyVo.regDate = null;
			ApplicationFacade(facade).historyVo.userEmpId = null;
			ApplicationFacade(facade).historyVo.userEmpName = null;
			ApplicationFacade(facade).historyVo.userOrgId = null;
			ApplicationFacade(facade).historyVo.userOrgName = null;
			ApplicationFacade(facade).historyVo.prevState = -1;
			ApplicationFacade(facade).historyVo.nextState = -1;
			ApplicationFacade(facade).historyVo.capacity = -1;
			ApplicationFacade(facade).historyVo.historyReason = null;
			ApplicationFacade(facade).historyVo.sno = null;
			ApplicationFacade(facade).historyVo.startRegDate = null;
			ApplicationFacade(facade).historyVo.endRegDate = null;
			ApplicationFacade(facade).historyVo.startInventorySno = null;
			ApplicationFacade(facade).historyVo.endInventorySno = null;
			ApplicationFacade(facade).historyVo.resultCount = -1;
			ApplicationFacade(facade).historyVo.startCharacter = null;
		}
		
		private function loadColumnSetting():void
		{
			//labelFunction 정보를 넘겨 준다. labelFunction이 없으면 안주면 또는 null을 주면 된다.
			var labelFunctionDatas:Vector.<LabelFunctionData> = new Vector.<LabelFunctionData>();
		}
		
		private function prevState_labelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			switch(value)
			{
				case 0: return DmosFramework.getInstance().SNL('SC_WARE_D4'); break;
				case 1: return DmosFramework.getInstance().SNL('SC_CHANGE_OF_STOCK_INFO_D4'); break;
				case 2: return DmosFramework.getInstance().SNL('SC_DELETE_THE_STOCK_INFO_D4'); break;
				case 3: return DmosFramework.getInstance().SNL('SC_APPLICATION_FOR_REGI_D4'); break;
				case 4: return DmosFramework.getInstance().SNL('SC_APPROVAL_FOR_REGI_D4'); break;
				case 5: return DmosFramework.getInstance().SNL('SC_CHANGE_OF_REGISTRATION_INFO_D4'); break;
				case 6: return DmosFramework.getInstance().SNL('SC_DISU_D4'); break;
				case 7: return DmosFramework.getInstance().SNL('SC_EXPIRE_PERIOD'); break;
				case 8: return DmosFramework.getInstance().SNL('SC_RERE_D4'); break;
				case 9: return DmosFramework.getInstance().SNL('SC_REST_D4'); break;
				case 10: return DmosFramework.getInstance().SNL('SC_STANDBY_RETU_D4'); break;
				case 11: return DmosFramework.getInstance().SNL('SC_APPROVAL_RETU_D4'); break;
				default: return ""; break;
			}
		}
		
		private function nextState_labelFunction(item:Object, column:GridColumn):String
		{
			var value:int = item[column.dataField];
			switch(value)
			{
				case 0: return DmosFramework.getInstance().SNL('SC_WARE_D4'); break;
				case 1: return DmosFramework.getInstance().SNL('SC_CHANGE_OF_STOCK_INFO_D4'); break;
				case 2: return DmosFramework.getInstance().SNL('SC_DELETE_THE_STOCK_INFO_D4'); break;
				case 3: return DmosFramework.getInstance().SNL('SC_APPLICATION_FOR_REGI_D4'); break;
				case 4: return DmosFramework.getInstance().SNL('SC_APPROVAL_FOR_REGI_D4'); break;
				case 5: return DmosFramework.getInstance().SNL('SC_CHANGE_OF_REGISTRATION_INFO_D4'); break;
				case 6: return DmosFramework.getInstance().SNL('SC_DISU_D4'); break;
				case 7: return DmosFramework.getInstance().SNL('SC_EXPIRE_PERIOD'); break;
				case 8: return DmosFramework.getInstance().SNL('SC_RERE_D4'); break;
				case 9: return DmosFramework.getInstance().SNL('SC_REST_D4'); break;
				case 10: return DmosFramework.getInstance().SNL('SC_STANDBY_RETU_D4'); break;
				case 11: return DmosFramework.getInstance().SNL('SC_APPROVAL_RETU_D4'); break;
				default: return ""; break;
			}
		}
	}
}