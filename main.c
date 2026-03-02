#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// 8 bits
unsigned char memoria[154],
              ir=0,  // Contem opcode
              e=0,  // Equal to
              l=0,  // Lower than
              g=0,  //  Greater than
              lr=0;  //  Flag Left/Right
  
//32 bits
unsigned int mbr=0; // Todo trafego passa pelo MBR

//16 bits
unsigned short int  mar=0,  // Endereço de memoria
                    ibr=0,  // Instrução a ser decodificada no proximo ciclo de maquina
                    imm=0,  // Contem op imediato
                    pc=0,  // Contem endereço proxima palavra
                    a=0,  //  Registrador A
                    b=0,  //  Registrador B
                    t=0;  //  Registrador T

char *p1,*p2,*p3,*p4;

void salva(){ //salva na memoria

        memoria[mar++]=mbr>>8;
         memoria[mar++]=mbr;
}

void separa(char string[20],char delimitador[]){ //separa a linha em varias partes de acordo com seu delimitador

  int i=0;
  char *x = strtok(string, delimitador);
  
  while(x !=NULL){
    if(i==0){
      p1=x; //recebe a primeira parte
    }
    else if(i==1){
      p2 = x; //recebe segunda parte 
    }
    else if (i==2){
      p3 = x; //recebe terceira parte (se tiver)
    }
    i=i+1;
    x=strtok(NULL,delimitador);
  }
 }

void guardaNaMemoria(char comando[20]){
  char *posicao, *tipo, *opcode1,*opcode2,*endereco1,*endereco2,*value;
  int pos=0,valor=0,end1=0,end2=0,contador=0;
  separa(comando,";"); //separa a linha pelo delimitador ";"
  posicao=p1; //recebe a posicao
  tipo=p2;    //recebe o tipo
  sscanf(posicao,"%x",&pos);   
  mar=pos;

  if (strcmp(tipo,"d")==0){
    value=p3; 
    sscanf(value,"%x",&valor);
    mbr=valor;
    memoria[mar]=mbr>>8;   
    mar=mar+1;
    memoria[mar]=mbr;
  }
  
  else if(strcmp(tipo,"i")==0){
    opcode1=p3;
    separa(opcode1,"/");
    opcode1=p1;
    opcode2=p2;         
    separa(opcode1," ");
    opcode1=p1;
    endereco1=p2;
    separa(opcode2," ");
    opcode2=p1;
    endereco2=p2;
    sscanf(endereco1,"%x",&end1);
    sscanf(endereco2,"%x",&end2);
    
    
    if (contador==0){ //guarda a instrucao da esquerda
        if (strcmp(opcode1,"hlt")==0)
        {
          mbr=0x0;  
          mbr=mbr<<11;
        }
        else if(strcmp(opcode1,"nop")==0)
        {
          mbr=0x01; 
          mbr=mbr<<11;        
          salva();         
        }
        else if(strcmp(opcode1,"add")==0)
        {
          mbr=0x02;
           mbr=mbr<<11;        
          salva();
        }
        else if(strcmp(opcode1,"sub")==0)
        {
          mbr=0x03;
           mbr=mbr<<11;        
          salva();
          
        }
        else if(strcmp(opcode1,"mul")==0)
        {
          mbr=0x04;
           mbr=mbr<<11;        
          salva();
        }
        else if(strcmp(opcode1,"div")==0)
        {
          mbr=0x05;
           mbr=mbr<<11;        
          salva();
        }
        else if(strcmp(opcode1,"cmp")==0)
        {
          mbr=0x06;
           mbr=mbr<<11;        
          salva();
        }
        else if(strcmp(opcode1,"xchg")==0)
        {
          mbr=0x07;
           mbr=mbr<<11;        
          salva();
        }
        else if(strcmp(opcode1,"and")==0)
        {
          mbr=0x08;
           mbr=mbr<<11;        
          salva();
        }
    else if(strcmp(opcode1,"or")==0)
        {
          mbr=0x09;
           mbr=mbr<<11;        
          salva();
        }
    else if(strcmp(opcode1,"xor")==0)
        {
          mbr=0x0A;
           mbr=mbr<<11;        
          salva();
        }
    else if(strcmp(opcode1,"not")==0)
        {
          mbr=0x0b;
           mbr=mbr<<11;        
          salva();
        }   
    else if(strcmp(opcode1,"je")==0)
        {
          mbr=0x0c;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
    else if(strcmp(opcode1,"jne")==0)
        {
          mbr=0x0d;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
    else if(strcmp(opcode1,"jl")==0)
        {
          mbr=0x0e;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
    else if(strcmp(opcode1,"jle")==0)
        {
          mbr=0x0f;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
    else if(strcmp(opcode1,"jg")==0)
        {
          mbr=0x10;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
    else if(strcmp(opcode1,"jge")==0)
        {
          mbr=0x11;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
    else if(strcmp(opcode1,"jmp")==0)
        {
          mbr=0x12;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
    else if(strcmp(opcode1,"lda")==0)
        {
         mbr=0x13;
         mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
          
         
        }
    else if(strcmp(opcode1,"ldb")==0)
        {
          mbr=0x14;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
          
        }
    else if(strcmp(opcode1,"sta")==0)
        {
          mbr=0x15;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
    else if(strcmp(opcode1,"stb")==0)
        {
          mbr=0x16;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
      else if(strcmp(opcode1,"ldrb")==0)
        {
          mbr=0x17;
           mbr=mbr<<11;        
          salva();
        }
      else if(strcmp(opcode1,"movial")==0)
        {
          mbr=0x18;          
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
      else if(strcmp(opcode1,"moviah")==0)
        {
          mbr=0x19;          
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
        else if(strcmp(opcode1,"addia")==0)
        {
          mbr=0x1a;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
        else if(strcmp(opcode1,"subia")==0)
        {
          mbr=0x1b;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
        else if(strcmp(opcode1,"mulia")==0)
        {
          mbr=0x1c;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
        else if(strcmp(opcode1,"divia")==0)
        {
          mbr=0x1d;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
        else if(strcmp(opcode1,"lsh")==0)
        {
          mbr=0x1e;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
      else if(strcmp(opcode1,"rsh")==0)
        {
          mbr=0x1f;
          mbr=mbr<<11;          
         mbr= mbr|end1;       
         salva();
        }
       contador=1;
    }
    if (contador==1){ //guardar instrucao da direita
      
        if (strcmp(opcode2,"hlt\n")==0)
        {
          mbr=0x0;  
          mbr=mbr<<11;
        }
        else if(strcmp(opcode2,"nop\n")==0)
        {
          mbr=0x01; 
          mbr=mbr<<11;        
          salva();         
        }
        else if(strcmp(opcode2,"add\n")==0)
        {
          mbr=0x02;
           mbr=mbr<<11;        
          salva();
        }
        else if(strcmp(opcode2,"sub\n")==0)
        {
          mbr=0x03;
           mbr=mbr<<11;        
          salva();
        }
        else if(strcmp(opcode2,"mul\n")==0)
        {
          mbr=0x04;
           mbr=mbr<<11;        
          salva();
        }
        else if(strcmp(opcode2,"div\n")==0)
        {
          mbr=0x05;
           mbr=mbr<<11;        
          salva();
        }
        else if(strcmp(opcode2,"cmp\n")==0)
        {
          mbr=0x06;
           mbr=mbr<<11;        
          salva();
        }
        else if(strcmp(opcode2,"xchg\n")==0)
        {
          mbr=0x07;
           mbr=mbr<<11;        
          salva();
          
          
        }
        else if(strcmp(opcode2,"and\n")==0)
        {
          mbr=0x08;
           mbr=mbr<<11;        
          salva();
        }
    else if(strcmp(opcode2,"or\n")==0)
        {
          mbr=0x09;
           mbr=mbr<<11;        
          salva();
        }
    else if(strcmp(opcode2,"xor\n")==0)
        {
          mbr=0x0A;
           mbr=mbr<<11;        
          salva();
        }
    else if(strcmp(opcode2,"not\n")==0)
        {
          mbr=0x0b;
           mbr=mbr<<11;        
          salva();
        }   
    else if(strcmp(opcode2,"je")==0)
        {
          mbr=0x0c;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
    else if(strcmp(opcode2,"jne")==0)
        {
          mbr=0x0d;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
    else if(strcmp(opcode2,"jl")==0)
        {
          mbr=0x0e;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
    else if(strcmp(opcode2,"jle")==0)
        {
          mbr=0x0f;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
    else if(strcmp(opcode2,"jg")==0)
        {
          mbr=0x10;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
    else if(strcmp(opcode2,"jge")==0)
        {
          mbr=0x11;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
    else if(strcmp(opcode2,"jmp")==0)
        {
          mbr=0x12;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
    else if(strcmp(opcode2,"lda")==0)
        {
         mbr=0x13;
         mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
         
        }
    else if(strcmp(opcode2,"ldb")==0)
        {
          mbr=0x14;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();          
        }
    else if(strcmp(opcode2,"sta")==0)
        {
          mbr=0x15;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
    else if(strcmp(opcode2,"stb")==0)
        {
          mbr=0x16;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
      else if(strcmp(opcode2,"ldrb\n")==0)
        {
          mbr=0x17;
           mbr=mbr<<11;        
          salva();
        }
      else if(strcmp(opcode2,"movial")==0)
        {
          mbr=0x18;          
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
      else if(strcmp(opcode2,"moviah")==0)
        {
          mbr=0x19;          
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
        else if(strcmp(opcode2,"addia")==0)
        {
          mbr=0x1a;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
        else if(strcmp(opcode2,"subia")==0)
        {
          mbr=0x1b;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
        else if(strcmp(opcode2,"mulia")==0)
        {
          mbr=0x1c;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
        else if(strcmp(opcode2,"divia")==0)
        {
          mbr=0x1d;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
        else if(strcmp(opcode2,"lsh")==0)
        {
          mbr=0x1e;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
      else if(strcmp(opcode2,"rsh")==0)
        {
          mbr=0x1f;
          mbr=mbr<<11;          
         mbr= mbr|end2;       
         salva();
        }
      contador=0;
    }    
  }   
}

void lerArquivo(){
    FILE *arquivo;
    char palavra[50];
    char *linha;
    
    arquivo = fopen("instrucoes.txt","r");

    if(arquivo==NULL){
        printf("ERRO AO ABRIR ARQUIVO");
       return;
    }
    while(!feof(arquivo)){
      linha=fgets(palavra,50,arquivo);
      if(linha){
      guardaNaMemoria(palavra);
    
      }
    }
    fclose(arquivo);
   
}

void busca(){
  mbr = 0;
  mbr = memoria[mar++];
  mbr = mbr << 8;
  mbr = (mbr | memoria[mar++]);
  mbr = mbr << 8;
  mbr = (mbr | memoria[mar++]);
  mbr = mbr << 8;
  mbr = (mbr | memoria[mar++]);
  
}

void mostraMemoria(){
  printf("\t\t\t Memória:\n");
  for(int i=0;i<154;i++){
    if(i%8==0){
      printf("\n");
    }
    printf("%.2x:  0x%.2x",i,memoria[i]);
    printf("\t");
    }
}      

void decodifica(){
  if(lr==0){
    busca();
    ir=mbr>>27;
   
    if(ir>=13 & ir<=23){
    mar = (mbr>>16)&0x7FF;      
    }
    
    if(ir>=24 & ir<=31){
      imm=(mbr>>16)&0x7ff;
    }   
    
    ibr = mbr&0xffff;              
  }
    
  else if(lr==1){
    ir=ibr>>11;
    
    if(ir>=13 & ir<=23){
    mar=ibr&0x7ff;
    }
    
    if(ir>=24 & ir<=31){
      imm=ibr&0x7ff;
    }    
  }
}

void flaglr(){
  if(lr==0){
    pc = pc +4;
    lr = 1;
  }
  else if(lr==1){
    lr=0;
  }
}

void operacao(){
    if(ir==0)//halt 
    {       
        pc=sizeof(memoria);      
    
    }
    else if(ir==1)//nop
    {       
        if(lr==1){
          pc=pc+4;      
        }
        else if (lr==0){
          lr=1;
        }
    }
    else if (ir==2)//add
    {
      a=a+b;
      flaglr();
    }
    else if (ir==3)//sub
    {
      a=a-b;
      flaglr();
    }
    else if(ir==4)//mul
    {
      a=a*b;
      flaglr();
    }
    else if(ir==5)//div
    {
      a=a/b;
     flaglr();
    }
    else if(ir==6)//cmp
    {
      if(a==b){
        e=1;
      }else{
        e=0;
      }
      if(a<b){
        l=1;
      }else{
        l=0;
      }
      if(a>b){
        g=1;
      }else{
        g=0;
      }
      flaglr();
    }
    else if(ir==7)//xchg
    {
      t=a;
      a=b;
      b=t;
      flaglr();
    }
    else if(ir==8)//and
    {
      a=a&b;
     flaglr();
    }
    else if(ir==9)//or
    {
      a=a|b;
      flaglr();
    }
    else if(ir==10)//xor
    {
      a=a^b;
      flaglr();
    }
    else if(ir==11)//not
    {
      a=!a;
     flaglr();
    }
    else if(ir==12)//je
    {
      if(e==1){
        pc=mar;
        lr=0;
      }
      else {
        flaglr();
      }
    }
    else if(ir==13)//jne
    {
      if(e==0){
        pc=mar;
        lr=0;
      }
      else {
        flaglr();
      }
    }
    else if(ir==14)//jl
    {
      if(l==1){
        pc=mar;
        lr=0;
      }
      else {
       flaglr();
      }
    }
    else if(ir==15)//jle
    {
      if(e==0 || l==1){
        pc=mar;
        lr=0;
      }
      else {
        flaglr();
      }
    }
    else if(ir==16)//jg
    {
      if(g==1){
        pc=mar;
        lr=0;
      }
      else {
        flaglr();
      }
    }
    else if(ir==17)//jge
    {
      if(e==1 || g==1){
        pc=mar;
        lr=0;
      }
      else {
        flaglr();
      }
    }
    else if(ir==18)//jmp
    {
      pc=mar;
        lr=0;
    }
    else if(ir==19)//lda
    {
      mbr=0;
      mbr=memoria[mar];
      mbr=mbr<<8;
      mbr=mbr|memoria[mar+1];
      a=mbr;
       flaglr();
          
    }
    else if(ir==20)//ldb
    {
      mbr=0;
      mbr=memoria[mar];
      mbr=mbr<<8;
      mbr=mbr|memoria[mar+1];
      b=mbr;
     flaglr();
    }
    else if(ir==21)//sta
    {
      mbr=a;
      memoria[mar]=mbr>>8;
      memoria[mar+1]=mbr;
      //por memoria[] ser de 8 bits, não é necessário uso de mascara
      flaglr();
    }
    else if(ir==22)//stb
    {
      mbr=b;
      memoria[mar]=mbr>>8;
      memoria[mar+1]=mbr;
      //por memoria[] ser de 8 bits, não é necessário uso de mascara
      flaglr();
    }
    else if(ir==23)//ldrb
    {
      mbr=b;
      mar=mbr;
      mbr=memoria[mar];
      mbr=mbr<<8;
      mbr=mbr|memoria[mar+1];
      a=mbr;
      flaglr();
    }
    else if(ir==24)//movial
    {
      a=0;
      mbr=imm;
      mbr=mbr>>8;
      a=mbr<<8;
     flaglr();
    }
    else if(ir==25)//moviah
    {
      mbr=imm;
      mbr=mbr>>8;
      a=a|mbr;
     flaglr();
    }
    else if(ir==26)//addia
    {
      
      mbr=imm;
      a=a+mbr;
     flaglr();
    }
    else if(ir==27)//subia
    {
      mbr=imm;
      a=a-imm;
      flaglr();
    }
    else if(ir==28)//mulia
    {
      mbr=imm;
      a=a*mbr;
     flaglr();
    }
    else if(ir==29)//divia
    {
      mbr=imm;
      a=a/mbr;
    flaglr();
    }
    else if(ir==30)//lsh
    {
      mbr=imm;
      a=a<<mbr;
      flaglr();
    }
    else if(ir==31)//rsh
    {
      mbr=imm;
      a=a>>mbr;
      flaglr();
    }
}

void registradores(){    
     printf("\t\t\t CPU:\n\n");
       printf("A:    %.04x          B:    %.04x          T:    %.04x\n\n",a,b,t);
       printf("MBR:  %.08x      MAR:  %.04x          IMM:  %.04x\n\n",mbr,mar,imm);
     printf("PC:   %.04x          IR:   %.02x            LR:   %.01x\n\n",pc,ir,!lr);
     printf("E:    %.01x             L:    %.01x             G:    %.01x\n\n",e,l,g);
    printf("IBR:  %.08x\n\n",ibr);
printf("--------------------------------------------------\n\n");
  
  mostraMemoria();
  printf("\n\n\t\t-*- Pressione ENTER para iniciar o próximo ciclo de máquina -*- \n");
  printf("\t\t-*- Ou aperte CTRL+C para finalizar a execução do trabalho -*-\n\n");
  printf("----------------------------------------------------------------------------------------------------\n");
  printf("----------------------------------------------------------------------------------------------------\n");
  printf("----------------------------------------------------------------------------------------------------\n\n");
  getchar(); 
}

void zeramemoria(){
  for(int i=0;i<154;i++){
    memoria[i]=0;
  }
}

void bemvindo(){
  printf("\t\tSIMULADOR CPU WITH ISA (Instruction Set Architecture)\n\n");
  printf("\t\t\t\t-*- Pressione ENTER para iniciar -*-\n\n");  
  getchar();
}

int main(void) {  
 zeramemoria();
  bemvindo();
  lerArquivo();  
  mbr=0;
  
  while(pc < sizeof(memoria)){
  mar=pc;      
  decodifica();
  operacao();     
  registradores();
  }
 
  printf("\t\tFIM\n");
   printf("\t\tFIM\n");
  printf("\t\tFIM\n");  
  printf("Pressione ENTER para fechar o programa");
  getchar();
 return 0;
}

