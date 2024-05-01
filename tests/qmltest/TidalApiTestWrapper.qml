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
    property alias access_tok: access_token
    property alias refresh_tok: refresh_token
    property alias expiry_tim : expiry_time
    property alias api: pythonApi

    // property MiniPlayer minPlayerPanel : miniPlayerPanel

    ConfigurationValue {
      id: token_type
      key:"/token_type"
      value: "Bearer"
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
      value: ""
    }


    TidalApi {
       id: pythonApi

        Component.onCompleted: {
            console.log('in tidal api oncompleted')
            setHandler('addTrack', function(id, title, album, artist, image, duration){
                //pythonApi.trackAdded(id, title, album, artist, image, duration)
                console.log("Wrapper says: addTrack")
                wrapper.handle();
            }
            );
            setHandler('get_url', function(newvalue) {
                console.log("Wrapper says: get_url")
                console.log('https://' + newvalue);
                pythonApi.authUrl(newvalue);
            });
            
            setHandler('get_token', function(type, token, rtoken, date) {
                token_type.value = type
                access_token.value = token
                console.log("Wrapper says: get_token")
                refresh_token.value = rtoken
                expiry_time.value = date
                console.log(expiry_time)
                loginTrue = true
                pythonApi.loginSuccess()
                pythonApi.loginIn()
            });

            setHandler('oauth_success', function() {
                console.log("Wrapper says: oauth_success")
                pythonApi.loginIn()
            });

            setHandler('oauth_login_success', function() {
                loginTrue = true
                console.log("Wrapper says: oauth_login_success")
                pythonApi.loginSuccess()
            });

            setHandler('oauth_login_failed', function() {
                loginTrue = false
                pythonApi.loginFailed()
            });

            setHandler('addPersonalPlaylist', function(id, name, image, num_tracks, description, duration)
            {
                console.log('Wrapper says: addPersonalPlaylist');
                pythonApi.personalPlaylistAdded(id, name, image, num_tracks, description, duration)
            });

        }
    }

    // initialPage: Component { FirstPage { } }
    // cover: Qt.resolvedUrl("cover/CoverPage.qml")
    // allowedOrientations: defaultAllowedOrientations

    Component.onCompleted: {

    //    pythonApi.loginIn()
    //    mprisPlayer.setCanControl(true)
    }

    function handle()
    {
        console.log('hello john doe')
    }


}
