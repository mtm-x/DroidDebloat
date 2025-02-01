# This Python file uses the following encoding: utf-8
import sys
import subprocess
import res.rc_res as rc_res

from pathlib import Path
from PySide6.QtCore import QObject, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, QmlElement
QML_IMPORT_NAME = "io.qt.textproperties"
QML_IMPORT_MAJOR_VERSION = 1

@QmlElement
class Debloater(QObject):

    @Slot(result=str)
    def check_device(self):
        result = subprocess.run(["adb", "devices"], capture_output=True, text=True)
        lines = result.stdout.splitlines()

        for line in lines[1:]:
            parts = line.split("device")[0]
            if parts:
                return parts
            else:
                return "No devices connected."
            
            
    
    @Slot(str,result=str)
    def app_name(self,s):
        self.Application_name = s.strip().lower()
        
            
    @Slot(str,result=list)
    def load_pkgs(self,s):
        package_list = subprocess.run(['adb', 'shell', 'pm', 'list', 'packages'], stdout=subprocess.PIPE, text=True).stdout.splitlines()
        cleaned_package_list = []
        for pkg in package_list:
            clean = pkg.replace("package:","")
            cleaned_package_list.append(clean)
        if cleaned_package_list:
            if not s:
                return cleaned_package_list

        self.filtered = []
        if cleaned_package_list :
            for pkg in cleaned_package_list:
                if self.Application_name in pkg.lower():
                    self.filtered.append(pkg)
                              
                        
        if self.filtered:
            return self.filtered
    
    @Slot(str,result=str)
    def uninstall(self,s):
        process = subprocess.run(['adb', 'shell', 'pm', 'uninstall', '--user', '0', s],stdout=subprocess.PIPE, text=True).stdout.splitlines()
        if "Success" in process:
            return "Uninstalled Successfully"
        else:
            return "Failed"

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "qml/Main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec()) 
