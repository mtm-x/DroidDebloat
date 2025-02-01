# This Python file uses the following encoding: utf-8
import sys
import subprocess

from pathlib import Path
from PySide6.QtCore import QObject, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, QmlElement
QML_IMPORT_NAME = "io.qt.textproperties"
QML_IMPORT_MAJOR_VERSION = 1

@QmlElement
class Debloater(QObject):

    @Slot(result=str)
    def debloat(self):
        return "Fuck"
    
    @Slot(str,result=str)
    def app_name(self,s):
        self.Application_name = s.strip().lower()
        print(self.Application_name)
        
            
    @Slot(result=list)
    def load_pkgs(self):

        package_list = subprocess.run(['adb', 'shell', 'pm', 'list', 'packages'], stdout=subprocess.PIPE, text=True).stdout.splitlines()
        cleaned_package_list = []
        for pkg in package_list:
            clean = pkg.replace("package:","")
            cleaned_package_list.append(clean)
            # print(cleaned_package_list)

        self.filtered = []
        if cleaned_package_list :
            for pkg in cleaned_package_list:
                if self.Application_name in pkg.lower():
                    self.filtered.append(pkg)
                              
                        
        if self.filtered:
            return self.filtered
        

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "Main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
