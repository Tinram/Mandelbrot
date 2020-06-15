
# makefile for Mono Mandel

CC = fbc
CFLAGS = -w all -gen gcc -O max -Wl -s -Wc -march=native,-mtune=native,-funroll-loops,-fomit-frame-pointer,-fivopts
NAME = monomandel
INPUTLIST = monomandel.bas


monomandel:
	$(CC) $(CFLAGS) $(INPUTLIST) -x $(NAME)