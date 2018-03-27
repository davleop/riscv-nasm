cmake_minimum_required(VERSION 2.6)

add_library("nasmlib"
	"badenum.c"
	"bsi.c"
	"crc64.c"
	"file.c"
	"filename.c"
	"hashtbl.c"
	"ilog2.c"
	"malloc.c"
	"md5c.c"
	"mmap.c"
	"path.c"
	"perfhash.c"
	"raa.c"
	"rbtree.c"
	"readnum.c"
	"realpath.c"
	"saa.c"
	"srcfile.c"
	"string.c"
	"strlist.c"
	"ver.c"
	"zerobuf.c")

set_target_properties("nasmlib" PROPERTIES OUTPUT_NAME "nasm")
