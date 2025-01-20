; Soil Moisture Sensor Program
; AT89C51 Microcontroller with L293D Motor Driver

ORG 0H       ; Program start address
START:
    MOV SP, #70H     ; Initialize stack pointer

    ; Initialize Ports
    MOV P0, #00H      ; Clear Port 0 (Assume ADC is connected to P0)
    MOV P1, #00H      ; Clear Port 1 (Motor control pins connected here)

    ; Initialize motor control pins for L293D (Port 1)
    ; Motor_A (P1.0) & Motor_B (P1.1)
    MOV P1.0, #0      ; Turn off motor initially
    MOV P1.1, #0

    ; Start reading the soil moisture level (Assuming the ADC gives a value in P0)
READ_MOISTURE:
    MOV R0, P0         ; Read ADC value into R0 (Assume 8-bit ADC, value 0-255)
    
    ; Compare moisture level to threshold (e.g., 30%)
    ; Let's say the threshold for dry soil is 30% of 255 = 76
    MOV A, R0          ; Load ADC value into accumulator
    MOV B, #76         ; Threshold value for dry soil
    CP A, B            ; Compare ADC value with threshold
    JC MOTOR_OFF       ; If ADC value >= 76, go to MOTOR_OFF (so the soil is wet)
    
    ; Soil is dry, turn the motor on (Watering the plant)
    MOV P1.0, #1       ; Turn motor on
    MOV P1.1, #0       ; Set L293D direction (depending on wiring)
    SJMP WAIT

MOTOR_OFF:
    ; Soil is wet, turn the motor off
    MOV P1.0, #0       ; Turn motor off
    MOV P1.1, #0       ; Ensure L293D motor is stopped
    
WAIT:
    ; Wait for some time before taking the next reading (e.g., delay loop)
    MOV R2, #50        ; Delay value
DELAY:
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    DJNZ R2, DELAY     ; Decrement and repeat until delay is finished

    SJMP READ_MOISTURE ; Repeat reading and checking soil moisture level

END
