#!/bin/sh

java -cp springmapedit.jar:lib_lin_x86/gluegen-rt.jar:lib_lin_x86/jogl.jar:lib_lin_x86/swt.jar -Xms128m -Xmx1024m -Djava.library.path=lib_lin_x86 application.SpringMapEditApplication