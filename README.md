# JR-COLLEGE-bBitFastCalculator
8-bit fast calculator that implements addition, subtraction, multiplication, and x^y. Uses a wallace tree architecture and booth encoding to optimize speed. 

**General Overview:**

In this readme I will explain the thought process and decisions I made while designing this calculator. This will include references, model descriptions, verification, layered
modeling techniques and potential improvements. This calculator is a fast calculator, focusing on speed, but not power optimization or surface area.

**Feature Set:**

The 8-bit calculator performs 4 functions. Addition, substruction, multiplication, and 2^y, where y is one of our two 8-bit inputs. The calculator was implemented across 
7 Verilog modules. The top-level module, calculator.v, will instantiate the others in some form to perform the necessary operations.

➔ The addition operation will work with both positive and negative numbers.

➔ The subtraction operation will work with both positive and negative numbers.

➔ The multiplication functionality will be able to multiply any two signed 8-bit
numbers, given that their product doesn’t overflow. (There are only 8-bits of
precision for the output as well; 1 signed bit and 7 numerical bits).

➔ The exponent operation will only work with positive inputs, and output
up to 7-bits of precision (i.e., a maximum calculation of 27 due output bus size)

**Architecture Visualization: **

![architecture visualization](https://github.com/JuniorBrice/JR-COLLEGE-8BitFastCalculator/assets/79341423/d1763295-6638-40b7-859d-d992b14b48a2)

**Module Descriptions & Methodology:**

_calculator.v (Top Level Module)_
This module simply acts as the mediator for all the functions but does no calculation on its own besides the shift operation required for the exponential. It uses a set of parameters 
and an input select bit to determine which of the 4 operations the device will perform. Using an always block, it generates a non-priority mux that triggers every time either input 
operand x, input operant y, or the select bit is changed. This mux then assigns the output of the calculator to be the output of the selected operation, all of which (except
the exponential) do their calculations inside a submodule. An image of the top-level module is shown below for clarification.


Areas for Improvement:

-> No turn order, players can move pieces however they wish regardless of proper turn.

-> No castling functionality.

-> No En passant functionality.

-> No check or checkmate functionality.

-> No collision detection for the Queen, Bishop, or Rook pieces. (I.e., these pieces may behave like a knight and jump over other pieces in its path of legal moves)

Hope you find this interesting!
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
If you randomly found this on the internet, feel free to take inspiration but please do not redistribute or copy code.  
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

