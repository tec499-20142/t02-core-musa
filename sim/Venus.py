
arquivo = open('fibonachi.txt' , 'r')  #decode-test
arquivo2 = open('bin.txt' , 'w')
arquivo3 = open('memory.txt' , 'w')

r_type = {'ADD':'000000','SUB':'000000','MUL':'000000','DIV':'000000','AND':'000000','OR':'000000','NOT':'000000','CMP':'000000', 'JR':'001000'}
i_type = {'ADDi':'001000', 'SUBi':'001001', 'ANDi':'001100','ORi':'001101', 'LW':'100011','SW':'101011','BRFL':'010001'}
j_type = {'HALT':'000010', 'NOP':'000001', 'CALL':'000011','RET':'000111','JPC':'001001' }


func = {'ADD':'100000','SUB':'100010','MUL':'011000','DIV':'011010','AND':'100100','OR':'100101','NOT':'100111','CMP':'011011'}
registers = {"$t0":'00000', "$t1":'00001', "$t2":'00010', "$t3":'00011', "$t4":'00100', "$t5":'00101', "$t6":'00110', "$t7":'00111', "$t8":'01000', "$t9":'01001', "$t10":'01010' }


def start(linha):
    linha = linha.replace(","," ")
    linha = linha.replace("\n","")
    linha = linha.split(" ")

    lista_r = r_type.keys()
    lista_i = i_type.keys()
    lista_j = j_type.keys()
    instrucao = ''
    if  linha[0] in lista_r :
        instrucao = rtype(linha) 
        #arquivo2.writelines(instrucao +'\n')
        #instrucao = '0x' + hex('0b'+instrucao)
        #arquivo3.writelines(instrucao + '\n')

    elif linha[0] in lista_j:
        instrucao = jtype(linha)
        #arquivo2.writelines(jtype(linha)+'\n')
        #arquivo3.writelines(jtype(linha)+'\n')

    elif linha[0] in lista_i:
        instrucao = itype(linha)
        #arquivo2.writelines(itype(linha)+'\n')

    return instrucao


def jtype( linha ):
    nova_linha = j_type.get(linha[0])                                  #OPCODE

    if linha[0] in ['RET', 'HALT', 'NOP'] :
        bina2 = ''
        for i in range(26):                                           #Completa com 0 a esquerda o valor do imediato vulgo extensor de sinal
            bina2 = bina2 + '0'
        nova_linha = nova_linha + bina2                               #OPCODE + 000...

    else:    
        bina = bin(int(linha[1]))[2:]
        bina2 = ''
        for i in range(26-len(bina)):                                    #Completa com 0 a esquerda o valor do imediato vulgo extensor de sinal
            bina2 = bina2 + '0'

        nova_linha = nova_linha + bina2 + bina                           #OPCODE + 000 + ENDERECO

    return nova_linha

def rtype ( linha ):
    nova_linha = r_type.get(linha[0])                                   #OPCODE
   
    if linha[0] == "CMP":
        nova_linha = str(nova_linha)+str(registers.get(linha[1]))       #RS
        nova_linha = str(nova_linha)+str(registers.get(linha[2]))       #RT
        nova_linha = nova_linha+'00000'                                 # Preenchendo o espaço do RD
        nova_linha = nova_linha+'00000'                                 #SHAMT
        nova_linha = nova_linha+func.get(linha[0])                      #FUNCT

    elif linha[0] == "JR":
        nova_linha = str(nova_linha)+str(registers.get(linha[1]))       #RS
        #bina = bin(int(linha[2]))[2:]                                   #Imediato da instrução
        bina2 = ''

        for i in range (21):                                            #Completando o imediato com zero para a instrução ficar com 32bits
            bina2 = bina2 + '0'
        nova_linha = str(nova_linha) + str(bina2)

    else:
        nova_linha = str(nova_linha)+str(registers.get(linha[1]))       #RS
        nova_linha = str(nova_linha)+str(registers.get(linha[2]))       #RT
        nova_linha = str(nova_linha)+str(registers.get(linha[3]))       #RD

        nova_linha = nova_linha + '00000'                                 #SHAMT
        nova_linha = nova_linha + func.get(linha[0])                      #FUNCT

    return nova_linha

def itype( linha ):
    nova_linha = i_type.get(linha[0])                                   #OPCODE

    if linha[0] == "BRFL":
        nova_linha = str(nova_linha)+str(registers.get(linha[1]))       #RS

        bina = bin(int(linha[2]))[2:]                                   #Imediato da instrução
        bina2 = bina
        for i in range (21 - len(bina)):                                #completando o imediato com zero para a instrução ficar com 32bits
            bina2 = '0' + bina2

        nova_linha = str(nova_linha) + str(bina2) 

    else:
        nova_linha = nova_linha + registers.get(linha[1])               #RS
        nova_linha = nova_linha + registers.get(linha[2])               #RD
        bina = bin(int(linha[3]))[2:]                                   #Converte o imediato para binario
        bina2 = bina

        for i in range(16-len(bina)):                                   #Completa com 0 a esquerda o valor do imediato vulgo extensor de sinal
            bina2 = '0' + bina2 

        nova_linha = nova_linha +  bina2

    return nova_linha

count = 0
for linha in arquivo:
    if linha != '\n':
        instrucao = start(linha)
        print instrucao
        arquivo2.writelines(instrucao + '\n' )
        arquivo3.writelines(str(count) + '   :    ' + instrucao +';' + '\n' )
        print linha
        count = count +1

arquivo3.writelines('[' + str(count) + '..1023]  :   00000000000000000000000000000000;' + '\n' )
arquivo3.close()
arquivo.close()
arquivo2.close()
