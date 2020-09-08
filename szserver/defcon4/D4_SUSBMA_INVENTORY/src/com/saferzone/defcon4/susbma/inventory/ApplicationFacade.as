package com.saferzone.defcon4.susbma.inventory
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.services.vo.SusbmaInventoryHistoryVO;
	import com.saferzone.defcon4.services.vo.SusbmaInventoryStatusVO;
	import com.saferzone.defcon4.susbma.inventory.consts.LocalConst;
	import com.saferzone.defcon4.susbma.inventory.controller.SusbmaInventoryAddCommand;
	import com.saferzone.defcon4.susbma.inventory.controller.SusbmaInventoryDeleteCommand;
	import com.saferzone.defcon4.susbma.inventory.controller.SusbmaInventoryListCommand;
	import com.saferzone.defcon4.susbma.inventory.controller.SusbmaInventoryModifyCommand;
	import com.saferzone.defcon4.susbma.inventory.model.SusbmaInventoryRemoteProxy;
	import com.saferzone.defcon4.susbma.inventory.view.ApplicationMediator;
	import com.saferzone.defcon4.susbma.inventory.view.UsbInventoryHistoryViewMediator;
	import com.saferzone.defcon4.susbma.inventory.view.UsbInventoryStatusViewMediator;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * ApplicationFacade
	 * Model, View, Controller 들을 각각 통합 관리해 주는 역할 
	 * @author lmj
	 */	
	public class ApplicationFacade extends Facade 
	{
		public static const NAME:String = "D4_SUSBMA_INVENTORY";
		
		public var page_size:int = DmosFramework.getInstance().CONFIG("LOAD_PAGE_SIZE")!=null?int(DmosFramework.getInstance().CONFIG("LOAD_PAGE_SIZE")):100;
		
		public function ApplicationFacade(key:String)
		{
			super(key);
		}

		public static function getInstance(key:String):ApplicationFacade
		{
			if(!instanceMap[key])
				instanceMap[key] = new ApplicationFacade(key);
			
			return instanceMap[key] as ApplicationFacade;
		}
		
		//------------------------------------------------------------------------------
		//
		// Properties #searchVo 
		//
		//------------------------------------------------------------------------------
		
		public var statusVo:SusbmaInventoryStatusVO;
		public var historyVo:SusbmaInventoryHistoryVO;
		
		public var selectedVo:SusbmaInventoryStatusVO;			//현재 선택된 필드 정보
		
		//--------------------------------------
		// statusArr
		//--------------------------------------
		
		private var _statusArr:Array;
		
		public function get statusArr():Array
		{
			return _statusArr;
		}
		
		public function set statusArr(value:Array):void
		{
			_statusArr = value;
		}
		
		//--------------------------------------
		// groupType 
		//--------------------------------------
		
		private var _groupType:int;
		
		public function get groupType():int
		{
			return _groupType;
		}
		
		public function set groupType(value:int):void
		{
			_groupType = value;
		}
		
		//--------------------------------------
		// pid 
		//--------------------------------------
		
		private var _pid:String;
		
		public function get pid():String
		{
			return _pid;
		}
		
		public function set pid(value:String):void
		{
			_pid = value;
		}
		
		//--------------------------------------
		// programId 
		//--------------------------------------
		
		private var _programId:String;
		
		public function get programId():String
		{
			return _programId;
		}
		
		public function set programId(value:String):void
		{
			_programId = value;
		}
		
		//--------------------------------------
		// programSeq 
		//--------------------------------------
		
		private var _programSeq:String;
		
		public function get programSeq():String
		{
			return _programSeq;
		}
		
		public function set programSeq(value:String):void
		{
			_programSeq = value;
		}
		
		//--------------------------------------
		// userId 
		//--------------------------------------
		
		private var _userId:String;
		
		public function get userId():String
		{
			return _userId ? _userId : "Standalone";
		}
		
		public function set userId(value:String):void
		{
			_userId = value;
		}
		
		//--------------------------------------
		// application 
		//--------------------------------------
		
		private var _application:D4_SUSBMA_INVENTORY;
		
		public function get application():D4_SUSBMA_INVENTORY
		{
			return _application;
		}
		
		public function set application(value:D4_SUSBMA_INVENTORY):void
		{
			_application = value;
		}
		
		/**
		 * 초기화 시작
		 */
		public function applicationStartup(application:D4_SUSBMA_INVENTORY):void
		{
			this.application = application;
			
			statusVo = new SusbmaInventoryStatusVO();
			historyVo = new SusbmaInventoryHistoryVO();
			
			statusVo.topCount = page_size;
			statusVo.startIdx = 0;
		
			historyVo.startIdx = 0;
			historyVo.topCount = page_size;
			
			initModel();
			initController();
			initView();
		}
		
		/**
		 * Facade 제거
		 */
		public function removeInstance():void
		{
			removeCore(this.multitonKey);
		}
		
		/**
		 * Proxy 초기화
		 */
		private function initModel():void
		{
			registerProxy(new SusbmaInventoryRemoteProxy());
		}
		
		/**
		 * Command 초기화
		 */
		private function initController():void
		{
			registerCommand(LocalConst.USB_INVENTORY_STATUS_LIST, SusbmaInventoryListCommand);		//USB재고현황 관련 Command
			registerCommand(LocalConst.USB_INVENTORY_STATUS_ADD, SusbmaInventoryAddCommand);
			registerCommand(LocalConst.USB_INVENTORY_STATUS_MODIFY, SusbmaInventoryModifyCommand);
			registerCommand(LocalConst.USB_INVENTORY_STATUS_DELETE, SusbmaInventoryDeleteCommand);
			registerCommand(LocalConst.USB_INVENTORY_HISTORY_LIST, SusbmaInventoryListCommand);		//USB재고이력 관련 Command
		}
		
		/**
		 * Mediator 초기화
		 */
		private function initView():void
		{
			if(application) registerMediator(new ApplicationMediator(application));
			if(application.statusVW) registerMediator(new UsbInventoryStatusViewMediator(application.statusVW));
			if(application.historyVW) registerMediator(new UsbInventoryHistoryViewMediator(application.historyVW));
		}
	}
}