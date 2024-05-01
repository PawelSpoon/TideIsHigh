import QtQuick 2.0
import QtTest 1.0
import "."

TestCase {

    name: "tidal api qml test"

    TidalApiTestWrapper {
        id: tidalApiWrapper
    }

    property string token_type : "Bearer";
    property var access_token : "";
    property var refresh_token : "";

    function initTestCase()
    {
        console.log('init testcase')
        tidalApiWrapper.api.getOAuth();
        // wait until authenticated
        for (var i = 0; i < 300; i++)  {
            //console.log(i);
            wait(1000);
            if (tidalApiWrapper.loginTrue == true) break;
        }
        console.log('init testcase done')
        access_token = tidalApiWrapper.access_tok;
        refresh_token = tidalApiWrapper.refresh_tok;
        // tracing those tokens will show a ConfigurationValue
        console.log('access_token:' + access_token.value);
        console.log('refresh_token:' + refresh_token.value);    
        // todo: break test, when i = 299
    }

/*    function test_login() {
        tidalApiWrapper.token_typ.key = "token_type";
        tidalApiWrapper.token_typ.value = "Bearer";
        tidalApiWrapper.access_tok.value = "eyJraWQiOiJ2OU1GbFhqWSIsImFsZyI6IkVTMjU2In0.eyJ0eXBlIjoibzJfYWNjZXNzIiwidWlkIjoxOTU2MDI2MjQsInNjb3BlIjoid19zdWIgcl91c3Igd191c3IiLCJnVmVyIjowLCJzVmVyIjowLCJjaWQiOjMyMzUsImV4cCI6MTcxNDczNjgyOSwic2lkIjoiZTIyODc4OGQtODJjNS00ODY2LTg0NzYtZGRlZDdhM2UwNzJkIiwiaXNzIjoiaHR0cHM6Ly9hdXRoLnRpZGFsLmNvbS92MSJ9.-a0GP-OZNmH5NNoog_XdCCWNZEGwRtLuJN1fFZu0TlQjeCF9lqwW7mDudhUw9jZ1uZkUYkCEm9QvudNKDLi20Q";
        tidalApiWrapper.refresh_tok.value = "eyJraWQiOiJoUzFKYTdVMCIsImFsZyI6IkVTNTEyIn0.eyJ0eXBlIjoibzJfcmVmcmVzaCIsInVpZCI6MTk1NjAyNjI0LCJzY29wZSI6Indfc3ViIHJfdXNyIHdfdXNyIiwiY2lkIjozMjM1LCJzVmVyIjowLCJnVmVyIjowLCJpc3MiOiJodHRwczovL2F1dGgudGlkYWwuY29tL3YxIn0.AOz3PNT7BSm38VOtsX-dw-agr_Xf1cNtpGBXhb2y9dY0xYAzMQug3H30VSa5E3sAJv1FnaFjaIy0zXw2DdXbSLqrAWBKVJMfAUhPbFsPAIila_0BbIz-AjYmDIXtfLfhkUzwUkpodrSh55Elz1cQ3AOTIJHCLD_Q7ls4aL-c3Xu0mH5V"
        tidalApiWrapper.expiry_tim.value = "1714736829"
        tidalApiWrapper.api.loginIn();
        // returns missing sessionId
        wait(5000);
        tidalApiWrapper.api.printLogin();
        //wait(5000);
        //compare(tidalApiWrapper.api.tracks,true);
        //console.log("printLogin(): " + tidalApiWrapper.api.printLogin());
    }*/

    /*function test_search() {
        console.log('testing search');
        tidalApiWrapper.api.genericSearch("New Order"); 
        wait(1000);
        console.log('done with search test')
    }*/

    function test_getPersonalPlaylists() 
    {
        console.log('testing personalPlaylists');
        tidalApiWrapper.api.getPersonalPlaylists(); 
        wait(10000);
        console.log('done with personalPlaylists')
    }

    function test_getFavoriteArtists() 
    {

    }

    function test_getFavoriteAlbums()
    {

    }
} 