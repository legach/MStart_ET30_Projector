#-------------USB Upgrade Bin Info----------------
# Device : bennet
# Build PATH : /home/chenjh/Mstar/358/CR/1080p/c_cn_348_sz_dvb_an_marshmallow_cus-cus
# Build TIME : 2020-12-17 19:17:35

# File Partition: set_partition
mmc slc 0 1
mmc rmgpt
mmc create misc 0x00080000
mmc create recovery 0x01900000
mmc create boot 0x01400000
mmc create optee 0x00600000
mmc create armfw 0x00010000
mmc create RTPM 0x00040000
mmc create dtb 0x00100000
mmc create system 0x51400000
mmc create userdata 0xFF000000
mmc create cache 0x40000000
mmc create tvservice 0x0A000000
mmc create tvconfig 0x00B00000
mmc create tvdatabase 0x00800000
mmc create tvcustomer 0x01000000
mmc create tvcertificate 0x00800000

# File Partition: mboot
filepartload 0x30200000 $(UpgradeImage) 0x4000 0x12000
mmc write.boot 1 0x30200000 0 0x12000
filepartload 0x30200000 $(UpgradeImage) 0x16000 0x183c00
mmc write.p 0x30200000 MBOOT 0x183C00

# File Partition: recovery
filepartload 0x30200000 $(UpgradeImage) 0x19a000 0x11cb036
mmc erase.p misc
mmc erase.p recovery
mmc write.p 0x30200000 recovery 0x11CB036 1
setenv recoverycmd mmc read.p 0x23000000 dtb 0x00100000\; mmc read.p 0x24D00000 recovery 0x01900000\; bootm 0x24D00000
saveenv

# File Partition: boot
filepartload 0x30200000 $(UpgradeImage) 0x1366000 0xe3b0f1
mmc erase.p boot
mmc write.p 0x30200000 boot 0xE3B0F1 1
setenv bootcmd mmc read.p 0x23000000 dtb 0x00100000\; mmc read.p 0x24D00000 boot 0x01400000\; bootm 0x24D00000
saveenv

# File Partition: optee
filepartload 0x30200000 $(UpgradeImage) 0x21a2000 0x191440
mmc erase.p optee
mmc write.p 0x30200000 optee 0x191440

# File Partition: armfw
filepartload 0x30200000 $(UpgradeImage) 0x2334000 0x9270
mmc erase.p armfw
mmc write.p 0x30200000 armfw 0x9270

# File Partition: RT_PM
filepartload 0x30200000 $(UpgradeImage) 0x233e000 0x10000
mmc erase.p RTPM
mmc write.p 0x30200000 RTPM 0x10000 1

# File Partition: dtb
filepartload 0x30200000 $(UpgradeImage) 0x234e000 0xa71
mmc erase.p dtb
mmc write.p 0x30200000 dtb 0xA71 1

# File Partition: system
mmc erase.p system
filepartload 0x30200000 $(UpgradeImage) 0x234f000 0x4b18bb0
mmc unlzo 0x30200000 0x4B18BB0 system 1
filepartload 0x30200000 $(UpgradeImage) 0x6e68000 0x69454d0
mmc unlzo.cont 0x30200000 0x69454D0 system 1
filepartload 0x30200000 $(UpgradeImage) 0xd7ae000 0x698b7b3
mmc unlzo.cont 0x30200000 0x698B7B3 system 1
filepartload 0x30200000 $(UpgradeImage) 0x1413a000 0x73ae30e
mmc unlzo.cont 0x30200000 0x73AE30E system 1
filepartload 0x30200000 $(UpgradeImage) 0x1b4e9000 0xd0ddfd
mmc unlzo.cont 0x30200000 0xD0DDFD system 1
filepartload 0x30200000 $(UpgradeImage) 0x1c1f7000 0xafcb6
mmc unlzo.cont 0x30200000 0xAFCB6 system 1
filepartload 0x30200000 $(UpgradeImage) 0x1c2a7000 0xafcb6
mmc unlzo.cont 0x30200000 0xAFCB6 system 1
filepartload 0x30200000 $(UpgradeImage) 0x1c357000 0xafcb6
mmc unlzo.cont 0x30200000 0xAFCB6 system 1
filepartload 0x30200000 $(UpgradeImage) 0x1c407000 0x75336
mmc unlzo.cont 0x30200000 0x75336 system 1

# File Partition: userdata
filepartload 0x30200000 $(UpgradeImage) 0x1c47d000 0x12f0759
mmc erase.p userdata
mmc unlzo 0x30200000 0x12F0759 userdata 1

# File Partition: cache
filepartload 0x30200000 $(UpgradeImage) 0x1d76e000 0x4b07a2
mmc erase.p cache
mmc unlzo 0x30200000 0x4B07A2 cache 1

# File Partition: tvservice
filepartload 0x30200000 $(UpgradeImage) 0x1dc1f000 0x4500000
mmc erase.p tvservice
mmc write.p 0x30200000 tvservice 0x4500000 1

# File Partition: tvconfig
filepartload 0x30200000 $(UpgradeImage) 0x2211f000 0xa00000
mmc erase.p tvconfig
mmc write.p 0x30200000 tvconfig 0xA00000 1

# File Partition: tvdatabase
filepartload 0x30200000 $(UpgradeImage) 0x22b1f000 0x800000
mmc erase.p tvdatabase
mmc write.p 0x30200000 tvdatabase 0x800000 1

# File Partition: tvcustomer
filepartload 0x30200000 $(UpgradeImage) 0x2331f000 0x1000000
mmc erase.p tvcustomer
mmc write.p 0x30200000 tvcustomer 0x1000000 1

# File Partition: tvcertificate
filepartload 0x30200000 $(UpgradeImage) 0x2431f000 0x800000
mmc erase.p tvcertificate
mmc write.p 0x30200000 tvcertificate 0x800000 1

# File Partition: set_config
setenv bootargs console
saveenv
setenv bootargs console=ttyS0,115200 androidboot.console=ttyS0 root=/dev/ram rw rootwait init=/init CORE_DUMP_PATH=/data/core_dump.%%p.gz KDebug=1 delaylogo=true androidboot.selinux=permissive SDIO_CONFIG=1 SAR5=ON str_ignore_wakelock
setenv bootlogo_gopidx 2
setenv bootlogo_buffer E_MMAP_ID_BOOTLOGO_BUFFER
setenv str_crc 2
setenv db_table 0
setenv verify n
setenv mboot_default_env 0
setenv sync_mmap 1
saveenv
setenv MstarUpgrade_complete 1
setenv sync_mmap 1
setenv db_table 0
saveenv
printenv
