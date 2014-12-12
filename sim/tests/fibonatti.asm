# F(n) = F(n-1) + F(n-2)
# F(1) = 1; F(2) = 2

.inicio:
addi $9, $10, 10  # number of iterations
addi $1, $10, 1   # setup F(1)
addi $2, $10, 1   # setup F(2)
addi $5, $10, 145 # endereco de destino na memoria
addi $7, $10, 1   # decrement step

.algoritmo:
add $4, $2, $1
add $1, $2, $10  
add $2, $4, $10
sub $9, $9, $7
bnez $9, .algoritmo

.store:
# para gerar o .hex usar o comando abaixo
sw $4 0x000000a($5)
# para simular usar o comando abaixo
#sw $2 0x10010000

# suspend execution
.halt:
j .halt 
