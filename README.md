

<a name="readme-top"></a>


[![Contributors][contributors-shield]][contributors-url]   [![Forks][forks-shield]][forks-url]   [![Stargazers][stars-shield]][stars-url] [![Issues][issues-shield]][issues-url]  [![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/algertc/kleopatra4mac">
    <img src="https://github.com/algertc/homebrew-kleopatra4mac/raw/main/images/kleo2_revised.png" alt="Logo" width="1000" height="210">
  </a>

  <p align="center">
      <p align="center">
    <span><strong>KDE Kleopatra GPG Utility for Mac</strong></span>
    <br />
    <a href="https://github.com/algertc/kleopatra4mac/issues">Report Bug</a>
    ·
    <a href="https://github.com/algertc/kleopatra4mac/pulls">Contribute</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>


<br></br>
<br></br>

<!-- ABOUT THE PROJECT -->
## About The Project

![WorkFlow](https://raw.githubusercontent.com/algertc/kleopatra4mac/main/images/render.png "Workflow")

<h4>Kleopatra4Mac is an all-in-one prebuilt port of KDE's GPG utility for use on MacOS. Kleopatra is a certificate manager and a universal crypto GUI. It supports managing X.509 and OpenPGP certificates in the GpgSM keybox and retrieving certificates from LDAP servers.

<strong>Features:
* Integrated Notepad
* Smartcards
* Simplified Certificate Management
* Contacts

<p align="right">(<a href="#readme-top">back to top</a>)</p>




<!-- GETTING STARTED -->
## Getting Started


### Prerequisites

* [Homebrew](https://brew.sh/)
  ```sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

* [GnuPG/GPG](https://www.gnupg.org/)
  ```sh
  brew install gnupg
  ```
  **Must run gpg at least once to generate configs

* [GnuPG Pinentry](https://www.gnupg.org/related_software/pinentry/index.html)
  ```sh
  brew install pinentry-mac
  ```

	
	
## Installation
* ### <strong>Precompiled Binaries (Recommended)</strong>

1. Brew Install

   ```sh
   brew install algertc/kleopatra4mac/kleopatra
   ```

  * ### Build From Source (Advanced)
	
2. Check the [Brew "Bottle" Documentation](https://docs.brew.sh/Bottles) for Full Explanation

3.  To Rebuild From [*Kleopatra.rb*](https://github.com/algertc/homebrew-kleopatra4mac/blob/main/kleopatra.rb)  in This Repo

	   `` brew install --build-from-source``
	
4.  If  You Decide to Make Changes, You Can Create Your Own New Bottle (**Please Consider Submitting  a  Pull Request!)**

	Bottles are produced by installing a formula with `brew install --build-bottle <formula>` and then bottling it with `brew bottle <formula>`

	
	
## After Installation

1. Make Sure dbus is Running
   ```sh
   brew services start dbus
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
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Dark mode
- [x] Universal Font
- [ ] Fix symlink spotlight search ranking
- [ ] Beautify/Modernize UI
	- [ ] Mimic [Plasma Styling](https://kde.org/images/screenshots/kleopatra.png)
	- [ ] Transparency
- [ ] Fix Unintended Pagination ([Issue #1](https://github.com/algertc/homebrew-kleopatra4mac/issues/1))
- [ ] Exclude Default Icon from KDE's "kiconthemes" and Point to:  [Modernized Application Icon](https://github.com/algertc/homebrew-kleopatra4mac/blob/main/images/Icon.svg)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the GPL 2.0 License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Vadim Panov](https://www.linkedin.com/in/vadim-panov-55a5a036)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

[contributors-shield]: https://img.shields.io/github/contributors/algertc/kleopatra4mac.svg?style=for-the-badge
[contributors-url]: https://github.com/algertc/kleopatra4mac/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/algertc/kleopatra4mac.svg?style=for-the-badge
[forks-url]: https://github.com/algertc/kleopatra4mac/network/members
[stars-shield]: https://img.shields.io/github/stars/algertc/kleopatra4mac.svg?style=for-the-badge
[stars-url]: https://github.com/algertc/kleopatra4mac/stargazers
[issues-shield]: https://img.shields.io/github/issues/algertc/kleopatra4mac.svg?style=for-the-badge
[issues-url]: https://github.com/algertc/kleopatra4mac/issues
[license-shield]: https://img.shields.io/github/license/algertc/kleopatra4mac.svg?style=for-the-badge
[license-url]: https://github.com/algertc/kleopatra4mac/blob/master/LICENSE.txt
