# RUN: llvm-mc -triple=x86_64-pc-linux -relocation-model=pic -filetype=obj -o %T/test_ELF1_x86-64.o %s
# RUN: llvm-mc -triple=x86_64-pc-linux -relocation-model=pic -filetype=obj -o %T/test_ELF2_x86-64.o %s
# RUN: llvm-rtdyld -triple=x86_64-pc-linux -verify -check=%s %/T/test_ELF1_x86-64.o
# Test that we can load this code twice at memory locations more than 2GB apart
# RUN: llvm-rtdyld -triple=x86_64-pc-linux -verify -map-section test_ELF1_x86-64.o,.got=0x10000 -map-section test_ELF2_x86-64.o,.text=0x100000000 %/T/test_ELF1_x86-64.o %T/test_ELF2_x86-64.o

# Assembly obtained by compiling the following and adding checks:
# @G = external global i8*
#
# define i8* @foo() {
#    %ret = load i8** @G
#    ret i32 %ret
# }
#

#
	.text
	.file	"ELF_x64-64_PIC_relocations.ll"
	.align	16, 0x90
	.type	foo,@function
foo:                                    # @foo
	.cfi_startproc
# BB#0:
	movq	G@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	retq
.Ltmp0:
	.size	foo, .Ltmp0-foo
	.cfi_endproc


	.section	".note.GNU-stack","",@progbits
