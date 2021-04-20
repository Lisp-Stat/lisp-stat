
<!-- PROJECT SHIELDS -->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MS-PL License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/lisp-stat/lisp-stat">
    <img src="https://lisp-stat.dev/images/stats-image.svg" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Lisp-Stat</h3>

  <p align="center">
	An environment for statistical computing
	<br />
    <a href="https://lisp-stat.dev/docs/"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/lisp-stat/lisp-stat/issues">Report Bug</a>
    ·
    <a href="https://github.com/lisp-stat/lisp-stat/issues">Request Feature</a>
    ·
    <a href="https://lisp-stat.github.io/lisp-stat/">Reference Manual</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About the Project</a>
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
	<li><a href="#resources">Resources</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About the Project

  Lisp-Stat provides support for vectorized mathematical operations,
  and a comprehensive set of statistical methods that are implemented
  using the latest numerical algorithms.  In addition, Common Lisp
  provides a dynamic programming environment
  ([REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)),
  an excellent object-oriented facility
  ([CLOS](https://en.wikipedia.org/wiki/Common_Lisp_Object_System))
  and meta-object protocol
  ([MOP](https://en.wikipedia.org/wiki/Metaobject#Metaobject_protocol)).

   Lisp-Stat is fully functional today, and most of the [XLISP-STAT
   libraries](https://github.com/Lisp-Stat/xls-archive) can be ported
   with the aid of a compatibility package
   [XLS-compat](https://github.com/Lisp-Stat/XLS-compat).  This gives
   Lisp-Stat a leg up on ecosystem development.


### Built With

* [data-frame](https://github.com/Lisp-Stat/data-frame)
* [dfio](https://github.com/Lisp-Stat/dfio)
* [numerical-utilities](https://github.com/Lisp-Stat/numerical-utilities)
* [special-functions](https://github.com/Lisp-Stat/special-functions)
* [array-operations](https://github.com/Lisp-Stat/array-operations)


<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these steps:

### Prerequisites

An ANSI Common Lisp implementation. Developed and tested with
[SBCL](https://www.sbcl.org/) and
[CCL](https://github.com/Clozure/ccl).

### Installation

Lisp-Stat is composed of several system that are designed to be
independently useful.  So you can, for example, use `select` to obtain
selections from two dimensional arrays without bringing in all of
Lisp-Stat.

#### Quicklisp

```lisp
(ql:quickload :lisp-stat)
```


#### Manual Installation
1. Clone the repositories
```sh
cd ~/quicklisp/local-projects && \
git clone https://github.com/Lisp-Stat/data-frame.git && \
git clone https://github.com/Lisp-Stat/dfio.git && \
git clone https://github.com/Lisp-Stat/special-functions.git && \
git clone https://github.com/Lisp-Stat/numerical-utilities.git && \
git clone https://github.com/Lisp-Stat/documentation.git && \
git clone https://github.com/Lisp-Stat/plot.git && \
git clone https://github.com/Lisp-Stat/select.git
git clone https://github.com/Lisp-Stat/lisp-stat.git
```
2. Reset the ASDF source-registry to find the new system (from the REPL)
   ```lisp
   (asdf:clear-source-registry)
   ```
3. Load the system
   ```lisp
   (ql:quickload :lisp-stat)
   ```

<!-- USAGE EXAMPLES -->
## Usage

Create a data frame from a file named "absorbation.csv" on the local disk:

```lisp
(defparameter *df* (csv-to-data-frame
		      (uiop:read-file-string #P"LS:DATASETS;absorbation.csv")))

```

For more examples, please refer to the
[Documentation](https://lisp-stat.dev/docs/).


<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/lisp-stat/lisp-stat/issues) for a list of proposed features (and known issues).

## Resources

This system is part of the [Lisp-Stat](https://lisp-stat.dev/) project; that should be your first stop for information. Also see the <!-- [resources](https://lisp-stat.dev/resources) and -->
[community](https://lisp-stat.dev/community) page for more
information.

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**. Please see [CONTRIBUTING](CONTRIBUTING.md) for details on the code of conduct, and the process for submitting pull requests.

<!-- LICENSE -->
## License

Distributed under the MS-PL License. See [LICENSE](LICENSE) for more information.



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/lisp-stat/lisp-stat](https://github.com/lisp-stat/lisp-stat)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/lisp-stat/lisp-stat.svg?style=for-the-badge
[contributors-url]: https://github.com/lisp-stat/lisp-stat/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/lisp-stat/lisp-stat.svg?style=for-the-badge
[forks-url]: https://github.com/lisp-stat/lisp-stat/network/members
[stars-shield]: https://img.shields.io/github/stars/lisp-stat/lisp-stat.svg?style=for-the-badge
[stars-url]: https://github.com/lisp-stat/lisp-stat/stargazers
[issues-shield]: https://img.shields.io/github/issues/lisp-stat/lisp-stat.svg?style=for-the-badge
[issues-url]: https://github.com/lisp-stat/lisp-stat/issues
[license-shield]: https://img.shields.io/github/license/lisp-stat/lisp-stat.svg?style=for-the-badge
[license-url]: https://github.com/lisp-stat/lisp-stat/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/company/symbolics/
