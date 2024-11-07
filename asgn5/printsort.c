#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void readString(char word[], int length);
void sorting(char word[], int len);
int flag = 1; 

int main() 
{
  while(flag == 1)
  {
    char word[21]; 
    printf("Enter word: ");
    readString(word, 21);
    printf("Original word: %s\n", word);
    sorting(word, strlen(word));
    printf("Alphabetized word: %s\n", word);  
  }

  return 0; 
}

void readString(char word[], int length)
{
  int i = 0;
  char character = getchar();
  
  if(character == 0x0A)
  {
      
      flag = 0; 
      printf("\nExiting");
      exit(1); 
  }
  else{
        while (i < length - 1 && character != '\n')
        {
            word[i++] = character;
            character = getchar();
        }
        word[i] = '\0';
  }
}

void sorting(char word[], int len)
{
  int i, j;
  char temp;
  
  for (i = 0; i < len - 1; i++)
  {
    for (j = 0; j < len - i - 1; j++)
    {
      if (word[j] > word[j+1])
      {
        temp = word[j];
        word[j] = word[j+1];
        word[j+1] = temp;
      }
    }
  }
}
