; RUN: llc < %s -march=mipsel   -mcpu=mips32   | FileCheck %s -check-prefix=ALL -check-prefix=32-C
; RUN: llc < %s -march=mipsel   -mcpu=mips32r2 | FileCheck %s -check-prefix=ALL -check-prefix=32-C
; RUN: llc < %s -march=mipsel   -mcpu=mips32r6 | FileCheck %s -check-prefix=ALL -check-prefix=32-CMP
; RUN: llc < %s -march=mips64el -mcpu=mips4    | FileCheck %s -check-prefix=ALL -check-prefix=64-C
; RUN: llc < %s -march=mips64el -mcpu=mips64   | FileCheck %s -check-prefix=ALL -check-prefix=64-C
; RUN: llc < %s -march=mips64el -mcpu=mips64r2 | FileCheck %s -check-prefix=ALL -check-prefix=64-C
; RUN: llc < %s -march=mips64el -mcpu=mips64r6 | FileCheck %s -check-prefix=ALL -check-prefix=64-CMP

define i32 @false_f32(float %a, float %b) nounwind {
; ALL-LABEL: false_f32:
; ALL:           addiu $2, $zero, 0

  %1 = fcmp false float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @oeq_f32(float %a, float %b) nounwind {
; ALL-LABEL: oeq_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.eq.s $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.eq.s $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.eq.s $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.eq.s $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp oeq float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ogt_f32(float %a, float %b) nounwind {
; ALL-LABEL: ogt_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ule.s $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ule.s $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.lt.s $[[T0:f[0-9]+]], $f14, $f12
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.lt.s $[[T0:f[0-9]+]], $f13, $f12
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ogt float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @oge_f32(float %a, float %b) nounwind {
; ALL-LABEL: oge_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ult.s $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ult.s $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.le.s $[[T0:f[0-9]+]], $f14, $f12
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.le.s $[[T0:f[0-9]+]], $f13, $f12
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp oge float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @olt_f32(float %a, float %b) nounwind {
; ALL-LABEL: olt_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.olt.s $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.olt.s $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.lt.s $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.lt.s $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp olt float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ole_f32(float %a, float %b) nounwind {
; ALL-LABEL: ole_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ole.s $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ole.s $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.le.s $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.le.s $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ole float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @one_f32(float %a, float %b) nounwind {
; ALL-LABEL: one_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ueq.s $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ueq.s $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ueq.s $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 32-CMP-DAG:    not $2, $[[T1]]

; 64-CMP-DAG:    cmp.ueq.s $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 64-CMP-DAG:    not $2, $[[T1]]

  %1 = fcmp one float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ord_f32(float %a, float %b) nounwind {
; ALL-LABEL: ord_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.un.s $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.un.s $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.un.s $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 32-CMP-DAG:    not $2, $[[T1]]

; 64-CMP-DAG:    cmp.un.s $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 64-CMP-DAG:    not $2, $[[T1]]

  %1 = fcmp ord float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ueq_f32(float %a, float %b) nounwind {
; ALL-LABEL: ueq_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ueq.s $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ueq.s $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ueq.s $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.ueq.s $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ueq float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ugt_f32(float %a, float %b) nounwind {
; ALL-LABEL: ugt_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ole.s $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ole.s $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ult.s $[[T0:f[0-9]+]], $f14, $f12
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.ult.s $[[T0:f[0-9]+]], $f13, $f12
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ugt float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @uge_f32(float %a, float %b) nounwind {
; ALL-LABEL: uge_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.olt.s $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.olt.s $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ule.s $[[T0:f[0-9]+]], $f14, $f12
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.ule.s $[[T0:f[0-9]+]], $f13, $f12
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp uge float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ult_f32(float %a, float %b) nounwind {
; ALL-LABEL: ult_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ult.s $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ult.s $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ult.s $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.ult.s $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ult float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ule_f32(float %a, float %b) nounwind {
; ALL-LABEL: ule_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ule.s $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ule.s $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ule.s $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.ule.s $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ule float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @une_f32(float %a, float %b) nounwind {
; ALL-LABEL: une_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.eq.s $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.eq.s $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.eq.s $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 32-CMP-DAG:    not $2, $[[T1]]

; 64-CMP-DAG:    cmp.eq.s $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 64-CMP-DAG:    not $2, $[[T1]]

  %1 = fcmp une float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @uno_f32(float %a, float %b) nounwind {
; ALL-LABEL: uno_f32:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.un.s $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.un.s $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.un.s $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.un.s $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp uno float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @true_f32(float %a, float %b) nounwind {
; ALL-LABEL: true_f32:
; ALL:           addiu $2, $zero, 1

  %1 = fcmp true float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @false_f64(double %a, double %b) nounwind {
; ALL-LABEL: false_f64:
; ALL:           addiu $2, $zero, 0

  %1 = fcmp false double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @oeq_f64(double %a, double %b) nounwind {
; ALL-LABEL: oeq_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.eq.d $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.eq.d $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.eq.d $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.eq.d $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp oeq double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ogt_f64(double %a, double %b) nounwind {
; ALL-LABEL: ogt_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ule.d $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ule.d $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.lt.d $[[T0:f[0-9]+]], $f14, $f12
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.lt.d $[[T0:f[0-9]+]], $f13, $f12
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ogt double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @oge_f64(double %a, double %b) nounwind {
; ALL-LABEL: oge_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ult.d $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ult.d $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.le.d $[[T0:f[0-9]+]], $f14, $f12
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.le.d $[[T0:f[0-9]+]], $f13, $f12
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp oge double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @olt_f64(double %a, double %b) nounwind {
; ALL-LABEL: olt_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.olt.d $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.olt.d $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.lt.d $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.lt.d $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp olt double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ole_f64(double %a, double %b) nounwind {
; ALL-LABEL: ole_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ole.d $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ole.d $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.le.d $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.le.d $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ole double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @one_f64(double %a, double %b) nounwind {
; ALL-LABEL: one_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ueq.d $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ueq.d $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ueq.d $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 32-CMP-DAG:    not $2, $[[T1]]

; 64-CMP-DAG:    cmp.ueq.d $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 64-CMP-DAG:    not $2, $[[T1]]

  %1 = fcmp one double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ord_f64(double %a, double %b) nounwind {
; ALL-LABEL: ord_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.un.d $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.un.d $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.un.d $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 32-CMP-DAG:    not $2, $[[T1]]

; 64-CMP-DAG:    cmp.un.d $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 64-CMP-DAG:    not $2, $[[T1]]

  %1 = fcmp ord double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ueq_f64(double %a, double %b) nounwind {
; ALL-LABEL: ueq_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ueq.d $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ueq.d $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ueq.d $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.ueq.d $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ueq double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ugt_f64(double %a, double %b) nounwind {
; ALL-LABEL: ugt_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ole.d $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ole.d $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ult.d $[[T0:f[0-9]+]], $f14, $f12
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.ult.d $[[T0:f[0-9]+]], $f13, $f12
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ugt double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @uge_f64(double %a, double %b) nounwind {
; ALL-LABEL: uge_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.olt.d $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.olt.d $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ule.d $[[T0:f[0-9]+]], $f14, $f12
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.ule.d $[[T0:f[0-9]+]], $f13, $f12
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp uge double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ult_f64(double %a, double %b) nounwind {
; ALL-LABEL: ult_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ult.d $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ult.d $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ult.d $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.ult.d $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ult double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @ule_f64(double %a, double %b) nounwind {
; ALL-LABEL: ule_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.ule.d $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.ule.d $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.ule.d $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.ule.d $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp ule double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @une_f64(double %a, double %b) nounwind {
; ALL-LABEL: une_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.eq.d $f12, $f14
; 32-C-DAG:      movf $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.eq.d $f12, $f13
; 64-C-DAG:      movf $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.eq.d $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 32-CMP-DAG:    not $2, $[[T1]]

; 64-CMP-DAG:    cmp.eq.d $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $[[T1:[0-9]+]], $[[T0]]
; 64-CMP-DAG:    not $2, $[[T1]]

  %1 = fcmp une double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @uno_f64(double %a, double %b) nounwind {
; ALL-LABEL: uno_f64:

; 32-C-DAG:      addiu $[[T0:2]], $zero, 0
; 32-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 32-C-DAG:      c.un.d $f12, $f14
; 32-C-DAG:      movt $[[T0]], $1, $fcc0

; 64-C-DAG:      addiu $[[T0:2]], $zero, 0
; 64-C-DAG:      addiu $[[T1:[0-9]+]], $zero, 1
; 64-C-DAG:      c.un.d $f12, $f13
; 64-C-DAG:      movt $[[T0]], $1, $fcc0

; 32-CMP-DAG:    cmp.un.d $[[T0:f[0-9]+]], $f12, $f14
; 32-CMP-DAG:    mfc1 $2, $[[T0]]

; 64-CMP-DAG:    cmp.un.d $[[T0:f[0-9]+]], $f12, $f13
; 64-CMP-DAG:    mfc1 $2, $[[T0]]

  %1 = fcmp uno double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @true_f64(double %a, double %b) nounwind {
; ALL-LABEL: true_f64:
; ALL:           addiu $2, $zero, 1

  %1 = fcmp true double %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}
