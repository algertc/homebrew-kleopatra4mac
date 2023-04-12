## After Installation

1. Make Sure dbus is Running
   ```sh
   brew services start dbus
   ```	
   If you get an error similar to `Error: Formula 'dbus' has not implemented #plist, #service or installed a locatable service file`, run the following command instead:
   ```sh
   brew services start d-bus
   ```
	
2. Select <strong>pinentry-mac</strong> as the Default Program
   ```js
   echo "pinentry-program /usr/local/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf 
   killall -9 gpg-agent
   ```
	
3. If You Need to Have Kleopatra First in Your PATH, Run:
   ```sh
   echo 'export PATH="/usr/local/Cellar/kleopatra/22.07.80/bin:$PATH"' >> ~/.zshrc
   ```
    ***(Note: Command here is for zshell)***
	
4. If You Want to Add This Application to the Launchpad, Run:
   ```sh
   cd /Applications && unzip /usr/local/Cellar/kleopatra/22.07.80/bin/app.zip
   ```
	
5. Kleopatra is Keg-Only, Which Means it Was Not Symlinked Into /opt/homebrew to Prevent Conflicts With Any *GPGme* or *KDE* Libraries. If You Must Create a Symlink, Run:
   ```sh
   export LDFLAGS="-L/usr/local/Cellar/kleopatra/22.07.80/lib"
   export CPPFLAGS="-I/usr/local/Cellar/kleopatra/22.07.80/include"
   ```
	
6. For compilers to find kleopatra, You May Need to Set:
   ```sh
   export LDFLAGS="-L/usr/local/Cellar/kleopatra/22.07.80/lib"
   export CPPFLAGS="-I/usr/local/Cellar/kleopatra/22.07.80/include"
   ```
	
7. For pkg-config to Find Kleopatra, You May Need to Set:
   ```sh
   export PKG_CONFIG_PATH="/usr/local/Cellar/kleopatra/22.07.80/lib/pkgconfig"
   ```
