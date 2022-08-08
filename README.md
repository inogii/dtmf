# dtmf
DTMF receiver and decoder in Matlab implementing Goertzel's algorithm

Dual Tone Multi-Frequency (DTMF) is a signaling method used in telephone networks for call set-up, call forwarding control and group calls. 
This project's purpose is to implement a DTMF receiver that is able to decode a sequence of digits encoded through a DTMF transmitter. 
In order to do so, Goertzel's algorithm is implemented, as it can calculate the Discrete Fourier Transform (DFT) at a specific frequency, providing a faster running time than the more common 256-point DFT.

# Execution
In order to execute the code, you must have a Matlab license and import all of the code in a directory. After that, you can run the main.m file, where only one test file can be loaded at a time. The test file can be chosen by changing line number 5 in the code with the name of any other test file. 
The report file contains further explanations on the provided code.
In the instructions.pdf file contains the official instructions provided in the Digital Signals Processing course of 3rd year of Ingeniería de Tecnologías y Servicios de Telecomunicación at ETSIT-UPM. 
