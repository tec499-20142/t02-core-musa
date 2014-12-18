#### Instruções com Registradores (R)
add $t1, $t2, $t3
sub $t1, $t2, $t3
mult $t1, $t2
div $t1, $t2, $t3
and $t1, $t2, $t3
or $t1, $t2, $t3
not $t1, $t2
divu $t1, $t2 # Nosso CMP será um DIVu

jr $t1 #JR: Salta para o endereço armazenado no registrador
jalr $t1 #JALR: Será nosso JPC

 nop #NOP

#### Instruções Imediatas (I)
addi $t1, $t2, 100 #ADDI
subi $t1, $t2, 100 #SUBI
andi $t1, $t2, 100 #ANDI
ori $t1, $t2, 100 #ORI
lw $t1, -100($t2) #LW
sw $t1, -100($t2) #SW

#### Instruções de Salto (J)

bc1t 1, myLabel #BCLT: Será nosso BRFL
jal myLabel #CALL
jr $ra #RET


sll $zero, $zero, 0 # ----> Modo como o NOP se comporta




 
myLabel:



break #HALT

	
