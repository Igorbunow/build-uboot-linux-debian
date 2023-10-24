setws fsb_pmu
# Create the platform
platform create -name ultra96v2_custom_platform \
    -hw zcu102 -no-boot-bsp
platform active ultra96v2_custom_platform

# Create the FSBL Domain
domain create -name "fsbl_domain" \
    -os standalone -proc psu_cortexa53_0
bsp setlib xilffs
bsp setlib xilsecure
bsp setlib xilpm
#bsp config stdin psu_uart_1
#bsp config stdout psu_uart_1
bsp config zynqmp_fsbl_bsp true

# Create the PMU FW Domain
domain create -name "pmufw_domain" \
    -os standalone -proc psu_pmu_0
bsp setlib xilfpga
bsp setlib xilsecure
bsp setlib xilskey
#bsp config stdin psu_uart_1
#bsp config stdout psu_uart_1

# Generate the platform
platform generate

# Create the applications
app create -name zynqmp_fsbl -template {Zynq MP FSBL} \
    -platform ultra96v2_custom_platform \
    -domain fsbl_domain -sysproj ultra96v2_custom_system
app create -name zynqmp_pmufw -template {ZynqMP PMU Firmware} \
    -platform ultra96v2_custom_platform \
    -domain pmufw_domain -sysproj ultra96v2_custom_system

# Configure the applications
app config -name zynqmp_fsbl build-config release
app config -name zynqmp_pmufw build-config release

# Build the applications
app build -name zynqmp_fsbl
app build -name zynqmp_pmufw
