import QtQuick 2.0
// import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5
// import QtMultimedia 5.6
// import org.nemomobile.mpris 1.0
// import Nemo.Configuration 1.0


    Python {
        signal authUrl(string url)
        signal loginSuccess()
        signal loginFailed()
        signal trackSearchFinished()
        signal artistSearchFinished()
        signal albumSearchFinished()
        signal searchFinished()

        signal trackAdded(int id, string title, string album, string artist, string image, int duration)
        signal albumAdded(int id, string title, string artist, string image, int duration)
        signal artistAdded(int id, string name, string image)
        signal playlistSearchAdded(int id, string name, string image, int duration, string uid)

        signal trackChanged(int id, string title, string album, string artist, string image, int duration)
        signal albumChanged(int id, string title, string artist, string image)
        signal artistChanged(int id, string name, string img)

        signal personalPlaylistAdded(string id, string title, string image, int num_tracks, string description, int duration)
        signal playlistAdded(string id, string title, string image, int num_tracks, string description, int duration)

        signal currentTrackInfo(string title, int track_num, string album, string artist, int duration, string album_image, string artist_image)

        property string artistsResults
        property string albumsResults
        property string tracksResults

        property bool albums: true
        property bool artists: true
        property bool tracks: true
        property bool playlists : true

        id: pythonApi

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'));
            console.log('in TidaApi.qml oncompleted')


            setHandler('get_url', function(newvalue) {
                pythonApi.authUrl(newvalue);
            });


            setHandler('trackInfo', function(id, title, album, artist, image, duration) {
                pythonApi.trackChanged(id, title, album, artist, image, duration)
            });

            setHandler('albumInfo', function(id, title, artist, image) {
                pythonApi.albumChanged(id, title, artist, image)
            });

            setHandler('artistInfo', function(id, name, img) {
                pythonApi.artistChanged(id, name, img)
            });


            setHandler('addTrack', function(id, title, album, artist, image, duration){
                pythonApi.trackAdded(id, title, album, artist, image, duration)
            }
            );

            setHandler('addArtist', function(id, name, image){
                pythonApi.artistAdded(id, name,image)
            }
            );

            setHandler('addAlbum', function(id, title, album, artist, image, duration){
                pythonApi.albumAdded(id, title, album, artist, image, duration)
            }
            );

            setHandler('addPlaylist', function(id, name, image, duration, uid){
                pythonApi.playlistSearchAdded(id, name, image, duration, uid)
            }
            );

            setHandler('trackSearchFinished', function() {
                pythonApi.trackSearchFinished()
            });

            setHandler('artistsSearchFinished', function() {
                pythonApi.artistSearchFinished()

            });

            setHandler('albumsSearchFinished', function() {
                pythonApi.albumSearchFinished()
            });

            setHandler('oauth_success', function() {
                pythonApi.loginIn()
            });

            setHandler('oauth_login_success', function() {
                loginTrue = true
                console.log("Login Successful")
                pythonApi.loginSuccess()
            });

            setHandler('oauth_login_failed', function() {
                loginTrue = false
                pythonApi.loginFailed()
            });

            setHandler('get_token', function(type, token, rtoken, date) {
                token_type.value = type
                access_token.value = token

                refresh_token.value = rtoken
                expiry_time.value = date
                console.log(expiry_time)
                loginTrue = true
                pythonApi.loginSuccess()
                pythonApi.loginIn()

            });

            setHandler('oauth_updated', function(type, token, rtoken, date) {
                token_type.value = type
                access_token.value = token

                refresh_token.value = rtoken
                expiry_time.value = date
                pythonApi.loginSuccess()
                pythonApi.loginIn()

            });

            setHandler('oauth_failed',function() {
                pythonApi.loginFailed()
            });

            setHandler('playUrl', function(url) {
                mediaPlayer.source = url;
                mediaPlayer.play()
            });

            setHandler('insertTrack', function(id)
            {
                console.log("inserted to PL", id)
                playlistManager.insertTrack(id)
            });

            setHandler('addTracktoPL', function(id)
            {
                console.log("appended to PL", id)
                playlistManager.appendTrack(id)
            });

            setHandler('fillFinished', function()
            {
                playlistManager.playPosition(0)
            });

            setHandler('currentTrackInfo', function(title, track_num, album, artist, duration, album_image, artist_image)
            {
                pythonApi.currentTrackInfo(title, track_num, album, artist, duration, album_image, artist_image)
            });

            setHandler('addPersonalPlaylist', function(id, name, image, num_tracks, description, duration)
            {
                pythonApi.personalPlaylistAdded(id, name, image, num_tracks, description, duration)
            });

            setHandler('setPlaylist', function(id, title, image, num_tracks, description, duration)
            {
                pythonApi.playlistAdded(id, title, image, num_tracks, description, duration)
            });

            importModule('tidal', function() {});

        }

        function printLogin()
        {
            console.log(token_type.value+ "\n" +  access_token.value + "\n" + refresh_token.value + "\n" + expiry_time.value)
        }

        function getOAuth() {
            call('tidal.Tidaler.request_oauth', function() {});
        }

        function loginIn() {
            console.log("Want login now")
            //console.log(expiry_time.value)
            //console.log(currentDate.toLocaleString(locale, "yyyy-MM-ddThh:mm:ss"))
            //print(Date.fromLocaleString(locale, expiry_time.value, "yyyy-MM-ddThh:mm:ss"));
            //console.log(Date.fromLocaleString(locale, expiry_time.value, "yyyy-MM-ddThh:mm:ss") < currentDate)
            if(Date.fromLocaleString(locale, expiry_time.value, "yyyy-MM-ddThh:mm:ss") > currentDate)
            {
                console.log("Valid login time");
                //console.log(token_type.value, access_token.value, refresh_token.value, expiry_time.value);
                console.log(token_type.value)
                console.log(access_token.value)
                call('tidal.Tidaler.login', [token_type.value, access_token.value, refresh_token.value, expiry_time.value], {});
            }
            else
            {
                console.log("inValid login time");
                console.log(token_type.value)
                console.log(access_token.value)
                //console.log(token_type.value, refresh_token.value, refresh_token.value, expiry_time.value);
                call('tidal.Tidaler.login', [token_type.value, refresh_token.value, refresh_token.value, expiry_time.value], {});
                console.log("Need to renew login")
            }

        }

        onError: {
            console.log('ERROR - unhandled error received:', traceback);
        }

        function genericSearch(text) {
            call("tidal.Tidaler.genericSearch", [text], {});
        }


        function playTrackId(id)
        {
            call("tidal.Tidaler.getTrackUrl", [id], function(name)
            {
                print(name[0], name[1])
                console.log(name)
                if(typeof name === 'undefined')
                    console.log(typeof name)
                else
                    console.log(typeof name)
            });
        }


        function getTrackInfo(id)
        {
            call("tidal.Tidaler.getTrackInfo", [id], {});
        }

        function getAlbumTracks(id)
        {
            call("tidal.Tidaler.getAlbumTracks", [id], {});
        }

        function getAlbumInfo(id)
        {
            call("tidal.Tidaler.getAlbumInfo", [id], {});
        }

        function getArtistInfo(id)
        {
            call("tidal.Tidaler.getArtistInfo", [id], {});
        }

        function playAlbumTracks(id)
        {
            call("tidal.Tidaler.playAlbumTracks", [id], {});
        }

        function playAlbumFromTrack(id)
        {
            call("tidal.Tidaler.playAlbumfromTrack", [id], {});
        }

        function getPersonalPlaylists(id)
        {
            call("tidal.Tidaler.getPersonalPlaylists", [], {});
        }

        function getPersonalPlaylist(id)
        {
            call("tidal.Tidaler.getPersonalPlaylist", [id], {});
        }

        function playPlaylist(id)
        {
            playlistManager.clearPlayList()
            call("tidal.Tidaler.playPlaylist", [id], {});
        }

        /* Supported categories
        Recently played
        Suggested new albums 
        Your history
        */
        function getPersonalArtists()
        {
            call("tidal.Tidaler.getPersonalArtists", [], {});
        }

        // should not be needed, use getArtistInfo instead
        // function getPersonalArtist(id)

        function getPersonalAlbums()
        {
            call("tidal.Tidaler.getPersonalAlbums", [], {});
        }

        function getPersonalTracks()
        {
            call("tidal.Tidaler.getPersonalTracks", [], {});
        }
    }

