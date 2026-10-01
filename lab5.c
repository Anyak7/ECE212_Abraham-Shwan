#include <stdio.h>
#include <stdlib.h>
#include "ece212.h"


int main() { // The entry-point of your C Program.
    
    // Call the ece212 setup command to connect to the LafBot pins
    ece212_setup();
    ece212_lafbot_setup();

    int x = 1;
    int speed = 16;
    while (1) {  // Repeats contents forever!
       writeLEDs(x);  
       delayms(500);
       x *=2;
       if (x == 16){
           x =1;
       }
        RFORWARD = 0x8000;
       LFORWARD = -0x8000;
       RBACK = 0;
       LBACK = 0;
       delayms(500);
       
       RFORWARD = 0;
       LFORWARD = 0;
       delayms(1000);
       
       RFORWARD = 0;
       LFORWARD = 0;
       RBACK = 0x8000;
       LBACK = -0x8000;
       delayms(500);
       
       RBACK = 0;
       LBACK = 0;
       delayms(1000);
       
      
    }


    
    
    

int main() {

    ece212_lafbot_setup();

    int left;
    int right;

    int leftSpeed;
    int rightSpeed;

    int threshold = 300;

    while (1) {

        left = analogRead(LEFT_SENSOR);
        right = analogRead(RIGHT_SENSOR);


        if (left < threshold && right < threshold) {

            leftSpeed = 0x6000;
            rightSpeed = 0x6000;
        }

 
        else if (left >= threshold && right < threshold) {

            leftSpeed = 0x3000;
            rightSpeed = 0x7000;
        }

    
        else if (left < threshold && right >= threshold) {

            leftSpeed = 0x7000;
            rightSpeed = 0x3000;
        }

  
        else {

            leftSpeed = 0x4000;
            rightSpeed = 0x4000;
        }

        LBACK = 0;
        RBACK = 0;

        LFORWARD = leftSpeed;
        RFORWARD = rightSpeed;

        delayms(75);
    }

    return 0;
}

    return 0;
}



