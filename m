From: Bo Hansen <bh@newtec.dk>
Subject: Re: kernel oops 2.6.31-rc6-rt2
Date: Tue, 18 Aug 2009 16:17:24 +0200
Message-ID: <4A8AB7F4.5020803@newtec.dk>
References: <4A891FE0.6070803@newtec.dk> <20090818130359.GA9911@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080502020701000503050709"
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [80.160.77.114] ([80.160.77.114]:37941 "EHLO pasmtpA.tele.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbZHRORb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Aug 2009 10:17:31 -0400
In-Reply-To: <20090818130359.GA9911@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080502020701000503050709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe,

I have attached the complete dmesg output from booting 2.6.31-rc6-rt2 
kernel.

Thanks for taking a look at it.

Best regards,
Bo




Uwe Kleine-König wrote:
> Hello,
>
> On Mon, Aug 17, 2009 at 11:16:16AM +0200, Bo Hansen wrote:
>   
>> Hello,
>>
>> I am running the latest release on a AT91RM9200 based board. I get the  
>> following during bootup:
>>     
> Can you provide a full kernel log.  Your's started shortly after the
> interesting part ...
>
> Best regards
> Uwe
>
>   

--------------080502020701000503050709
Content-Type: text/plain;
 name="180809_kernel_oops_2.6.31-rc6-rt2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="180809_kernel_oops_2.6.31-rc6-rt2.txt"

Linux version 2.6.31-rc6-rt2 (bo@bo-workstation) (gcc version 4.1.2) #1 PREEMPT 
RT Mon Aug 17 08:52:02 CEST 2009
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
CPU: VIVT data cache, VIVT instruction cache
Machine: NEWTEC cpu777
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 16384
free_area_init_node: node 0, pgdat c032a398, node_mem_map c0344000
  Normal zone: 128 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 16256 pages, LIFO batch:3
Clocks: CPU 179 MHz, master 59 MHz, main 18.432 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: mem=64M console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.
0.120:/home/bo/rt_linux/ptxcpu777/platform-cpu777/root ip=:192.168.0.103:192.168
.0.254:255.255.255.0:::dhcp
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 61560KB available (2872K code, 216K data, 112K init, 0K highmem)
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Preemptible RCU implementation.
NR_IRQS:192
AT91: 96 gpio irqs in 3 banks
Console: colour dummy device 80x30
console [ttyS0] enabled
Calibrating delay loop... 89.79 BogoMIPS (lpj=350208)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
i2c-core: driver [dummy] registered
cpu777_board_initCPU777: ds1743 rtc detected
tcb_clksrc: tc0 at 7.988 MHz
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 3, 57344 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
io scheduler noop registered (default)
io scheduler deadline registered
atmel_usart.0: ttyS0 at MMIO 0xfefff200 (irq = 1) is a ATMEL_SERIAL
atmel_usart.1: ttyS1 at MMIO 0xfffc0000 (irq = 6) is a ATMEL_SERIAL
atmel_usart.2: ttyS2 at MMIO 0xfffcc000 (irq = 9) is a ATMEL_SERIAL
atmel_usart.3: ttyS3 at MMIO 0xfffc4000 (irq = 7) is a ATMEL_SERIAL
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
dm9000 Ethernet Driver, V1.31
eth0: Link now 100-FullDuplex
eth0: AT91 ethernet at 0xfefbc000 int=24 100-FullDuplex (00:50:c2:7d:71:83)
eth0: Davicom 9161 PHY (Copper)
physmap platform flash device: 00800000 at 10000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0041
physmap-flash.0: Swapping erase regions for broken CFI table.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
atmel_spi atmel_spi.0: Atmel SPI Controller at 0xfffe0000 (irq 13)
atmel_spi atmel_spi.0: can't setup spi0.1, status -22
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 23, io mem 0x00300000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
rtc-ds1742 rtc-ds1742.0: rtc core: registered rtc-ds1742 as rtc0
i2c /dev entries driver
i2c-core: driver [dev_driver] registered
at91_mci at91_mci: 4 wire bus mode not supported - using 1 wire
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
rtc-ds1742 rtc-ds1742.0: setting system clock to 2009-08-18 16:07:20 UTC (125061
1640)
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.31-rc6-rt2 #1)
PC is at __wake_up_common+0x30/0x88
LR is at __wake_up+0x3c/0x4c
pc : [<c002f420>]    lr : [<c00306e0>]    psr: 00000013
sp : c384bf48  ip : fffffff4  fp : c384bf74
r10: 00000006  r9 : 00000000  r8 : c0313e38
r7 : 00000001  r6 : 00000001  r5 : 00000001  r4 : 00000006
r3 : 00000001  r2 : 00000001  r1 : 00000006  r0 : c0313e38
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: c000717f  Table: 20004000  DAC: 00000017
Process irq/100-eth0 (pid: 253, stack limit = 0xc384a270)
Stack: (0xc384bf48 to 0xc384c000)
bf40:                   00000001 00000006 00000001 c0313e20 00000000 00000000 
bf60: 00000000 00000000 c384bf9c c384bf78 c00306e0 c002f400 00000000 c384a000 
bf80: c384bfa4 c0313ddc c384a000 c387bba0 00000000 c384bfa0 c00640a0 c00306b4 
bfa0: c024ffb4 00000032 c3821e30 c3821e30 c387bba0 c0063f7c 00000000 c004b810 
bfc0: 00000000 00000000 c384bfc8 c384bfc8 c384bfd0 c384bfd0 00000000 00000000 
bfe0: c384bfe0 c384bfe0 00000000 00000000 00000000 c00257a0 33cc33cc 33cc33cc 
[<c002f420>] (__wake_up_common+0x30/0x88) from [<c00306e0>] (__wake_up+0x3c/0x4c
)
[<c00306e0>] (__wake_up+0x3c/0x4c) from [<c00640a0>] (irq_thread+0x124/0x1ac)
[<c00640a0>] (irq_thread+0x124/0x1ac) from [<c004b810>] (kthread+0x7c/0x84)
[<c004b810>] (kthread+0x7c/0x84) from [<c00257a0>] (kernel_thread_exit+0x0/0x8)
Code: e1a0a001 e1a08000 e1a06002 e59b9004 (e59c300c) 
---[ end trace 1c5395b9b5078579 ]---
exiting task "irq/100-eth0" (253) is an active IRQ thread (irq 0)
eth0: Link now 100-FullDuplex
Sending DHCP requests .., OK
IP-Config: Got DHCP answer from 192.168.0.103, my address is 192.168.0.214
IP-Config: Complete:
     device=eth0, addr=192.168.0.214, mask=255.255.255.0, gw=192.168.0.254,
     host=192.168.0.214, domain=newtec, nis-domain=(none),
     bootserver=192.168.0.103, rootserver=192.168.0.120, rootpath=/home/bo/rt_li
nux/ptxcpu777/platform-cpu777/root
Looking up port of RPC 100003/2 on 192.168.0.120
Looking up port of RPC 100005/1 on 192.168.0.120
VFS: Mounted root (nfs filesystem) on device 0:13.
Freeing init memory: 112K


--------------080502020701000503050709--
