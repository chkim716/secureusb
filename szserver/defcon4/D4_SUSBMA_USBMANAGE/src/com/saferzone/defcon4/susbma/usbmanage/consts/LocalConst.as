package com.saferzone.defcon4.susbma.usbmanage.consts
{
	public class LocalConst
	{
		
		public static const BTN_SEARCH:int = 0;
		public static const BTN_EXCEL:int = 1;
		public static const BTN_ADD:int = 2;
		public static const BTN_MOD:int = 3;
		public static const BTN_DEL:int = 4;
		public static const BTN_UNUSE:int = 5;
		public static const BTN_PWDINIT:int = 6;
		public static const BTN_RELOAD:int = 7;
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_USBMANAGE_USB_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트를 요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 새로고침 버튼 클릭시
		 * 		  Parameter : None
		 * 		- Class : ApplicationFacade
		 * 		  Invoke : applicationStartup() --> 최초구동시 자동로드
		 * 		  Parameter : None
		 * Receiver
		 * 		- Class : SusbmaUsbmanageUsbListCommand
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의  selectSusbmaUsbmanageUsbList() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_USB_LIST:String	= "SUSBMA_USBMANAGE_USB_LIST";
		

		/**
		 * ---------------------------------------------------------
		 * D4LC_CMD_ADD
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 신규 변경사유 추가를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaAddCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  addOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_USB_ADD:String 	= "SUSBMA_USBMANAGE_USB_ADD";

		
		/**
		 * ---------------------------------------------------------
		 * D4LC_CMD_MODIFY
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 수정을  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaModifyCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  modifyOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_USB_MODIFY:String 	= "SUSBMA_USBMANAGE_USB_MODIFY";

		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_USBMANAGE_MNGEMPID_MODIFY
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 관리책임자 일괄변경을  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 입력Popup창에서 확인을 누른후 
		 * 		  Parameter : usb 정보
		 * Receiver
		 * 		- Class : OpemanAccumaModifyCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  modifyOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_MNGEMPID_MODIFY:String 	= "SUSBMA_USBMANAGE_MNGEMPID_MODIFY";
		
		
		
		/**
		 * ---------------------------------------------------------
		 * D4LC_CMD_DELETE
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 삭제를  요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 그리드에서 선택을 하고 삭제버튼 클릭시 
		 * 		  Parameter : OpemanAccumaGroupVO
		 * Receiver
		 * 		- Class : OpemanAccumaDeleteCommand
		 * 		  Action : OpemanAccumaRemoteProxy 의  deleteOpemanAccumaGroup() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_USB_DELETE:String 	= "SUSBMA_USBMANAGE_USB_DELETE";
		
		
		/**
		 * ---------------------------------------------------------
		 * OPEMAN_ACCUMA_GROUP_LIST_LOADSUCCESS
		 * OPEMAN_ACCUMA_GROUP_LIST_LOADFAIL
		 * 
		 * OPEMAN_ACCUMA_GROUP_ADDSUCCESS
		 * OPEMAN_ACCUMA_GROUP_ADDFAIL
		 * 
		 * OPEMAN_ACCUMA_GROUP_MODIFYSUCCESS
		 * OPEMAN_ACCUMA_GROUP_MODIFYFAIL
		 * 
		 * OPEMAN_ACCUMA_GROUP_DELETESUCCESS
		 * OPEMAN_ACCUMA_GROUP_DELETEFAIL
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트 수신완료에 대한 notify
		 * Sender
		 * 		- Class : OpemanAccumaRemoteProxy
		 * 		  InvokeTime : 변경사유목록수신성공 
		 * 		  Parameter : 변경사유목록 VO list  
		 * Receiver
		 * 		- Class : ApplicationMediator
		 * 		  Action : datagrid에 저장한다
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_USB_LIST_LOADSUCCESS:String = "SUSBMA_USBMANAGE_USB_LIST_LOADSUCCESS";
		public static const SUSBMA_USBMANAGE_USB_LIST_LOADFAIL:String = "SUSBMA_USBMANAGE_USB_LIST_LOADFAIL";
		
		public static const SUSBMA_USBMANAGE_USB_ADDSUCCESS:String = "SUSBMA_USBMANAGE_USB_ADDSUCCESS";
		public static const SUSBMA_USBMANAGE_USB_ADDFAIL:String = "SUSBMA_USBMANAGE_USB_ADDFAIL";
		
		public static const SUSBMA_USBMANAGE_USB_MODIFYSUCCESS:String = "SUSBMA_USBMANAGE_USB_MODIFYSUCCESS";
		public static const SUSBMA_USBMANAGE_USB_MODIFYFAIL:String = "SUSBMA_USBMANAGE_USB_MODIFYFAIL";
		
		public static const SUSBMA_USBMANAGE_MNGEMPID_MODIFYSUCCESS:String = "SUSBMA_USBMANAGE_MNGEMPID_MODIFYSUCCESS";
		public static const SUSBMA_USBMANAGE_MNGEMPID_MODIFYFAIL:String  = "SUSBMA_USBMANAGE_MNGEMPID_MODIFYFAIL";
		
		public static const SUSBMA_USBMANAGE_USB_DELETESUCCESS:String = "SUSBMA_USBMANAGE_USB_DELETESUCCESS";
		public static const SUSBMA_USBMANAGE_USB_DELETEFAIL:String = "SUSBMA_USBMANAGE_USB_DELETEFAIL";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_USBMANAGE_CLASS_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트를 요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 새로고침 버튼 클릭시
		 * 		  Parameter : None
		 * 		- Class : ApplicationFacade
		 * 		  Invoke : applicationStartup() --> 최초구동시 자동로드
		 * 		  Parameter : None
		 * Receiver
		 * 		- Class : SusbmaUsbmanageUsbListCommand
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의  selectSusbmaUsbmanageUsbList() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_CLASS_LIST:String	= "SUSBMA_USBMANAGE_CLASS_LIST";
		public static const SUSBMA_USBMANAGE_MEDIA_LIST:String	= "SUSBMA_USBMANAGE_MEDIA_LIST";
		public static const SUSBMA_USBMANAGE_REASON_LIST:String	= "SUSBMA_USBMANAGE_REASON_LIST";
		public static const SUSBMA_USBMANAGE_STATE_LIST:String	= "SUSBMA_USBMANAGE_STATE_LIST";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_USBMANAGE_USE_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트를 요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 새로고침 버튼 클릭시
		 * 		  Parameter : None
		 * 		- Class : ApplicationFacade
		 * 		  Invoke : applicationStartup() --> 최초구동시 자동로드
		 * 		  Parameter : None
		 * Receiver
		 * 		- Class : SusbmaUsbmanageUsbListCommand
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의  selectSusbmaUsbmanageUsbList() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_USE_LIST:String	= "SUSBMA_USBMANAGE_USE_LIST";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_USBMANAGE_CHANGE_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트를 요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 새로고침 버튼 클릭시
		 * 		  Parameter : None
		 * 		- Class : ApplicationFacade
		 * 		  Invoke : applicationStartup() --> 최초구동시 자동로드
		 * 		  Parameter : None
		 * Receiver
		 * 		- Class : SusbmaUsbmanageUsbListCommand
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의  selectSusbmaUsbmanageUsbList() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_CHANGE_LIST:String	= "SUSBMA_USBMANAGE_CHANGE_LIST";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_USBMANAGE_USE_LIST_LOADSUCCESS
		 * SUSBMA_USBMANAGE_USE_LIST_LOADFAIL
		 * 
		 * SUSBMA_USBMANAGE_CHANGE_LIST_LOADSUCCESS
		 * SUSBMA_USBMANAGE_CHANGE_LIST_LOADFAIL
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트 수신완료에 대한 notify
		 * Sender
		 * 		- Class : OpemanAccumaRemoteProxy
		 * 		  InvokeTime : 변경사유목록수신성공 
		 * 		  Parameter : 변경사유목록 VO list  
		 * Receiver
		 * 		- Class : ApplicationMediator
		 * 		  Action : datagrid에 저장한다
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_USE_LIST_LOADSUCCESS:String = "SUSBMA_USBMANAGE_USE_LIST_LOADSUCCESS";
		public static const SUSBMA_USBMANAGE_USE_LIST_LOADFAIL:String = "SUSBMA_USBMANAGE_USE_LIST_LOADFAIL";
		
		public static const SUSBMA_USBMANAGE_CHANGE_LIST_LOADSUCCESS:String = "SUSBMA_USBMANAGE_CHANGE_LIST_LOADSUCCESS";
		public static const SUSBMA_USBMANAGE_CHANGE_LIST_LOADFAIL:String = "SUSBMA_USBMANAGE_CHANGE_LIST_LOADFAIL";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_USBMANAGE_COMMON_LIST
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트를 요청하는 Command
		 * Sender
		 * 		- Class : ApplicationMediator
		 * 		  InvokeTime : 새로고침 버튼 클릭시
		 * 		  Parameter : None
		 * 		- Class : ApplicationFacade
		 * 		  Invoke : applicationStartup() --> 최초구동시 자동로드
		 * 		  Parameter : None
		 * Receiver
		 * 		- Class : SusbmaUsbmanageUsbListCommand
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의  selectSusbmaUsbmanageUsbList() 호출
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_COMMON_LIST:String	= "SUSBMA_USBMANAGE_COMMON_LIST";
		
		/**
		 * ---------------------------------------------------------
		 * SUSBMA_USBMANAGE_USE_LIST_LOADSUCCESS
		 * SUSBMA_USBMANAGE_USE_LIST_LOADFAIL
		 * 
		 * SUSBMA_USBMANAGE_CHANGE_LIST_LOADSUCCESS
		 * SUSBMA_USBMANAGE_CHANGE_LIST_LOADFAIL
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 변경사유 리스트 수신완료에 대한 notify
		 * Sender
		 * 		- Class : OpemanAccumaRemoteProxy
		 * 		  InvokeTime : 변경사유목록수신성공 
		 * 		  Parameter : 변경사유목록 VO list  
		 * Receiver
		 * 		- Class : ApplicationMediator
		 * 		  Action : datagrid에 저장한다
		 * ---------------------------------------------------------
		 */
		public static const SUSBMA_USBMANAGE_COMMON_LIST_LOADSUCCESS:String = "SUSBMA_USBMANAGE_COMMON_LIST_LOADSUCCESS";
		public static const SUSBMA_USBMANAGE_COMMON_LIST_LOADFAIL:String = "SUSBMA_USBMANAGE_COMMON_LIST_LOADFAIL";
		
		/**
		 * ---------------------------------------------------------
		 * D4LC_CMD_PASSWORD_INITIALIZE
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- 비밀번호 변경 호출 커맨드
		 * Sender
		 * 		- Class : PasswordInitializeMediator
		 * 		  InvokeTime : confirmButton_on_click
		 * 		  Parameter : targets, sno, pwd
		 * Receiver
		 * 		- Class : PasswordInitialize [Command]
		 * 		  Action : SusbmaUsbmanageRemoteProxy 의 changeUsbPassword() 호출
		 * ---------------------------------------------------------
		 */
		public static const D4LC_CMD_PASSWORD_INITIALIZE:String = "D4LC_CMD_PASSWORD_INITIALIZE";
		
		/**
		 * ---------------------------------------------------------
		 * D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT
		 * D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT
		 * ---------------------------------------------------------
		 * 용도 
		 * 		- NOTIFY : changeUsbPassword()
		 * Sender
		 * 		- Class : OpemanAccumaRemoteProxy
		 * 		  InvokeTime : 비밀번호 변경 RPC 호출 
		 * 		  Parameter : result or fault  
		 * Receiver
		 * 		- Class : PasswordInitializeMediator
		 * 		  Action : do nothing
		 * ---------------------------------------------------------
		 */
		public static const D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT:String = "D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT";
		public static const D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT:String = "D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT";
		
		
		public static const D4LC_CMD_USB_RETURN:String = "D4LC_CMD_USB_RETURN";
		
		public static const D4LC_NOTIFY_USB_RETURN_SUCCESS:String = "D4LC_NOTIFY_USB_RETURN_SUCCESS";
		public static const D4LC_NOTIFY_USB_RETURN_FAIL:String = "D4LC_NOTIFY_USB_RETURN_FAIL";
		
		public static const D4LC_CMD_MAKE_EMERGENCY_KEY:String = "D4LC_CMD_MAKE_EMERGENCY_KEY";
		
		public static const D4LC_NOTIFY_MAKE_EMERGENCY_KEY_RESULT:String = "D4LC_NOTIFY_MAKE_EMERGENCY_KEY_RESULT";
		
		public static const D4LC_NOTIFY_MAKE_EMERGENCY_KEY_FAIL:String = "D4LC_NOTIFY_MAKE_EMERGENCY_KEY_FAIL";
		
		public static const D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL:String = "D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL";
		public static const D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL_SUCCESS:String = "D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL_SUCCESS";
		
		public static const SUSBMA_USBMANAGE_DELETE_LIST:String = "SUSBMA_USBMANAGE_DELETE_LIST";
		
		public static const SUSBMA_USBMANAGE_DELETE_LIST_LOADSUCCESS:String = "SUSBMA_USBMANAGE_DELETE_LIST_LOADSUCCESS";
		public static const SUSBMA_USBMANAGE_DELETE_LIST_LOADFAIL:String = "SUSBMA_USBMANAGE_DELETE_LIST_LOADFAIL";
		
		public static const SUSBMA_USBMANAGE_MASS_REGISTER:String = "SUSBMA_USBMANAGE_MASS_REGISTER";
		
		public static const SUSBMA_USBMANAGE_MASS_REGISTER_SUCCESS:String = "SUSBMA_USBMANAGE_MASS_REGISTER_SUCCESS";
		public static const SUSBMA_USBMANAGE_MASS_REGISTER_FAIL:String = "SUSBMA_USBMANAGE_MASS_REGISTER_FAIL";
		
		public static const SUSBMA_USBMANAGE_STATUS_LIST:String = "SUSBMA_USBMANAGE_STATUS_LIST";
		public static const SUSBMA_USBMANAGE_STATUS_LIST_LOADSUCCESS:String = "SUSBMA_USBMANAGE_STATUS_LIST_LOADSUCCESS";
		public static const SUSBMA_USBMANAGE_STATUS_LIST_LOADFAIL:String = "SUSBMA_USBMANAGE_STATUS_LIST_LOADFAIL";
		
		public static const SUSBMA_USBMANAGE_FILE_DELETE_LIST:String = "SUSBMA_USBMANAGE_FILE_DELETE_LIST";
		public static const SUSBMA_USBMANAGE_FILE_DELETE_LISTLOADSUCCESS:String = "SUSBMA_USBMANAGE_FILE_DELETE_LISTLOADSUCCESS";
		public static const SUSBMA_USBMANAGE_FILE_DELETE_LISTLOADFAIL:String = "SUSBMA_USBMANAGE_FILE_DELETE_LISTLOADFAIL";
		
		public static const SUSBMA_USBMANAGE_UPDATE_LIST:String = "SUSBMA_USBMANAGE_UPDATE_LIST";
		public static const SUSBMA_USBMANAGE_UPDATE_LIST_LOADSUCCESS:String = "SUSBMA_USBMANAGE_UPDATE_LIST_LOADSUCCESS";
		public static const SUSBMA_USBMANAGE_UPDATE_LIST_LOADFAIL:String = "SUSBMA_USBMANAGE_UPDATE_LIST_LOADFAIL";
		
		public static const D4LC_CMD_PASSWORD_INITIALIZE_CHECK:String = "D4LC_CMD_PASSWORD_INITIALIZE_CHECK";
		public static const D4LC_NOTIFY_PASSWORD_INITIALIZE_CHECK_SUCCESS:String = "D4LC_NOTIFY_PASSWORD_INITIALIZE_CHECK_SUCCESS";
		public static const D4LC_NOTIFY_PASSWORD_INITIALIZE_CHECK_FAULT:String = "D4LC_NOTIFY_PASSWORD_INITIALIZE_CHECK_FAULT";
		
	}
}
