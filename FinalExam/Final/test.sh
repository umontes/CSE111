#!/bin/bash

javac Final.java
java -classpath ".:sqlite-jdbc-3.32.3.2.jar" Final

python3 Final.py
