//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy
{
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.controller.SusbmaPolicyAddCommand;
	import com.saferzone.defcon4.susbma.policy.controller.SusbmaPolicyDeleteCommand;
	import com.saferzone.defcon4.susbma.policy.controller.SusbmaPolicyListCommand;
	import com.saferzone.defcon4.susbma.policy.controller.SusbmaPolicyModifyCommand;
	import com.saferzone.defcon4.susbma.policy.model.SusbmaPolicyRemoteProxy;
	import com.saferzone.defcon4.susbma.policy.view.ApplicationMediator;
	import com.saferzone.defcon4.susbma.policy.view.SusbmaCommonPolicyOptionMediator;
	import com.saferzone.defcon4.susbma.policy.view.SusbmaPolicyClassMediator;
	import com.saferzone.defcon4.susbma.policy.view.SusbmaPolicyOptionMediator;
	
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
		public static const NAME:String = "D4_SUSBMA_POLICY";
		
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
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
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
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * Application
		 */
		private var application:D4_SUSBMA_POLICY;
		
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
			this.application = app as D4_SUSBMA_POLICY;
			
			initModel();
			initController();
			initView();
			
			//sendNotification(LocalConst.SUSBMA_POLIICY_CLASS_LIST, 1);
			sendNotification(LocalConst.D4LC_CMD_GROUPTYPE_SELECT);
		}
		
		/**
		 * Facade 제거
		 */
		public function removeInstance():void
		{
			removeCore(this.multitonKey);
		}
		
		//--------------------------------------
		// private 
		//--------------------------------------
		
		/*
		facade iterate test
		public function notifyToAllFacade():void
		{
			var iFacade:IFacade;
		
			for(var p:String in instanceMap)
			{
				//trace("name : " + p);
				iFacade = instanceMap[p];
				iFacade.sendNotification(GlobalConst.D4GC_NOTIFY_CHANGEUSERLANGUAGE);
				//trace("instance : " + instanceMap[p]);
			}
		}
		*/
		
		/**
		 * Proxy 초기화
		 */
		private function initModel():void
		{
			registerProxy(new SusbmaPolicyRemoteProxy());
		}
		
		/**
		 * Command 초기화
		 */
		private function initController():void
		{
			//계정그룹관련 Command
			registerCommand(LocalConst.SUSBMA_POLIICY_CLASS_LIST, SusbmaPolicyListCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_CLASS_MODIFY, SusbmaPolicyModifyCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_CLASSCHECK_MODIFY, SusbmaPolicyModifyCommand);
			
			//부서관련 Command
			registerCommand(LocalConst.SUSBMA_POLIICY_DEPT_LIST, SusbmaPolicyListCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_DEPT_ADD, SusbmaPolicyAddCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_DEPT_MODIFY, SusbmaPolicyModifyCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_DEPT_DELETE, SusbmaPolicyDeleteCommand);
			
			//개별정책관련 Command
			registerCommand(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST, SusbmaPolicyListCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST, SusbmaPolicyListCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_ADD, SusbmaPolicyAddCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_MODIFY, SusbmaPolicyModifyCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_POLICY_GROUP_DELETE, SusbmaPolicyDeleteCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_POLICY_USB_LIST, SusbmaPolicyListCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_POLICY_USB_ADD, SusbmaPolicyAddCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_POLICY_USB_DELETE, SusbmaPolicyDeleteCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_POLICY_USB_MODIFY, SusbmaPolicyModifyCommand);
			
			//옵션설정관련 Command
			registerCommand(LocalConst.SUSBMA_POLIICY_RAW_LIST, SusbmaPolicyListCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_RAW_ADD, SusbmaPolicyAddCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_RAW_MODIFY, SusbmaPolicyModifyCommand);
			registerCommand(LocalConst.SUSBMA_POLIICY_RAW_DELETE, SusbmaPolicyDeleteCommand);
			
			registerCommand(LocalConst.D4LC_CMD_GROUPTYPE_SELECT, SusbmaPolicyListCommand);
			
			//Common Policy
//			registerCommand(LocalConst.SUSBMA_COMMON_POLICY_SAVE, SusbmaPolicyModifyCommand);
//			registerCommand(LocalConst.SUSBMA_COMMON_POLICY_LOAD, SusbmaPolicyListCommand);
//			registerCommand(LocalConst.D4LC_CMD_PASSWORD_INITIALIZE, SusbmaPolicyModifyCommand);
//			registerCommand(LocalConst.D4LC_CMD_POPUP_LIST_LOAD,SusbmaPolicyListCommand);
//			registerCommand(LocalConst.D4LC_CMD_POPUP_LIST_SAVE, SusbmaPolicyModifyCommand);
//			registerCommand(LocalConst.D4LC_CMD_SECURE_ADMIN_INFO_LOAD,SusbmaPolicyListCommand);
//			registerCommand(LocalConst.D4LC_CMD_SECURE_ADMIN_INFO_SAVE, SusbmaPolicyModifyCommand);
		}
		
		/**
		 * Mediator 초기화
		 */
		private function initView():void
		{
			if(application)
				registerMediator(new ApplicationMediator(application));
			if(application.classView)
				registerMediator(new SusbmaPolicyClassMediator(application.classView));
			if(application.optionView)
				registerMediator(new SusbmaPolicyOptionMediator(application.optionView));
//			if(application.commonOptionView)
//				registerMediator(new SusbmaCommonPolicyOptionMediator(application.commonOptionView));
		}
	}
}
