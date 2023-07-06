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

**Architecture Visualization:**

![architecture visualization](https://github.com/JuniorBrice/JR-COLLEGE-8BitFastCalculator/assets/79341423/d1763295-6638-40b7-859d-d992b14b48a2)

**Module Descriptions & Methodology:**

**_calculator.v (Top Level Module)_**

This module simply acts as the mediator for all the functions but does no calculation on its own besides the shift operation required for the exponential. It uses a set of parameters 
and an input select bit to determine which of the 4 operations the device will perform. Using an always block, it generates a non-priority mux that triggers every time either input 
operand x, input operant y, or the select bit is changed. This mux then assigns the output of the calculator to be the output of the selected operation, all of which (except
the exponential) do their calculations inside a submodule. An image of the top-level module is shown below for clarification.

![calculator](https://github.com/JuniorBrice/JR-COLLEGE-8BitFastCalculator/assets/79341423/129dce57-d5f0-47b0-9912-7854e29f2d4b)

_**carry_look_ahead_adder_8.v**_

In calculator.v, I instantiated two identical 8-bit fast carry look ahead fast adders (CLA1 and CLA2), but utilize them separately. One for the addition operation of the calculator,
and the other for the subtraction operation. An image of this 8-bit CLA adder is shown below:

![8carrylookaheadadder](https://github.com/JuniorBrice/JR-COLLEGE-8BitFastCalculator/assets/79341423/d19f8d98-4ba0-40e5-9a34-f1617def64b5)

This adder uses a width parameter for ease of editability, and generate statements for compact code. For the addition operation, we uses the CLA adder as normal, but for subtraction,
if you look back to calculator.v, we implement 2’s complement in its port wiring to facilitate easy substraction. Since this adder is already optimized to deal with signed inputs,
the addition and subtraction operations work flawlessly with them.

_**fast_multiplier.v, booth_encoder.v, and wallace_addition.v**_

In calculator.v, I instantiate fast_multipler.v to facililitate multiplication. Inside the module appears as such:

![fast multiplier](https://github.com/JuniorBrice/JR-COLLEGE-8BitFastCalculator/assets/79341423/fda27d7d-c10d-4aea-89dd-761fd6a646a5)

Notice, I instantiated the booth_encoder.v module 5 times to generate 5 partial products. These 5 partial products are based on groupings of 3 of the bits of the multiplicand, as 
dictated by a typical booth recoding algorithm. The partial products generated are propagated through a wire (partial_p) and are each 16 bits in length to provide sufficient sign 
extension. booth_encoder.v looks like such:

![boothencoder](https://github.com/JuniorBrice/JR-COLLEGE-8BitFastCalculator/assets/79341423/cd408e72-216a-43dd-bd58-35a3c26cbe5f)

After the partial products are encoded, they get passed to the wallace_addition.v module, which is very complex looking. For the sake of my comprehension when creating this calculator,
I created a visualization that is also suitable for this readme. Remember, the encoded partial products provided by the booth encoder are 16-bits in length to account for negative
encoded values that require sign extension, and the inherent heavy shifts wallace addition implmenments. The wallace addition algorithm in wallace_addition.v is implemented exactly as follows:

![wallacefr](https://github.com/JuniorBrice/JR-COLLEGE-8BitFastCalculator/assets/79341423/855229cd-11a7-4ad1-8519-8a13521be63c)

Feel free to zoom in, or refer to the included excel sheet in the wallace tree visualization folder. Each section highlighted in green is a completed column of wallace addition, in yellow are 
half-adders implemented by half_adder.v, in orange are full adders implemented by full_adder.v, in blue are bits that will persist to the next stage of addition, and in gray is addition
implmented by carry_look_ahead_adder_20.v (distinct from the other carry look ahead adders mentioned prviously in the report, as it has 20 bits).

The total wallace addition for this calculator is broken into 5 stages as shown in the diagram, the last stage being the result. In parentheses, for each half or full-adder, is a number unique
to that adder alone, implemented for organizational and troubleshooting purposes. For instance, adder 54 produces c54 (carry-bit 54) and s54 (sum-bit 54). This diagram maps 1 to 1 to the verilog
module of wallace_addition.v, which is a bit too long to include in this readme, but you can find in the project files.

At the end of this wallace addition module, we assign our final multiplication value, which is passed to fast_multipler.v, then adjusted if the product is a negative 2’s compliment value,
and finally passed all the way back to calculator.v to be used as a result.

_**full_adder.v, half_adder.v, carry_look_ahead_adder_20.v**_
In wallace_addition.v we implemented over 60 distinct adders to properly represent the algorithm. The module mainly comprises a full adder sub-module and a half_adder submodule. Both of which
are straightforward and can be seen down below. They were instanstiated a multitude of times to gain the desired effect.

![smoladders](https://github.com/JuniorBrice/JR-COLLEGE-8BitFastCalculator/assets/79341423/a5e32bd7-29bf-449e-8b0f-25b1f35587d9)

I also implemented a 20-bit carry look ahead adder for the fourth stage of the addition. This carry look ahead adder is no different from the 8-bit CLA adder from a hardware description language
standpoint, as I simply just changed the width parameter of the adder from 8 to 20.

_**Shift Resgister (Implements 2^y)**_

As mentioned earlier, the expontential function is the only one of the four operations that did not need a distinct submodule. This is because it fits rather compactly into the calculator.v
top-level module. The section that implements the operation appears as follows:

![shiftreg](https://github.com/JuniorBrice/JR-COLLEGE-8BitFastCalculator/assets/79341423/8c0e20ac-22cc-4771-b33f-a0a82696b04a)

The wire exp is 8-bits wide, to accomplish 8-bits of accuracy at the output. In pratice however, this means only the first 7 shifts will be accurate 100% of the time, as an operation of 2^8
(8 shifts) would overload the register and force it to display zeroes due to the 1-bit bit being shifted off the left end of the MSB. Due to this, the exponential operation can only obtain
a respectable maximum value of 128.

**Testing:**
Here is a basic simulation waveform verifying functionality:

![waveform](https://github.com/JuniorBrice/JR-COLLEGE-8BitFastCalculator/assets/79341423/51ff741c-c6d8-4db3-b7df-2d883a26c05f)

Areas for Improvement:

-> There are many things that can be improved upon. For instance, in wallace_addition.v, I did a lot of uneccessary addition and calculated many zero bits that will never make it into the final
answer due to the necessary truncation. Initially, I included so many leading zeroes in in this module to make certain I would have enough sign-extension bits if I needed them, but instead it
ended up causing the calulator to be much more complex, consuming more power than necessary. Cutting down on this wallace addition module would be a huge improvement. I couldve also made use of
generate statements to implement the module, which might have saved a lot of time had I been able to figure out how to properly implement the alternating half and full adders required for the algorithm.

-> I could have implemented a feature that allows the user to select which of the 8-bit inputs to use in the exponent calculation.

-> I could have improved precision of the calculator, to allow for bigger operations. i.e. make the output bus width larger.

-> I could have added an overflow indication bit

Hope you find this interesting!
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
If you randomly found this on the internet, feel free to take inspiration but please do not redistribute or copy code.  
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

