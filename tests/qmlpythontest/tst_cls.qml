import QtQuick 2.0
import QtTest 1.0
import "."

TestCase {

    name: "cls qml test"

    MyComponent {
        id: myComponent
    }

    function test_MyMethod() {
        myComponent.callMyMethod();
        wait(100);
        compare(myComponent.result,42);
    }

}