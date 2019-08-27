Return-Path: <SRS0=YHoI=WX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE92C3A5A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 12:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C40206BF
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 12:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfH0Mea (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:34:30 -0400
Received: from mail.thorsis.com ([92.198.35.195]:43042 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfH0Me3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Aug 2019 08:34:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 8C7FF474B;
        Tue, 27 Aug 2019 14:35:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QmVT4IKBCdHy; Tue, 27 Aug 2019 14:35:33 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 05EF84EEC; Tue, 27 Aug 2019 14:35:30 +0200 (CEST)
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.10-rt5
Date:   Tue, 27 Aug 2019 14:34:19 +0200
Message-ID: <1775495.KgcFvHdtex@ada>
In-Reply-To: <20190827105542.qxvtteirkh55i5ly@linutronix.de>
References: <20190827105542.qxvtteirkh55i5ly@linutronix.de>
Content-Type: multipart/mixed; boundary="nextPart6453163.GZLFrfenIk"
Content-Transfer-Encoding: 7Bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart6453163.GZLFrfenIk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello Sebastian,

Am Dienstag, 27. August 2019, 12:55:42 CEST schrieb Sebastian Andrzej Siewior:
> I'm pleased to announce the v5.2.10-rt5 patch set.
> 
> Changes since v5.2.10-rt4:
> 
>   - Take care of compile issue within the timer-atmel-tcb driver on
>     AT91. Reported by Alexander Dahl, patched by Alexandre Belloni.
> 
>   - Fixes to the hrtimer code to finally avoiding warnings while
>     canceling a running hrtimer in IRQ context. Patches by Julien Grall.

This causes build errors on my side now, I tested with the .config we use on 
our custom tree on a tag "v5.2.10-rt5-rebase", cross-compiling with gcc 7.3.1 
for ARCH=arm:


% LANG=C PATH=/opt/OSELAS.Toolchain-2018.02.0/arm-v7a-linux-gnueabihf/
gcc-7.3.1-glibc-2.27-binutils-2.30-kernel-4.15-sanitized/bin:${PATH} 
HOSTCC=gcc CROSS_COMPILE=arm-v7a-linux-gnueabihf- ARCH=arm make              
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  CHK     include/generated/compile.h
  CC      kernel/time/hrtimer.o
kernel/time/hrtimer.c: In function 'hrtimer_grab_expiry_lock':
kernel/time/hrtimer.c:937:33: error: 'migration_base' undeclared (first use in 
this function); did you mean 'migrate_mode'?
  if (timer->is_soft && base != &migration_base) {
                                 ^~~~~~~~~~~~~~
                                 migrate_mode
kernel/time/hrtimer.c:937:33: note: each undeclared identifier is reported 
only once for each function it appears in
scripts/Makefile.build:278: recipe for target 'kernel/time/hrtimer.o' failed
make[2]: *** [kernel/time/hrtimer.o] Error 1
scripts/Makefile.build:489: recipe for target 'kernel/time' failed
make[1]: *** [kernel/time] Error 2
Makefile:1073: recipe for target 'kernel' failed
make: *** [kernel] Error 2


I did savedefconfig and attached the result.

Greets
Alex

--nextPart6453163.GZLFrfenIk
Content-Disposition: attachment; filename="defconfig"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="defconfig"

# CONFIG_LOCALVERSION_AUTO is not set
# CONFIG_SWAP is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT_RT_FULL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_EMBEDDED=y
# CONFIG_SLUB_DEBUG is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_ARCH_AT91=y
CONFIG_SOC_SAMA5D2=y
# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
# CONFIG_ARM_MODULE_PLTS is not set
CONFIG_UACCESS_WITH_MEMCPY=y
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_ARM_APPENDED_DTB=y
CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
CONFIG_VFP=y
CONFIG_NEON=y
# CONFIG_SUSPEND is not set
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
CONFIG_INET=y
CONFIG_INET_UDP_DIAG=y
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set
# CONFIG_NF_CONNTRACK_PROCFS is not set
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_IRC is not set
# CONFIG_NF_CONNTRACK_SIP is not set
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_SET=m
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=m
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_HASH=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_TPROXY=m
# CONFIG_NETFILTER_XTABLES is not set
CONFIG_NF_TABLES_IPV4=y
CONFIG_NF_TABLES_ARP=y
# CONFIG_IP_NF_IPTABLES is not set
CONFIG_VLAN_8021Q=m
# CONFIG_WIRELESS is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_FW_LOADER is not set
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_RAW_NAND=y
CONFIG_MTD_NAND_ECC_SW_BCH=y
CONFIG_MTD_NAND_ATMEL=y
CONFIG_MTD_UBI=y
CONFIG_ATMEL_TCLIB=y
CONFIG_ATMEL_SSC=y
CONFIG_SRAM=y
CONFIG_EEPROM_AT25=m
CONFIG_NETDEVICES=y
# CONFIG_NET_CORE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_MACB=m
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CIRRUS is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_FARADAY is not set
# CONFIG_NET_VENDOR_HISILICON is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_SMSC_PHY=m
# CONFIG_WLAN is not set
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_KEYBOARD_ATKBD is not set
CONFIG_KEYBOARD_GPIO=y
# CONFIG_INPUT_MOUSE is not set
# CONFIG_SERIO is not set
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_ATMEL=y
CONFIG_SERIAL_ATMEL_CONSOLE=y
CONFIG_HW_RANDOM=y
CONFIG_I2C=m
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_AT91=m
CONFIG_I2C_GPIO=m
CONFIG_SPI=y
CONFIG_SPI_ATMEL=m
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PINCTRL_AT91=y
CONFIG_GPIO_SYSFS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AT91_POWEROFF=m
CONFIG_POWER_RESET_AT91_RESET=m
CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC=m
CONFIG_SENSORS_LM75=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_AT91SAM9X_WATCHDOG=m
CONFIG_SAMA5D4_WATCHDOG=m
CONFIG_MFD_ATMEL_FLEXCOM=m
CONFIG_REGULATOR=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# CONFIG_HID is not set
# CONFIG_USB_SUPPORT is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_AT91RM9200=y
CONFIG_RTC_DRV_AT91SAM9=y
CONFIG_DMADEVICES=y
CONFIG_AT_HDMAC=y
CONFIG_AT_XDMAC=y
CONFIG_UIO=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_VIRTIO_MENU is not set
# CONFIG_IOMMU_SUPPORT is not set
CONFIG_PWM=y
CONFIG_PWM_ATMEL=m
CONFIG_FANOTIFY=y
CONFIG_TMPFS=y
CONFIG_CONFIGFS_FS=y
CONFIG_UBIFS_FS=y
# CONFIG_UBIFS_FS_SECURITY is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_DEV_ATMEL_AES=y
CONFIG_CRYPTO_DEV_ATMEL_TDES=y
CONFIG_CRYPTO_DEV_ATMEL_SHA=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
CONFIG_CRC_CCITT=m
CONFIG_CRC_ITU_T=m
CONFIG_XZ_DEC=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DEBUG_INFO=y
CONFIG_GDB_SCRIPTS=y
CONFIG_STRIP_ASM_SYMS=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_SCHED_DEBUG is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_FTRACE is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_STRICT_DEVMEM=y
CONFIG_DEBUG_LL=y
CONFIG_EARLY_PRINTK=y

--nextPart6453163.GZLFrfenIk--

