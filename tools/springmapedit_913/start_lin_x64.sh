#!/bin/sh

java -cp springmapedit.jar:lib_lin_x64/gluegen-rt.jar:lib_lin_x64/jogl.jar:lib_lin_x64/swt.jar -Xms128m -Xmx1024m -Djava.library.path=lib_lin_x64 application.SpringMapEditApplication