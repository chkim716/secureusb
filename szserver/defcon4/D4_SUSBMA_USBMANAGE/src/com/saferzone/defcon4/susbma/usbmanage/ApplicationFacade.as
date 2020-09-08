//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.services.vo.SearchSusbMasterVO;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.controller.PasswordInitialize;
	import com.saferzone.defcon4.susbma.usbmanage.controller.SusbmaUsbManageAddCommand;
	import com.saferzone.defcon4.susbma.usbmanage.controller.SusbmaUsbManageDeleteCommand;
	import com.saferzone.defcon4.susbma.usbmanage.controller.SusbmaUsbManageListCommand;
	import com.saferzone.defcon4.susbma.usbmanage.controller.SusbmaUsbManageModifyCommand;
	import com.saferzone.defcon4.susbma.usbmanage.model.SusbmaUsbManageRemoteProxy;
	import com.saferzone.defcon4.susbma.usbmanage.view.ApplicationMediator;
	
	import mx.collections.IList;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import spark.components.Application;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * ApplicationFacade 이름
		 */
		public static const NAME:String = "D4_SUSBMA_USBMANAGE";
		
		public var page_size:int = DmosFramework.getInstance().CONFIG("LOAD_PAGE_SIZE")!=null?int(DmosFramework.getInstance().CONFIG("LOAD_PAGE_SIZE")):100;
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function ApplicationFacade(key:String)
		{
			super(key);
		}
		
		//------------------------------------------------------------------------------
		//
		// Statics 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * singleton method
		 */
		public static function getInstance(key:String):ApplicationFacade
		{
			if(!instanceMap[key])
				instanceMap[key] = new ApplicationFacade(key);
			
			return instanceMap[key] as ApplicationFacade;
		}
		
		
		//--------------------------------------
		// selectedUSB 
		//--------------------------------------
		
		public var selectedUSB:SusbUsbMasterVO;
		
		public var unUseState:int;
		
		//--------------------------------------
		// selectedUSBList 
		//--------------------------------------
		
		private var _selectedInitSNO:String;
		
		public function get selectedInitSNO():String
		{
			return _selectedInitSNO;
		}
		
		public function set selectedInitSNO(value:String):void
		{
			_selectedInitSNO = value;
		}
		
		public var selectedUSBList:IList;
		
		private var _selectedUSBList:Vector.<Object>;
		
		public function get selectedAgentList():Vector.<Object>
		{
			return _selectedUSBList;
		}
		
		public function set selectedAgentList(value:Vector.<Object>):void
		{
			_selectedUSBList = value;
		}
		
		//--------------------------------------
		// selectedUSBCount
		//--------------------------------------
		public var selectedUsbCount:int;
		
		//--------------------------------------
		// application 
		//--------------------------------------
		
		private var _application:D4_SUSBMA_USBMANAGE;
		
		/**
		 * Application
		 */
		public function get application():D4_SUSBMA_USBMANAGE
		{
			return _application;
		}
		
		/**
		 * @private
		 */
		public function set application(value:D4_SUSBMA_USBMANAGE):void
		{
			_application = value;
		}
		
		//--------------------------------------
		// searchVO 
		//--------------------------------------
		
		public var searchVO:SearchSusbMasterVO;
		public var searchVO2:SearchSusbMasterVO;
		
		//--------------------------------------
		// pid 
		//--------------------------------------
		
		/**
		 * pid
		*/
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
		
		/**
		 * programId
		 */
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
		
		/**
		 * programSeq
		 */
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
		
		/**
		 * userId
		 */
		private var _userId:String;
		
		public function get userId():String
		{
			return _userId ? _userId : "Standalone";
		}
		
		public function set userId(value:String):void
		{
			_userId = value;
		}
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// public 
		//--------------------------------------
		
		/**
		 * 초기화 시작
		 */
		public function applicationStartup(app:Application):void
		{
			this.application = app as D4_SUSBMA_USBMANAGE;
			
			initModel();
			initController();
			initView();
			
			searchVO = new SearchSusbMasterVO();
			searchVO2 = new SearchSusbMasterVO();
			searchVO.topCount = page_size;
			searchVO.startIdx = 0;
			searchVO.sortColumn = "SNO";
			searchVO.sortOrder = "desc";
			searchVO.mediaId = -1;
			searchVO.stateId = -1;
			searchVO.requestState = -1;
			
			sendNotification(LocalConst.SUSBMA_USBMANAGE_USB_LIST, searchVO);
		}
		
		/**
		 * Facade 제거
		 */
		public function removeInstance():void
		{
			applicationMediator.removeTimer();
			removeCore(this.multitonKey);
		}
		
		//--------------------------------------
		// private 
		//--------------------------------------
		
		/**
		 * Proxy 초기화
		 */
		private function initModel():void
		{
			registerProxy(new SusbmaUsbManageRemoteProxy());
		}
		
		/**
		 * Command 초기화
		 */
		private function initController():void
		{
			//계정그룹관련 Command
			registerCommand(LocalConst.SUSBMA_USBMANAGE_USB_LIST, SusbmaUsbManageListCommand);
			registerCommand(LocalConst.SUSBMA_USBMANAGE_USB_ADD, SusbmaUsbManageAddCommand);
			registerCommand(LocalConst.SUSBMA_USBMANAGE_USB_MODIFY, SusbmaUsbManageModifyCommand);
			registerCommand(LocalConst.SUSBMA_USBMANAGE_USB_DELETE, SusbmaUsbManageDeleteCommand);
			registerCommand(LocalConst.SUSBMA_USBMANAGE_MNGEMPID_MODIFY, SusbmaUsbManageModifyCommand);
			//하단 탭네비게이션 Command
			registerCommand(LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST, SusbmaUsbManageListCommand);
			registerCommand(LocalConst.SUSBMA_USBMANAGE_USE_LIST, SusbmaUsbManageListCommand);
			registerCommand(LocalConst.SUSBMA_USBMANAGE_COMMON_LIST, SusbmaUsbManageListCommand);
			registerCommand(LocalConst.SUSBMA_USBMANAGE_DELETE_LIST, SusbmaUsbManageListCommand);
			//USB반납
			registerCommand(LocalConst.D4LC_CMD_USB_RETURN, SusbmaUsbManageDeleteCommand);
			// Password Initialize
			registerCommand(LocalConst.D4LC_CMD_PASSWORD_INITIALIZE, PasswordInitialize);
			//긴급도구 비상키 생성
			registerCommand(LocalConst.D4LC_CMD_MAKE_EMERGENCY_KEY, SusbmaUsbManageAddCommand);
			registerCommand(LocalConst.D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL, SusbmaUsbManageListCommand);
			
			registerCommand(LocalConst.SUSBMA_USBMANAGE_MASS_REGISTER, SusbmaUsbManageAddCommand);
			registerCommand(LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LIST, SusbmaUsbManageListCommand);
			registerCommand(LocalConst.SUSBMA_USBMANAGE_STATUS_LIST, SusbmaUsbManageListCommand);
			
			registerCommand(LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST, SusbmaUsbManageListCommand);
		}
		
		private var $ApplicationMediator:ApplicationMediator;
		public function get applicationMediator():ApplicationMediator
		{
			return $ApplicationMediator;
		}
		
		private function initView():void
		{
			if($ApplicationMediator){
				removeMediator($ApplicationMediator.getMediatorName());	
			}
			
			$ApplicationMediator = new ApplicationMediator(application); 
			registerMediator($ApplicationMediator);
		}
	}
}
