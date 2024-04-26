import QtQuick 2.0
import io.thp.pyotherside 1.5

Rectangle {
    width: 200; height: 200

    property var result
    
    Python {
        id: python
        Component.onCompleted : {
            addImportPath(Qt.resolvedUrl('.'));
            importModule('my_module', function() {
                console.log('Python module loaded');
            });
        }
    }

    function callMyMethod() {
        python.call('my_module.call_my_method',[], function(res) {
            myComponent.result = res;
        });
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            python.call('my_module.MyClass.my_method',[], function(result) {
                console.log(result);
            });
        }
    }
}