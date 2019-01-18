#include "include\JSON.au3"
#include "include\http.au3"
#include <array.au3>
#include <Constants.au3>

Global $file = HttpGet("http://www.mywebserver.ru/make_json.php")

JsonToArray($file)

Func JsonToArray($JSON)
    $JSON = StringRegExpReplace($JSON, "[\[\]{}]", "")
    $sBreak = StringSplit($JSON, ",")
    For $a = 1 To $sBreak[0]
        $t = _JSONDecode("{" & $sBreak[$a] & "}")
        ;_ArrayDisplay($t, "multi " & $a & " of " & $sBreak[0])
		Switch $a
		 Case 1
			$sDomain = $t[1][1]
			If $sDomain == "NULL" Then
			   MsgBox($MB_SYSTEMMODAL, "Error", "Receive NULL. Exit (3 sec).", 3)
			   Exit (1)
			EndIf
		 Case 2
			$sDomainUser = $t[1][1]
		 Case 3
			$sDomainPassword = $t[1][1]
		 EndSwitch
	  Next
	  Local $iPID = RunAs($sDomainUser, $sDomain, $sDomainPassword, $RUN_LOGON_NOPROFILE, "\\192.168.0.2\programs\far\FAR.EXE", "\\192.168.0.2\programs\far\")
 EndFunc   ;==>JsonToArray
