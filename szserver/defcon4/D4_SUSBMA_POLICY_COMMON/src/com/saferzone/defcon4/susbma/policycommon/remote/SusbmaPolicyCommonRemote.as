package com.saferzone.defcon4.susbma.policycommon.remote
{
	import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;
	
	import mx.collections.IList;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	public class SusbmaPolicyCommonRemote extends RemoteObject
	{
		public function SusbmaPolicyCommonRemote()
		{
			super("SusbmaPolicyCommonRemote");
			showBusyCursor = true;
		}
		
		public function selectSusbmaPolicyCommon():AsyncToken
		{
			return getOperation("selectSusbmaPolicyCommon").send();
		}
		
		public function updateSusbmaPolicyCommon(obj:Object):AsyncToken
		{
			return getOperation("updateSusbmaPolicyCommon").send(obj);
		}
		
		public function updateSusbmaInitPassword(pwdObj:Object):AsyncToken
		{
			return getOperation("updateSusbmaInitPassword").send(pwdObj);
		}
		
		public function selectPopupList():AsyncToken
		{
			return getOperation("selectPopupList").send();
		}
		
		public function updatePopupList(popupObj:Object):AsyncToken
		{
			return getOperation("updatePopupList").send(popupObj);
		}
		
		public function selectSecureAdminInfo():AsyncToken
		{
			return getOperation("selectSecureAdminInfo").send();
		}
		
		public function updateSecureAdminInfo(vo:SusbmaPolicyCommonMasterVO):AsyncToken
		{
			return getOperation("updateSecureAdminInfo").send(vo);
		}
	}
}