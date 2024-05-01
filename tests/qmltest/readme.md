harbour-tidalplayer is a 1:1 copy from player
TidalApi is an extracted piece of harbour-tidalplayer
TidalApiTestWrapper should be the minimal hosting environment

configurationvalue is a mock class

then run: pip install tidalapi

i need to define aliases to have access to subitems, just to use the id is not possible

execute
qmltestrunner -input tst_TidalApi.qml 

to get rid of mark.interactive error add pytest.ini as per 
https://docs.pytest.org/en/stable/how-to/mark.html

then i did add some traces to display the oath url and use it in parallel to the test.
i am still not able to open the browser page from ubuntu container even with:

export ...

export BROWSER = '/mnt/c/Program Files/Vivaldi/Application/vivaldi.exe'

ln -s "/mnt/c/Program Files/Vivaldi/Application/vivaldi.exe" ~/.local/bin/vivaldi
export BROWSER=~/.local/bin/vivaldi

this did not solve my problem, instead:
i have implemented a test fixture
trace the uri for oauth
click on it within some seconds will authenticate you in browser and continue with the test