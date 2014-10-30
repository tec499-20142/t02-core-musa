#include <stdio.h>
#include <stdlib.h>
//#include "main.h"

//Global Variables:
//pc: Program Counter
//registers[]: represent register bank
//mem[]: Represent the data memory
int  pc=0, registers[32], mem[1000];


//Fuction to identify the instruction type:
// i - I-type Instruction
// r - R-type Instruction
// j - J-type Instruction
char identify_instruction_type(int instruction_opcode){
	char result;
	if(instruction_opcode == 0x23 || instruction_opcode == 0x2b || instruction_opcode == 0x2a || instruction_opcode == 0x08 || instruction_opcode == 0x10 || instruction_opcode == 0x0c || instruction_opcode == 0x13 || instruction_opcode == 0x04 || instruction_opcode == 0x05){
		result = 'i';
	}
	else if (instruction_opcode == 0x00){
		result = 'r';	
	}
	else if (instruction_opcode == 0x02 || instruction_opcode == 0x3e || instruction_opcode == 0x3f ){
		result = 'j';	
	}
	else{
		result = 'e';
	}
	return result;

}

//Function responsible to reproduce the results of the i-type instructions
void decode_i_type(unsigned int instruction_opcode, unsigned int instruction){
	int rd, rs1, imm;
	
	//Define the fields of the instructions
	rs1 = ((instruction >> 21) & 0x1F);
	rd = ((instruction >> 16) & 0x1F);		
	imm = (instruction & 0xFFFF );
	printf("RS1: %x RD: %x IMM: %x\n", rs1, rd, imm);
	
	//Load Instruction - lw RD = mem
	if(instruction_opcode == 0x23){
		registers[rd] = mem[registers[rs1] + imm];		
	}
	//Store Instruction - sw mem = RD
	else if(instruction_opcode == 0x2b){
		mem[registers[rs1] + imm] = registers[rd];
	}
	//brfl - TBD
	else if(instruction_opcode == 0x09){
		printf("TBD");
	}
	//addi - RD = RS1 + Sext(imm)
	else if(instruction_opcode == 0x08){
		registers[rd] = registers[rs1] + imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
 	}
 	//subi RD = RS1 - Sext(imm)
 	else if(instruction_opcode == 0x10){
		registers[rd] = registers[rs1] - imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//andi RD = RS1 ^ Sext(imm)
	else if(instruction_opcode == 0x0c){
		registers[rd] = registers[rs1] & imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//ori RD = RS1 V Sext(imm)
	else if(instruction_opcode == 0x13){
		registers[rd] = registers[rs1] | imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//beqz PC = PC + 4 + (RS1 = 0 ? SExt(imm) : 0)
	else if(instruction_opcode == 0x04){
		if(registers[rs1] == 0){
			pc = pc + imm;
		}
		else{
			pc = pc ;
		}
		printf("Valor de PC : %x\n", pc);
	}
	//bnez Fixme
	else if(instruction_opcode == 0x05){
		if(registers[rs1] != 0){
			pc = pc + imm;
		}
		else{
			pc = pc ;
		}
		printf("BNEZ - Valor de PC : %x\n", pc);
	}
	
}

//Function responsible to reproduce the results of the r-type instructions
void decode_r_type(unsigned int instruction_opcode, unsigned int instruction){
	int rd, rs1, rs2, function;
	//Define the fields of the instructions
	rs1 = ((instruction >> 21) & 0x1F);
	rs2 = ((instruction >> 16) & 0x1F);
	rd = ((instruction >> 11) & 0x1F);	
	function = (instruction & 0x3F);
	
	printf("RS1: %x RS2: %x RD: %x Function: %x\n", rs1, rs2, rd, function);
	//add - RD = RS1 + RS2
	if(function == 0x20){
		registers[rd] = registers[rs1] + registers[rs2];
		printf("rs1: %x registers[rs1] %x\n",rs1, registers[rs1]);
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//sub - RD = RS1 - RS2
	else if(function == 0x22){
		registers[rd] = registers[rs1] - registers[rs2];
	}
	//and - RD = RS1 ^ RS2
	else if(function == 0x24){
		registers[rd] = registers[rs1] & registers[rs2];
	}
	//NOR
	else if(function == 0x27){
		registers[rd] = !(registers[rs1] | registers[rs2]);
	}
	//or - RD = RS1 _ RS2
	else if(function == 0x25){
		registers[rd] = registers[rs1] | registers[rs2];
	}
	//mult - RD = RS1 . RS2
	else if(function == 0x18){
		registers[rd] = registers[rs1] * registers[rs2];
	}
	//div - RD = RS1 / RS2
	else if(function == 0x1A){
		registers[rd] = registers[rs1] / registers[rs2];
	}
	//cmp - RD = RS1 cmp RS2
	else if(function == 0x1C){
		registers[rd] = registers[rs1] - registers[rs2];

	}
	//not - RD = ~RS2
	else if(function == 0x1D){
		registers[rd] = ~registers[rs2];
	}
	//jr PC = RS1
	else if(function == 0x08){
		pc = (registers[rs1]/4) - 1;// -1 because the increment of for.
		printf("JR - Valor de PC: %x\n", pc);
	}
}

//Function responsible to reproduce the results of the j-type instructions
void decode_j_type(unsigned int instruction_opcode, unsigned int instruction){
	int pc_offset;
	
	pc_offset = (instruction & 0x3FFFFFF);
	//pc = pc offset
	if(instruction_opcode == 0x02){
		pc = pc_offset - 1;// -1 because the increment of for.
	}
	else if(instruction_opcode == 0x3e){
	}
	else if(instruction_opcode == 0x3f){
		
	}
}

//Function responsible to write in a file the values stored in registers and data memory.
//The files will be used to compare with the results of the hardware simulation
void write_results(void){
	int j;
	FILE *arq_registers, *arq_mem;
	arq_registers = fopen("registers.hex", "wt");
	arq_mem = fopen("mem.hex", "wt");
	
	for(j=0;j<32;j++){
		fprintf(arq_registers, "%x\n", registers[j]);
	}
	
	for(j=0;j<1000;j++){
		fprintf(arq_mem, "%x\n", mem[j]);
	}
	
	
	fclose(arq_registers);	
	fclose(arq_mem);

}



void main (int argc, char *argv[]){
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
	for(size_instruction=0; (!feof(arq_instructions)); size_instruction++){
		//reading_result_opcode = fgets(instruction_opcode, 3, arq_instructions);  
		//reading_result = fgets(instruction, 8, arq_instructions);  

		reading_result = fscanf(arq_instructions, "%x", &instruction[size_instruction]); 

	}
	printf("size_instruction %d\n", size_instruction);
	fclose(arq_instructions);
	
	for(pc=0;pc<size_instruction;pc++){
		
		printf("Instruction : %x\n", instruction[pc]);
		instruction_opcode = ((instruction[pc] >> 26) & 0x3F);	
		printf("Instruction Opcode: %x\n", instruction_opcode);
		
		instruction_type = identify_instruction_type(instruction_opcode);
		
		printf("Instruction Type: %c\n", instruction_type);
		
		if(instruction_type == 'i'){
			decode_i_type(instruction_opcode, instruction[pc]);
		}
		else if(instruction_type == 'r'){
			decode_r_type(instruction_opcode, instruction[pc]);
		}
		else if(instruction_type == 'j'){
			decode_j_type(instruction_opcode, instruction[pc]);
		}
		printf("Valor de PC: %x\n\n\n", pc);
	}
	
	write_results();

   free( instruction);
}


