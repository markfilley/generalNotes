#!/usr/bin/python
import os.path
import sys

def command1(*args):
    print ('Command1')
    print (str(args))

def command2(*args):
    print ('Command2')
    print (str(args))


commands = {
    'command1': command1,
    'command2': command2
}

if __name__ == '__main__':
    command = os.path.basename(sys.argv[0])
    if command in commands:
        commands[command](*sys.argv[1:])