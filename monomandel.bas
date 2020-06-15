
'-----------------------------------------------------------------------------------------
'
' Monochrome Mandelbrot Explorer.
'
' Mandelbrot math loop converted from C: http://warp.povusers.org/Mandelbrot/
' Mouse zoom by RedMarvin.
' SHL optimisations by D.J. Peters.
'
' @author        Martin Latter
' @copyright     Martin Latter, 20/08/2011
' @version       0.21
' @license       GNU GPL version 3.0 (GPL v3); https://www.gnu.org/licenses/gpl-3.0.html
' @link          https://github.com/Tinram/Mandelbrot.git
'
'-----------------------------------------------------------------------------------------


' #include "FBGfx.bi"
' USING FB ' fine on Windows, providing key names instead of scancodes; commented out to avoid macros for Linux compilation


DECLARE SUB renderFractal(BYVAL fMinReal AS DOUBLE, BYVAL fMaxImag AS DOUBLE, BYVAL fScreenDivisor AS SINGLE)

SUB winTitle()
	WindowTitle " Monochrome Mandel  ~  mouse buttons: zoom | C: colour toggle | S: screenshot | R: reset | ESC: exit"
END SUB


CONST AS UINTEGER SCREEN_X = 1000, SCREEN_Y = 1000 ' square screen dimensions
CONST AS UINTEGER MAX_ITERATIONS = 512
CONST AS UINTEGER MASTER_SCREEN_DIVISOR = 2
CONST AS UINTEGER THRESHOLD = 256
CONST AS DOUBLE MIN_REAL = -0.5

DIM SHARED AS UINTEGER iColourFlag = 0
DIM AS INTEGER iMX, iMY, iMB
DIM AS STRING sFilename, sXClicked = CHR(255) + "k"
DIM AS DOUBLE fMinReal = MIN_REAL, fMaxImag = 0
DIM AS SINGLE fScreenDivisor = MASTER_SCREEN_DIVISOR


SCREENRES SCREEN_X, SCREEN_Y, 32,, &h04

SCREENLOCK
	LINE (0, 0) - (SCREEN_X - 1, SCREEN_Y - 1), RGB(255, 255, 255), BF
SCREENUNLOCK

winTitle()

renderFractal(fMinReal, fMaxImag, fScreenDivisor)


DO

	GETMOUSE iMX, iMY,, iMB

	IF iMB > 0 THEN

		SELECT CASE iMB

			CASE 1
				fMinReal = 2 * iMX * fScreenDivisor / SCREEN_X + fMinReal - fScreenDivisor
				fMaxImag = 2 * (SCREEN_Y - 1 - iMY) * fScreenDivisor / SCREEN_Y + fMaxImag - fScreenDivisor
				fScreenDivisor *= 0.5

			CASE 2
				fScreenDivisor *= 2

			CASE 4
				fMinReal = 2 * iMX * fScreenDivisor / SCREEN_X + fMinReal - fScreenDivisor
				fMaxImag = 2 * (SCREEN_Y - 1 - iMY) * fScreenDivisor / SCREEN_Y + fMaxImag - fScreenDivisor

		END SELECT

		renderFractal(fMinReal, fMaxImag, fScreenDivisor)

	END IF

	SLEEP 20

	IF MULTIKEY(&h1F) THEN
		sFilename = "MonoMandel_" & CINT(TIMER) & ".bmp"
		BSAVE sFilename, 0
	END IF

	IF MULTIKEY(&h2E) THEN
		iColourFlag = IIF(iColourFlag = 0, 1, 0)
		renderFractal(fMinReal, fMaxImag, fScreenDivisor)
	END IF

	IF MULTIKEY(&h13) THEN
		fMinReal = MIN_REAL : fMaxImag = 0 : fScreenDivisor = MASTER_SCREEN_DIVISOR
		renderFractal(fMinReal, fMaxImag, fScreenDivisor)
	END IF

LOOP UNTIL MULTIKEY(&h01) OR INKEY = sXClicked



SUB renderFractal(BYVAL fMinReal AS DOUBLE, BYVAL fMaxImag AS DOUBLE, BYVAL fScreenDivisor AS SINGLE)

	DIM AS ULONG PTR pSP = SCREENPTR ' fbc x64, use UINTEGER for x32
	DIM AS UINTEGER iX, iY, iN, iC, iColflag
	DIM AS DOUBLE fRealFactor, fImagFactor, fCImag, fCReal, fZReal, fZReal2, fZImag, fZImag2

	fRealFactor = fScreenDivisor / SCREEN_X
	fImagFactor = fScreenDivisor / SCREEN_Y
	fMinReal -= fScreenDivisor
	fMaxImag -= fScreenDivisor
	iColflag = iColourFlag


	SCREENLOCK

	FOR iY = 0 TO SCREEN_Y - 1

		fCImag = ((SCREEN_Y - 1 - iY) SHL 1) * fImagFactor + fMaxImag

		FOR iX = 0 TO SCREEN_X - 1

			fCReal = (iX SHL 1) * fRealFactor + fMinReal
			fZReal = fCReal
			fZImag = fCImag
			iC = MAX_ITERATIONS

			FOR iN = 0 TO MAX_ITERATIONS - 1

				fZReal2 = fZReal * fZReal
				fZImag2 = fZImag * fZImag
				IF (fZReal2 + fZImag2) > THRESHOLD THEN iC = iN : EXIT FOR
				fZImag = (fZReal + fZReal) * fZImag + fCImag
				fZReal = fZReal2 - fZImag2 + fCReal

			NEXT iN

			IF iC <> MAX_ITERATIONS THEN
				iC = IIF(iColflag = 0, ABS((iC AND 63) - 31) * 7 + 31, ABS((iC AND 127) - 31) * 6) ' two ways of colouring
				*(pSP + iY * SCREEN_X + iX) = RGB(iC, iC, iC)
			ELSE
				*(pSP + iY * SCREEN_X + iX) = &H00000000
			END IF

		NEXT iX

	NEXT iY

	SCREENUNLOCK

END SUB
