@echo off
REM Define o caminho para a pasta do GLFW. Ajuste se necessário.
SET GLFW_INCLUDE_PATH=libs\glfw-3.4.bin.WIN64\include
SET GLFW_LIB_PATH=libs\glfw-3.4.bin.WIN64\lib-vc2022

echo Compiling main.cpp...
g++ main.cpp -I "%GLFW_INCLUDE_PATH%" -L "%GLFW_LIB_PATH%"-lglfw3 -lgdi32 -lopengl32 -static-libgcc -static-libstdc++ -Wl,--subsystem,windows

IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo Error while compiling!
) ELSE (
    echo.
    echo successfully compiled!
    REM Opcional: Executa o programa após a compilação
    REM start main.exe
)
pause