@Echo Off
Cls
Chcp 65001 >Nul

Title 安装中...
Echo 安装中...

:: 检查必要文件是否存在
If Not Exist "EPT.exe" (
    Echo 错误: EPT.exe 不存在!
    Pause
    Exit /B 1
)
If Not Exist "EPT.ico" (
    Echo 错误: EPT.ico 不存在!
    Pause
    Exit /B 1
)

:: 创建目标目录
Md "%USERPROFILE%\RegFile\EPT" 2>Nul
If Not Exist "%USERPROFILE%\RegFile\EPT" (
    Echo 错误: 无法创建目录 %USERPROFILE%\RegFile\EPT
    Pause
    Exit /B 1
)

:: 复制文件
Copy /y "EPT.exe" "%USERPROFILE%\RegFile\EPT\" || (
    Echo 错误: 复制 EPT.exe 失败
    Pause
    Exit /B 1
)
Copy /y "EPT.ico" "%USERPROFILE%\RegFile\EPT\" || (
    Echo 错误: 复制 EPT.ico 失败
    Pause
    Exit /B 1
)
If Exist "Error.exe" (
    Copy /y "Error.exe" "%USERPROFILE%\RegFile\EPT\" || (
        Echo 警告: 复制 Error.exe 失败
    )
)
If Exist "NoEPT.exe" (
    Copy /y "NoEPT.exe" "%USERPROFILE%\RegFile\EPT\" || (
        Echo 警告: 复制 NoEPT.exe 失败
    )
)

:: 设置注册表
Reg Add "HKCR\.ept" /ve /d "eptfile" /f >Nul || (
    Echo 错误: 无法设置 .ept 注册表项
    Pause
    Exit /B 1
)

Reg Add "HKCR\eptfile" /v "FriendlyTypeName" /t REG_SZ /d "CMD单行解析程序" /f >Nul || (
    Echo 错误: 无法设置 FriendlyTypeName
    Pause
    Exit /B 1
)

Reg Add "HKCR\eptfile\DefaultIcon" /ve /d "\"%USERPROFILE%\RegFile\EPT\EPT.ico\"" /f >Nul || (
    Echo 错误: 无法设置 DefaultIcon
    Pause
    Exit /B 1
)

Reg Add "HKCR\eptfile\shell\open\command" /ve /d "\"%USERPROFILE%\RegFile\EPT\EPT.exe\" \"%%1\"" /f >Nul || (
    Echo 错误: 无法设置 open command
    Pause
    Exit /B 1
)

Title 安装完成√
Echo 安装完成√
Echo 您可以安全的关闭此窗口

Set /p "SetpLS=[按Enter键退出]"
Exit /B 0