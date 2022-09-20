# ANTLR4
The binaries of the ANTLR4 parser generator with some scripts

See [ANTLR Website](https://www.antlr.org/) for the original distribution of ANTLR.

## setup
- watch this video https://www.youtube.com/watch?v=pa8qG0I10_I
- download java JRE 11 
- download repo 
- open Env variables 
- add new user variable 
- variable name : ANTLR4_HOME
- variable value : path to repo ex. 'C:\Users\asayedal\Downloads\antlr4-master'
- add new Path : %ANTLR4_HOME%\bin
- add new Path : %JAVA_HOME%\bin

## run 
- cd %ANTLR4_HOME%\sample ex. 'C:\Users\asayedal\Downloads\antlr4-master\sample'
- open cmd 
- antlr4 A2ML
- compile A2ML*.java
- grun A2ML a2ml -gui
