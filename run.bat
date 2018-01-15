@echo off
del /Q log\*.*

call c:\Python27\Scripts\pybot --pythonpath lib\ --outputdir log --consolemarkers on TestSets\MainSet.robot

pause