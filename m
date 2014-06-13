From: jordan <triplesquarednine@gmail.com>
Subject: Re: 3.14.3-rt5: at91: Crash early at boot
Date: Fri, 13 Jun 2014 10:48:05 -0400
Message-ID: <CAOcfFMw9e3_=Yz0jyU7HdYx4Kod=9-X5T9JPNcUjoVC4jBtS9Q@mail.gmail.com>
References: <20140613142506.GL3448@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:54348 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaFMOsH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jun 2014 10:48:07 -0400
Received: by mail-vc0-f177.google.com with SMTP id ij19so2359859vcb.36
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Jun 2014 07:48:05 -0700 (PDT)
In-Reply-To: <20140613142506.GL3448@lukather>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Maxim,

You may be one of the people affected by some upstream RT changes
[dating back to 3.12-rt] that causes linux-rt to fail to boot on some
H/W.

I myself, am affected, i know of lots of AMD users and the some ARM
h/w that doesn't boot, without reverting a couple of these changes.
[as noted here;
http://www.spinics.net/lists/linux-rt-users/msg11655.html]... You
could try this patch; http://pastebin.com/jb4tuNna - which is applied
after the rt patchset ... This is how i have been able to use RT on my
machines for many RT releases now.

your problem may or may not be the same. but it's probably worth a try.

Jordan



On Fri, Jun 13, 2014 at 10:25 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hello everyone,
>
> I just gave the latest preempt-rt release for 3.14 a try on an ARM
> Atmel SAMA5D3 Xplained board, without any changes to the kernel but
> the preempt-rt patches obviously.
>
> The same non-rt version, with the same configuration (except for the
> preempt-rt related options), boot fine.
>
> And whenever I boot it, I get:
>
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 3.14.3-rt4+ (max@lukather) (gcc version 4.8.2 (Ubuntu/Linaro 4.8.2-16ubuntu4) ) #11 PREEMPT Fri Jun 13 16:03:53 CEST 2014
> CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7), cr=10c53c7d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: SAMA5D3 Xplained
> bootconsole [earlycon0] enabled
> Memory policy: Data cache writeback
> AT91: Detected soc type: sama5d3
> AT91: Detected soc subtype: sama5d36
> AT91: sram at 0x300000 of 0x20000 mapped at 0xfef58000
> CPU: All CPU(s) started in SVC mode.
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line: console=ttyS0,115200 earlyprintk mtdparts=atmel_nand:256k(at91bootstrap),512k(uboot),256k(env),256k(env-backup),128k(dtb),5m(kernel),2m(rootfs)ro,-(data) root=/dev/nfs ip=dhcp nfsroot=192.168.0.40:/srv/nfs/sysdev rw
> PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 253432K/262144K available (4519K kernel code, 191K rwdata, 1292K rodata, 174K init, 120K bss, 8712K reserved)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
>     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>       .text : 0xc0008000 - 0xc05b51bc   (5813 kB)
>       .init : 0xc05b6000 - 0xc05e1984   ( 175 kB)
>       .data : 0xc05e2000 - 0xc0611f60   ( 192 kB)
>        .bss : 0xc0611f6c - 0xc06301bc   ( 121 kB)
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Preemptible hierarchical RCU implementation.
> NR_IRQS:16 nr_irqs:16 16
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.3-rt4+ #11
> task: c05ecb28 ti: c05e2000 task.ti: c05e2000
> PC is at wake_up_process+0x8/0x40
> LR is at kthread_create_on_node+0xb0/0x178
> pc : [<c003ece0>]    lr : [<c0036318>]    psr: 200001d3
> sp : c05e3ef0  ip : 00000017  fp : 00000000
> r10: 00000000  r9 : cf4024c0  r8 : ffffffff
> r7 : c004cd24  r6 : cf402500  r5 : c05e3f0c  r4 : 00000000
> r3 : c06147b0  r2 : 00000001  r1 : cf402554  r0 : 00000000
> Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c53c7d  Table: 20004059  DAC: 00000015
> Process swapper (pid: 0, stack limit = 0xc05e2240)
> Stack: (0xc05e3ef0 to 0xc05e4000)
> 3ee0:                                     c06147b0 cf402540 00000000 c0036318
> 3f00: 00000000 c004bd38 00000000 00000000 c05e3f10 c05e3f10 00000000 cf404c00
> 3f20: cf402500 c0318374 00000010 00000010 c004d474 c051dddc 00000010 c055c07c
> 3f40: 00000104 cf402500 cf404c00 c0318374 00000080 00000010 cf4024c0 c004d808
> 3f60: cfdf3ca4 c047cefc fefffc00 00000010 cf4024c0 cfffc240 00000000 c05d00ac
> 3f80: c055c07c cf4024c0 cfdf3ca4 c05e08a0 ffffffff c05ea000 c05daab8 c05cfecc
> 3fa0: c05ea000 c05e0a28 c05ea000 c0611f80 c05ea000 c05bd9d0 c05d9950 c05b6924
> 3fc0: ffffffff ffffffff c05b64ec 00000000 00000000 c05daab8 00000000 10c53c7d
> 3fe0: c05ea01c c05daab4 c05edbd8 20004059 410fc051 20008070 00000000 00000000
> Code: e3a05001 eaffffcd e92d4818 e1a04000 (e5903000)
> ---[ end trace 3406ff24bd97382e ]---
> Kernel panic - not syncing: Attempted to kill the idle task!
>
> Do you know what could be the cause of this, or is this any known issue?
>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
