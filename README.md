<div id="top"></div>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/SolarSpec/DLSmultiAverage">
    <img src="images/logo.png" alt="SolarSpec" width="160" height="120">
  </a>

<h3 align="center">DLSmultiAverage</h3>

  <p align="center">
    A Graphical User Interface 
    <br />
    <a href="https://github.com/dudeImpossible42/PIASgui"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/dudeImpossible42/PIASgui">View Demo</a>
    ·
    <a href="https://github.com/dudeImpossible42/PIASgui/issues">Report Bug</a>
    ·
    <a href="https://github.com/dudeImpossible42/PIASgui/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![PIAS Screenshot][product-screenshot]](https://solarspec.ok.ubc.ca/)
A GUI to help average all the useful data exported from the LS instrument.

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

* [MATLAB](https://www.mathworks.com/products/matlab.html)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

To begin using this app is very simple. Just verify you have the necessary prequisites and follow the installation instructions.

### Prerequisites

Make sure MATLAB is installed. It is available for download in the Software Distribution section under the Help tab after you log into Canvas. [https://canvas.ubc.ca/](https://canvas.ubc.ca/)

### Installation

1. Clone the repo to your PC
   ```sh
   git clone https://github.com/SolarSpec/DLSmultiAverage.git
   ```
2. Install the application 
   ```
   Click on the .mlappinstall file in your repository to open and install in MATLAB
   ```
3. Browse the APPS header
   ```
   You will find the recently installed application and can add it to your favourites
   ```

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

To begin, select the extracted LS instrument (.dat) files that you want averaged. After specifying which files, the GUI will plot the correlated g2-1 data vs. lag time (s) while also displaying each respective channel (CHA and CHB). At the bottom of the application, the filename of the currently plotted data will display above a UI prompt; which asks the user whether to add the file for averaging or if it should be disregarded. After the app has completed iterating through each file, it will then display a successful alert message indicating the new filename of the averaged data, along with its file location.

_For more information on any of the internal functions, please refer to the [MATLAB Documentation](https://www.mathworks.com/help/matlab/)_

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [X] Choose which trace to add
    - [X] Disregard data from unsed traces
- [X] Plot individual channels
    - [X] Plot correlation
- [X] Average over all uneven file lengths
    - [X] Cutoff at only useful data to avg

See the [open issues](https://github.com/dudeImpossible42/PIASgui/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>



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

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the BSD 3-Clause License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

SolarSpec - [SolarSpec Website](https://solarspec.ok.ubc.ca/) - vidihari@student.ubc.ca

Project Link: [https://github.com/SolarSpec/DLSmultiAverage](https://github.com/SolarSpec/DLSmultiAverage)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Group Leader - Dr. Robert Godin](https://solarspec.ok.ubc.ca/people/)
* [Group Alumni - James Kivai](https://solarspec.ok.ubc.ca/people/)
* [The Entire SolarSpec Team](https://solarspec.ok.ubc.ca/people/)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/SolarSpec/DLSmultiAverage.svg?style=for-the-badge
[contributors-url]: https://github.com/SolarSpec/DLSmultiAverage/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/SolarSpec/DLSmultiAverage.svg?style=for-the-badge
[forks-url]: https://github.com/SolarSpec/DLSmultiAverage/network/members
[stars-shield]: https://img.shields.io/github/stars/SolarSpec/DLSmultiAverage.svg?style=for-the-badge
[stars-url]: https://github.com/SolarSpec/DLSmultiAverage/stargazers
[issues-shield]: https://img.shields.io/github/issues/SolarSpec/DLSmultiAverage.svg?style=for-the-badge
[issues-url]: https://github.com/SolarSpec/DLSmultiAverage/issues
[license-shield]: https://img.shields.io/github/license/SolarSpec/DLSmultiAverage.svg?style=for-the-badge
[license-url]: https://github.com/SolarSpec/DLSmultiAverage/blob/main/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/haris-vidimlic-06730019b/
[product-screenshot]: images/Screenshot.png
