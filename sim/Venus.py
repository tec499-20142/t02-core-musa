
arquivo = open('decode-test.txt' , 'r')
arquivo2 = open('bin.txt' , 'w')
arquivo3 = open('hex.txt' , 'w')

r_type = {'ADD':'000000','SUB':'000000','MUL':'000000','DIV':'000000','AND':'000000','OR':'000000','NOT':'000000','CMP':'000000'}
i_type = {'ADDi':'001000', 'SUBi':'001001', 'ANDi':'001100','ORi':'001101', 'LW':'100011','SW':'101011'}
j_type = { 'JPC':'001001', 'HALT':'000010', 'NOP':'000001'}
b_type = {'JR':'001000', 'CALL':'000011','RET':'000111',}
brfl_type = {'BRFL':'010001'}

func = {'ADD':'100000','SUB':'100010','MUL':'011000','DIV':'011010','AND':'100100','OR':'100101','NOT':'100111','CMP':'011011'}
registers = {"$t0":'00000', "$t1":'00001', "$t2":'00010', "$t3":'00011', "$t4":'00100', "$t5":'00101', "$t6":'00110', "$t7":'00111', "$t8":'01000', "$t9":'01001' }


def start(linha):
    linha = linha.replace(","," ")
    linha = linha.replace("\n","")
    linha = linha.split(" ")

    lista_r = r_type.keys()
    lista_i = i_type.keys()
    lista_j = j_type.keys()
    lista_b = b_type.keys()
    lista_brfl = brfl_type.keys()

    if  linha[0] in lista_r :
        instrucao = rtype(linha)
        arquivo2.writelines(instrucao +'\n')
        #instrucao = '0x' + hex('0b'+instrucao)
        #arquivo3.writelines(instrucao + '\n')

    elif linha[0] in lista_j:
        arquivo2.writelines(jtype(linha)+'\n')
        arquivo3.writelines(jtype(linha)+'\n')

    elif linha[0] in lista_i:
        arquivo2.writelines(itype(linha)+'\n')

    elif linha[0] in lista_brfl:
        arquivo2.writelines(branch(linha)+'\n')

    elif linha[0] in lista_b:
        arquivo2.writelines(brfl(linha)+'\n')


def jtype( linha ):
    bina = bin(int(linha[1]))[2:]
    bina2 = ''

    for i in range(26-len(bina)):                        #Completa com 0 a esquerda o valor do imediato vulgo extensor de sinal
        bina2 = bina2 + '0'

    nova_linha = j_type.get(linha[0]) + bina2 + bina    #OPCODE + 000 + ENDERECO
    return nova_linha

def rtype ( linha ):
    nova_linha = r_type.get(linha[0])                                         #OPCODE
    nova_linha = str(nova_linha)+str(registers.get(linha[1]))       #RS
    nova_linha = str(nova_linha)+str(registers.get(linha[2]))       #RT
    nova_linha = str(nova_linha)+str(registers.get(linha[3]))       #RD

    nova_linha = nova_linha+'00000'                                         #SHAMT
    nova_linha = nova_linha+func.get(linha[0])                          #FUNCT
    return nova_linha

def itype( linha ):
    nova_linha = i_type.get(linha[0])
    nova_linha = nova_linha + registers.get(linha[1])
    nova_linha = nova_linha + registers.get(linha[2])
    bina = bin(int(linha[3]))[2:]                       #Converte o imediato para binario
    bina2 = ""

    for i in range(16-len(bina)):                        #Completa com 0 a esquerda o valor do imediato vulgo extensor de sinal
        bina2 = bina2 + '0'

    return nova_linha + bina2 + bina

#CALL RET E JR
def branch(linha):
    print (linha[1])
    nova_linha = i_type.get(linha[0])
    nova_linha = nova_linha + registers.get(linha[1])

    for i in range(21-len(bina)):                        #Completa com 0 a esquerda o valor do imediato vulgo extensor de sinal
        bina2 = bina2 + '0'

    return nova_linha + bina2

def brfl (linha):
    nova_linha = r_type.get(linha[0])                                         #OPCODE
    nova_linha = str(nova_linha)+str(registers.get(linha[1]))       #RS
    nova_linha = str(nova_linha)+str(registers.get(linha[2]))

    return nova_linha



for linha in arquivo:
    start(linha)
    print linha

arquivo3.close()
arquivo.close()
arquivo2.close()
