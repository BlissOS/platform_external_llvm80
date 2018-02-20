; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv6m-eabi -asm-verbose=false %s -o - | FileCheck %s

define void @test8(i8* %a) {
; CHECK-LABEL: test8:
; CHECK:         ldrb r1, [r0]
; CHECK-NEXT:    mvns r1, r1
; CHECK-NEXT:    strb r1, [r0]
; CHECK-NEXT:    bx lr
  %x = load i8, i8* %a
  %xn = xor i8 %x, -1
  store i8 %xn, i8* %a
  ret void
}

define void @test8_2(i8* %a, i8* %b) {
; CHECK-LABEL: test8_2:
; CHECK:         ldrb r2, [r1]
; CHECK-NEXT:    ldrb r3, [r0]
; CHECK-NEXT:    mvns r3, r3
; CHECK-NEXT:    strb r3, [r0]
; CHECK-NEXT:    mvns r0, r2
; CHECK-NEXT:    strb r0, [r1]
; CHECK-NEXT:    bx lr
  %x = load i8, i8* %a
  %y = load i8, i8* %b
  %xn = xor i8 %x, -1
  %yn = xor i8 %y, -1
  store i8 %xn, i8* %a
  store i8 %yn, i8* %b
  ret void
}

define void @loop8(i8* %a) {
; CHECK-LABEL: loop8:
; CHECK:         movs r1, #0
; CHECK-NEXT:  .LBB2_1:
; CHECK-NEXT:    ldrb r2, [r0, r1]
; CHECK-NEXT:    mvns r2, r2
; CHECK-NEXT:    strb r2, [r0, r1]
; CHECK-NEXT:    adds r1, r1, #1
; CHECK-NEXT:    cmp r1, #10
; CHECK-NEXT:    bne .LBB2_1
; CHECK-NEXT:    bx lr
entry:
  br label %for.body

for.body:
  %i = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, i8* %a, i32 %i
  %x = load i8, i8* %arrayidx
  %xn = xor i8 %x, -1
  store i8 %xn, i8* %arrayidx
  %inc = add nuw nsw i32 %i, 1
  %exitcond = icmp eq i32 %inc, 10
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

define void @loop8_2(i8* %a, i8* %b) {
; CHECK-LABEL: loop8_2:
; CHECK:         .save {r4, lr}
; CHECK-NEXT:    push {r4, lr}
; CHECK-NEXT:    movs r2, #0
; CHECK-NEXT:  .LBB3_1:
; CHECK-NEXT:    ldrb r3, [r1, r2]
; CHECK-NEXT:    ldrb r4, [r0, r2]
; CHECK-NEXT:    mvns r4, r4
; CHECK-NEXT:    strb r4, [r0, r2]
; CHECK-NEXT:    mvns r3, r3
; CHECK-NEXT:    strb r3, [r1, r2]
; CHECK-NEXT:    adds r2, r2, #1
; CHECK-NEXT:    cmp r2, #10
; CHECK-NEXT:    bne .LBB3_1
; CHECK-NEXT:    pop {r4, pc}
entry:
  br label %for.body

for.body:
  %i = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i8, i8* %a, i32 %i
  %arrayidx2 = getelementptr inbounds i8, i8* %b, i32 %i
  %x = load i8, i8* %arrayidx
  %y = load i8, i8* %arrayidx2
  %xn = xor i8 %x, -1
  %yn = xor i8 %y, -1
  store i8 %xn, i8* %arrayidx
  store i8 %yn, i8* %arrayidx2
  %inc = add nuw nsw i32 %i, 1
  %exitcond = icmp eq i32 %inc, 10
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

define void @test32(i32* %a) {
; CHECK-LABEL: test32:
; CHECK:         ldr r1, [r0]
; CHECK-NEXT:    mvns r1, r1
; CHECK-NEXT:    str r1, [r0]
; CHECK-NEXT:    bx lr
  %x = load i32, i32* %a
  %xn = xor i32 %x, -1
  store i32 %xn, i32* %a
  ret void
}

define void @test32_2(i32* %a, i32* %b) {
; CHECK-LABEL: test32_2:
; CHECK:         ldr r2, [r1]
; CHECK-NEXT:    ldr r3, [r0]
; CHECK-NEXT:    mvns r3, r3
; CHECK-NEXT:    str r3, [r0]
; CHECK-NEXT:    mvns r0, r2
; CHECK-NEXT:    str r0, [r1]
; CHECK-NEXT:    bx lr
  %x = load i32, i32* %a
  %y = load i32, i32* %b
  %xn = xor i32 %x, -1
  %yn = xor i32 %y, -1
  store i32 %xn, i32* %a
  store i32 %yn, i32* %b
  ret void
}

define void @loop32(i32* %a) {
; CHECK-LABEL: loop32:
; CHECK:         movs r1, #0
; CHECK-NEXT:  .LBB6_1:
; CHECK-NEXT:    ldr r2, [r0, r1]
; CHECK-NEXT:    mvns r2, r2
; CHECK-NEXT:    str r2, [r0, r1]
; CHECK-NEXT:    adds r1, r1, #4
; CHECK-NEXT:    cmp r1, #40
; CHECK-NEXT:    bne .LBB6_1
; CHECK-NEXT:    bx lr
entry:
  br label %for.body

for.body:
  %i = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* %a, i32 %i
  %x = load i32, i32* %arrayidx
  %xn = xor i32 %x, -1
  store i32 %xn, i32* %arrayidx
  %inc = add nuw nsw i32 %i, 1
  %exitcond = icmp eq i32 %inc, 10
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

define void @loop32_2(i32* %a, i32* %b) {
; CHECK-LABEL: loop32_2:
; CHECK:         .save {r4, lr}
; CHECK-NEXT:    push {r4, lr}
; CHECK-NEXT:    movs r2, #0
; CHECK-NEXT:  .LBB7_1:
; CHECK-NEXT:    ldr r3, [r1, r2]
; CHECK-NEXT:    ldr r4, [r0, r2]
; CHECK-NEXT:    mvns r4, r4
; CHECK-NEXT:    str r4, [r0, r2]
; CHECK-NEXT:    mvns r3, r3
; CHECK-NEXT:    str r3, [r1, r2]
; CHECK-NEXT:    adds r2, r2, #4
; CHECK-NEXT:    cmp r2, #40
; CHECK-NEXT:    bne .LBB7_1
; CHECK-NEXT:    pop {r4, pc}
entry:
  br label %for.body

for.body:
  %i = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* %a, i32 %i
  %arrayidx2 = getelementptr inbounds i32, i32* %b, i32 %i
  %x = load i32, i32* %arrayidx
  %y = load i32, i32* %arrayidx2
  %xn = xor i32 %x, -1
  %yn = xor i32 %y, -1
  store i32 %xn, i32* %arrayidx
  store i32 %yn, i32* %arrayidx2
  %inc = add nuw nsw i32 %i, 1
  %exitcond = icmp eq i32 %inc, 10
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}
