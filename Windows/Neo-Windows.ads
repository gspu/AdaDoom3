--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
with
  System,
  Interfaces,
  Interfaces.C,
  Ada.Command_Line,
  Ada.Unchecked_Conversion,
  Neo.Foundation.Data_Types;
use
  System,
  Interfaces,
  Interfaces.C,
  Ada.Command_Line,
  Neo.Foundation.Data_Types;
package Neo.Windows
  is
  -----------
  -- Types --
  -----------
    type Record_Network_Interface;
    type Record_Network_Address;
    type Record_Winsock_Data_Thirty_Two_Bit;
    type Record_Winsock_Data_Sixty_Four_Bit;
    type Record_Socket_Address;
    type Record_IP_Address_String;
    type Record_IP_Address;
    type Record_Adapter_Info_Thirty_Two_Bit;
    type Record_Adapter_Info_Sixty_Four_Bit;
    type Record_Host_Entity;
    type Array_Array_Integer_1_Unsigned_C
      is array (Natural range <>)
      of Array_Integer_1_Unsigned_C(1..4);
  ------------------
  -- Enumerations --
  ------------------
    type Enumerated_Address_Types
      is(
      Loopback_Address_Type,
      Broadcast_Address_Type,
      IP_Address_Type);
  ---------------
  -- Constants --
  ---------------
    WINSOCK_DESCRIPTION_LENGTH     : constant Integer_Size_C := 256;
    WINSOCK_SYSTEM_STATUS_LENGTH   : constant Integer_Size_C := 128;
    MAX_ADAPTER_DESCRIPTION_LENGTH : constant Integer_Size_C := 128;
    MAX_ADAPTER_NAME_LENGTH        : constant Integer_Size_C := 256;
    MAX_ADAPTER_ADDRESS_LENGTH     : constant Integer        := 8;
    NULL_WSADATA_DESCRIPTION                                      : constant String_1_C(1..WINSOCK_DESCRIPTION_LENGTH + 1)             := (others => Character_1_C'First);
    NULL_WSADATA_SYSTEM_STATUS                                    : constant String_1_C(1..WINSOCK_SYSTEM_STATUS_LENGTH + 1)           := (others => Character_1_C'First);
    NULL_SOCKET_ADDRESS_DATA                                      : constant Array_Integer_1_Unsigned_C(1..14)                         := (others => 0);
    NULL_IP_ADDRESS_STRING_STRING                                 : constant String_1_C(1..16)                                         := (others => Character_1_C'First);
    NULL_ADAPTER_INFO_NAME                                        : constant String_1_C(1..MAX_ADAPTER_NAME_LENGTH + 4)                := (others => Character_1_C'First);
    NULL_ADAPTER_INFO_DESCRIPTION                                 : constant String_1_C(1..MAX_ADAPTER_DESCRIPTION_LENGTH + 4)         := (others => Character_1_C'First);
    NULL_ADAPTER_INFO_ADDRESS                                     : constant Array_Integer_1_Unsigned_C(1..MAX_ADAPTER_ADDRESS_LENGTH) := (others => 0);
    NULL_IP_ADDRESS                                               : constant Array_Integer_1_Unsigned_C(1..4)                          := (others => 0);
    NULL_PADDING                                                  : constant Array_Integer_1_Unsigned_C(1..8)                          := (others => 0);
  -----------------
  -- Array_Types --
  -----------------
    type Array_Adapter_Info_Thirty_Two_Bit
      is array (Natural range <>)
      of aliased Record_Adapter_Info_Thirty_Two_Bit;
    type Access_Array_Adapter_Info_Thirty_Two_Bit
      is access all Array_Adapter_Info_Thirty_Two_Bit;
    type Array_Network_Interfaces
      is array (Natural range <>)
      of Record_Network_Interface;
  -----------------
  -- Subprograms --
  -----------------

  ----------------
  -- Directives --
  ----------------

  ---------------
  -- Constants --
  ---------------
    INSERT_ON_TOP_OF_EVERYTHING                : constant Address              := To_Address(Integer_4_Signed(-2));
    INSERT_ON_TOP_OF_APPLICATIONS              : constant Address              := To_Address(Integer_4_Unsigned(16#0000_0000#));
    GENERIC_CURSOR                             : constant Address              := To_Address(Integer_4_Unsigned(16#0000_7F8B#));--(16#0000_7F00#));
    GENERIC_ICON                               : constant Address              := To_Address(Integer_4_Unsigned(16#0000_7F00#));
    BRUSH_GRAY                                 : constant Address              := To_Address(Integer_4_Unsigned(16#0000_0011#));
    SO_BROADCAST                               : constant Integer_4_Signed_C   := 16#0000_0020#;
    SOL_SOCKET                                 : constant Integer_4_Signed_C   := 16#0000_FFFF#;
    FIONREAD                                   : constant Integer_4_Unsigned_C := 16#2000_667F#;
    FIONBIO                                    : constant Integer_4_Unsigned_C := 16#8004_667E#;
    FIOASYNC                                   : constant Integer_4_Unsigned_C := 16#8004_667D#;
    PORT_ANY                                                      : constant Integer_2_Unsigned_C := -1;
    INVALID_PORT                                                  : constant Integer_2_Unsigned_C := -1;
    INVALID_SOCKET                                                : constant Integer_4_Unsigned_C := Integer_4_Unsigned_C'Last;
    SOCKET_ERROR                                                  : constant Integer_4_Signed_C   := -1;
    SOCK_STREAM                                                   : constant Integer_4_Signed_C   := 1;
    SOCK_DGRAM                                                    : constant Integer_4_Signed_C   := 2;
    SOCK_RAW                                                      : constant Integer_4_Signed_C   := 3;
    SOCK_RDM                                                      : constant Integer_4_Signed_C   := 4;
    SOCK_SEQPACKET                                                : constant Integer_4_Signed_C   := 5;
    IPPROTO_HOPOPTS                                               : constant Integer_4_Signed_C   := 0;
    IPPROTO_ICMP                                                  : constant Integer_4_Signed_C   := 1;
    IPPROTO_IGMP                                                  : constant Integer_4_Signed_C   := 2;
    IPPROTO_GGP                                                   : constant Integer_4_Signed_C   := 3;
    IPPROTO_IPV4                                                  : constant Integer_4_Signed_C   := 4;
    IPPROTO_ST                                                    : constant Integer_4_Signed_C   := 5;
    IPPROTO_TCP                                                   : constant Integer_4_Signed_C   := 6;
    IPPROTO_CBT                                                   : constant Integer_4_Signed_C   := 7;
    IPPROTO_EGP                                                   : constant Integer_4_Signed_C   := 8;
    IPPROTO_IGP                                                   : constant Integer_4_Signed_C   := 9;
    IPPROTO_PUP                                                   : constant Integer_4_Signed_C   := 12;
    IPPROTO_UDP                                                   : constant Integer_4_Signed_C   := 17;
    IPPROTO_IDP                                                   : constant Integer_4_Signed_C   := 22;
    IPPROTO_RDP                                                   : constant Integer_4_Signed_C   := 27;
    IPPROTO_IPV6                                                  : constant Integer_4_Signed_C   := 41;
    IPPROTO_ROUTING                                               : constant Integer_4_Signed_C   := 43;
    IPPROTO_FRAGMENT                                              : constant Integer_4_Signed_C   := 44;
    IPPROTO_ESP                                                   : constant Integer_4_Signed_C   := 50;
    IPPROTO_AH                                                    : constant Integer_4_Signed_C   := 51;
    IPPROTO_ICMPV6                                                : constant Integer_4_Signed_C   := 58;
    IPPROTO_NONE                                                  : constant Integer_4_Signed_C   := 59;
    IPPROTO_DSTOPTS                                               : constant Integer_4_Signed_C   := 60;
    IPPROTO_ND                                                    : constant Integer_4_Signed_C   := 77;
    IPPROTO_ICLFXBM                                               : constant Integer_4_Signed_C   := 78;
    IPPROTO_PIM                                                   : constant Integer_4_Signed_C   := 103;
    IPPROTO_PGM                                                   : constant Integer_4_Signed_C   := 113;
    IPPROTO_L2TP                                                  : constant Integer_4_Signed_C   := 115;
    IPPROTO_SCTP                                                  : constant Integer_4_Signed_C   := 132;
    IPPROTO_RAW                                                   : constant Integer_4_Signed_C   := 255;
    IPPROTO_MAX                                                   : constant Integer_4_Signed_C   := 256;
    IPPROTO_RESERVED_RAW                                          : constant Integer_4_Signed_C   := 257;
    IPPROTO_RESERVED_IPSEC                                        : constant Integer_4_Signed_C   := 258;
    IPPROTO_RESERVED_IPSECOFFLOAD                                 : constant Integer_4_Signed_C   := 259;
    IPPROTO_RESERVED_MAX                                          : constant Integer_4_Signed_C   := 260;
    AF_UNSPEC                                                     : constant Integer_2_Unsigned_C := 0;
    AF_UNIX                                                       : constant Integer_2_Unsigned_C := 1;
    AF_INET                                                       : constant Integer_2_Unsigned_C := 2;
    AF_IMPLINK                                                    : constant Integer_2_Unsigned_C := 3;
    AF_PUP                                                        : constant Integer_2_Unsigned_C := 4;
    AF_CHAOS                                                      : constant Integer_2_Unsigned_C := 5;
    AF_NS                                                         : constant Integer_2_Unsigned_C := 6;
    AF_IPX                                                        : constant Integer_2_Unsigned_C := AF_NS;
    AF_ISO                                                        : constant Integer_2_Unsigned_C := 7;
    AF_OSI                                                        : constant Integer_2_Unsigned_C := AF_ISO;
    AF_ECMA                                                       : constant Integer_2_Unsigned_C := 8;
    AF_DATAKIT                                                    : constant Integer_2_Unsigned_C := 9;
    AF_CCITT                                                      : constant Integer_2_Unsigned_C := 10;
    AF_SNA                                                        : constant Integer_2_Unsigned_C := 11;
    AF_DECnet                                                     : constant Integer_2_Unsigned_C := 12;
    AF_DLI                                                        : constant Integer_2_Unsigned_C := 13;
    AF_LAT                                                        : constant Integer_2_Unsigned_C := 14;
    AF_HYLINK                                                     : constant Integer_2_Unsigned_C := 15;
    AF_APPLETALK                                                  : constant Integer_2_Unsigned_C := 16;
    AF_NETBIOS                                                    : constant Integer_2_Unsigned_C := 17;
    AF_VOICEVIEW                                                  : constant Integer_2_Unsigned_C := 18;
    AF_FIREFOX                                                    : constant Integer_2_Unsigned_C := 19;
    AF_UNKNOWN1                                                   : constant Integer_2_Unsigned_C := 20;
    AF_BAN                                                        : constant Integer_2_Unsigned_C := 21;
    AF_ATM                                                        : constant Integer_2_Unsigned_C := 22;
    AF_INET6                                                      : constant Integer_2_Unsigned_C := 23;
    AF_CLUSTER                                                    : constant Integer_2_Unsigned_C := 24;
    AF_12844                                                      : constant Integer_2_Unsigned_C := 25;
    AF_IRDA                                                       : constant Integer_2_Unsigned_C := 26;
    AF_NETDES                                                     : constant Integer_2_Unsigned_C := 28;
    INADDR_ANY                                                    : constant Integer_4_Unsigned_C := 16#00000000#;
    INADDR_LOOPBACK                                               : constant Integer_4_Unsigned_C := 16#7f000001#;
    INADDR_BROADCAST                                              : constant Integer_4_Unsigned_C := 16#ffffffff#;
    INADDR_NONE                                                   : constant Integer_4_Unsigned_C := 16#ffffffff#;
    ERROR_INSUFFICIENT_BUFFER                  : constant Integer_4_Unsigned_C := 16#_#;
    CODE_PAGE_UTF_8                            : constant Integer_4_Unsigned_C := 16#0000_FDE9#;
    KEY_READ                                   : constant Integer_4_Unsigned_C := 16#0002_0019#;
    HKEY_LOCAL_MACHINE                         : constant Integer_4_Unsigned_C := 16#8000_0002#;
    GENERIC_READ                               : constant Integer_4_Unsigned_C := 16#8000_0000#;
    GENERIC_WRITE                              : constant Integer_4_Unsigned_C := 16#4000_0000#;
    FILE_SHARE_READ                            : constant Integer_4_Unsigned_C := 16#0000_0001#;
    FILE_SHARE_WRITE                           : constant Integer_4_Unsigned_C := 16#0000_0002#;
    OPEN_EXISTING                              : constant Integer_4_Unsigned_C := 16#0000_0003#;
    ADD_LIST_OF_INSTALLED_DEVICES              : constant Integer_4_Unsigned_C := 16#0000_0004#;
    RESTRICT_DEVICES_TO_CURRENT_HARDWARE       : constant Integer_4_Unsigned_C := 16#0000_0002#;
    PROPERTY_FOR_DEVICE_DESCRIPTION            : constant Integer_4_Unsigned_C := 16#0000_0000#;
    PROPERTY_FOR_DEVICE_NAME                   : constant Integer_4_Unsigned_C := 16#0000_000C#;
    GET_RAW_DEVICE_NAME                        : constant Integer_4_Unsigned_C := 16#2000_0007#;
    GET_RAW_DEVICE_HEADER                      : constant Integer_4_Unsigned_C := 16#1000_0005#;
    GET_RAW_DEVICE_DATA                        : constant Integer_4_Unsigned_C := 16#1000_0003#;
    GET_RAW_DEVICE_PREPARSED_DATA              : constant Integer_4_Unsigned_C := 16#2000_0005#;
    FORMAT_MESSAGE_ALLOCATE_BUFFER             : constant Integer_4_Unsigned_C := 16#0000_0100#;
    FORMAT_MESSAGE_ARGUMENT_ARRAY              : constant Integer_4_Unsigned_C := 16#0000_2000#;
    FORMAT_MESSAGE_FROM_HMODULE                : constant Integer_4_Unsigned_C := 16#0000_0800#;
    FORMAT_MESSAGE_FROM_STRING                 : constant Integer_4_Unsigned_C := 16#0000_0400#;
    FORMAT_MESSAGE_FROM_SYSTEM                 : constant Integer_4_Unsigned_C := 16#0000_1000#;
    FORMAT_MESSAGE_IGNORE_INSERTS              : constant Integer_4_Unsigned_C := 16#0000_0200#;
    FORMAT_MESSAGE_MAX_WIDTH_MASK              : constant Integer_4_Unsigned_C := 16#0000_00FF#;
    EVENT_CLOSE                                : constant Integer_4_Unsigned_C := 16#0000_0010#;
    EVENT_KEY_UP                               : constant Integer_4_Unsigned_C := 16#0000_0101#;
    EVENT_SIZING                               : constant Integer_4_Unsigned_C := 16#0000_0214#;
    EVENT_COMMAND                              : constant Integer_4_Unsigned_C := 16#0000_0112#;
    EVENT_KEY_DOWN                             : constant Integer_4_Unsigned_C := 16#0000_0100#;
    EVENT_CHARACTER                            : constant Integer_4_Unsigned_C := 16#0000_0102#;
    EVENT_SIZE_CHANGED                         : constant Integer_4_Unsigned_C := 16#0000_0005#;
    EVENT_SYSTEM_KEY_DOWN                      : constant Integer_4_Unsigned_C := 16#0000_0104#;
    EVENT_SYSTEM_KEY_UP                        : constant Integer_4_Unsigned_C := 16#0000_0105#;
    EVENT_ACTIVATION_CHANGE                    : constant Integer_4_Unsigned_C := 16#0000_0006#;
    EVENT_MOUSE_MIDDLE_DOWN                    : constant Integer_4_Unsigned_C := 16#0000_0207#;
    EVENT_MOUSE_RIGHT_DOWN                     : constant Integer_4_Unsigned_C := 16#0000_0204#;
    EVENT_MOUSE_EXTRA_DOWN                     : constant Integer_4_Unsigned_C := 16#0000_020B#;
    EVENT_MOUSE_LEFT_DOWN                      : constant Integer_4_Unsigned_C := 16#0000_0201#;
    EVENT_MOUSE_MIDDLE_UP                      : constant Integer_4_Unsigned_C := 16#0000_0208#;
    EVENT_MOUSE_RIGHT_UP                       : constant Integer_4_Unsigned_C := 16#0000_0205#;
    EVENT_MOUSE_EXTRA_UP                       : constant Integer_4_Unsigned_C := 16#0000_020C#;
    EVENT_MOUSE_LEFT_UP                        : constant Integer_4_Unsigned_C := 16#0000_0202#;
    EVENT_MOUSE_WHEEL_VERTICAL                 : constant Integer_4_Unsigned_C := 16#0000_020A#;
    EVENT_MOUSE_WHEEL_HORIZONTAL               : constant Integer_4_Unsigned_C := 16#0000_020E#;
    EVENT_MOUSE_MOVE                           : constant Integer_4_Unsigned_C := 16#0000_0200#;
    EVENT_MOVE                                 : constant Integer_4_Unsigned_C := 16#0000_0003#;
    EVENT_CREATE                               : constant Integer_4_Unsigned_C := 16#0000_0001#;
    EVENT_INPUT_FOCUS_GAINED                   : constant Integer_4_Unsigned_C := 16#0000_0007#;
    EVENT_INPUT_FOCUS_LOST                     : constant Integer_4_Unsigned_C := 16#0000_0008#;
    STYLE_EXTRA_ALWAYS_ON_TOP                  : constant Integer_4_Unsigned_C := 16#0000_0008#;
    STYLE_EXTRA_NOTHING                        : constant Integer_4_Unsigned_C := 16#0000_0000#; 
    STYLE_NOTHING                              : constant Integer_4_Unsigned_C := 16#0000_0000#; 
    STYLE_TITLEBAR                             : constant Integer_4_Unsigned_C := 16#00C0_0000#;
    STYLE_TITLEBAR_MENU                        : constant Integer_4_Unsigned_C := 16#0008_0000#;
    STYLE_TITLEBARLESS_AND_BORDERLESS          : constant Integer_4_Unsigned_C := 16#8000_0000#;
    STYLE_VISIBLE_INITIALLY                    : constant Integer_4_Unsigned_C := 16#1000_0000#;
    STYLE_BORDER_THIN_LINE                     : constant Integer_4_Unsigned_C := 16#0080_0000#;
    STYLE_BORDER_SIZABLE                       : constant Integer_4_Unsigned_C := 16#0004_0000#;
    STYLE_BOX_FULLSCREEN                       : constant Integer_4_Unsigned_C := 16#0001_0000#;
    STYLE_BOX_ICONIZE                          : constant Integer_4_Unsigned_C := 16#0002_0000#;
    STYLE_NO_ACTIVATE                          : constant Integer_4_Unsigned_C := 16#0800_0000#;
    ICON_INFORMATION                           : constant Integer_4_Unsigned_C := 16#0000_0040#;
    ICON_WARNING                               : constant Integer_4_Unsigned_C := 16#0000_0030#;
    ICON_ERROR                                 : constant Integer_4_Unsigned_C := 16#0000_0010#;
    ICON_CUSTOM                                : constant Integer_4_Unsigned_C := 16#0000_0080#;
    LOAD_FROM_FILE                             : constant Integer_4_Unsigned_C := 16#0000_0010#;
    LOAD_ICO                                   : constant Integer_4_Unsigned_C := 16#0000_0001#;
    LOAD_CUR                                   : constant Integer_4_Unsigned_C := 16#0000_0002#;
    IGNORE_MESSAGE_FILTER_MINIMUM              : constant Integer_4_Unsigned_C := 16#0000_0000#;
    IGNORE_MESSAGE_FILTER_MAXIMUM              : constant Integer_4_Unsigned_C := 16#0000_0000#;
    BUTTON_OKAY                                : constant Integer_4_Unsigned_C := 16#0000_0000#;
    BUTTONS_YES_NO                             : constant Integer_4_Unsigned_C := 16#0000_0004#;
    BUTTONS_CANCEL_OKAY                        : constant Integer_4_Unsigned_C := 16#0000_0001#;
    BUTTONS_CANCEL_RETRY                       : constant Integer_4_Unsigned_C := 16#0000_0005#;
    MEMORY_MOVEABLE                            : constant Integer_4_Unsigned_C := 16#0000_0002#;
    MEMORY_DYNAMIC_DATA_EXCHANGE_SHARE         : constant Integer_4_Unsigned_C := 16#0000_2000#;
    MESSAGE_QUIT                               : constant Integer_4_Unsigned_C := 16#0000_0012#;
    CLIPBOARD_UNICODE_TEXT                     : constant Integer_4_Unsigned_C := 16#0000_000D#;
    REMOVE_MESSAGES_AFTER_PROCESSING           : constant Integer_4_Unsigned_C := 16#0000_0001#;
    NO_ERROR                                   : constant Integer_4_Unsigned_C := 16#0000_0000#;
    DEFAULT_TO_NEAREST_MONITOR                 : constant Integer_4_Unsigned_C := 16#0000_0002#;
    MAIL_API_TO                                : constant Integer_4_Unsigned_C := 16#0000_0001#;
    MAIL_API_DIALOG                            : constant Integer_4_Unsigned_C := 16#0000_0008#;
    ATTRIBUTE_SUB_DIRECTORY                    : constant Integer_4_Unsigned_C := 16#0000_0010#;
    GET_MOUSE                                  : constant Integer_4_Unsigned_C := 16#0000_0003#;
    SET_MOUSE                                  : constant Integer_4_Unsigned_C := 16#0000_0004#;
    SEND_CHANGE                                : constant Integer_4_Unsigned_C := 16#0000_0002#;
    GENERIC_DESKTOP_CONTROL                    : constant Integer_4_Unsigned_C := 16#0000_0001#;
    USE_RAW_MOUSE                              : constant Integer_4_Unsigned_C := 16#0000_0002#;
    USE_RAW_POINTER                            : constant Integer_4_Unsigned_C := 16#0000_0001#;
    USE_RAW_KEYBOARD                           : constant Integer_4_Unsigned_C := 16#0000_0005#;
    USE_RAW_JOYSTICK                           : constant Integer_4_Unsigned_C := 16#0000_0004#;
    USE_RAW_GAMEPAD                            : constant Integer_4_Unsigned_C := 16#0000_0006#;
    USE_RAW_KEYPAD                             : constant Integer_4_Unsigned_C := 16#0000_0004#;
    KIND_RAW_MOUSE                             : constant Integer_4_Unsigned_C := 16#0000_0000#;
    KIND_RAW_KEYBOARD                          : constant Integer_4_Unsigned_C := 16#0000_0001#;
    KIND_RAW_HUMAN_INTERFACE_DEVICE            : constant Integer_4_Unsigned_C := 16#0000_0002#;
    KIND_HUMAN_INTERFACE_DEVICE_INPUT          : constant Integer_4_Unsigned_C := 16#0000_0000#;
    SUCCESSFUL_HUMAN_INTEFACE_DEVICE_OPERATION : constant Integer_4_Unsigned_C := 16#0000_0000#;
    SUBEVENT_RAW_MOUSE_MIDDLE_DOWN             : constant Integer_4_Unsigned_C := 16#0000_0010#;
    SUBEVENT_RAW_MOUSE_MIDDLE_UP               : constant Integer_4_Unsigned_C := 16#0000_0020#;
    SUBEVENT_RAW_MOUSE_LEFT_DOWN               : constant Integer_4_Unsigned_C := 16#0000_0001#;
    SUBEVENT_RAW_MOUSE_LEFT_UP                 : constant Integer_4_Unsigned_C := 16#0000_0002#;
    SUBEVENT_RAW_MOUSE_RIGHT_DOWN              : constant Integer_4_Unsigned_C := 16#0000_0004#;
    SUBEVENT_RAW_MOUSE_RIGHT_UP                : constant Integer_4_Unsigned_C := 16#0000_0008#;
    SUBEVENT_RAW_MOUSE_EXTRA_1_DOWN            : constant Integer_4_Unsigned_C := 16#0000_0040#;
    SUBEVENT_RAW_MOUSE_EXTRA_1_UP              : constant Integer_4_Unsigned_C := 16#0000_0080#;
    SUBEVENT_RAW_MOUSE_EXTRA_2_DOWN            : constant Integer_4_Unsigned_C := 16#0000_0100#;
    SUBEVENT_RAW_MOUSE_EXTRA_2_UP              : constant Integer_4_Unsigned_C := 16#0000_0200#;
    SUBEVENT_RAW_MOUSE_WHEEL_VERTICAL          : constant Integer_4_Unsigned_C := 16#0000_0400#;
    SUBEVENT_RAW_MOUSE_WHEEL_HORIZONTAL        : constant Integer_4_Unsigned_C := 16#0000_0000#; -- ???
    SUBEVENT_ACTIVATED_BY_CLICK                : constant Integer_4_Unsigned_C := 16#0000_0002#;
    SUBEVENT_KEY_COMBINATION_ALT_ENTER         : constant Integer_4_Unsigned_C := 16#0000_000D#;
    SUBEVENT_RESIZE_BOTTOM_RIGHT               : constant Integer_4_Unsigned_C := 16#0000_0008#;
    SUBEVENT_RESIZE_BOTTOM_LEFT                : constant Integer_4_Unsigned_C := 16#0000_0007#;
    SUBEVENT_RESIZE_TOP_RIGHT                  : constant Integer_4_Unsigned_C := 16#0000_0005#;
    SUBEVENT_RESIZE_TOP_LEFT                   : constant Integer_4_Unsigned_C := 16#0000_0004#;
    SUBEVENT_RESIZE_BOTTOM                     : constant Integer_4_Unsigned_C := 16#0000_0006#;
    SUBEVENT_RESIZE_RIGHT                      : constant Integer_4_Unsigned_C := 16#0000_0002#;
    SUBEVENT_RESIZE_LEFT                       : constant Integer_4_Unsigned_C := 16#0000_0001#;
    SUBEVENT_RESIZE_TOP                        : constant Integer_4_Unsigned_C := 16#0000_0003#;
    SUBEVENT_RESIZE_SNAPBACK                   : constant Integer_4_Unsigned_C := 16#0000_0009#;
    SUBEVENT_CLICK_ACTIVATION                  : constant Integer_4_Unsigned_C := 16#0000_0002#;
    SUBEVENT_FULLSCREENED                      : constant Integer_4_Unsigned_C := 16#0000_0002#;
    SUBEVENT_RESTORED                          : constant Integer_4_Unsigned_C := 16#0000_0000#;
    SUBEVENT_ICONIZED                          : constant Integer_4_Unsigned_C := 16#0000_0001#;
    SUBEVENT_KEY_LEFT_MOUSE                    : constant Integer_4_Unsigned_C := 16#0000_0001#;
    SUBEVENT_KEY_CLEAR                         : constant Integer_4_Unsigned_C := 16#0000_00FE#;
    SUBEVENT_KEY_F10                           : constant Integer_4_Unsigned_C := 16#0000_0079#;
    SUBEVENT_KEY_F11                           : constant Integer_4_Unsigned_C := 16#0000_007A#;
    SUBEVENT_KEY_ALTERNATIVE                   : constant Integer_4_Unsigned_C := 16#0000_0012#;
    SUBEVENT_KEY_ALTERNATIVE_LEFT              : constant Integer_4_Unsigned_C := 16#0000_00A4#;
    SUBEVENT_KEY_ALTERNATIVE_RIGHT             : constant Integer_4_Unsigned_C := 16#0000_00A5#;
    SUBEVENT_KEY_CONTROL                       : constant Integer_4_Unsigned_C := 16#0000_0011#;
    SUBEVENT_KEY_CONTROL_LEFT                  : constant Integer_4_Unsigned_C := 16#0000_00A2#;
    SUBEVENT_KEY_CONTROL_RIGHT                 : constant Integer_4_Unsigned_C := 16#0000_00A3#;
    SUBEVENT_KEY_SHIFT                         : constant Integer_4_Unsigned_C := 16#0000_0010#;
    SUBEVENT_KEY_SHIFT_LEFT                    : constant Integer_4_Unsigned_C := 16#0000_00A0#;
    SUBEVENT_KEY_SHIFT_RIGHT                   : constant Integer_4_Unsigned_C := 16#0000_00A1#;
    SUBEVENT_MENU_POPOUT                       : constant Integer_4_Unsigned_C := 16#0000_F100#;
    SUBEVENT_SCREEN_SAVER_START                : constant Integer_4_Unsigned_C := 16#0000_F140#;
    SUBEVENT_WORD_LOW                          : constant Integer_4_Unsigned_C := 16#0000_FFFF#;
    SUBEVENT_WORD_HIGH                         : constant Integer_4_Unsigned_C := 16#FFFF_0000#;
    SUBEVENT_SHORT_LOW                         : constant Integer_2_Unsigned_C := 16#00FF#;
    END_OF_FILE_ON_WINDOWS                     : constant Integer_2_Unsigned_C := 16#FFFF#;
    SHORT_HIGH_BIT                             : constant Integer_2_Unsigned_C := 16#C000#;
    LANGUAGE_ARABIC                            : constant Integer_2_Unsigned_C := 16#0401#;
    LANGUAGE_BASQUE                            : constant Integer_2_Unsigned_C := 16#042D#;
    LANGUAGE_CATALAN                           : constant Integer_2_Unsigned_C := 16#0403#;
    LANGUAGE_CHINESE_SIMPLIFIED                : constant Integer_2_Unsigned_C := 16#0804#;
    LANGUAGE_CHINESE_TRADITIONAL               : constant Integer_2_Unsigned_C := 16#0404#;
    LANGUAGE_CZECH                             : constant Integer_2_Unsigned_C := 16#0405#;
    LANGUAGE_DANISH                            : constant Integer_2_Unsigned_C := 16#0406#;
    LANGUAGE_DUTCH                             : constant Integer_2_Unsigned_C := 16#0413#;
    LANGUAGE_ENGLISH                           : constant Integer_2_Unsigned_C := 16#0409#;
    LANGUAGE_FINNISH                           : constant Integer_2_Unsigned_C := 16#040B#;
    LANGUAGE_FRENCH                            : constant Integer_2_Unsigned_C := 16#040C#;
    LANGUAGE_GERMAN                            : constant Integer_2_Unsigned_C := 16#0407#;
    LANGUAGE_GREEK                             : constant Integer_2_Unsigned_C := 16#0408#;
    LANGUAGE_HEBREW                            : constant Integer_2_Unsigned_C := 16#040D#;
    LANGUAGE_HUNGARIAN                         : constant Integer_2_Unsigned_C := 16#040E#;
    LANGUAGE_ITALIAN                           : constant Integer_2_Unsigned_C := 16#0410#;
    LANGUAGE_JAPANESE                          : constant Integer_2_Unsigned_C := 16#0411#;
    LANGUAGE_KOREAN                            : constant Integer_2_Unsigned_C := 16#0412#;
    LANGUAGE_NORWEGIAN                         : constant Integer_2_Unsigned_C := 16#0414#;
    LANGUAGE_POLISH                            : constant Integer_2_Unsigned_C := 16#0415#;
    LANGUAGE_PORTUGUESE                        : constant Integer_2_Unsigned_C := 16#0816#;
    LANGUAGE_PORTUGUESE_BRAZIL                 : constant Integer_2_Unsigned_C := 16#0416#;
    LANGUAGE_RUSSIAN                           : constant Integer_2_Unsigned_C := 16#0419#;
    LANGUAGE_SLOVAKIAN                         : constant Integer_2_Unsigned_C := 16#041B#;
    LANGUAGE_SLOVENIAN                         : constant Integer_2_Unsigned_C := 16#0424#;
    LANGUAGE_SPANISH                           : constant Integer_2_Unsigned_C := 16#0C0A#;
    LANGUAGE_SWEDISH                           : constant Integer_2_Unsigned_C := 16#041D#;
    LANGUAGE_TURKISH                           : constant Integer_2_Unsigned_C := 16#041F#;
    LANGUAGE_NEUTRAL                           : constant Integer_1_Unsigned_C := 16#00#;
    SUBLANGUAGE_DEFAULT                        : constant Integer_1_Unsigned_C := 16#01#;
    GET_CLASS_CURSOR                           : constant Integer_4_Signed_C   := -12;
    SET_WINDOW_STYLE                           : constant Integer_4_Signed_C   := -16;
    SET_WINDOW_STYLE_EXTRA                     : constant Integer_4_Signed_C   := -20;
    SET_CLASS_CURSOR                           : constant Integer_4_Signed_C   := -12;
    HOOK_LOW_LEVEL_KEYBOARD                    : constant Integer_4_Signed_C   := 13;
    HOOK_LOW_LEVEL_MOUSE                       : constant Integer_4_Signed_C   := 14;
    REGION_NULL                                : constant Integer_4_Signed_C   := 0;
    REGION_COMPLEX                             : constant Integer_4_Signed_C   := 2;
    REGION_SIMPLE                              : constant Integer_4_Signed_C   := 1;
    PRESSED_OKAY                               : constant Integer_4_Signed_C   := 1;
    PRESSED_RETRY                              : constant Integer_4_Signed_C   := 4;
    PRESSED_YES                                : constant Integer_4_Signed_C   := 6;
    FAILED                                     : constant Integer_4_Signed_C   := 0;
    AN_ACTION_OCCURED                          : constant Integer_4_Signed_C   := 0;
    MAKE_WINDOW_FULLSCREEN                     : constant Integer_4_Signed_C   := 3;
    MAKE_WINDOW_HIDE                           : constant Integer_4_Signed_C   := 0;
    MAKE_WINDOW_RESTORE                        : constant Integer_4_Signed_C   := 9;
    MAKE_WINDOW_NORMALIZE                      : constant Integer_4_Signed_C   := 1;
    MAKE_WINDOW_GO_TO_ICONIC                   : constant Integer_4_Signed_C   := 2;
    DATA_HORZONTAL_RESOLUTION                  : constant Integer_4_Signed_C   := 8;
    DATA_NUMBER_OF_BITS_PER_PIXEL              : constant Integer_4_Signed_C   := 12;
    DATA_VERTICAL_RESOLUTION                   : constant Integer_4_Signed_C   := 10;
    MILLISECOND_TIMEOUT_FORCE_WRITE            : constant Integer_4_Signed_C   := 500
    MOUSE_WHEEL_DELTA                          : constant Integer_2_Signed     := 120;
    MAXIMUM_PATH_FOR_CREATE_FILE               : constant Integer_4_Signed     := 32_767;
  -------------
  -- Arrays --
  ------------
    type Reserved_Capabilities
      is array (1..17)
      of Integer_2_Unsigned_C;
    type Reserved_Button_Capabilities
      is array (1..10)
      of Integer_4_Unsigned_C;
    type Reserved_Shit
      is array (1..5)
      of Integer_2_Unsigned_C;
  -------------
  -- Records --
  -------------
    NULL_NETWORK_INTERFACE : constant Record_Network_Interface := (
      IP   => 0,
      Mask => 0);
    NULL_RECORD_NETWORK_ADDRESS : constant Record_Network_Address   := (
      Kind => IP_Address_Type,
      IP   => NULL_IP_ADDRESS,
      Port => 0);
    NULL_RECORD_WINSOCK_DATA_THIRTY_TWO_BIT : constant Record_Winsock_Data_Thirty_Two_Bit := (
      Version       => 0,
      High_Version  => 0,
      Description   => NULL_WSADATA_DESCRIPTION,
      System_Status => NULL_WSADATA_SYSTEM_STATUS,
      Max_Sockets   => 0,
      Max_Udp_Dg    => 0,
      Vendor_Info   => null);
    NULL_RECORD_WINSOCK_DATA_SIXTY_FOUR_BIT : constant Record_Winsock_Data_Sixty_Four_Bit := (
      Version       => 0,
      High_Version  => 0,
      Max_Sockets   => 0,
      Max_Udp_Dg    => 0,
      Vendor_Info   => null,
      Description   => NULL_WSADATA_DESCRIPTION,
      System_Status => NULL_WSADATA_SYSTEM_STATUS);
    NULL_RECORD_SOCKET_ADDRESS : constant Record_Socket_Address := (
      Family  => 0,
      Port    => 0,
      Address => 0,
      Padding => NULL_PADDING);
    NULL_RECORD_IP_ADDRESS_STRING : constant Record_IP_Address_String := (
      String => NULL_IP_ADDRESS_STRING_STRING);
    NULL_RECORD_IP_ADDRESS : constant Record_IP_Address := (
      Next       => null,
      IP_Address => NULL_RECORD_IP_ADDRESS_STRING,
      IP_Mask    => NULL_RECORD_IP_ADDRESS_STRING,
      Context    => 0);
    NULL_RECORD_ADAPTER_INFO_THIRTY_TWO_BIT : constant Record_Adapter_Info_Thirty_Two_Bit := (
      Next                  => null,
      Combo_Index           => 0,
      Name                  => NULL_ADAPTER_INFO_NAME,
      Description           => NULL_ADAPTER_INFO_DESCRIPTION,
      Address_Length        => 0,
      Address               => NULL_ADAPTER_INFO_ADDRESS,
      Index                 => 0,
      Address_Type          => 0,
      DHCP_Enabled          => 0,
      Current_Ip_Address    => null,
      Ip_Address_List       => NULL_RECORD_IP_ADDRESS,
      Gateway_List          => NULL_RECORD_IP_ADDRESS,
      DHCP_Server           => NULL_RECORD_IP_ADDRESS,
      Have_Wins             => 0,
      Primary_Wins_Server   => NULL_RECORD_IP_ADDRESS,
      Secondary_Wins_Server => NULL_RECORD_IP_ADDRESS,
      Lease_Obtained        => 0, 
      Lease_Expires         => 0);
    NULL_RECORD_ADAPTER_INFO_SIXTY_FOUR_BIT : constant Record_Adapter_Info_Sixty_Four_Bit := (
      Next                  => null,
      Combo_Index           => 0,
      Name                  => NULL_ADAPTER_INFO_NAME,
      Description           => NULL_ADAPTER_INFO_DESCRIPTION,
      Address_Length        => 0,
      Address               => NULL_ADAPTER_INFO_ADDRESS,
      Index                 => 0,
      Address_Type          => 0,
      DHCP_Enabled          => 0,
      Current_Ip_Address    => null,
      Ip_Address_List       => NULL_RECORD_IP_ADDRESS,
      Gateway_List          => NULL_RECORD_IP_ADDRESS,
      DHCP_Server           => NULL_RECORD_IP_ADDRESS,
      Have_Wins             => 0,
      Primary_Wins_Server   => NULL_RECORD_IP_ADDRESS,
      Secondary_Wins_Server => NULL_RECORD_IP_ADDRESS,
      Lease_Obtained        => 0, 
      Lease_Expires         => 0);
    NULL_RECORD_HOST_ENTITY : constant Record_Host_Entity := (
      Name      => null,
      Aliases   => null,
      Kind      => 0,
      Length    => 0,
      Addr_List => null);
    --
    type Record_Network_Interface
      is record
        IP   : Integer_4_Unsigned_C;
        Mask : Integer_4_Unsigned_C;
      end record;
      pragma Convention(C, Record_Network_Interface);
    type Record_Network_Address
      is record
        Kind : Enumerated_Address_Types;
        IP   : Array_Integer_1_Unsigned_C(1..4);
        Port : Integer_2_Unsigned_C;
      end record;
    type Record_Winsock_Data_Thirty_Two_Bit
      is record
        Version       : Integer_2_Unsigned_C;
        High_Version  : Integer_2_Unsigned_C;
        Description   : String_1_C(1..WINSOCK_DESCRIPTION_LENGTH + 1);
        System_Status : String_1_C(1..WINSOCK_SYSTEM_STATUS_LENGTH + 1);
        Max_Sockets   : Integer_8_Unsigned_C;
        Max_Udp_Dg    : Integer_8_Unsigned_C;
        Vendor_Info   : Access_Character_2_C;
      end record;
      pragma Convention(C, Record_Winsock_Data_Thirty_Two_Bit);
    type Record_Winsock_Data_Sixty_Four_Bit
      is record
        Version       : Integer_2_Unsigned_C;
        High_Version  : Integer_2_Unsigned_C;
        Max_Sockets   : Integer_2_Unsigned_C;
        Max_Udp_Dg    : Integer_2_Unsigned_C;
        Vendor_Info   : Access_Character_1_C;
        Description   : String_1_C(1..WINSOCK_DESCRIPTION_LENGTH + 1);
        System_Status : String_1_C(1..WINSOCK_SYSTEM_STATUS_LENGTH + 1);
      end record;
      pragma Convention(C, Record_Winsock_Data_Sixty_Four_Bit);
    type Record_Socket_Address
      is record
        Family  : Integer_2_Unsigned_C;
        Port    : Integer_2_Unsigned_C;
        Address : Integer_4_Unsigned_C;
        Padding : Array_Integer_1_Unsigned_C(1..8);
      end record;
      pragma Convention(C, Record_Socket_Address);
    type Record_IP_Address_String
      is record
        String : String_1_C(1..16);
      end record;
      pragma Convention(C, Record_IP_Address_String);
    type Record_IP_Address
      is record
        Next       : Access_IP_Address;
        IP_Address : Record_IP_Address_String;
        IP_Mask    : Record_IP_Address_String;
        Context    : Integer_4_Unsigned_C;
      end record;
      pragma Convention(C, Record_IP_Address);
    type Record_Adapter_Info_Thirty_Two_Bit
      is record
        Next                  : Access_Adapter_Info_Thirty_Two_Bit;
        Combo_Index           : Integer_4_Unsigned_C;
        Name                  : String_1_C(1..MAX_ADAPTER_NAME_LENGTH + 4);
        Description           : String_1_C(1..MAX_ADAPTER_DESCRIPTION_LENGTH + 4);
        Address_Length        : Integer_4_Unsigned_C;
        Address               : Array_Integer_1_Unsigned_C(1..MAX_ADAPTER_ADDRESS_LENGTH);
        Index                 : Integer_4_Unsigned_C;
        Address_Type          : Integer_4_Unsigned_C;
        DHCP_Enabled          : Integer_4_Unsigned_C;
        Current_Ip_Address    : Access_IP_Address;
        Ip_Address_List       : aliased Record_IP_Address;
        Gateway_List          : Record_IP_Address;
        DHCP_Server           : Record_IP_Address;
        Have_Wins             : Integer_4_Signed_C;
        Primary_Wins_Server   : Record_IP_Address;
        Secondary_Wins_Server : Record_IP_Address;
        Lease_Obtained        : Integer_4_Unsigned_C;
        Lease_Expires         : Integer_4_Unsigned_C;
      end record;
      pragma Convention(C, Record_Adapter_Info_Thirty_Two_Bit);
    type Record_Adapter_Info_Sixty_Four_Bit
      is record
        Next                  : Access_Adapter_Info_Sixty_Four_Bit;
        Combo_Index           : Integer_4_Unsigned_C;
        Name                  : String_1_C(1..MAX_ADAPTER_NAME_LENGTH + 4);
        Description           : String_1_C(1..MAX_ADAPTER_DESCRIPTION_LENGTH + 4);
        Address_Length        : Integer_4_Unsigned_C;
        Address               : Array_Integer_1_Unsigned_C(1..MAX_ADAPTER_ADDRESS_LENGTH);
        Index                 : Integer_4_Unsigned_C;
        Address_Type          : Integer_4_Unsigned_C;
        DHCP_Enabled          : Integer_4_Unsigned_C;
        Current_Ip_Address    : Access_IP_Address;
        Ip_Address_List       : aliased Record_IP_Address;
        Gateway_List          : Record_IP_Address;
        DHCP_Server           : Record_IP_Address;
        Have_Wins             : Integer_4_Signed_C;
        Primary_Wins_Server   : Record_IP_Address;
        Secondary_Wins_Server : Record_IP_Address;
        Lease_Obtained        : Integer_8_Unsigned_C;
        Lease_Expires         : Integer_8_Unsigned_C;
      end record;
      pragma Convention(C, Record_Adapter_Info_Sixty_Four_Bit);
    type Record_Host_Entity
      is record
        Name      : Access_Character_2_C;
        Aliases   : Access_String_1_C;
        Kind      : Integer_2_Signed_C;
        Length    : Integer_2_Signed_C;
        Addr_List : Access_Array_Array_Integer_1_Unsigned_C;
      end record;
      pragma Convention(C, Record_Host_Entity);
    --
typedef struct _OVERLAPPED {
  ULONG_PTR Internal;
  ULONG_PTR InternalHigh;
  union {
    struct {
      DWORD Offset;
      DWORD OffsetHigh;
    };
    PVOID  Pointer;
  };
  HANDLE    hEvent;
} OVERLAPPED, *LPOVERLAPPED;
    type Record_Overlapped_Something
      is record
        Internal : ;
        Internal_High : ;
        Event  : Address;
      end record;
    type Record_Device_Attributes
      is record
        Size    : Integer_4_Unsigned_C := ;
        Vendor  : Integer_2_Unsigned_C := ;
        Product : Integer_2_Unsigned_C := ;
        Version : Integer_2_Unsigned_C := ;
      end record;
    type Record_Device_Header
      is record
        Kind        : Integer_4_Unsigned_C := ;
        Size        : Integer_4_Unsigned_C := ;
        Device      : Address              := ;
        Data_Signed : Integer_4_Signed_C   := ;
      end record;
      pragma Convention(C, Record_Device_Header);
    type Record_Device_Capabilities
      is record
        Usage                                 : Integer_2_Unsigned_C  := ;
        Page                                  : Integer_2_Unsigned_C  := ;
        Input_Report_Byte_Length              : Integer_2_Unsigned_C  := ;
        Output_Report_Byte_Length             : Integer_2_Unsigned_C  := ;
        Feature_Report_Byte_Length            : Integer_2_Unsigned_C  := ;
        Reserved                              : Reserved_Capabilities := ;
        Number_Of_Link_Collection_Nodes       : Integer_2_Unsigned_C  := ;
        Number_Of_Input_Button_Capabilities   : Integer_2_Unsigned_C  := ;
        Number_Of_Input_Value_Capabilities    : Integer_2_Unsigned_C  := ;
        Number_Of_Input_Data_Indices          : Integer_2_Unsigned_C  := ;
        Number_Of_Output_Button_Capabilities  : Integer_2_Unsigned_C  := ;
        Number_Of_Output_Value_Capabilities   : Integer_2_Unsigned_C  := ;
        Number_Of_Output_Data_Indices         : Integer_2_Unsigned_C  := ;
        Number_Of_Feature_Button_Capabilities : Integer_2_Unsigned_C  := ;
        Number_Of_Feature_Value_Capabilities  : Integer_2_Unsigned_C  := ;
        Number_Of_Feature_Data_Indices        : Integer_2_Unsigned_C  := ;
      end record;
      pragma Convention(C, Record_Device_Capabilities);
    type Record_Device_Button_Capabilities
      is record
        Page                : Integer_2_Unsigned_C         := ;
        Report_Identifier   : Integer_1_Unsigned_C         := ;
        Is_Alias            : Integer_4_Signed_C           := ;
        Bit_Field           : Integer_2_Unsigned_C         := ;
        Link_Usage          : Integer_2_Unsigned_C         := ;
        Link_Page           : Integer_2_Unsigned_C         := ;
        Is_Range            : Integer_4_Signed_C           := ;
        Is_String_Range     : Integer_4_Signed_C           := ;
        Is_Designator_Range : Integer_4_Signed_C           := ;
        Is_Absolute         : Integer_4_Signed_C           := ;
        Reserved            : Reserved_Button_Capabilities := ;
        Usage_Minimum       : Integer_2_Unsigned_C         := ;
        String_Minimum      : Integer_2_Unsigned_C         := ;
        String_Maximum      : Integer_2_Unsigned_C         := ;
        Designator_Minimum  : Integer_2_Unsigned_C         := ;
        Designator_Maximum  : Integer_2_Unsigned_C         := ;
        Data_Index_Minimum  : Integer_2_Unsigned_C         := ;
        Data_Index_Maximum  : Integer_2_Unsigned_C         := ;
      end record;
      pragma Convention(C, Record_Device_Button_Capabilities);
    type Record_Device_Capability_Values
      is record
        Page                : Integer_2_Unsigned_C := ;
        Report_Identifier   : Integer_1_Unsigned_C := ;
        Is_Alias            : Integer_4_Signed_C   := ;
        Bit_Field           : Integer_2_Unsigned_C := ;
        Link_Collection     : Integer_2_Unsigned_C := ;
        Link_Usage          : Integer_2_Unsigned_C := ;
        Link_Page           : Integer_2_Unsigned_C := ;
        Is_Range            : Integer_4_Signed_C   := ;
        Is_String_Range     : Integer_4_Signed_C   := ;
        Is_Designator_Range : Integer_4_Signed_C   := ;
        Is_Absolute         : Integer_4_Signed_C   := ;
        Has_Null            : Integer_4_Signed_C   := ;
        Reserved_A          : Integer_1_Unsigned_C := ;
        Bit_Size            : Integer_2_Unsigned_C := ;
        Report_Count        : Integer_2_Unsigned_C := ;
        Reserved_B          : Reserved_Shit        := ;
        Units_Exponent      : Integer_4_Signed_C   := ;
        Logical_Minimum     : Integer_4_Signed_C   := ;
        Logical_Maximum     : Integer_4_Signed_C   := ;
        Physical_Minimum    : Integer_4_Signed_C   := ;
        Physical_Maximum    : Integer_4_Signed_C   := ;
        Usage_Minimum       : Integer_2_Unsigned_C := ;
        Usage_Maximum       : Integer_2_Unsigned_C := ;
        String_Minimum      : Integer_2_Unsigned_C := ;
        String_Maximum      : Integer_2_Unsigned_C := ;
        Designator_Minimum  : Integer_2_Unsigned_C := ;
        Designator_Maximum  : Integer_2_Unsigned_C := ;
      end record;
      pragma Convention(C, Record_Device_Capability_Values);
    type Record_Mouse
      is record
        Flags             : Integer_2_Unsigned_C := ;
        Button_Flags      : Integer_2_Unsigned_C := ;
        Button_Data       : Integer_2_Unsigned_C := ;
        Buttons           : Integer_4_Unsigned_C := ;
        Last_X            : Integer_4_Signed_C   := ;
        Last_Y            : Integer_4_Signed_C   := ;
        Extra_Information : Integer_4_Unsigned_C := ;
      end record;
      pragma Convention(C, Record_Mouse);
    -- type Record_Mouse
    --   is record
    --     Point       : Record_Point;
    --     Data        : Integer_4_Unsigned_C;
    --     Flags       : Integer_4_Unsigned_C;
    --     Time        : Integer_4_Unsigned_C;
    --     Information : Address; -- Changes on 64/32 bit systems
    --   end record;
    --   pragma Convention(C, Record_Mouse);
    type Record_Keyboard
      is record
        Make_Code         : Integer_2_Unsigned_C := ;
        Flags             : Integer_2_Unsigned_C := ;
        Reserved          : Integer_2_Unsigned_C := ;
        Key               : Integer_2_Unsigned_C := ;
        Message           : Integer_4_Unsigned_C := ;
        Extra_Information : Integer_4_Unsigned_C := ;
      end record;
      pragma Convention(C, Record_Keyboard);
    type Record_Version_Information
      is record
        Size                : Integer_4_Unsigned_C := ;
        Major               : Integer_4_Unsigned_C := ;
        Minor               : Integer_4_Unsigned_C := ;
        Build_Number        : Integer_4_Unsigned_C := ;
        Platform_Identifier : Integer_4_Unsigned_C := ;
        Service_Pack        : String_2(1..128)     := ;
        Service_Pack_Major  : Integer_2_Unsigned_C := ;
        Service_Pack_Minor  : Integer_2_Unsigned_C := ;
        Suite_Mask          : Integer_2_Unsigned_C := ;
        Product_Type        : Integer_1_Unsigned_C := ;
        Reserved            : Integer_1_Unsigned_C := ;
      end record;
      pragma Convention(C, Record_Version_Information);
    type Record_Device_Interface
      is record
        Size     : Integer_4_Unsigned_C        := ;
        Class_ID : Integer_4_Unsigned_C        := ;
        Flags    : Integer_4_Unsigned_C        := ;
        Reserved : Access_Integer_4_Unsigned_C := ; -- ULONG_PTR
      end record;
    type Record_Flash_Information
      is record
        Size     : Integer_4_Unsigned_C := ;
        Window   : Address              := ;
        Flags    : Integer_4_Unsigned_C := ;
        Count    : Integer_4_Unsigned_C := ;
        Time_Out : Integer_4_Unsigned_C := ;
      end record;
      pragma Convention(C, Record_Flash_Information);
    type Record_Rectangle
      is record
        Left   : Integer_4_Signed_C := ;
        Top    : Integer_4_Signed_C := ;
        Right  : Integer_4_Signed_C := ;
        Bottom : Integer_4_Signed_C := ;
      end record;
      pragma Convention(C, Record_Rectangle); 
    type Record_Monitor_Information
      is record
        Size      : Integer_4_Unsigned_C := ;
        Monitor   : Record_Rectangle     := ;
        Work_Area : Record_Rectangle     := ;
        Flags     : Integer_4_Unsigned_C := ;
      end record;
      pragma Convention(C, Record_Monitor_Information);
    type Record_Window_Class
      is record
        Size       : Integer_4_Unsigned_C;
        Style      : Integer_4_Unsigned_C;
        Callback   : Address;
        Extra_A    : Integer_4_Signed_C;
        Extra_B    : Integer_4_Signed_C;
        Instance   : Address;
        Icon_Large : Address;
        Cursor     : Address;
        Background : Address;
        Menu_Name  : Access_Constant_Character_2_C;
        Class_Name : Access_Constant_Character_2_C;
        Icon_Small : Address;
      end record;
      pragma Convention(C, Record_Window_Class); 
    type Record_Point
      is record
        X : Integer_4_Signed_C;
        Y : Integer_4_Signed_C;
      end record;
      pragma Convention(C, Record_Point);
    type Record_Message
      is record
        Window        : Address              := NULL_ADDRESS;
        Data          : Integer_4_Unsigned_C := 0;
        Data_Unsigned : Integer_4_Unsigned_C := 0;
        Data_Signed   : Integer_4_Signed_C   := 0;
        Time          : Integer_4_Unsigned_C := 0;
        Point         : Record_Point         := <>;
      end record;
      pragma Convention(C, Record_Message);
    type Record_Key
      is record
        Code        : Integer_4_Unsigned_C := 0;
        Scan_Code   : Integer_4_Unsigned_C := 0;
        Flags       : Integer_4_Unsigned_C := 0;
        Time        : Integer_4_Unsigned_C := 0;
        Information : Address              := NULL_ADDRESS; -- Changes on 64/32 bit systems
      end record;
      pragma Convention(C, Record_Key);
    type Record_Memory_Status
      is record
        Length                     : Integer_4_Unsigned_C;
        Memory_Load                : Integer_4_Unsigned_C;
        Total_Physical             : Integer_8_Unsigned_C;
        Available_Physical         : Integer_8_Unsigned_C;
        Total_Page_File            : Integer_8_Unsigned_C;
        Available_Page_File        : Integer_8_Unsigned_C;
        Total_Virtual              : Integer_8_Unsigned_C;
        Available_Virtual          : Integer_8_Unsigned_C;
        Available_Extended_Virtual : Integer_8_Unsigned_C;
      end record;
      pragma Convention(C, Record_Memory_Status);
    type Record_GUID
      is record
        First_Eight_Hex   : Integer_4_Unsigned_C;
        Second_Four_Hex   : Integer_2_Unsigned_C;
        Third_Four_Hex    : Integer_2_Unsigned_C;
        Final_Sixteen_Hex : Array_Integer_1_Unsigned_C(1..8);
      end record;
      pragma Convention(C, Record_GUID);
    type Record_Device_Information
      is record
        Size       : Integer_4_Unsigned_C;
        Class_GUID : Record_GUID;
        Instance   : Integer_4_Unsigned_C;
        Reserved   : Address; -- ULONG_PTR!!!
      end record;
      pragma Convention(C, Record_Device_Information);
    type Record_Device
      is record
        Page   : Integer_2_Unsigned_C;
        Usage  : Integer_2_Unsigned_C;
        Flags  : Integer_4_Unsigned_C;
        Target : Address;
      end record;
      pragma Convention(C, Record_Device);
    type Record_Device_List_Element
      is record
        Handle : Address;
        Kind   : Integer_4_Unsigned_C;
      end record;
      pragma Convention(C, Record_Device_List_Element);
  ------------
  -- Arrays --
  ------------
    type Array_Record_Device_List_Element
      is array (Positive range <>)
      of Record_Device_List_Element;
  --------------------
  -- Type Constants --
  --------------------
    NULL_RECORD_DEVICE_ATTRIBUTES:
      constant Record_Device_Attributes :=(
        );
    NULL_RECORD_DEVICE_INTERFACE: 
      constant Record_Device_Interface :=(
        Size     => Record_Device_Interface'Size / 8,
        Class_ID => 0,
        Flags    => 0,
        Reserved => NULL_ADDRESS);
    NULL_RECORD_DEVICE_CAPABILITIES:
      constant Record_Device_Capabilities :=(
        Usage                                 => 0,
        Page                                  => 0,
        Input_Report_Byte_Length              => 0,
        Output_Report_Byte_Length             => 0,
        Feature_Report_Byte_Length            => 0,
        Reserved                              => (others => 0),
        Number_Of_Link_Collection_Nodes       => 0,
        Number_Of_Input_Button_Capabilities   => 0,
        Number_Of_Input_Value_Capabilities    => 0,
        Number_Of_Input_Data_Indices          => 0,
        Number_Of_Output_Button_Capabilities  => 0,
        Number_Of_Output_Value_Capabilities   => 0,
        Number_Of_Output_Data_Indices         => 0,
        Number_Of_Feature_Button_Capabilities => 0,
        Number_Of_Feature_Value_Capabilities  => 0,
        Number_Of_Feature_Data_Indices        => 0);
    NULL_RECORD_DEVICE_BUTTON_CAPABILITIES:
      constant Record_Device_Button_Capabilities :=(
        Page                => 0,
        Report_Identifier   => 0,
        Is_Alias            => 0,
        Bit_Field           => 0,
        Link_Usage          => 0,
        Link_Page           => 0,
        Is_Range            => 0,
        Is_String_Range     => 0,
        Is_Designator_Range => 0,
        Is_Absolute         => 0,
        Reserved            => (others => 0),
        Usage_Minimum       => 0,
        String_Minimum      => 0,
        String_Maximum      => 0,
        Designator_Minimum  => 0,
        Designator_Maximum  => 0,
        Data_Index_Minimum  => 0,
        Data_Index_Maximum  => 0);
    NULL_RECORD_GUID:
      constant Record_GUID :=(
        First_Eight_Hex   => 0,
        Second_Four_Hex   => 0,
        Third_Four_Hex    => 0,
        Final_Sixteen_Hex => (others => 0));
    NULL_RECORD_DEVICE_INFORMATION:
      constant Record_Device_Information :=(
        Size       => Record_Device_Information'Size / 8,
        Class_GUID => NULL_RECORD_GUID,
        Instance   => 0,
        Reserved   => NULL_ADDRESS);
    NULL_RECORD_DEVICE_LIST_ELEMENT:
      constant Record_Device_List_Element :=(
        Handle => NULL_ADDRESS,
        Kind   => 0);
    NULL_RECORD_DEVICE:
      constant Record_Device :=(
        Page   => 0,
        Usage  => 0,
        Flags  => 0,
        Target => NULL_ADDRESS);
    NULL_RECORD_VERSION_INFORMATION:
      constant Record_Version_Information :=(
        Size                => Record_Version_Information'Size / 8,
        Major               => 0,
        Minor               => 0,
        Build_Number        => 0,
        Platform_Identifier => 0,
        Service_Pack        => (others => ' '),
        Service_Pack_Major  => 0,
        Service_Pack_Minor  => 0,
        Suite_Mask          => 0,
        Product_Type        => 0,
        Reserved            => 0);
    NULL_RECORD_FLASH_INFORMATION:
      constant Record_Flash_Information :=(
        Size     => Record_Flash_Information'Size / 8,
        Window   => NULL_ADDRESS,
        Flags    => 0,
        Count    => 0,
        Time_Out => 0);
    NULL_RECORD_MEMORY_STATUS:
      constant Record_Memory_Status :=(
        Length                     => Record_Memory_Status'Size / 8,
        Memory_Load                => 0,
        Total_Physical             => 0,
        Available_Physical         => 0,
        Total_Page_File            => 0,
        Available_Page_File        => 0,
        Total_Virtual              => 0,
        Available_Virtual          => 0,
        Available_Extended_Virtual => 0);
    NULL_RECORD_WINDOW_CLASS:
      constant Record_Window_Class :=(
        Size       => Record_Window_Class'Size / 8,
        Style      => 0,
        Callback   => NULL_ADDRESS,
        Extra_A    => 0,
        Extra_B    => 0,
        Instance   => NULL_ADDRESS,
        Icon_Small => NULL_ADDRESS,
        Icon_Large => NULL_ADDRESS,
        Cursor     => NULL_ADDRESS,
        Background => NULL_ADDRESS,
        Menu_Name  => null,
        Class_Name => null);
    NULL_RECORD_RECTANGLE:
      constant Record_Rectangle :=(
        Left   => 0,
        Top    => 0,
        Right  => 0, 
        Bottom => 0);
    NULL_RECORD_MONITOR_INFORMATION:
      constant Record_Monitor_Information :=(
        Size      => Record_Monitor_Information'Size / 8,
        Monitor   => NULL_RECORD_RECTANGLE,
        Work_Area => NULL_RECORD_RECTANGLE,
        Flags     => 0);
    NULL_RECORD_POINT:
      constant Record_Point :=(
        X => 0,
        Y => 0);
    NULL_RECORD_MESSAGE:
      constant Record_Message :=(
        Window        => NULL_ADDRESS,
        Data          => 0,
        Data_Unsigned => 0,
        Data_Signed   => 0,
        Time          => 0,
        Point         => NULL_RECORD_POINT);
    NULL_RECORD_KEY:
      constant Record_Key :=(
        Code        => 0,
        Scan_Code   => 0,
        Flags       => 0,
        Time        => 0,
        Information => NULL_ADDRESS); 
  ---------------
  -- Accessors --
  ---------------
    -- type Access_Record_Device_List
    --   is access all Record_Device_List;
    -- type Access_Array_Record_Device_List
    --   is access all Array_Record_Device_List;
    type Access_Record_Key
      is access all Record_Key;
    type Access_Record_Mouse
      is access all Record_Mouse;
    type Access_Record_Rectangle
      is access all Record_Rectangle;
    type Access_Record_Monitor_Information
      is access all Record_Monitor_Information;
    type Access_Network_Interface
      is access all Record_Network_Interface;
    type Access_Network_Address
      is access all Record_Network_Address;
    type Access_Winsock_Data_Thirty_Two_Bit
      is access all Record_Winsock_Data_Thirty_Two_Bit;
    type Access_Winsock_Data_Sixty_Four_Bit
      is access all Record_Winsock_Data_Sixty_Four_Bit;
    type Access_Socket_Address
      is access all Record_Socket_Address;
    type Access_IP_Address_String
      is access all Record_IP_Address_String;
    type Access_IP_Address
      is access all Record_IP_Address;
    type Access_Adapter_Info_Thirty_Two_Bit
      is access all Record_Adapter_Info_Thirty_Two_Bit;
    type Access_Adapter_Info_Sixty_Four_Bit
      is access all Record_Adapter_Info_Sixty_Four_Bit;
    type Access_Host_Entity
      is access all Record_Host_Entity;
    type Access_Array_Array_Integer_1_Unsigned_C
      is access all Array_Array_Integer_1_Unsigned_C;
  -----------------
  -- Subprograms --
  -----------------
    --
    function To_Byte_Array(
      Item : in Integer_4_Unsigned_C)
      return Array_Integer_1_Unsigned_C;
    function To_Byte_Array(
      Item : in Integer_2_Unsigned_C)
      return Array_Integer_1_Unsigned_C;
    function To_Int(
      Item : in String_1_C)
      return Integer_4_Unsigned_C;
    function To_Int(
      Item : in Array_Integer_1_Unsigned_C)
      return Integer_4_Unsigned_C;
    function To_Array_Integer_1_Unsigned_C(
      Item : in String_1_C)
      return Array_Integer_1_Unsigned_C;
    function To_String_1_C(
      Item : in Array_Integer_1_Unsigned_C)
      return String_1_C;
    procedure Free_Adapter_Info_Thirty_Two_Bit
      is new Ada.Unchecked_Deallocation(Record_Adapter_Info_Thirty_Two_Bit, Access_Adapter_Info_Thirty_Two_Bit);
    function Get_Last_Error
      return Integer_4_Signed_C;
    function Winsock_Startup(
      Version_Requested : in Integer_2_Signed_C;
      Winsock_Data      : in Access_Winsock_Data_Thirty_Two_Bit)
      return Integer_4_Signed_C;
    function Get_Adapters_Information(
      Adapter_Info : in Access_Adapter_Info_Thirty_Two_Bit;
      Size_Pointer : in Access_Integer_4_Unsigned_C)
      return Integer_4_Unsigned_C;
    function To_Host_Byte_Order(
      Net_Long : in Integer_4_Unsigned_C)
      return Integer_4_Unsigned_C;
    function To_Integer_4_Unsigned_C(
      cp : in String_1_C )
      return Integer_4_Unsigned_C;
    function Winsock_Cleanup
      return Integer_4_Signed_C;
    function Host_To_Networking_Short(
      Host_Short : in Integer_2_Unsigned_C)
      return Integer_2_Unsigned_C;
    function Send_To(
      Socket_Identifier  : in Integer_4_Unsigned_C;
      Message_Buffer     : in Array_Integer_1_Unsigned_C;
      Message_Length     : in Integer_4_Signed_C;
      Flags              : in Integer_4_Signed_C;
      Destination        : in Access_Socket_Address;
      Sizeof_Destination : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Make_Socket(
      af       : in Integer_4_Signed_C;
      Kind     : in Integer_4_Signed_C;
      Protocol : in Integer_4_Signed_C)
      return Integer_4_Unsigned_C;
    function Control_Socket_IO(
      Socket : in Integer_4_Unsigned_C;
      cmd    : in Integer_4_Unsigned_C;
      argp   : in Access_Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Set_Socket_Options(
      Socket  : in Integer_4_Unsigned_C;
      Level   : in Integer_4_Signed_C;
      optname : in Integer_4_Signed_C;
      optval  : in String_1_C;
      optlen  : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Bind_Socket(
      Socket      : in Integer_4_Unsigned_C;
      Name        : in Access_Socket_Address;
      Name_Length : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Close_Socket(
      Socket : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Get_Socket_Name(
      Socket      : in Integer_4_Unsigned_C;
      Name        : in Access_Address;
      Name_Length : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Get_Host_By_Name(
      Name : String_1_C)
      return Access_Host_Entity;
    --
    function To_Integer_4_Signed_C
      is new Ada.Unchecked_Conversion(Access_Record_Mouse, Integer_4_Signed_C);
    function To_Integer_4_Signed_C
      is new Ada.Unchecked_Conversion(Access_Record_Key, Integer_4_Signed_C);
    function To_Address
      is new Ada.Unchecked_Conversion(Integer_4_Unsigned, Address);
    function To_Character_2
      is new Ada.Unchecked_Conversion(Integer_2_Unsigned, Character_2);
    function To_Access_Record_Rectangle   
      is new Ada.Unchecked_Conversion(Address, Access_Record_Rectangle);
    function To_Access_Record_Key 
      is new Ada.Unchecked_Conversion(Integer_4_Signed_C, Access_Record_Key);
    function To_Access_Record_Rectangle   
      is new Ada.Unchecked_Conversion(Integer_4_Signed_C, Access_Record_Rectangle);
    function Get_Blank_Cursor
      return Array_Integer_1_Unsigned;
    procedure Get_Device_Identifier(
      Identifier : in Access_Device_Identifier);
    function Is_Lower(
      Item : in Character_2)
      return Integer_4_Signed;
    function Is_Upper(
      Item : in Character_2)
      return Integer_4_Signed;
    function Write_File(
      File                     : in Address;
      Buffer                   : in Access_Constant_Array_Integer_1_Unsigned_C;
      Number_Of_Bytes_To_Write : in Integer_4_Unsigned_C;
      Bytes_Written            : in Access_Integer_4_Unsigned_C;
      Over_Lapped              : in Access_Record_Overlapped)
      return Integer_4_Signed_C;
    function Convert_String_2_C_To_UTF_8(
      Code_Page                   : in Integer_4_Unsigned_C;
      Flags                       : in Integer_4_Unsigned_C;
      Original_String             : in Access_String_2_C;
      Character_Count_Of_Original : in Integer_4_Signed_C;
      Resulting_String            : in Access_String_1_C;
      Byte_Count_Of_Result        : in Integer_4_Signed_C;
      Default_Character           : in Access_Constant_String_1_C;
      Used_Default_Character      : in Access_Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Register_Devices(
      Devices : in Address;
      Number  : in Integer_4_Unsigned_C;
      Size    : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Set_Device_Output_Data(
      Device : in Address;
      Data   : in Address;
      Size   : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Get_Device_Attributes(
      Device     : in Address;
      Attributes : in Access_Device_Attributes)
      return Integer_4_Signed_C;
    function Get_Device_Interface_Detail(
      Information_Set       : in Record_Device_Information;--_In_       HDEVINFO 
      Interface             : in Record_Device_Interface;--_In_       PSP_DEVICE_INTERFACE_DATA 
      Interface_Detail      : in Record_Device_Detail;--_Out_opt_  PSP_DEVICE_INTERFACE_DETAIL_DATA 
      Interface_Detail_Size : in Integer_4_Unsigned_C;--, _In_       DWORD 
      Required_Size         : in Access_Integer_4_Unsigned_C;--_Out_opt_  PDWORD 
      Information           : in );--_Out_opt_  PSP_DEVINFO_DATA);
      return Integer_4_Signed;
    function Enumerate_Device_Interfaces(
      Information_Set      : in Access_Device_Information;
      Information_Data     : in Access_PSP_DEVINFO_DATA;
      Interface_Class_Guid : in Access_GUID;
      Member_Index         : in Integer_4_Unsigned;
      Interface_Data       : in Access_PSP_DEVICE_INTERFACE_DATA)
      return Integer_4_Signed;
    function Sleep(
      Milliseconds : in Integer_4_Unsigned_C;
      Alertable    : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Registry_Close_Key(
      Key : in Address)
      return Integer_4_Signed_C;
    function Registry_Open_Key(
      Key     : in Integer_4_Unsigned_C;
      Sub_Key : in String_2_C;
      Options : in Integer_4_Unsigned_C;
      Desired : in Integer_4_Unsigned_C;
      Result  : in Address)
      return Integer_4_Unsigned_C;
    function Registry_Query_Value(
      Key        : in Address;
      Value_Name : in String_2_C;
      Reserved   : in Address;
      Kind       : in Address;
      Data       : in Address;
      Data_Size  : in Address)
      return Integer_4_Unsigned_C;
    function Get_Device_Usages(
      Kind            : in Integer_4_Signed_C; -- Enumerated
      Page            : in Integer_2_Unsigned_C;
      Link_Collection : in Integer_2_Unsigned_C;
      Usage           : in Address;
      Usage_Length    : in Address; -- PULONG!
      Preparsed_Data  : in Address;
      Report          : in Access_Array_Integer_1_Unsigned_C;
      Report_Length   : in Integer_4_Unsigned_C)
      return Integer_4_Unsigned_C;
    function Get_Device_Button_Capabilities(
      Kind                : in Integer_4_Signed_C;
      Button_Capabilities : in Address;
      Length              : in Address;
      Preparsed_Data      : in Address)
      return Integer_4_Unsigned_C;
    function Create_File(
      Name                 : in Address;
      Desired_Access       : in Integer_4_Unsigned_C;
      Share_Mode           : in Integer_4_Unsigned_C;
      Security_Attributes  : in Address;
      Creation_Desposition : in Integer_4_Unsigned_C;
      Flags_And_Attributes : in Integer_4_Unsigned_C;
      Template_File        : in Address)
      return Address;
    function Get_Device_Manufacturer(
      File   : in Address;
      Buffer : in Address;
      Size   : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Get_Device_Description(
      File   : in Address;
      Buffer : in Address;
      Size   : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Get_Device_Product(
      File   : in Address;
      Buffer : in Address;
      Size   : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Get_Device_Information(
      Device  : in Address;
      Command : in Integer_4_Unsigned_C;
      Data    : in Address;
      Size    : in Address)
      return Integer_4_Unsigned_C;
    function Get_Device_Input_Data(
      Raw_Input   : in Address;
      Command     : in Integer_4_Unsigned_C;
      Data        : in Address;
      Size        : in Address;
      Header_Size : in Integer_4_Unsigned_C)
      return Integer_4_Unsigned_C;
    function Get_Device_Information(
      Guid          : in Address;
      Enumerator    : in Address;
      Window_Parent : in Address;
      Flags         : in Integer_4_Unsigned_C)
      return Address;
    function Get_Device_Registry_Property(
      Set           : in Address;
      Data          : in Address;
      Property      : in Integer_4_Unsigned_C;
      Registry_Kind : in Address;
      Buffer        : in Address;
      Size          : in Integer_4_Unsigned_C;
      Required_Size : in Address)
      return Integer_4_Signed_C;
    function Get_Device_Instance_Id(
      Set           : in Address;
      Data          : in Address;
      Id            : in Address;
      Size          : in Integer_4_Unsigned_C;
      Required_Size : in Address)
      return Integer_4_Signed_C;
    function Get_Device_Enumeration(
      Set    : in Address;
      Member : in Integer_4_Unsigned_C;
      Data   : in Address)
      return Integer_4_Signed_C;
    function Get_Device_List(
      List  : in Address;
      Count : in Address;
      Size  : in Integer_4_Unsigned_C)
      return Integer_4_Unsigned_C;
    function Destroy_Device_List(
      List : in Address)
      return Integer_4_Signed_C;
    function Enumerate_Display_Monitor(
      Device_Context : in Address;
      Clip           : in Address;
      Callback       : in Address;
      Data           : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Get_Clip_Box(
      Device_Context : in Address;
      Rectangle      : in Address)
      return Integer_4_Signed_C;
    function Find_Intersecting_Rectangle(
      Destination : in Address;
      Rectangle_A : in Address;
      Rectangle_B : in Address)
      return Integer_4_Signed_C;
    function Get_Client_Rectangle(
      Window    : in Address;
      Rectangle : in Address)
      return Integer_4_Signed_C;
    function Rectangles_Are_Equal(
      Rectangle_A : Address;
      Rectangle_B : Address)
      return Integer_4_Signed_C;
    function Get_Class_Setting(
      Window : in Address;
      Index  : in Integer_4_Signed_C)
      return Integer_4_Unsigned_C;
    function Get_Version(
      Version_Information : in Address)
      return Integer_4_Signed_C;
    function Get_User_Name(
      Buffer : Address;
      Size   : Address)
      return Integer_4_Signed_C;
    function Create_Cursor(
      Instance   : in Address;
      Hot_Spot_X : in Integer_4_Signed_C;
      Hot_Spot_Y : in Integer_4_Signed_C;
      Width      : in Integer_4_Signed_C;
      Height     : in Integer_4_Signed_C;
      Bits_AND   : in Address;
      Bits_XOR   : in Address)
      return Address;
    function Change_Class_Setting(
      Window  : in Address;
      Command : in Integer_4_Signed_C;
      Setting : in Integer_4_Unsigned_C)
      return Integer_4_Unsigned_C;
    function Flash_Window(
      Flash_Information : in Address)
      return Integer_4_Signed_C;
    function Get_Clip_Cursor_Area(
      Rectangle : in Address)--Record_Rectangle)
      return Integer_4_Signed_C;
    function Clip_Cursor(
      Rectangle : in Address)--Record_Rectangle)
      return Integer_4_Signed_C;
    function System_Parameter_Information(
      Action       : in Integer_4_Unsigned_C;
      Parameter_A  : in Integer_4_Unsigned_C;
      Parameter_B  : in Address;
      User_Profile : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Change_Window_Setting( -- 64 bit difference, SetWindowLongPtr
      Window  : in Address;
      Command : in Integer_4_Signed_C;
      Setting : in Integer_4_Unsigned_C)
      return Integer_4_Unsigned_C;
    function Get_Procedure_Address(
      Module         : in Address;
      Procedure_Name : in Access_Constant_Character_2_C)
      return Address;
    function Get_Key_State(
      Virtual_Key : in Integer_4_Unsigned_C)
      return Integer_2_Unsigned_C;
    function Free_Library(
      Module : in Address)
      return Integer_4_Signed_C;
    function Load_Library(
      Name : in Access_Constant_Character_2_C) 
      return Address; 
    function Get_Foreground_Window
      return Address;
    function Get_Disk_Free_Space(
      Directory                  : in Access_Constant_Character_2_C;
      Free_Bytes_Available       : in Address;
      Total_Number_Of_Bytes      : in Address;
      Total_Number_Of_Free_Bytes : in Address)
      return Integer_4_Signed_C;
    function Shell_Execute(
      Window       : in Address;
      Operation    : in Access_Constant_Character_2_C;
      File         : in Access_Constant_Character_2_C;
      Parameters   : in Access_Constant_Character_2_C;
      Directory    : in Access_Constant_Character_2_C;
      Show_Command : in Integer_4_Signed_C)
      return Address;
    function Set_Process_Working_Set_Size(
      Process : in Address;
      Minimum : in Integer_Size_C;
      Maximum : in Integer_Size_C)
      return Integer_4_Signed_C;
    function Virtual_Unlock(
      Data : in Address;
      Size : in Integer_Size_C)
      return Integer_4_Signed_C;
    function Virtual_Lock(
      Data : in Address;
      Size : in Integer_Size_C)
      return Integer_4_Signed_C;
    function Global_Allocate(
      Flags : Integer_4_Unsigned_C;
      Bytes : Integer_Size_C)
      return Address;
    function Get_Clipboard_Data(
      Format : in Integer_4_Unsigned_C)
      return Address;
    function Global_Lock(
      Memory : in Address)
      return Address;
    function Global_Unlock(
      Memory : in Address)
      return Integer_4_Signed_C;
    function Global_Free(
      Memory : in Address)
      return Address;
    function Open_Clipboard(
      Window : in Address)
      return Integer_4_Signed_C;
    function Close_Clipboard
      return Integer_4_Signed_C;
    function Empty_Clipboard
      return Integer_4_Signed_C;
    function Set_Clipboard_Data(
      Format : in Integer_4_Unsigned_C;
      Memory : in Address)
      return Address;
    function Format_Message(
      Flags      : in Integer_4_Unsigned_C;
      Source     : in Address;
      Identifier : in Integer_4_Unsigned_C;
      Language   : in Integer_4_Unsigned_C;
      Buffer     : in Access_Constant_Character_2_C;
      Size       : in Integer_4_Unsigned_C;
      Arguments  : in Address)
      return Integer_4_Unsigned_C;
    procedure Global_Memory_Status(
      Buffer : Address);
    function Get_System_Default_Language
      return Integer_2_Unsigned_C;
    function Get_Cursor_Position(
      Point : in Address)
      return Integer_4_Signed_C;
    function Bring_Window_To_Top(
      Window : in Address)
      return Integer_4_Signed_C;
    function Set_Window_Position(
      Window       : in Address;
      Insert_After : in Address;
      X            : in Integer_4_Signed_C;
      Y            : in Integer_4_Signed_C;
      Width        : in Integer_4_Signed_C;
      Height       : in Integer_4_Signed_C;
      Flags        : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    procedure Post_Quit_Message(
      Exit_Code : in Integer_4_Signed_C);
    function Monitor_From_Window(
      Window : in Address;
      Flags  : in Integer_4_Unsigned_C)
      return Address;
    function Send_Message(
      Window        : in Address;
      Message       : in Integer_4_Unsigned_C;
      Data_Unsigned : in Integer_4_Unsigned_C;
      Data_Signed   : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Get_Desktop_Window
      return Address; 
    function Get_Current_Process
      return Address;
    function Get_Current_Instance
      return Address;
    function Get_Process_Affinity_Mask(
      Process               : in Address;
      Process_Affinity_Mask : in Address;
      System_Affinity_Mask  : in Address)
      return Integer_4_Signed_C;
    function Query_Performance_Counter(
      Performance_Count : in Address) 
      return Integer_4_Signed_C;
    function Query_Performance_Frequency(
      Frequency : in Address) 
      return Integer_4_Signed_C;
    function Get_Last_Error
      return Integer_4_Unsigned_C;
    function Create_Mutex(
      Attributes    : in Address;
      Initial_Owner : in Integer_4_Signed_C;
      Name          : in String_2_C)
      return Address;
    function Release_Mutex(
      Mutex : in Address)
      return Integer_4_Signed_C;
    function Get_Module_Handle(
      Module_Name : Access_Constant_Character_2_C)
      return Address;
    function Set_Cursor_Position(
      X : in Integer_4_Signed_C;
      Y : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Show_Cursor(
      Do_Show : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Load_Cursor(
      Instance    : in Address;
      Cursor_Name : in Address)
      return Address;
    function Load_Icon(
      Instance  : in Address;
      Icon_Name : in Address)
      return Address;
    function Load_Image(
      Instance  : in Address;
      Name      : in Access_Constant_Character_2_C;
      Kind      : in Integer_4_Unsigned_C;
      Desired_X : in Integer_4_Signed_C;
      Desired_Y : in Integer_4_Signed_C;
      Load      : in Integer_4_Unsigned_C)
      return Address;
    function Message_Box(
      Window  : in Address;
      Text    : in String_2_C;
      Caption : in String_2_C;
      Kind    : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Get_Current_Thread_Id
      return Integer_4_Unsigned_C;
    function Unhook_Windows_Hook(
      Hook : in Address)
      return Integer_4_Signed_C;
    function Call_Next_Hook(
      Hook          : in Address;
      Code          : in Integer_4_Signed_C;
      Data_Signed   : in Integer_4_Signed_C;
      Data_Unsigned : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Set_Windows_Hook(
      Hook      : in Integer_4_Signed_C;
      Callback  : in Address;
      Modifier  : in Address;
      Thread_Id : in Integer_4_Unsigned_C)
      return Address;
    function Set_Focus(
      Window : in Address)
      return Address;
    function Set_Foreground_Window(
      Window : in Address)
      return Integer_4_Signed_C;
    function Set_Active_Window(
      Window : in Address)
      return Address;
    function Set_Window_Text(
      Window : in Address;
      Text   : in Access_Constant_Character_2_C)
      return Integer_4_Signed_C;
    function Register_Class(
      Window_Class : in Address)
      return Integer_2_Unsigned_C;
    function Unregister_Class(
      Class_Name   : in String_2_C;
      Window_Class : in Address)
      return Integer_4_Signed_C;
    function Define_Window_Procedure(
      Window        : in Address;
      Message       : in Integer_4_Unsigned_C;
      Data_Unsigned : in Integer_4_Unsigned_C;
      Data_Signed   : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Create_Window(
      Style_Extra : in Integer_4_Unsigned_C;
      Class_Name  : in String_2_C;
      Window_Name : in String_2_C;
      Style       : in Integer_4_Unsigned_C;
      X           : in Integer_4_Signed_C;
      Y           : in Integer_4_Signed_C;
      Width       : in Integer_4_Signed_C;
      Height      : in Integer_4_Signed_C;
      Parent      : in Address;
      Menu        : in Address;
      Instance    : in Address;
      Parameter   : in Address)
      return Address;
    function Show_Window(
      Window  : in Address;
      Command : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
    function Update_Window(
      Window : in Address)
      return Integer_4_Signed_C;
    function Destroy_Window(
      Window : in Address)
      return Integer_4_Signed_C;
    function Find_Window(
      Class_Name  : in String_2_C;
      Window_Name : in Address)
      return Address;
    function Get_Window_Rectangle(
      Window    : in Address;
      Rectangle : in Address)
      return Integer_4_Signed_C;
    function Adjust_Window_Rectangle(
      Rectangle   : in Address;
      Style       : in Integer_4_Unsigned_C;
      Menu        : in Integer_4_Signed_C;
      Extra_Style : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Peek_Message(
      Message        : in Address;
      Window         : in Address;
      Filter_Minimum : in Integer_4_Unsigned_C;
      Filter_Maximum : in Integer_4_Unsigned_C;
      Command        : in Integer_4_Unsigned_C)
      return Integer_4_Signed_C;
    function Translate_Message(
      Message : in Address)
      return Integer_4_Signed_C;
    function Dispatch_Message(
      Message : in Address)
      return Integer_4_Signed_C;
    function Get_Message_Time
      return Integer_4_Unsigned_C;
    function Get_Monitor_Information(
      Monitor     : in Address;
      Information : in Address)
      return Integer_4_Signed_C;
    function Get_Device_Context(
      Window : in Address)
      return Address;
    function Release_Device_Context(
      Window         : in Address;
      Device_Context : in Address)
      return Integer_4_Signed_C;
    function Get_Device_Capabilities(
      Device_Context : in Address;
      Capability     : in Integer_4_Signed_C)
      return Integer_4_Signed_C;
-------
private
-------
  ----------------
  -- Directives --
  ----------------
    pragma Import(Stdcall, Get_Last_Error,           "WSAGetLastError");
    pragma Import(Stdcall, Winsock_Startup,          "WSAStartup");
    pragma Import(Stdcall, Get_Adapters_Information, "GetAdaptersInfo");
    pragma Import(Stdcall, To_Host_Byte_Order,       "ntohl");
    pragma Import(Stdcall, To_Integer_4_Unsigned_C,  "inet_addr");
    pragma Import(Stdcall, Winsock_Cleanup,          "WSACleanup");
    pragma Import(Stdcall, Host_To_Networking_Short, "htons");
    pragma Import(Stdcall, Send_To,                  "sendto");
    pragma Import(Stdcall, Make_Socket,              "socket");
    pragma Import(Stdcall, Control_Socket_IO,        "ioctlsocket");
    pragma Import(Stdcall, Set_Socket_Options,       "setsockopt");
    pragma Import(Stdcall, Get_Socket_Name,          "getsockname");
    pragma Import(Stdcall, Bind_Socket,              "bind");
    pragma Import(Stdcall, Close_Socket,             "closesocket");
    pragma Import(Stdcall, Get_Host_By_Name,         "gethostbyname");
    pragma Linker_Options("C:\MinGW\lib\libwsock32.a");
    pragma Linker_Options("C:\Windows\System32\IPHLPAPI.DLL");
    pragma Linker_Options("-lgdi32");
    pragma Linker_Options("-lhid");
    pragma Linker_Options("-lsetupapi");
    pragma Import(C,       Get_Current_Instance,           "rts_get_hInstance");
    pragma Import(Stdcall, Is_Lower,                       "iswlower");
    pragma Import(Stdcall, Is_Upper,                       "iswupper");
    pragma Import(Stdcall, Write_File,                     "WriteFile");
    pragma Import(Stdcall, Convert_String_2_C_To_UTF_8,    "WideCharToMultiByte");
    pragma Import(Stdcall, Sleep,                          "SleepEx");
    pragma Import(Stdcall, Enumerate_Device_Interfaces,    "SetupDiEnumDeviceInterfaces");
    pragma Import(Stdcall, Registry_Close_Key,             "RegCloseKey");
    pragma Import(Stdcall, Registry_Query_Value,           "RegQueryValueExW");
    pragma Import(Stdcall, Registry_Open_Key,              "RegOpenKeyExW");
    pragma Import(Stdcall, Create_File,                    "CreateFileW");
    pragma Import(Stdcall, Destroy_Device_List,            "SetupDiDestroyDeviceInfoList");
    pragma Import(Stdcall, Get_Device_Interface_Detail,    "SetupDiGetDeviceInterfaceDetail");
    pragma Import(Stdcall, Get_Device_Registry_Property,   "SetupDiGetDeviceRegistryPropertyW");
    pragma Import(Stdcall, Get_Device_Enumeration,         "SetupDiEnumDeviceInfo");
    pragma Import(Stdcall, Get_Device_Instance_Id,         "SetupDiGetDeviceInstanceIdW");
    pragma Import(Stdcall, Get_Device_Class_Information,   "SetupDiGetClassDevsW");
    pragma Import(Stdcall, Get_Device_Identifier,          "HidD_GetHidGuid");
    pragma Import(Stdcall, Get_Device_Attributes,          "HidD_GetAttributes");
    pragma Import(Stdcall, Set_Device_Output_Data,         "HidD_SetOutputReport");
    pragma Import(Stdcall, Get_Device_Manufacturer,        "HidD_GetManufacturerString");
    pragma Import(Stdcall, Get_Device_Product,             "HidD_GetProductString");
    pragma Import(Stdcall, Get_Device_Description,         "HidD_GetPhysicalDescriptor");
    pragma Import(Stdcall, Get_Device_Usages,              "HidP_GetUsages");
    pragma Import(Stdcall, Get_Device_Button_Capabilities, "HidP_GetButtonCaps");
    pragma Import(Stdcall, Get_Device_Input_Data,          "GetRawInputData");
    pragma Import(Stdcall, Get_Device_List,                "GetRawInputDeviceList");
    pragma Import(Stdcall, Get_Device_Raw_Information,     "GetRawInputDeviceInfoW");
    pragma Import(Stdcall, Register_Devices,               "RegisterRawInputDevices");
    pragma Import(Stdcall, Enumerate_Display_Monitor,      "EnumDisplayMonitors");
    pragma Import(Stdcall, Get_Clip_Box,                   "GetClipBox");
    pragma Import(Stdcall, Rectangles_Are_Equal,           "EqualRect");
    pragma Import(Stdcall, Find_Intersecting_Rectangle,    "IntersectRect");
    pragma Import(Stdcall, Get_Client_Rectangle,           "GetClientRect");
    pragma Import(Stdcall, Get_Class_Setting,              "GetClassLongW");
    pragma Import(Stdcall, Get_Version,                    "GetVersionExW");
    pragma Import(Stdcall, Get_User_Name,                  "GetUserNameW");
    pragma Import(Stdcall, Create_Cursor,                  "CreateCursor");
    pragma Import(Stdcall, Change_Class_Setting,           "SetClassLongW");
    pragma Import(Stdcall, Flash_Window,                   "FlashWindowEx");
    pragma Import(Stdcall, Get_Clip_Cursor_Area,           "GetClipCursor");
    pragma Import(Stdcall, Clip_Cursor,                    "ClipCursor");
    pragma Import(Stdcall, System_Parameter_Information,   "SystemParametersInfoW");
    pragma Import(Stdcall, Get_Current_Thread_Id,          "GetCurrentThreadId");
    pragma Import(Stdcall, Get_Module_Handle,              "GetModuleHandleW");
    pragma Import(Stdcall, Get_Key_State,                  "GetKeyState");
    pragma Import(Stdcall, Set_Window_Text,                "SetWindowTextW");
    pragma Import(Stdcall, Change_Window_Setting,          "SetWindowLongW");
    pragma Import(Stdcall, Get_Foreground_Window,          "GetForegroundWindow");
    pragma Import(Stdcall, Free_Library,                   "FreeLibrary");
    pragma Import(Stdcall, Load_Library,                   "LoadLibraryW");
    pragma Import(Stdcall, Get_Procedure_Address,          "GetProcAddress");
    pragma Import(Stdcall, Shell_Execute,                  "ShellExecuteW");
    pragma Import(Stdcall, Set_Process_Working_Set_Size,   "SetProcessWorkingSetSize");
    pragma Import(Stdcall, Get_Disk_Free_Space,            "GetDiskFreeSpaceExW");
    pragma Import(Stdcall, Virtual_Lock,                   "VirtualLock");
    pragma Import(Stdcall, Virtual_Unlock,                 "VirtualUnlock");
    pragma Import(Stdcall, Set_Clipboard_Data,             "SetClipboardData");
    pragma Import(Stdcall, Get_Clipboard_Data,             "GetClipboardData");
    pragma Import(Stdcall, Empty_Clipboard,                "EmptyClipboard");
    pragma Import(Stdcall, Open_Clipboard,                 "OpenClipboard");
    pragma Import(Stdcall, Close_Clipboard,                "CloseClipboard");
    pragma Import(Stdcall, Global_Lock,                    "GlobalLock");
    pragma Import(Stdcall, Global_Unlock,                  "GlobalUnlock");
    pragma Import(Stdcall, Global_Free,                    "GlobalFree");
    pragma Import(Stdcall, Global_Allocate,                "GlobalAlloc");
    pragma Import(Stdcall, Format_Message,                 "FormatMessageW");
    pragma Import(Stdcall, Get_System_Default_Language,    "GetSystemDefaultUILanguage");
    pragma Import(Stdcall, Global_Memory_Status,           "GlobalMemoryStatusEx");
    pragma Import(Stdcall, Get_Cursor_Position,            "GetCursorPos");
    pragma Import(Stdcall, Bring_Window_To_Top,            "BringWindowToTop");
    pragma Import(Stdcall, Set_Window_Position,            "SetWindowPos");
    pragma Import(Stdcall, Send_Message,                   "SendMessageW");
    pragma Import(Stdcall, Unregister_Class,               "UnregisterClassW");
    pragma Import(Stdcall, Message_Box,                    "MessageBoxW");
    pragma Import(Stdcall, Get_Current_Process,            "GetCurrentProcess");
    pragma Import(Stdcall, Monitor_From_Window,            "MonitorFromWindow");
    pragma Import(Stdcall, Post_Quit_Message,              "PostQuitMessage"); 
    pragma Import(Stdcall, Get_Desktop_Window,             "GetDesktopWindow"); 
    pragma Import(Stdcall, Get_Process_Affinity_Mask,      "GetProcessAffinityMask");
    pragma Import(Stdcall, Query_Performance_Counter,      "QueryPerformanceCounter");
    pragma Import(Stdcall, Query_Performance_Frequency,    "QueryPerformanceFrequency");
    pragma Import(Stdcall, Get_Last_Error,                 "GetLastError");
    pragma Import(Stdcall, Create_Mutex,                   "CreateMutexW");
    pragma Import(Stdcall, Release_Mutex,                  "ReleaseMutex");
    pragma Import(Stdcall, Set_Cursor_Position,            "SetCursorPos");
    pragma Import(Stdcall, Show_Cursor,                    "ShowCursor");
    pragma Import(Stdcall, Load_Cursor,                    "LoadCursorW");
    pragma Import(Stdcall, Load_Icon,                      "LoadIconW");
    pragma Import(Stdcall, Load_Image,                     "LoadImageW");
    pragma Import(Stdcall, Call_Next_Hook,                 "CallNextHookEx");
    pragma Import(Stdcall, Unhook_Windows_Hook,            "UnhookWindowsHookEx");
    pragma Import(Stdcall, Set_Windows_Hook,               "SetWindowsHookExW");
    pragma Import(Stdcall, Set_Focus,                      "SetFocus");
    pragma Import(Stdcall, Set_Foreground_Window,          "SetForegroundWindow");
    pragma Import(Stdcall, Set_Active_Window,              "SetActiveWindow");
    pragma Import(Stdcall, Register_Class,                 "RegisterClassExW");
    pragma Import(Stdcall, Define_Window_Procedure,        "DefWindowProcW");
    pragma Import(Stdcall, Create_Window,                  "CreateWindowExW");
    pragma Import(Stdcall, Show_Window,                    "ShowWindow");
    pragma Import(Stdcall, Update_Window,                  "UpdateWindow");
    pragma Import(Stdcall, Destroy_Window,                 "DestroyWindow");
    pragma Import(Stdcall, Find_Window,                    "FindWindowW");
    pragma Import(Stdcall, Get_Window_Rectangle,           "GetWindowRect");
    pragma Import(Stdcall, Adjust_Window_Rectangle,        "AdjustWindowRectEx");
    pragma Import(Stdcall, Peek_Message,                   "PeekMessageW");
    pragma Import(Stdcall, Translate_Message,              "TranslateMessage");
    pragma Import(Stdcall, Dispatch_Message,               "DispatchMessageW");
    pragma Import(Stdcall, Get_Message_Time,               "GetMessageTime");
    pragma Import(Stdcall, Get_Monitor_Information,        "GetMonitorInfoW");
    pragma Import(Stdcall, Get_Device_Context,             "GetDC");
    pragma Import(Stdcall, Release_Device_Context,         "ReleaseDC");
    pragma Import(Stdcall, Get_Device_Capabilities,        "GetDeviceCaps");
  end Neo.Windows;