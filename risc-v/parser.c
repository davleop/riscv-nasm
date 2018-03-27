/* ----------------------------------------------------------------------- *
 *   
 *   Copyright 1996-2009 The NASM Authors - All Rights Reserved
 *   See the file AUTHORS included with the NASM distribution for
 *   the specific copyright holders.
 *
 *   Redistribution and use in source and binary forms, with or without
 *   modification, are permitted provided that the following
 *   conditions are met:
 *
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above
 *     copyright notice, this list of conditions and the following
 *     disclaimer in the documentation and/or other materials provided
 *     with the distribution.
 *     
 *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 *     CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 *     INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 *     MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 *     CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *     SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *     NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 *     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 *     OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * ----------------------------------------------------------------------- */

/* 
 * parser.c   source file for the risc-v parser module of the Netwide
 *            Assembler
 */

#include "nasm.h"
#include "parser.h"

insn *parse_line_riscv(int pass, char *buffer, insn *result, ldfunc ldef)
{
	printf("line: %s\n", buffer);

	result->label = "";
	result->prefixes[0] = 0;
	result->opcode = 0;
	result->condition = 0;
	result->operands = 0;
	result->addr_size = 0;
	result->eops = 0;
	result->eops_float = 0;
	result->times = 0;
	result->forw_ref = 0;
	result->rex_done = 0;
	result->rex = 0;
	result->vexreg = 0;
	result->vex_cm = 0;
	result->vex_wlp = 0;
	result->evex_p[0] = 0;
	result->evex_tuple = 0;
	result->evex_rm = 0;
	result->evex_brerop = 0;

	(void) pass;
	(void) buffer;
	(void) ldef;

	return result;
}
