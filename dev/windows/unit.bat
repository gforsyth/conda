@ECHO ON
pushd %TEMP% || goto :error
cd \conda_src || goto :error
CALL dev-init.bat || goto :error
CALL conda info || goto :error
REM TODO:  Remove before merge, temporary:
CALL conda install -c napari/label/bundle_tools -c conda-forge "menuinst=2" || goto :error
CALL pytest -m "not integration" -v --splits=%TEST_SPLITS% --group=%TEST_GROUP% || goto :error
goto :EOF

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
