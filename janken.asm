ORG 0x100


; 表示
MOV AH, 0x09
MOV DX, INPUT
INT 0x21

; 入力してもらう
MOV AH, 0x01 ; 入力
INT 0x21

MOV AH, 0x09 ; 改行
MOV DX, CRLF
INT 0x21

MOV DX, USER
INT 0x21
CALL hand0

MOV BX, 0
keywait:
ADD BX, 2 ; 繰り返し
CMP BX, 4
JLE skip1 ; チェック
MOV BX, 0
skip1:
; キーボード状態のチェック
MOV AH, 0x06 ; コンソールへの入力確認
MOV DL, 0xff ; キーボード状態のチェック
INT 0x21
JZ keywait ; 入力無ければ戻る

MOV AH, 0x09 ; 表示
MOV DX, CPUS
INT 0x21

MOV DX, [RPS+BX] ; 表示文字列のアドレスを取得
INT 0x21

; プログラム終了

MOV AX, 0x4c00
INT 0x21

hand0:
CMP AL, 0x31
JAE hand1
MOV DX, ROCK
INT 0x21
RET

hand1:
CMP AL, 0x32
JE hand2
MOV DX, PAPER
INT 0x21
RET

hand2:
MOV DX, SCISSORS
INT 0x21
RET

RPS DW ROCK, PAPER, SCISSORS ; アドレステーブル

ROCK DB ’Rock’, 0x0d, 0x0a, ’$’
PAPER DB ’Paper’, 0x0d, 0x0a, ’$’
SCISSORS DB ’Scissors’, 0x0d, 0x0a, ’$’

INPUT DB ’Please Input Handsign (Rock->0, Paper->1, Scissors->2)’, 0x0d, 0x0a, ’INPUT:’, 0x0d, 0x0a, ’$’

USER DB ’User:’, ’$’ 改行なし;
CPUS DB ’CPU:’, ’$’

CRLF DB 0x0d, 0x0a, ’$’
