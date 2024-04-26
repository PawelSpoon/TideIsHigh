import QtQuick 2.0
import QtTest 1.0
import "."

TestCase {

    name: "tidal player qml test"

/*    tidPlayer {
        id: myComponent
    }*/

    Connections
    {
        target: playlistManager
    /*    onPlayListFinished:
        {
            titleLabel.text = ""
            artist_albumLabel.text = ""
            coverImage.source = ""
            prevButton.enabled = playlistManager.canPrev;
            nextButton.enabled = playlistManager.canNext;
        }*/
    }

    function test_MyMethod() {
        playlistManager.callMyMethod();
        wait(100);
        compare(playlistManager.result,42);
    }

}