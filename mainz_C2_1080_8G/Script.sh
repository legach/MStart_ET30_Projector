# Start auto_update.txt parsing

# File Partition: set_partition
mmc slc 0 1
mmc rmgpt
mmc create misc 0x00080000
mmc create license 0x00A00000
mmc create recovery 0x01900000
mmc create boot 0x01400000
mmc create optee 0x00600000
mmc create armfw 0x00010000
mmc create RTPM 0x00040000
mmc create dtb 0x00100000
mmc create system 0x60000000
mmc create userdata 0x120000000
mmc create cache 0x40000000
mmc create tvservice 0x09600000
mmc create tvconfig 0x00A00000
mmc create tvdatabase 0x00800000
mmc create tvcustomer 0x01000000
mmc create tvcertificate 0x00800000

# File Partition: mboot
filepartload 0x30200000 $(UpgradeImage) 0x4000 0x12000
mmc write.boot 1 0x30200000 0 0x12000
filepartload 0x30200000 $(UpgradeImage) 0x16000 0x1bf800
mmc write.p 0x30200000 MBOOT 0x1BF800

# File Partition: recovery
filepartload 0x30200000 $(UpgradeImage) 0x1d6000 0x11b79e1
mmc erase.p misc
mmc erase.p recovery
mmc write.p 0x30200000 recovery 0x11B79E1 1
setenv recoverycmd mmc read.p 0x23000000 dtb 0x00100000\; mmc read.p 0x24D00000 recovery 0x01900000\; bootm 0x24D00000
saveenv

# File Partition: boot
filepartload 0x30200000 $(UpgradeImage) 0x138e000 0xe2d65a
mmc erase.p boot
mmc write.p 0x30200000 boot 0xE2D65A 1
setenv bootcmd mmc read.p 0x23000000 dtb 0x00100000\; mmc read.p 0x24D00000 boot 0x01400000\; bootm 0x24D00000
saveenv

# File Partition: optee
filepartload 0x30200000 $(UpgradeImage) 0x21bc000 0x18ad80
mmc erase.p optee
mmc write.p 0x30200000 optee 0x18AD80

# File Partition: armfw
filepartload 0x30200000 $(UpgradeImage) 0x2347000 0x9270
mmc erase.p armfw
mmc write.p 0x30200000 armfw 0x9270

# File Partition: RT_PM
filepartload 0x30200000 $(UpgradeImage) 0x2351000 0x10000
mmc erase.p RTPM
mmc write.p 0x30200000 RTPM 0x10000 1

# File Partition: dtb
filepartload 0x30200000 $(UpgradeImage) 0x2361000 0xa71
mmc erase.p dtb
mmc write.p 0x30200000 dtb 0xA71 1

# File Partition: system
mmc erase.p system
filepartload 0x30200000 $(UpgradeImage) 0x2362000 0x49fe4d3
mmc unlzo 0x30200000 0x49FE4D3 system 1
filepartload 0x30200000 $(UpgradeImage) 0x6d61000 0x8b6ad28
mmc unlzo.cont 0x30200000 0x8B6AD28 system 1
filepartload 0x30200000 $(UpgradeImage) 0xf8cc000 0x8723d5c
mmc unlzo.cont 0x30200000 0x8723D5C system 1
filepartload 0x30200000 $(UpgradeImage) 0x17ff0000 0x6d9cc8a
mmc unlzo.cont 0x30200000 0x6D9CC8A system 1
filepartload 0x30200000 $(UpgradeImage) 0x1ed8d000 0x5bc3f21
mmc unlzo.cont 0x30200000 0x5BC3F21 system 1
filepartload 0x30200000 $(UpgradeImage) 0x24951000 0x36baa00
mmc unlzo.cont 0x30200000 0x36BAA00 system 1
filepartload 0x30200000 $(UpgradeImage) 0x2800c000 0xafcb6
mmc unlzo.cont 0x30200000 0xAFCB6 system 1
filepartload 0x30200000 $(UpgradeImage) 0x280bc000 0xafcb6
mmc unlzo.cont 0x30200000 0xAFCB6 system 1
filepartload 0x30200000 $(UpgradeImage) 0x2816c000 0xafcb6
mmc unlzo.cont 0x30200000 0xAFCB6 system 1
filepartload 0x30200000 $(UpgradeImage) 0x2821c000 0xafcb6
mmc unlzo.cont 0x30200000 0xAFCB6 system 1
filepartload 0x30200000 $(UpgradeImage) 0x282cc000 0x2a336
mmc unlzo.cont 0x30200000 0x2A336 system 1

# File Partition: userdata
filepartload 0x30200000 $(UpgradeImage) 0x282f7000 0x155c81d
mmc erase.p userdata
mmc unlzo 0x30200000 0x155C81D userdata 1

# File Partition: cache
filepartload 0x30200000 $(UpgradeImage) 0x29854000 0x4b07a2
mmc erase.p cache
mmc unlzo 0x30200000 0x4B07A2 cache 1

# File Partition: tvservice
filepartload 0x30200000 $(UpgradeImage) 0x29d05000 0x4500000
mmc erase.p tvservice
mmc write.p 0x30200000 tvservice 0x4500000 1

# File Partition: tvconfig
filepartload 0x30200000 $(UpgradeImage) 0x2e205000 0xa00000
mmc erase.p tvconfig
mmc write.p 0x30200000 tvconfig 0xA00000 1

# File Partition: tvdatabase
filepartload 0x30200000 $(UpgradeImage) 0x2ec05000 0x800000
mmc erase.p tvdatabase
mmc write.p 0x30200000 tvdatabase 0x800000 1

# File Partition: tvcustomer
filepartload 0x30200000 $(UpgradeImage) 0x2f405000 0x1000000
mmc erase.p tvcustomer
mmc write.p 0x30200000 tvcustomer 0x1000000 1

# File Partition: tvcertificate
filepartload 0x30200000 $(UpgradeImage) 0x30405000 0x800000
mmc erase.p tvcertificate
mmc write.p 0x30200000 tvcertificate 0x800000 1

# File Partition: set_config
setenv bootargs console
saveenv
setenv bootargs console=ttyS0,115200 androidboot.console=ttyS0 root=/dev/ram rw rootwait init=/init CORE_DUMP_PATH=/data/core_dump.%%p.gz KDebug=1 delaylogo=true androidboot.selinux=permissive SDIO_CONFIG=1 SAR5=ON str_ignore_wakelock
setenv bootlogo_gopidx 2
setenv bootlogo_buffer E_MMAP_ID_BOOTLOGO_BUFFER
setenv no_compare_uboot 1
setenv str_crc 1
setenv db_table 0
setenv verify n
setenv sync_mmap 1
setenv display_logo on
setenv play_music off
setenv UARTOnOff off
setenv factory_poweron_mode secondary
setenv spi_mirror_mode 1
setenv enable_tcon_panel 0
setenv pTconPanelEnv 0
saveenv
setenv MstarUpgrade_complete 1
setenv sync_mmap 1
setenv db_table 0
setenv ForceUpgradePath mainz_C2_1080_8G.bin
saveenv
printenv
