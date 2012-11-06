From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: scheduler clock for MXS [Was: Re: Wakeup latency measured with
	SCHED_TRACER depends on HZ]
Date: Tue, 6 Nov 2012 10:12:29 +0000
Message-ID: <20121106101229.GN28327@n2100.arm.linux.org.uk>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org> <20121105025753.GA26528@S2100-06.ap.freescale.net> <50978370.9060001@meduna.org> <20121105134655.GB27260@S2100-06.ap.freescale.net> <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk> <20121106024052.GA27643@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37447 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2KFKNv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Nov 2012 05:13:51 -0500
Content-Disposition: inline
In-Reply-To: <20121106024052.GA27643@S2100-06.ap.freescale.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 06, 2012 at 10:40:54AM +0800, Shawn Guo wrote:
> Here is the boot log on my imx23 board after applying both Stanislav's
> and Katsuki's patches.
> 
> [    0.000000] Booting Linux on physical CPU 0
> [    0.000000] Linux version 3.7.0-rc1-00012-ga31941d (r65073@S2101-09) (gcc ver
> sion 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #756 Tue Nov 6 10:04:30 CST 2012
> [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine: Freescale i.MX23 (Device Tree), model: Freescale i.MX23
> Evaluation Kit
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] On node 0 totalpages: 32768
> [    0.000000] free_area_init_node: node 0, pgdat c051ada8, node_mem_map c0a7000
> 0
> [    0.000000]   Normal zone: 256 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 32512 pages, LIFO batch:7
> [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> [    0.000000] pcpu-alloc: [0] 0
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pag
> es: 32512
> [    0.000000] Kernel command line: console=ttyAMA0,115200 debug earlyprintk roo
> t=/dev/mmcblk0p3 rw rootwait no_console_suspend
> [    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.000000] Memory: 128MB = 128MB total
> [    0.000000] Memory: 119200k/119200k available, 11872k reserved, 0K highmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc04bf150   (4829 kB)
> [    0.000000]       .init : 0xc04c0000 - 0xc04e29cc   ( 139 kB)
> [    0.000000]       .data : 0xc04e4000 - 0xc051d5c0   ( 230 kB)
> [    0.000000]        .bss : 0xc051d5e4 - 0xc0a6ce38   (5439 kB)
> [    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, N
> odes=1
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] of_irq_init: children remain, but no parents
> [    0.000000] sched_clock: 16 bits at 32kHz, resolution 31250ns, wraps every 20
> 47ms

So where are you setting this up?  My guess is it's after time_init()
has done its stuff.
