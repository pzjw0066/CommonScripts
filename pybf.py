import io
import sys
import argparse

class Bfvm:
    def __init__(self,initmem:bytes=None,size:int=65536,inputIO:io.IOBase=sys.stdin,outputIO:io.IOBase=sys.stdout):
        if initmem:
            self.__mem = bytearray(initmem[:size])
        else:
            self.__mem = bytearray(size)

        self.__mc = 0
        self.__inputIO = inputIO
        self.__outputIO = outputIO

    def execute(self,code:str):
        'execute the Brainfuck code.'
        pc = 0
        mc = self.__mc
        mem = self.__mem
        inputIO = self.__inputIO
        outputIO = self.__outputIO
        while pc < len(code):
            if code[pc] == '+':
                mem[mc] += 1
            elif code[pc] == '-':
                mem[mc] -= 1
            elif code[pc] == '.':
                outputIO.write(chr(mem[mc]))
            elif code[pc] == ',':
                mem[pc] = inputIO.read(1)
            elif code[pc] == '<':
                mc -= 1
            elif code[pc] == '>':
                mc += 1
            elif code[pc] in '[]':
                self.__mc = mc
                if code[pc] == '[' and not mem[mc]:
                    pc = self.__skip(code,pc,True)
                elif code[pc] == ']' and mem[mc]:
                    pc = self.__skip(code,pc,False)

            elif code[pc] == ' ':
                pass
            else:
                raise NotBfCodeError('Not a vaild Brainfuck code!')
            pc += 1
        self.__mc = mc

    def __skip(self,code:str,pc:int,order:bool) -> int:
        'skip to the forward if var "order" is True else skip to the backward.'
        mc = self.__mc
        mem = self.__mem
        c = 1
        if order:
            pc += 1
            while c:
                if code[pc] == '[':
                    c += 1
                elif code[pc] == ']':
                    c -= 1  
                pc += 1
        else:
            pc -= 1
            while c:
                if code[pc] == ']':
                    c += 1
                elif code[pc] == '[':
                    c -= 1
                pc -= 1
        return pc + 1

class NotBfCodeError(Exception):
    pass

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='A simple Brainfuck interpreter.')
    parser.add_argument('sourcefile',type=str)
    parser.add_argument('-m','--memory',help='give a memory size of the brainfuck program.',type=int)
    args = parser.parse_args()
    memsize = args.memory if args.memory else 65536
    bfvm = Bfvm(None,memsize)
    with open(args.sourcefile) as f:
        bfvm.execute(f.read())