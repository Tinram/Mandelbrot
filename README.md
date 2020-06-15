
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

    mouse left button        zoom in
    mouse right button       zoom out
    C                        toggle between lighter and darker greys
    S                        screenshot (bitmap screenshot saved to current dir)
    R                        reset view
    ESC                      exit


## Build

Install [FreeBASIC](http://www.freebasic.net/forum/viewforum.php?f=1) compiler (*fbc*).

(Compilation can be with either the x32 or x64 version of *fbc*, but x32-compilation will require the screen pointer datatype to be changed (see source comment).)

Ensure GCC is available: `whereis gcc`

### Linux

```bash
    make
```

or

```bash
    fbc monomandel.bas icons/monomandel.xpm -gen gcc -O max -w all -Wl -s -Wc -march=native,-mtune=native
```

### Windows

```batch
    fbc monomandel.bas -s gui monomandel.rc -gen gcc -O max -w all -arch pentium4-sse3
```


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
