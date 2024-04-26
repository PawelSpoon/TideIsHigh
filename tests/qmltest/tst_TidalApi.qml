import QtQuick 2.0
import QtTest 1.0
import "."

TestCase {

    name: "tidal api qml test"

    TidalApiTestWrapper {
        id: tidalApiWrapper
    }

    function test_MyMethod() {
        tidalApiWrapper.token_typ.key = "jan";
        tidalApiWrapper.api.printLogin();
        wait(100);
        compare(tidalApiWrapper.api.tracks,true);
    }

}