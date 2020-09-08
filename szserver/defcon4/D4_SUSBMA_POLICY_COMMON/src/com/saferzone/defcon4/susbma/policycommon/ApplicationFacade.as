package
{
	import com.saferzone.defcon4.susbma.policycommon.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policycommon.controller.SusbmaPolicyCommonCommand;
	import com.saferzone.defcon4.susbma.policycommon.model.SusbmaPolicyCommonRemoteProxy;
	import com.saferzone.defcon4.susbma.policycommon.view.ApplicationMediator;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import spark.components.Application;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		public static const NAME:String = "D4_SUSBMA_POLICY_COMMON";
		
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
		
		private var _pid:String;
		
		public function get pid():String
		{
			return _pid;
		}
		
		public function set pid(value:String):void
		{
			_pid = value;
		}
		
		private var _programId:String;
		
		public function get programId():String
		{
			return _programId;
		}
		
		public function set programId(value:String):void
		{
			_programId = value;
		}
		
		private var _programSeq:String;
		
		public function get programSeq():String
		{
			return _programSeq;
		}
		
		public function set programSeq(value:String):void
		{
			_programSeq = value;
		}
		
		private var _userId:String;
		
		public function get userId():String
		{
			return _userId ? _userId : "Standalone";
		}
		
		public function set userId(value:String):void
		{
			_userId = value;
		}
		
		private var application:D4_SUSBMA_POLICY_COMMON;
		
		public function applicationStartup(app:Application):void
		{
			this.application = app as D4_SUSBMA_POLICY_COMMON;
			
			initModel();
			initController();
			initView();
			
			sendNotification(LocalConst.SUSBMA_COMMON_POLICY_LOAD);
		}
		
		public function removeInstance():void
		{
			removeCore(this.multitonKey);
		}
		
		private function initModel():void
		{
			registerProxy(new SusbmaPolicyCommonRemoteProxy());
		}
		
		private function initController():void
		{
			registerCommand(LocalConst.SUSBMA_COMMON_POLICY_SAVE, SusbmaPolicyCommonCommand);
			registerCommand(LocalConst.SUSBMA_COMMON_POLICY_LOAD, SusbmaPolicyCommonCommand);
		}
		
		private function initView():void
		{
			if(application)
				registerMediator(new ApplicationMediator(application));
		}
	}
}