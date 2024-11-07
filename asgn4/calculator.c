#include <stdio.h>
#include <stdlib.h>
#include "operations.h"


int main() {

    int con = 1;
    int invalid, opcount = 0;
    int opchoice, x, y, result;
    char choice;
    
    printf("Welcome to the Calculator program.\nOperations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift\n");
    
    while(con) {

        printf("\nNumber of operations performed: %d", opcount);
        invalid = 0;
        opcount = opcount + 1;

        printf("\nEnter number: ");
        scanf("%d", &x);

        printf("Enter second number: ");
        scanf("%d", &y);

        printf("Select operation: ");
        scanf("%d", &opchoice);

        switch(opchoice) {
            case 1:
                result = addnums(x, y);
                break;

            case 2:
                result = subnums(x, y);
                break;

            case 3:
                result = multnums(x, y);
                break;

            case 4:
                result = divnums(x, y);
                break;

            case 5:
                result = andnums(x, y);
                break;

            case 6:
                result = ornums(x, y);
                break;
            
            case 7:
                result = xornums(x, y);
                break;

            case 8:
                result = lshiftnums(x, y);
                break;

            case 9:
                result = rshiftnums(x, y);
                break;
            
            default:
                invalid = 1;            
        }

        if (invalid) {
            printf("Result: Invalid Operation\n");
        }

        else {
            printf("Result: %d\n", result);
        }

        printf("Continue (y/n)?: ");
        scanf("%s", &choice);
        if (choice == 'n') {
            con = 0;
            printf("\nNumber of operations performed: %d\nExiting", opcount);
        }
    }
    return 0;
}