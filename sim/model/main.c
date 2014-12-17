#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>
//#include "main.h"

//Global Variables:
//pc: Program Counter
//registers[]: represent register bank
//mem[]: Represent the data memory
//flags: bool vector containing the flags
//       bit 2: above
//       bit 1: equals
//       bit 0: overflow
const int overflow = 0, equals = 1, above = 2;
int  pc=0, registers[32], mem[1000], stk[32], ptr = 0;
bool flags[3];


//Fuction to identify the instruction type:
// i - I-type Instruction
// r - R-type Instruction
// j - J-type Instruction
char identify_instruction_type(int instruction_opcode)
{
    char result;
    if(instruction_opcode == 0x23 || // Load Word
       instruction_opcode == 0x2b || // Store Word
       instruction_opcode == 0x08 || // Add Immediate
       instruction_opcode == 0x0e || // Subtract Immediate
       instruction_opcode == 0x0c || // And Immediate
       instruction_opcode == 0x0d || // Or Immediate
       instruction_opcode == 0x11)   // BRFL
    {
        result = 'i';
    }
    else if (instruction_opcode == 0x00 || instruction_opcode == 0x18)
    {
        result = 'r';
    }
    else if (instruction_opcode == 0x01 || // NOP
             instruction_opcode == 0x02 || // HALT
             instruction_opcode == 0x03 || // CALL
             instruction_opcode == 0x07 || // RET
             instruction_opcode == 0x09)   // JPC
    {
        result = 'j';
    }
    else
    {
        printf("------------------------\n");
        printf("ERROR!! UNKNOWN OPCODE!!\n");
        printf("------------------------\n");
        result = 'e';
    }
    return result;

}

void push(int value)
{
    stk[ptr] = value;
    ptr++;
}

int pop()
{
    ptr--;
    return stk[ptr];
}

bool check_overflow(int op1, int op2)
{
    if ((op2 > 0 && op1 > INT_MAX - op2) ||
    (op2 < 0 && op1 < INT_MIN - op2))
    {
        flags[overflow] = 1;
        return 1;
    }
    flags[overflow] = 0;
    return 0;
}

//Function responsible to reproduce the results of the i-type instructions
void decode_i_type(unsigned int instruction_opcode, unsigned int instruction)
{
    int rd, rs1, imm;

    //Define the fields of the instructions
    rs1 = ((instruction >> 21) & 0x1F);
    rd = ((instruction >> 16) & 0x1F);
    imm = (instruction & 0xFFFF );
    printf("RS1: %x RD: %x IMM: %x\n", rs1, rd, imm);

    //Load Instruction - lw RD = mem
    if(instruction_opcode == 0x23)
    {
        printf("Instruction Mnemonic: LW\n");
        check_overflow(registers[rs1], imm);
        registers[rd] = mem[registers[rs1] + imm];
        printf("Memory Target: %d\n", (registers[rs1] + imm));
        printf("Value loaded from memory to register %d: %d\n", rd, registers[rd]);
    }
    //Store Instruction - sw mem = RD
    else if(instruction_opcode == 0x2b)
    {
        printf("Instruction Mnemonic: SW\n");
        check_overflow(registers[rs1], imm);
        mem[registers[rs1] + imm] = registers[rd];
        printf("Memory Target: %d\n", (registers[rs1] + imm));
        printf("Value stored in memory from register %d: %d\n", mem[registers[rs1] + imm], registers[rd]);
    }
    //brfl - TBD
    else if(instruction_opcode == 0x11)
    {
        printf("Instruction Mnemonic: BRFL\n");
        printf("TBD");
    }
    //addi - RD = RS1 + Sext(imm)
    else if(instruction_opcode == 0x08)
    {
        printf("Instruction Mnemonic: ADDi\n");
        check_overflow(registers[rs1], imm);
        registers[rd] = registers[rs1] + imm;
        printf("Value written to register %x: %x\n", rd, registers[rd]);
    }
    //subi RD = RS1 - Sext(imm)
    else if(instruction_opcode == 0x0e)
    {
        printf("Instruction Mnemonic: SUBi\n");
        check_overflow(registers[rs1], imm);
        registers[rd] = registers[rs1] - imm;
        printf("Value written to register %x: %x\n", rd, registers[rd]);
    }
    //andi RD = RS1 ^ Sext(imm)
    else if(instruction_opcode == 0x0c)
    {
        printf("Instruction Mnemonic: ANDi\n");
        registers[rd] = registers[rs1] & imm;
        flags[overflow] = 0;
        printf("Value written to register %x : %x\n", rd, registers[rd]);
    }
    //ori RD = RS1 V Sext(imm)
    else if(instruction_opcode == 0x0d)
    {
        printf("Instruction Mnemonic: ORi\n");
        registers[rd] = registers[rs1] | imm;
        flags[overflow] = 0;
        printf("Value written to register %x: %x\n", rd, registers[rd]);
    }
}

//Function responsible to reproduce the results of the r-type instructions
void decode_r_type(unsigned int instruction_opcode, unsigned int instruction)
{
    int rd, rs1, rs2, function;
    //Define the fields of the instructions
    rs1 = ((instruction >> 21) & 0x1F);
    rs2 = ((instruction >> 16) & 0x1F);
    rd = ((instruction >> 11) & 0x1F);
    function = (instruction & 0x3F);

    printf("RS1: %x RS2: %x RD: %x Function: %x\n", rs1, rs2, rd, function);
    //add - RD = RS1 + RS2
    if(function == 0x20)
    {
        printf("Instruction Mnemonic: ADD\n");
        check_overflow(registers[rs1], registers[rs2]);
        registers[rd] = registers[rs1] + registers[rs2];
        printf("Value written to register %x: %x\n", rd, registers[rd]);
    }
    //sub - RD = RS1 - RS2
    else if(function == 0x22)
    {
        printf("Instruction Mnemonic: SUB\n");
        check_overflow(registers[rs1], registers[rs2]);
        registers[rd] = registers[rs1] - registers[rs2];
        printf("Value written to register %x: %x\n", rd, registers[rd]);
    }
    //and - RD = RS1 ^ RS2
    else if(function == 0x24)
    {
        printf("Instruction Mnemonic: AND\n");
        registers[rd] = registers[rs1] & registers[rs2];
        flags[overflow] = 0;
        printf("Value written to register %x: %x\n", rd, registers[rd]);
    }

    //not (anteriormente, estava como "nor")
    else if(function == 0x27)
    {
        printf("Instruction Mnemonic: NOT\n");
        registers[rd] = ~registers[rs2];
        flags[overflow] = 0;
        printf("Value written to register %x: %x\n", rd, registers[rd]);
    }
    //or - RD = RS1 _ RS2
    else if(function == 0x25)
    {
        printf("Instruction Mnemonic: OR\n");
        registers[rd] = registers[rs1] | registers[rs2];
        flags[overflow] = 0;
        printf("Value written to register %x: %x\n", rd, registers[rd]);
    }
    //mul - RD = RS1 . RS2
    else if(function == 0x18)
    {
        printf("Instruction Mnemonic: MUL\n");
        check_overflow(registers[rs1], registers[rs2]);
        registers[rd] = registers[rs1] * registers[rs2];
        printf("Value written to register %x: %x\n", rd, registers[rd]);
    }
    //div - RD = RS1 / RS2
    else if(function == 0x1A)
    {
        printf("Instruction Mnemonic: DIV\n");
        if(registers[rs2] != 0)
        {
            registers[rd] = registers[rs1] / registers[rs2];
            printf("Value written to register %x: %x\n", rd, registers[rd]);
        }
        else
        {
            flags[overflow] = 1;
            printf("--------------------------------------\n");
            printf("ERROR!! Cannot divide by zero! RS2: %x\n", registers[rs2]);
            printf("--------------------------------------\n");
        }
    }
    //cmp - RD = RS1 cmp RS2
    else if(function == 0x1B)
    {
        //fixme
        printf("Instruction Mnemonic: CMP\n");
        registers[rd] = registers[rs1] - registers[rs2];

    }
    //jr PC = RS1
    else if(function == 0x18)
    {
        printf("Instruction Mnemonic: JR\n");
        pc = registers[rs1] - 1;//(registers[rs1]/4) - 1;// -1 because the increment of for.
        printf("JR - PC Value: %x\n", pc);
    }
    else
    {
        printf("----------------------------------\n");
        printf("ERROR!! Function %x is undefined!!\n", function);
        printf("----------------------------------\n");
    }
}

//Function responsible to reproduce the results of the j-type instructions
void decode_j_type(unsigned int instruction_opcode, unsigned int instruction)
{
    int pc_offset;

    pc_offset = (instruction & 0x3FFFFFF);
    printf("PC offset: %x\n", pc_offset);

    if(instruction_opcode == 0x01)
    {
        printf("Instruction Mnemonic: NOP\n");
        printf("Nothing to do here.....\n");
    }
    else if(instruction_opcode == 0x02)
    {
        //fixme
        printf("Instruction Mnemonic: HALT\n");
        pc--;
    }
    //pc = pc offset
    else if(instruction_opcode == 0x03)
    {
        printf("Instruction Mnemonic: CALL\n");
        printf("Stacking current PC: %x\n");
        push(pc);
        pc = pc_offset - 1;// -1 because the increment of for.
        printf("CALL - PC value: %x\n", pc);
    }
    else if(instruction_opcode == 0x07)
    {
        printf("Instruction Mnemonic: RET\n");
        pc = pop();
        printf("RET - PC value: %x\n", pc);
    }
    else if(instruction_opcode == 0x09)
    {
        printf("Instruction Mnemonic: JPC\n");
        pc = (pc + pc_offset) - 1;// -1 because the increment of for.
        printf("JPC - PC value: %x\n", pc);

    }
}

//Function responsible to write in a file the values stored in registers and data memory.
//The files will be used to compare with the results of the hardware simulation
void write_results(void)
{
    int j;
    FILE *arq_registers, *arq_mem;
    arq_registers = fopen("registers.hex", "wt");
    arq_mem = fopen("mem.hex", "wt");

    for(j=0; j<32; j++)
    {
        fprintf(arq_registers, "%x\n", registers[j]);
    }

    for(j=0; j<1000; j++)
    {
        fprintf(arq_mem, "%x\n", mem[j]);
    }


    fclose(arq_registers);
    fclose(arq_mem);

}



void main (int argc, char *argv[])
{
    FILE *arq_instructions;
    unsigned int *instruction;//[1048576];
    unsigned int instruction_opcode;
    char *reading_result, *reading_result_opcode;
    char instruction_type;
    int  size_instruction,i;
    printf("Parametro: %s\n", argv[1]);
    instruction = malloc( 1048576 );

    //#include "execute_instructions.c"
//	registers[1] = 2;
//	registers[2] = 2;

    //Read the file that contains the instructions
    arq_instructions = fopen(argv[1], "rt");
    if (arq_instructions == NULL)
    {
        printf("Instrunctions File was not opened\n");
        return;
    }
    //Read all the instructions and storage in 'instruction' char vector
    //while(!feof(arq_instructions)){
    for(size_instruction=0; (!feof(arq_instructions)); size_instruction++)
    {
        //reading_result_opcode = fgets(instruction_opcode, 3, arq_instructions);
        //reading_result = fgets(instruction, 8, arq_instructions);

        reading_result = fscanf(arq_instructions, "%x", &instruction[size_instruction]);

    }
    printf("Instructions %d\n\n", size_instruction);
    fclose(arq_instructions);

    for(pc=0; pc<size_instruction; pc++)
    {

        printf("Instruction (hex): %x\n", instruction[pc]);
        instruction_opcode = ((instruction[pc] >> 26) & 0x3F);
        printf("Instruction Opcode (hex): %x\n", instruction_opcode);

        instruction_type = identify_instruction_type(instruction_opcode);

        printf("Instruction Type: %c\n", instruction_type);

        if(instruction_type == 'i')
        {
            decode_i_type(instruction_opcode, instruction[pc]);
        }
        else if(instruction_type == 'r')
        {
            decode_r_type(instruction_opcode, instruction[pc]);
        }
        else if(instruction_type == 'j')
        {
            decode_j_type(instruction_opcode, instruction[pc]);
        }
        printf("Flags:\n");
        printf("Overflow: %d, Equals: %d, Above: %d\n", flags[overflow], flags[equals], flags[above]);
        printf("PC Value (hex): %x\n\n\n", pc);
    }

    write_results();

    free( instruction);
}


