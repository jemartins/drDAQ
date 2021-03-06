/*==================================

 grace.i 

    Copyright (C) 2006 DrDAQ Application Project.

    This software is in the public domain.
    Permission to use, copy, modify, and distribute this software and its
    documentation for any purpose and without fee is hereby granted,
    without any conditions or restrictions.
    This software is provided "as is" without express or implied warranty.

    If you discover a bug or add an enhancement here's how to reach us:

        https://sourceforge.net/projects/drdaq
 
 
 Revision history:
 ==================================
 $Log: grace.i,v $
 Revision 1.3  2006/05/15 18:20:06  jemartins
 added Copyright

 Revision 1.2  2006/03/16 12:04:51  jemartins
 inicial revision

 ==================================*/

%module grace
%{
/* Put header files here or function declarations like below */
/* int main (int argc, char* argv[]); */
 
extern int GraceIsOpen();
extern int GraceClose();
extern int GracePrintf (const char*);
extern int OpenGrace();
extern int SetEscala (float max_x, float max_y, float major_tick_x, float minor_tick_x, float major_tick_y, float minor_tick_y);
extern int SetSimbolo (int nchan);
extern int PlotaGrace (float x1, float y1, float x2, float y2,  int nchan);
extern int GravaDados ();
%}

/* int main (int argc, char* argv[]); */
extern int GraceIsOpen();
extern int GraceClose();
extern int GracePrintf (const char*);
extern int OpenGrace();
extern int SetEscala (float max_x, float max_y, float major_tick_x, float minor_tick_x, float major_tick_y, float minor_tick_y);
extern int SetSimbolo (int nchan);
extern int PlotaGrace (float x1, float y1, float x2, float y2,  int nchan);
extern int GravaDados ();
