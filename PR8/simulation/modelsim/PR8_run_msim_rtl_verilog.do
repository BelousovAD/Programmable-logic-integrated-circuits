transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/My_works/4_year/PLIS/PR8 {C:/My_works/4_year/PLIS/PR8/PR8.v}

