C==========================================================================C
C       Einlesen von Hygris-Bilddateien [character*1 pro Pixel]            C
C       Konvertierung integer*2 - Feld gray                                C
C--------------------------------------------------------------------------C
C       Format : Character*1 pro Pixel                                     C
C                Grauwerte GRAY (Zeilen,Spalten)                           C
C                Spalten variieren zuerst von 1 bis S                      C
C                Zeilen  variieren dann   von Z bis 1                      C
C==========================================================================C

        program igrayr

        character*60    dsnam
        integer*4       z,s,i,j
        character*1     cgray(2048)
        integer*2       gray

        open(3,file='history.asc')
        write(3,200)
        write(*,200)
 200    format(//
     +  ' ==========================================================='/
     +  ' |                                                         |'/
     +  ' |   Converting an image file to an ASCII-file.            |'/
     +  ' |   Maximal number of pixels in a row (x direction):2048  |'/
     +  ' |                                                         |'/
     +  ' ==========================================================='/
     +  ' |                                                         |'/
     +  ' |                  Program written by Tsay on 1997.04.29  |'/
     +  ' ==========================================================='/
     +  /' > Output file name = ?')
        read(*,'(a60)',err=100) dsnam
        open(2,file=dsnam)
        write(3,'(a60)') dsnam

        write(3,201)
        write(*,201)
 201    format(/' > Input the image file name (*.raw) :')
        read(*,'(a60)',err=100) dsnam
        write(3,'(a60)') dsnam
        write(3,203)
        write(*,203)
 203    format(/' > Number of pixels in a row (x direction) :')
        read(*,*) s
        write(3,*) s
        write(3,202)
        write(*,202)
 202    format(/' > Number of pixels in a column (y direction) :')
        read(*,*) z
        write(3,*) z

        write(2,204) dsnam,z,s
 204    format('# Image file name : ',a50/
     +         '#      row number    :',i6/
     +         '#      column number :',i6/
     +         '#   x(column)     y(row)     gray value'/
     +         '# ============ ============ ============')

        open(1,file=dsnam,status='old',form='unformatted',
     +          access='direct',recl=s,err=100)

        do 1 i=z,1,-1
           read(1,rec=i,err=101) (cgray(j),j=1,s)
           do 2 j=1,s
                gray=ichar(cgray(j))
                write(2,205) j,z-i+1,gray
 205            format(1x,i11,2i13)
 2         continue
 1      continue

        close (1)
        close (2)
        goto 1000

 100    write(*,*) '>>> Input error !'
        stop
 101    write(*,*) '>>> Reading error !'
        stop

 1000   end
