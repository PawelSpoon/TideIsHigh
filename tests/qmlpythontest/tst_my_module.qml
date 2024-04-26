import QtQuick 2.0
import QtTest 1.0
import io.thp.pyotherside 1.5

TestCase {

    name: "my module qml test"

    Python {
        id: python
        Component.onCompleted : {
            addImportPath(Qt.resolvedUrl('.'));
            importModule('my_module', function() {
                console.log('Python module loaded');
            });
        }
    }

    function test_MyMethod() {
        var result;
        python.call('my_module.call_my_method', [], function(res) {
            result = res;
        });
        wait(100);
        compare(result,42);
    } 
}