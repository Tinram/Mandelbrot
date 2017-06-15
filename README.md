
# Mandelbrot

### Monochrome Mandelbrot Set explorer.


[1]: https://tinram.github.io/images/mandelbrot.gif
![mandelbrot][1]


## Purpose

Minimalist Mandelbrot Set fractal explorer with accurate zoom coordinates.


## OS Support

+ Linux
+ Windows


## Controls

    Mouse left button        zoom in
    Mouse right button       zoom out
    C                        toggle between lighter and darker greys
    S                        screenshot (bitmap screenshot saved to current dir)
    R                        reset view
    ESC                      exit


## Build

Use the FreeBASIC x32 compiler and GCC.

### Linux

    fbc monomandel.bas icons/monomandel.xpm -gen gcc -O max -w all -arch pentium4-sse3

### Windows

    fbc monomandel.bas -s gui monomandel.rc -gen gcc -O max -w all -arch pentium4-sse3

#### Further Optimisation

*example:*

    -Wc -march=core-avx2,-mtune=core-avx2      # Intel Haswell CPU


## Credits

+ RedMarvin (mouse zoom).
+ D.J. Peters (shift optimisations).
+ Juha Nieminen (C Mandelbrot example).


## Other

The rendering is reasonably fast for a single-threaded application, while preserving good detail in the set.

Colouring the Mandelbrot Set can be a pain: easy to get weird colour schemes, hard to get effective ones. The existing scheme is merely a compromise.

A sine-based colouring scheme could offer a larger range of greys.

Saving bitmaps is lousy but native in FreeBASIC. Non-native PNG support would bloat the executable considerably.


## License

Mandelbrot is released under the [GPL v.3](https://www.gnu.org/licenses/gpl-3.0.html).
