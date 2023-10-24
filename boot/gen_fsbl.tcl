set hwdsgn [open_hw_design vcu_trd_wrapper.hdf]
generate_app -hw $hwdsgn -os standalone -proc psu_cortexa53_0 -app zynqmp_fsbl -compile -sw fsbl -dir fsbl
quit
