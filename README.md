
## My first steps into asembly

Through these tasks, I've gained a deeper understanding
of how data is manipulated at the hardware level, and how
high-level constructs like loops, conditionals, and functions
translate into Assembly instructions. This has not only improved
my problem-solving skills but also given me a new perspective on
how software interacts with hardware.

## Permissions
The function begins by moving the arguments into the `eax` and
`ebx` registers. 

The ant's ID is extracted by shifting the bits in `eax` to the
right by 24 and storing the result in `ecx`.

The rooms the ant wants to reserve are obtained by performing
a bitwise AND operation on `eax` with `0xFFFFFF` and storing the
result in `edx`.

The rooms the ant can reserve are fetched from the `ant_permissions`
array at the index corresponding to the ant's ID. This value is then
stored in `eax`.

A bitwise AND operation is performed on `eax` and `edx` to check if the
ant can reserve the rooms it wants. The result is stored in `eax`.

The function then compares `eax` and `edx`. If they are not the same, it
means the ant cannot reserve one or more of the rooms it wants. In this
case, the function writes `0` to the memory address in `ebx` and ends.
If `eax` and `edx` are the same, it means the ant can reserve all the
rooms it wants. In this case, the function writes `1` to the memory
address in `ebx` and ends.

## Treyfer
### treyfer_crypt

This function encrypts a plaintext using a key.

- It starts by saving the base pointer and the stack pointer.
- It then saves all general-purpose registers.
- It loads the addresses of the plaintext and the key into `esi`
and `edi` respectively.
- It initializes `eax` and `edx` to 0. These will be used as loop counters.
- It enters a nested loop where it performs the encryption. The inner loop
runs 8 times for each byte of the plaintext and key. The outer loop runs
`num_rounds` times.
- After the encryption is done, it restores all general-purpose registers
and returns.

### treyfer_dcrypt

This function decrypts a ciphertext using a key.

- It starts by saving the base pointer and the stack pointer.
- It then saves all general-purpose registers.
- It loads the addresses of the ciphertext and the key into
`esi` and `edi` respectively.
- It initializes all general-purpose registers to 0.
- It enters a nested loop where it performs the decryption.
The inner loop runs 8 times for each byte of the ciphertext
and key. The outer loop runs `num_rounds` times.
- After the decryption is done, it restores all general-purpose
registers and returns.

## Labyrinth Algorithm

Initially, two variables are declared to store constants.
These variables represent the number of lines minus one (`num_line - 1`)
and the number of columns minus one (`num_column - 1`). 

Following this, the registers `eax` and `ebx` are cleared to store the
current line and column respectively, while `ecx` and `edx` are reserved for
eneral use.

Within the `loop_label`, the value 1 is moved into the current block
of the matrix. This is done to ensure that the matrix is traversed in
one direction only. Subsequently, `eax` and `ebx` are compared with the
constant values of `num_line` and `num_column` respectively. This comparison
is performed to check if the labyrinth has been successfully navigated.

Next, the block to the right is compared to 0. If it is 0, the index is moved
to the current block and the process starts over. If not, the search for
0 in the nearby blocks continues. This process is repeated in all directions.
When a 0 is found, the algorithm moves to that location.

Finally, the coordinates of the exit are saved into the corresponding 
addresses.

**Author:** Visanescu Bogdan-Emilian  
