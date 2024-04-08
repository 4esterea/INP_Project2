; Autor reseni: Zhdanovich Iaroslav xzhdan00
; Pocet cyklu k serazeni puvodniho retezce: 2327
; Pocet cyklu razeni sestupne serazeneho retezce: 3316
; Pocet cyklu razeni vzestupne serazeneho retezce: 451
; Pocet cyklu razeni retezce s vasim loginem: 682
; Implementovany radici algoritmus: Insertion sort
; ------------------------------------------------

; DATA SEGMENT
                .data
; login:          .asciiz "vitejte-v-inp-2023"    ; puvodni uvitaci retezec
; login:          .asciiz "vvttpnjiiee3220---"  ; sestupne serazeny retezec
; login:          .asciiz "---0223eeiijnpttvv"  ; vzestupne serazeny retezec
login:          .asciiz "xzhdan00"            

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize - "funkce" print_string)

; CODE SEGMENT
                .text
main:
        ; SEM DOPLNTE VASE RESENI

        daddi   r11, r0, 1      ;i = 1
        jal for


for:    ;r11 - i
        daddi   r10, r11, 0     ;j = i
        lb      r7, login(r10)  ;r7 = login[j]
        beqz    r7, continue    ;if (login[j] == '\0') break
        j while


while:  ;r10 - j
        beqz    r10, for
        daddi   r3, r10, 0      ;r3 = j
        daddi   r2, r10, -1     ;r2 = j-1
        lb      r5, login(r2)   ;r5 = login[j-1]
        lb      r6, login(r3)   ;r6 = login[j]
        sltu    r7, r6, r5      ;if (login[j] <= login[j-1]):
        bnez    r7, swap        ;swap
        daddi   r11, r11, 1     ;i++
        j for

swap:   ;r10 - j
        sb      r5, login(r3)   ;login[j] = login[j-1]
        sb      r6, login(r2)   ;login[j-1] = login[j]
        daddi   r10, r10, -1    ;j--
        j      while
        
continue:
        daddi   r4, r0, login   ; vozrovy vypis: adresa login: do r4
        jal     print_string    ; vypis pomoci print_string - viz nize

        syscall 0   ; halt

print_string:   ; adresa retezce se ocekava v r4
        sw      r4, params_sys5(r0)
        daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
        syscall 5   ; systemova procedura - vypis retezce na terminal
        jr      r31 ; return - r31 je urcen na return address
