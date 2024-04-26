import QtQuick 2.0
// import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5
// import QtMultimedia 5.6
// import org.nemomobile.mpris 1.0
// import Nemo.Configuration 1.0

// import "pages"
// import "pages/widgets"
import "."

Rectangle
{
    id: wrapper

    property bool loginTrue : false
    property var locale: Qt.locale()
    property date currentDate: new Date()
    property alias token_typ : token_type 
    property alias api: pythonApi

    // property MiniPlayer minPlayerPanel : miniPlayerPanel

    ConfigurationValue {
      id: token_type
      key:"/token_type"
    }

    ConfigurationValue {
      id: access_token
      key:"/access_token"
      value:""
    }

    ConfigurationValue {
      id: refresh_token
      key:"/refresh_token"
    }

    ConfigurationValue {
      id: expiry_time
      key:"/expiry_time"
    }


    TidalApi {
       id: pythonApi
    }

    // initialPage: Component { FirstPage { } }
    // cover: Qt.resolvedUrl("cover/CoverPage.qml")
    // allowedOrientations: defaultAllowedOrientations


    Component.onCompleted: {
        pythonApi.loginIn()
    //    mprisPlayer.setCanControl(true)
    }
}
