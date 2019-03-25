Return-Path: <SRS0=5pzl=R4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D69EC4360F
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Mar 2019 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA7520870
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Mar 2019 10:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfCYKSo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:18:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44834 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbfCYKSn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Mar 2019 06:18:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C52A1596;
        Mon, 25 Mar 2019 03:18:41 -0700 (PDT)
Received: from [10.37.9.236] (unknown [10.37.9.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ABCD3F575;
        Mon, 25 Mar 2019 03:18:38 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.0.3-rt1
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave P Martin <Dave.Martin@arm.com>
References: <20190320171511.icjhdlulgal2yeho@linutronix.de>
 <791056c4-3575-0bd8-031e-44d0e3b21e54@arm.com> <87tvfrs76z.fsf@linutronix.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <3cb3c190-e804-982a-1c5b-8545a97379b9@arm.com>
Date:   Mon, 25 Mar 2019 10:18:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87tvfrs76z.fsf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

Thank you for your answer.

On 3/25/19 8:13 AM, John Ogness wrote:
> On 2019-03-22, Julien Grall <julien.grall@arm.com> wrote:
>> Apologies for a possible stupid question.
> 
> It's an important question because the behavior of console printing has
> changed. (Or, rather, is in the process of being changed. Depending on
> complaints/approval, it may change some more.)
> 
>> On 20/03/2019 17:15, Sebastian Andrzej Siewior wrote:
>>>     - Applied John Ogness' prinkt rework. One visible change is the
>>>       output during boot. Under the hood and for RT: By default, output
>>>       that is created at KERN_WARN[0] or higher is printed immediately if the
>>>       console supports "atomic" print (currently the 8250 driver does).
>>>       This output is printed immediately (and visible) even from IRQ-off
>>>       or preempt-disabled regions which wasn't the case earlier. This will
>>>       raise the latency at run-time *but* there should be no WARNING,
>>>       ERROR or PANIC messages at run-time on a fully working system.
>>>       Messages with lower severity are printed "later" by a kthread.
>>
>> Using 5.0.3-rt1, I get some warning message completely mangled with
>> the rest of the output (e.g systemd message) but also between
>> them. Some excerpt of a 500 lines lockdep warning (AFAICT the printk
>> is not related to the printk code):
>>
>> [   52.294547] 005: ... which became HARDIRQ-irq-unsafe at:
>> [   52.294553] 005: ...
>> [   52.294554] 005:   lock_acquire+0xf8/0x318
>> [  OK  ] Reached target
>> t_spin_lock+0x48/0x70  lock_acquire+0xf8/0x318
>> [0;1;39mRemote File Systems.[   52.294570] 005:   iommu_dma_map_msi_msg+0x5c/0x1
>>
>> [   52.296824] 005: CPU: 5 PID: 2108 Comm: ip Not tainted 5.0.3-rt1-00007-g42ede
>> 9a0fed6 #4312] 005:  __sys_sendmsg+0x68/0xb8
>>
>> I understand the new series add support for "atomic" print. So I am
>> wondering whether this issue is related to it? Is there any advice to
>> prevent the mangling?
> 
> The atomic print allows important messages to be print immediately
> (regardless of the context of the printer). This means that if any other
> context was already printing, it will be interrupted. This cannot be
> synchronized without causing significant scheduling delays.> 
> The atomic messages always do the interrupting and will continue to the
> end of the line. So it should be possible to piece the non-atomic
> messages back together. However, I am a bit confused by your output. Is
> it possible that I could see the full boot log?

I seem to have two issues. The first one is what you described above, the other
is what looks like spurious print. I have appended the full boot log below.

> 
> The main goal of the atomic messages is so that you never lose any
> important messages. To help readability, perhaps the atomic messages
> should begin with a '\n' as well?
This may partly help one of the problem I have seen. Now, it would be easier to
remove the lines we don't care. Interestingly the dmesg output does not contain any
mangling.

Cheers,

[    0.000000] 000: printk: bootconsole [pl11] enabled
[    0.000000] 000: efi: Getting EFI parameters from FDT:
[    0.000000] 000: efi: EFI v2.60 by EDK II
[    0.000000] 000: efi:
[    0.000000] 000:  SMBIOS=0xf8b80000
[    0.000000] 000:  SMBIOS 3.0=0xf8b60000
[    0.000000] 000:  ACPI 2.0=0xf8ba0000
[    0.000000] 000:  MEMATTR=0xfc10e018
[    0.000000] 000:  RNG=0xf86aff98
[    0.000000] 000:  MEMRESERVE=0xf86c4018
[    0.000000] 000:
[    0.000000] 000: efi: seeding entropy pool
[    0.000000] 000: cma: Reserved 32 MiB at 0x00000000fa000000
[    0.000000] 000: NUMA: No NUMA configuration found
[    0.000000] 000: NUMA: Faking a node at [mem 0x0000000080000000-0x00000009fff
fffff]
[    0.000000] 000: NUMA: NODE_DATA [mem 0x9fefda100-0x9fefdbfff]
[    0.000000] 000: Zone ranges:
[    0.000000] 000:   DMA32
[    0.000000] 000: [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000] 000:   Normal
[    0.000000] 000: [mem 0x0000000100000000-0x00000009ffffffff]
[    0.000000] 000: Movable zone start for each node
[    0.000000] 000: Early memory node ranges
[    0.000000] 000:   node   0: [mem 0x0000000080000000-0x00000000dfffffff]
[    0.000000] 000:   node   0: [mem 0x00000000e00f0000-0x00000000f869ffff]
[    0.000000] 000:   node   0: [mem 0x00000000f86a0000-0x00000000f86bffff]
[    0.000000] 000:   node   0: [mem 0x00000000f86c0000-0x00000000f86cbfff]
[    0.000000] 000:   node   0: [mem 0x00000000f86cc000-0x00000000f86cffff]
[    0.000000] 000:   node   0: [mem 0x00000000f86d0000-0x00000000f8a0ffff]
[    0.000000] 000:   node   0: [mem 0x00000000f8a10000-0x00000000f8b8ffff]
[    0.000000] 000:   node   0: [mem 0x00000000f8b90000-0x00000000f8baffff]
[    0.000000] 000:   node   0: [mem 0x00000000f8bb0000-0x00000000f8f4ffff]
[    0.000000] 000:   node   0: [mem 0x00000000f8f50000-0x00000000fdf6ffff]
[    0.000000] 000:   node   0: [mem 0x00000000fdf70000-0x00000000fdfbffff]
[    0.000000] 000:   node   0: [mem 0x00000000fdfc0000-0x00000000feffffff]
[    0.000000] 000:   node   0: [mem 0x0000000880000000-0x00000009ffffffff]
[    0.000000] 000: Zeroed struct page in unavailable ranges: 580 pages
[    0.000000] 000: Initmem setup node 0 [mem 0x0000000080000000-0x00000009fffff
fff]
[    0.000000] 000: On node 0 totalpages: 2092816
[    0.000000] 000:   DMA32 zone: 8192 pages used for memmap
[    0.000000] 000:   DMA32 zone: 0 pages reserved
[    0.000000] 000:   DMA32 zone: 519952 pages, LIFO batch:63
[    0.000000] 000:   Normal zone: 24576 pages used for memmap
[    0.000000] 000:   Normal zone: 1572864 pages, LIFO batch:63
[    0.000000] 000: psci: probing for conduit method from DT.
[    0.000000] 000: psci: PSCIv1.1 detected in firmware.
[    0.000000] 000: psci: Using standard PSCI v0.2 function IDs
[    0.000000] 000: psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] 000: psci: SMC Calling Convention v1.1
[    0.000000] 000: random: get_random_bytes called from start_kernel+0x98/0x47c
 with crng_init=0
[    0.000000] 000: percpu: Embedded 40 pages/cpu @ffff80097eee4000 s124880 r819
2 d30768 u163840
[    0.000000] 000: pcpu-alloc: s124880 r8192 d30768 u163840 alloc=40*4096
[    0.000000] 000:
[    0.000000] 000: pcpu-alloc:
[    0.000000] 000: [0]
[    0.000000] 000: 0
[    0.000000] 000: [0]
[    0.000000] 000: 1
[    0.000000] 000: [0]
[    0.000000] 000: 2
[    0.000000] 000: [0]
[    0.000000] 000: 3
[    0.000000] 000: [0]
[    0.000000] 000: 4
[    0.000000] 000: [0]
[    0.000000] 000: 5
[    0.000000] 000:
[    0.000000] 000: Detected VIPT I-cache on CPU0
[    0.000000] 000: CPU features: detected: ARM erratum 845719
[    0.000000] 000: CPU features: detected: ARM erratum 843419
[    0.000000] 000: Built 1 zonelists, mobility grouping on.  Total pages: 20600
48
[    0.000000] 000: Policy zone: Normal
[    0.000000] 000: Kernel command line: BOOT_IMAGE=/vmlinuz-perso root=/dev/map
per/juno2--julieng--vg-root ro loglvlinfo=all acpi=off earlycon=pl011,0x7ff80000
[    0.000000] 000: software IO TLB: mapped [mem 0xf219b000-0xf619b000] (64MB)
[    0.000000] 000: Memory: 8067344K/8371264K available (16828K kernel code, 417
8K rwdata, 6384K rodata, 1792K init, 12285K bss, 271152K reserved, 32768K cma-re
served)
[    0.000000] 000: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] 000: Running RCU self tests
[    0.000000] 000: rcu: Preemptible hierarchical RCU implementation.
[    0.000000] 000: rcu:        RCU event tracing is enabled.
[    0.000000] 000: rcu:        RCU lockdep checking is enabled.
[    0.000000] 000: rcu:        RCU restricting CPUs from NR_CPUS=64 to nr_cpu_i
ds=6.
[    0.000000] 000: rcu:        RCU priority boosting: priority 1 delay 500 ms.
[    0.000000] 000:     No expedited grace period (rcu_normal_after_boot).
[    0.000000] 000:     Tasks RCU enabled.
[    0.000000] 000: rcu: RCU calculated value of scheduler-enlistment delay is 2
5 jiffies.
[    0.000000] 000: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] 000: NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] 000: GIC: Using split EOI/Deactivate mode
[    0.000000] 000: GICv2m: range[mem 0x2c1c0000-0x2c1cffff], SPI[224:255]
[    0.000000] 000: GICv2m: range[mem 0x2c1d0000-0x2c1dffff], SPI[256:287]
[    0.000000] 000: GICv2m: range[mem 0x2c1e0000-0x2c1effff], SPI[288:319]
[    0.000000] 000: GICv2m: range[mem 0x2c1f0000-0x2c1fffff], SPI[320:351]
[    0.000000] 000: clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xfffff
fff, max_idle_ns: 1911260446275 ns
[    0.000002] 000: sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps ev
ery 2147483647500ns
[    0.009090] 000: Failed to initialize '/smb@8000000/motherboard/iofpga@3,0000
0000/timer@120000': -22
[    0.019598] 000: arch_timer: cp15 and mmio timer(s) running at 50.00MHz (phys
/phys).
[    0.027463] 000: clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cy
cles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.038863] 000: sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every
4398046511100ns
[    0.048890] 000: Console: colour dummy device 80x25
[    0.053892] 000: printk: console [tty0] enabled
[    0.058522] 000: printk: bootconsole [pl11] disabled
[    0.000000] 000: Booting Linux on physical CPU 0x0000000100 [0x410fd033]
[    0.000000] 000: Linux version 5.0.3-rt1-00007-g42ede9a0fed6 (julieng@e108454
-lin) (gcc version 8.2.1 20180802 (GNU Toolchain for the A-profile Architecture
8.2-2019.01 (arm-rel-8.28))) #43 SMP PREEMPT RT Thu Mar 21 16:46:25 GMT 2019
[    0.000000] 000: Machine model: ARM Juno development board (r2)
[    0.000000] 000: earlycon: pl11 at MMIO 0x000000007ff80000 (options '')
[    0.000000] 000: printk: bootconsole [pl11] enabled
[    0.000000] 000: efi: Getting EFI parameters from FDT:
[    0.000000] 000: efi: EFI v2.60 by EDK II
[    0.000000] 000: efi:  SMBIOS=0xf8b80000  SMBIOS 3.0=0xf8b60000  ACPI 2.0=0xf
8ba0000  MEMATTR=0xfc10e018  RNG=0xf86aff98  MEMRESERVE=0xf86c4018
[    0.000000] 000: efi: seeding entropy pool
[    0.000000] 000: cma: Reserved 32 MiB at 0x00000000fa000000
[    0.000000] 000: NUMA: No NUMA configuration found
[    0.000000] 000: NUMA: Faking a node at [mem 0x0000000080000000-0x00000009fff
fffff]
[    0.000000] 000: NUMA: NODE_DATA [mem 0x9fefda100-0x9fefdbfff]
[    0.000000] 000: Zone ranges:
[    0.000000] 000:   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000] 000:   Normal   [mem 0x0000000100000000-0x00000009ffffffff]
[    0.000000] 000: Movable zone start for each node
[    0.000000] 000: Early memory node ranges
[    0.000000] 000:   node   0: [mem 0x0000000080000000-0x00000000dfffffff]
[    0.000000] 000:   node   0: [mem 0x00000000e00f0000-0x00000000f869ffff]
[    0.000000] 000:   node   0: [mem 0x00000000f86a0000-0x00000000f86bffff]
[    0.000000] 000:   node   0: [mem 0x00000000f86c0000-0x00000000f86cbfff]
[    0.000000] 000:   node   0: [mem 0x00000000f86cc000-0x00000000f86cffff]
[    0.000000] 000:   node   0: [mem 0x00000000f86d0000-0x00000000f8a0ffff]
[    0.000000] 000:   node   0: [mem 0x00000000f8a10000-0x00000000f8b8ffff]
<Modem lines changed: +CTS>
[    0.000000] 000:   node   0: [mem 0x00000000f8b90000-0x00000000f8baffff]
[    0.000000] 000:   node   0: [mem 0x00000000f8bb0000-0x00000000f8f4ffff]
[    0.000000] 000:   node   0: [mem 0x00000000f8f50000-0x00000000fdf6ffff]
[    0.000000] 000:   node   0: [mem 0x00000000fdf70000-0x00000000fdfbffff]
[    0.000000] 000:   node   0: [mem 0x00000000fdfc0000-0x00000000feffffff]
[    0.000000] 000:   node   0: [mem 0x0000000880000000-0x00000009ffffffff]
[    0.000000] 000: Zeroed struct page in unavailable ranges: 580 pages
[    0.000000] 000: Initmem setup node 0 [mem 0x0000000080000000-0x00000009fffff
fff]
[    0.000000] 000: psci: probing for conduit method from DT.
[    0.000000] 000: psci: PSCIv1.1 detected in firmware.
[    0.000000] 000: psci: Using standard PSCI v0.2 function IDs
[    0.000000] 000: psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] 000: psci: SMC Calling Convention v1.1
[    0.000000] 000: random: get_random_bytes called from start_kernel+0x98/0x47c
 with crng_init=0
[    0.000000] 000: percpu: Embedded 40 pages/cpu @ffff80097eee4000 s124880 r819
2 d30768 u163840
[    0.000000] 000: Detected VIPT I-cache on CPU0
[    0.000000] 000: CPU features: detected: ARM erratum 845719
[    0.000000] 000: CPU features: detected: ARM erratum 843419
[    0.000000] 000: Built 1 zonelists, mobility grouping on.  Total pages: 20600
48
[    0.000000] 000: Policy zone: Normal
[    0.000000] 000: Kernel command line: BOOT_IMAGE=/vmlinuz-perso root=/dev/map
per/juno2--julieng--vg-root ro loglvlinfo=all acpi=off earlycon=pl011,0x7ff80000
[    0.000000] 000: software IO TLB: mapped [mem 0xf219b000-0xf619b000] (64MB)
[    0.000000] 000: Memory: 8067344K/8371264K available (16828K kernel code, 417
8K rwdata, 6384K rodata, 1792K init, 12285K bss, 271152K reserved, 32768K cma-re
served)
[    0.000000] 000: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] 000: Running RCU self tests
[    0.000000] 000: rcu: Preemptible hierarchical RCU implementation.
[    0.000000] 000: rcu:        RCU event tracing is enabled.
[    0.000000] 000: rcu:        RCU lockdep checking is enabled.
[    0.000000] 000: rcu:        RCU restricting CPUs from NR_CPUS=64 to nr_cpu_i
ds=6.
[    0.000000] 000: rcu:        RCU priority boosting: priority 1 delay 500 ms.
[    0.000000] 000:     No expedited grace period (rcu_normal_after_boot).
[    0.000000] 000:     Tasks RCU enabled.
[    0.000000] 000: rcu: RCU calculated value of scheduler-enlistment delay is 2
5 jiffies.
[    0.000000] 000: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] 000: NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] 000: GIC: Using split EOI/Deactivate mode
[    0.000000] 000: GICv2m: range[mem 0x2c1c0000-0x2c1cffff], SPI[224:255]
[    0.000000] 000: GICv2m: range[mem 0x2c1d0000-0x2c1dffff], SPI[256:287]
[    0.000000] 000: GICv2m: range[mem 0x2c1e0000-0x2c1effff], SPI[288:319]
[    0.000000] 000: GICv2m: range[mem 0x2c1f0000-0x2c1fffff], SPI[320:351]
[    0.000000] 000: clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xfffff
fff, max_idle_ns: 1911260446275 ns
[    0.000002] 000: sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps ev
ery 2147483647500ns
[    0.009090] 000: Failed to initialize '/smb@8000000/motherboard/iofpga@3,0000
0000/timer@120000': -22
[    0.019598] 000: arch_timer: cp15 and mmio timer(s) running at 50.00MHz (phys
/phys).
[    0.027463] 000: clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cy
cles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.038863] 000: sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every
4398046511100ns
[    0.048890] 000: Console: colour dummy device 80x25
[    0.053892] 000: printk: console [tty0] enabled
[    0.058522] 000: printk: bootconsole [pl11] disabled
[    0.063611] 000: Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,
 Ingo Molnar
[    0.063617] 000: ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.063623] 000: ... MAX_LOCK_DEPTH:          48
[    0.063629] 000: ... MAX_LOCKDEP_KEYS:        8191
[    0.063634] 000: ... CLASSHASH_SIZE:          4096
[    0.063640] 000: ... MAX_LOCKDEP_ENTRIES:     32768
[    0.063646] 000: ... MAX_LOCKDEP_CHAINS:      65536
[    0.063651] 000: ... CHAINHASH_SIZE:          32768
[    0.063657] 000:  memory used by lock dependency info: 7263 kB
[    0.063662] 000:  per task-struct memory footprint: 1920 bytes
[    0.064034] 000: Calibrating delay loop (skipped), value calculated using tim
er frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.064046] 000: pid_max: default: 32768 minimum: 301
[    0.065016] 000: LSM: Security Framework initializing
[    0.273803] 000: Dentry cache hash table entries: 1048576 (order: 14, 6710886
4 bytes)
[    0.460765] 000: Inode-cache hash table entries: 524288 (order: 10, 4194304 b
ytes)
[    0.461382] 000: Mount-cache hash table entries: 16384 (order: 5, 131072 byte
s)
[    0.461873] 000: Mountpoint-cache hash table entries: 16384 (order: 5, 131072
 bytes)
[    0.499624] 000: ASID allocator initialised with 32768 entries
[    0.515344] 000: rcu: Hierarchical SRCU implementation.
[    0.545362] 000: EFI runtime services will be disabled.
[    0.560054] 000: smp: Bringing up secondary CPUs ...
[    0.617595] 001: CPU features: detected: EL2 vector hardening
[    0.617609] 001: Detected PIPT I-cache on CPU1
[    0.617675] 001: CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[    0.674235] 002: Detected PIPT I-cache on CPU2
[    0.674275] 002: CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[    0.731251] 003: Detected VIPT I-cache on CPU3
[    0.731337] 003: CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[    0.788046] 004: Detected VIPT I-cache on CPU4
[    0.788119] 004: CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[    0.844865] 005: Detected VIPT I-cache on CPU5
[    0.844935] 005: CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[    0.846159] 000: smp: Brought up 1 node, 6 CPUs
[    0.846169] 000: SMP: Total of 6 processors activated.
[    0.846178] 000: CPU features: detected: 32-bit EL0 Support
[    0.846187] 000: CPU features: detected: CRC32 instructions
[    0.849352] 000: CPU: All CPU(s) started at EL2
[    0.849543] 000: alternatives: patching kernel code
[    0.859506] 000: devtmpfs: initialized
[    0.978890] 002: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff
f, max_idle_ns: 7645041785100000 ns
[    0.980873] 002: futex hash table entries: 2048 (order: 7, 524288 bytes)
[    0.985555] 002: xor: measuring software checksum speed
[    1.022482] 002:    8regs     :  3624.000 MB/sec
[    1.062839] 001:    32regs    :  4159.000 MB/sec
[    1.103247] 002:    arm64_neon:  3729.000 MB/sec
[    1.103253] 002: xor: using function: 32regs (4159.000 MB/sec)
[    1.103283] 002: pinctrl core: initialized pinctrl subsystem
[    1.116426] 002: SMBIOS 3.0.0 present.
[    1.116445] 002: DMI: ARM LTD ARM Juno Development Platform/ARM Juno Developm
ent Platform, BIOS EDK II Jan 23 2017
[    1.121459] 002: NET: Registered protocol family 16
[    1.125583] 002: audit: initializing netlink subsys (disabled)
[    1.126522] 001: audit: type=2000 audit(1.064:1): state=initialized audit_ena
bled=0 res=1
[    1.138293] 002: cpuidle: using governor menu
[    1.140414] 002: vdso: 2 pages (1 code @ ffff0000110f6000, 1 data @ ffff00001
1905000)
[    1.140426] 002: hw-breakpoint: found 6 breakpoint and 4 watchpoint registers
.
[    1.162175] 002: DMA: preallocated 256 KiB pool for atomic allocations
[    1.169151] 002: Serial: AMBA PL011 UART driver
[    1.254891] 002: 7ff80000.uart: ttyAMA0 at MMIO 0x7ff80000 (irq = 32, base_ba
ud = 0) is a PL011 rev3
[    1.255007] 002: printk: console [ttyAMA0] enabled
[    1.425539] 002: HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    1.425548] 002: HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    1.425554] 002: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.425559] 002: HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    1.439417] 002: cryptd: max_cpu_qlen set to 1000
[    1.521847] 002: raid6: neonx8   gen()  2086 MB/s
[    1.590582] 001: raid6: neonx8   xor()  1898 MB/s
[    1.659485] 000: raid6: neonx4   gen()  1791 MB/s
[    1.728708] 002: raid6: neonx4   xor()   786 MB/s
[    1.796880] 001: raid6: neonx2   gen()  1528 MB/s
[    1.865513] 002: raid6: neonx2   xor()  1680 MB/s
[    1.934351] 002: raid6: neonx1   gen()  1203 MB/s
[    2.002897] 002: raid6: neonx1   xor()  1218 MB/s
[    2.071581] 003: raid6: int64x8  gen()  1213 MB/s
[    2.140376] 000: raid6: int64x8  xor()   403 MB/s
[    2.209112] 001: raid6: int64x4  gen()   556 MB/s
[    2.277751] 001: raid6: int64x4  xor()   822 MB/s
[    2.346370] 001: raid6: int64x2  gen()   789 MB/s
[    2.414976] 002: raid6: int64x2  xor()   747 MB/s
[    2.483668] 001: raid6: int64x1  gen()   577 MB/s
[    2.552423] 002: raid6: int64x1  xor()   501 MB/s
[    2.552429] 002: raid6: using algorithm neonx8 gen() 2086 MB/s
[    2.552433] 002: raid6: .... xor() 1898 MB/s, rmw enabled
[    2.552436] 002: raid6: using neon recovery algorithm
[    2.556628] 002: ACPI: Interpreter disabled.
[    2.570587] 001: vgaarb: loaded
[    2.572650] 001: SCSI subsystem initialized
[    2.577310] 001: usbcore: registered new interface driver usbfs
[    2.578391] 001: usbcore: registered new interface driver hub
[    2.579190] 001: usbcore: registered new device driver usb
[    2.595108] 001: pps_core: LinuxPPS API ver. 1 registered
[    2.595114] 001: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
Giometti <giometti@linux.it>
[    2.595233] 001: PTP clock support registered
[    2.596355] 001: EDAC MC: Ver: 3.0.0
[    2.602067] 001: Registered efivars operations
[    2.614744] 001: Advanced Linux Sound Architecture Driver Initialized.
[    2.622903] 002: clocksource: Switched to clocksource arch_sys_counter
[    4.205755] 001: VFS: Disk quotas dquot_6.6.0
[    4.206168] 001: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte
s)
[    4.209305] 001: pnp: PnP ACPI: disabled
[    4.299455] 002: NET: Registered protocol family 2
[    4.306103] 002: tcp_listen_portaddr_hash hash table entries: 4096 (order: 7,
 851968 bytes)
[    4.310099] 002: TCP established hash table entries: 65536 (order: 7, 524288
bytes)
[    4.357013] 002: TCP bind hash table entries: 65536 (order: 11, 13107200 byte
s)
[    4.391239] 002: TCP: Hash tables configured (established 65536 bind 65536)
[    4.398580] 002: UDP hash table entries: 4096 (order: 8, 1703936 bytes)
[    4.408873] 002: UDP-Lite hash table entries: 4096 (order: 8, 1703936 bytes)
[    4.414833] 002: NET: Registered protocol family 1
[    4.418713] 002: RPC: Registered named UNIX socket transport module.
[    4.418731] 002: RPC: Registered udp transport module.
[    4.418747] 002: RPC: Registered tcp transport module.
[    4.418762] 002: RPC: Registered tcp NFSv4.1 backchannel transport module.
[    4.421147] 002: Unpacking initramfs...
[    5.562061] 002: Freeing initrd memory: 8516K
[    5.568666] 002: hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 c
ounters available
[    5.572143] 002: hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 c
ounters available
[    5.572521] 002: kvm [1]: 8-bit VMID
[    5.572526] 002: kvm [1]: IPA Size Limit: 40bits
[    5.600319] 002: kvm [1]: vgic interrupt IRQ1
[    5.600980] 002: kvm [1]: Hyp mode initialized successfully
[    5.745023] 002: Initialise system trusted keyrings
[    5.746381] 002: workingset: timestamp_bits=44 max_order=21 bucket_order=0
[    5.892781] 002: squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    5.903585] 002: NFS: Registering the id_resolver key type
[    5.903729] 002: Key type id_resolver registered
[    5.903745] 002: Key type id_legacy registered
[    5.903826] 002: nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    5.905332] 002: SGI XFS with security attributes, no debug enabled
[    5.925351] 002: 9p: Installing v9fs 9p2000 file system support
[    6.316318] 001: Key type asymmetric registered
[    6.316417] 001: Asymmetric key parser 'x509' registered
[    6.316693] 001: Block layer SCSI generic (bsg) driver version 0.4 loaded (ma
jor 245)
[    6.316755] 001: io scheduler mq-deadline registered
[    6.316774] 001: io scheduler kyber registered
[    6.393170] 001: pl061_gpio 1c1d0000.gpio: PL061 GPIO chip @0x000000001c1d000
0 registered
[    6.403630] 001: pci-host-generic 40000000.pcie: host bridge /pcie@40000000 r
anges:
[    6.403686] 001: pci-host-generic 40000000.pcie:    IO 0x5f800000..0x5fffffff
 -> 0x00000000
[    6.403818] 001: pci-host-generic 40000000.pcie:   MEM 0x50000000..0x57ffffff
 -> 0x50000000
[    6.403860] 001: pci-host-generic 40000000.pcie:   MEM 0x4000000000..0x40ffff
ffff -> 0x4000000000
[    6.404110] 001: pci-host-generic 40000000.pcie: ECAM at [mem 0x40000000-0x4f
ffffff] for [bus 00-ff]
[    6.405513] 001: pci-host-generic 40000000.pcie: PCI host bridge to bus 0000:
00
[    6.405541] 001: pci_bus 0000:00: root bus resource [bus 00-ff]
[    6.405550] 001: pci_bus 0000:00: root bus resource [io  0x0000-0x7fffff]
[    6.405557] 001: pci_bus 0000:00: root bus resource [mem 0x50000000-0x57fffff
f]
[    6.405565] 001: pci_bus 0000:00: root bus resource [mem 0x4000000000-0x40fff
fffff pref]
[    6.410836] 001: pci 0000:01:00.0: enabling Extended Tags
[    6.415958] 001: pci 0000:02:01.0: enabling Extended Tags
[    6.418482] 001: pci 0000:02:02.0: enabling Extended Tags
[    6.421176] 001: pci 0000:02:03.0: enabling Extended Tags
[    6.424222] 001: pci 0000:02:0c.0: enabling Extended Tags
[    6.427045] 001: pci 0000:02:10.0: enabling Extended Tags
[    6.430233] 001: pci 0000:02:1f.0: enabling Extended Tags
[    6.452608] 001: pci 0000:00:00.0: BAR 14: assigned [mem 0x50000000-0x501ffff
f]
[    6.452636] 001: pci 0000:00:00.0: BAR 0: assigned [mem 0x4000000000-0x400000
3fff 64bit pref]
[    6.452678] 001: pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    6.452716] 001: pci 0000:01:00.0: BAR 14: assigned [mem 0x50000000-0x501ffff
f]
[    6.452741] 001: pci 0000:01:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    6.452778] 001: pci 0000:02:01.0: BAR 14: assigned [mem 0x50000000-0x500ffff
f]
[    6.452803] 001: pci 0000:02:1f.0: BAR 14: assigned [mem 0x50100000-0x501ffff
f]
[    6.452827] 001: pci 0000:02:01.0: BAR 13: assigned [io  0x1000-0x1fff]
[    6.452852] 001: pci 0000:02:1f.0: BAR 13: assigned [io  0x2000-0x2fff]
[    6.452891] 001: pci 0000:03:00.0: BAR 6: assigned [mem 0x50000000-0x5007ffff
 pref]
[    6.452936] 001: pci 0000:03:00.0: BAR 2: assigned [mem 0x50080000-0x50083fff
 64bit]
[    6.453008] 001: pci 0000:03:00.0: BAR 0: assigned [mem 0x50084000-0x5008407f
 64bit]
[    6.453061] 001: pci 0000:03:00.0: BAR 4: assigned [io  0x1000-0x107f]
[    6.453081] 001: pci 0000:02:01.0: PCI bridge to [bus 03]
[    6.453090] 001: pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    6.453108] 001: pci 0000:02:01.0:   bridge window [mem 0x50000000-0x500fffff
]
[    6.453138] 001: pci 0000:02:02.0: PCI bridge to [bus 04]
[    6.453179] 001: pci 0000:02:03.0: PCI bridge to [bus 05]
[    6.453220] 001: pci 0000:02:0c.0: PCI bridge to [bus 06]
[    6.453261] 001: pci 0000:02:10.0: PCI bridge to [bus 07]
[    6.453344] 001: pci 0000:08:00.0: BAR 0: assigned [mem 0x50100000-0x50103fff
 64bit]
[    6.453395] 001: pci 0000:08:00.0: BAR 2: assigned [io  0x2000-0x20ff]
[    6.453412] 001: pci 0000:02:1f.0: PCI bridge to [bus 08]
[    6.453421] 001: pci 0000:02:1f.0:   bridge window [io  0x2000-0x2fff]
[    6.453438] 001: pci 0000:02:1f.0:   bridge window [mem 0x50100000-0x501fffff
]
[    6.453466] 001: pci 0000:01:00.0: PCI bridge to [bus 02-08]
[    6.453475] 001: pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
[    6.453492] 001: pci 0000:01:00.0:   bridge window [mem 0x50000000-0x501fffff
]
[    6.453521] 001: pci 0000:00:00.0: PCI bridge to [bus 01-08]
[    6.453528] 001: pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
[    6.453539] 001: pci 0000:00:00.0:   bridge window [mem 0x50000000-0x501fffff
]
[    6.471674] 001: EINJ: ACPI disabled.
[    6.519098] 001: dma-pl330 7ff00000.dma: Loaded driver for PL330 DMAC-341330
[    6.519109] 001: dma-pl330 7ff00000.dma:     DBUFF-1024x16bytes Num_Chans-8 N
um_Peri-8 Num_Events-8
[    6.578801] 001: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    6.605810] 001: SuperH (H)SCI(F) driver initialized
[    6.608720] 001: msm_serial: driver initialized
[    6.611870] 001: arm-smmu 2b500000.iommu: probing hardware configuration...
[    6.611876] 001: arm-smmu 2b500000.iommu: SMMUv1 with:
[    6.611882] 001: arm-smmu 2b500000.iommu:    stage 2 translation
[    6.611886] 001: arm-smmu 2b500000.iommu:    coherent table walk
[    6.611907] 001: arm-smmu 2b500000.iommu:    stream matching with 32 register
 groups
[    6.611932] 001: arm-smmu 2b500000.iommu:    4 context banks (4 stage-2 only)
[    6.611954] 001: arm-smmu 2b500000.iommu:    Supported page sizes: 0x60211000
[    6.611960] 001: arm-smmu 2b500000.iommu:    Stage-2: 40-bit IPA -> 40-bit PA
[    6.616502] 001: arm-smmu 7fb10000.iommu: probing hardware configuration...
[    6.616509] 001: arm-smmu 7fb10000.iommu: SMMUv1 with:
[    6.616515] 001: arm-smmu 7fb10000.iommu:    stage 2 translation
[    6.616519] 001: arm-smmu 7fb10000.iommu:    non-coherent table walk
[    6.616525] 001: arm-smmu 7fb10000.iommu:    (IDR0.CTTW overridden by FW conf
iguration)
[    6.616543] 001: arm-smmu 7fb10000.iommu:    stream matching with 2 register
groups
[    6.616564] 001: arm-smmu 7fb10000.iommu:    1 context banks (1 stage-2 only)
[    6.616587] 001: arm-smmu 7fb10000.iommu:    Supported page sizes: 0x60211000
[    6.616592] 001: arm-smmu 7fb10000.iommu:    Stage-2: 40-bit IPA -> 40-bit PA
[    6.619166] 001: arm-smmu 7fb20000.iommu: probing hardware configuration...
[    6.619171] 001: arm-smmu 7fb20000.iommu: SMMUv1 with:
[    6.619177] 001: arm-smmu 7fb20000.iommu:    stage 2 translation
[    6.619182] 001: arm-smmu 7fb20000.iommu:    non-coherent table walk
[    6.619187] 001: arm-smmu 7fb20000.iommu:    (IDR0.CTTW overridden by FW conf
iguration)
[    6.619207] 001: arm-smmu 7fb20000.iommu:    stream matching with 2 register
groups
[    6.619228] 001: arm-smmu 7fb20000.iommu:    1 context banks (1 stage-2 only)
[    6.619249] 001: arm-smmu 7fb20000.iommu:    Supported page sizes: 0x60211000
[    6.619254] 001: arm-smmu 7fb20000.iommu:    Stage-2: 40-bit IPA -> 40-bit PA
[    6.621698] 001: arm-smmu 7fb30000.iommu: probing hardware configuration...
[    6.621704] 001: arm-smmu 7fb30000.iommu: SMMUv1 with:
[    6.621709] 001: arm-smmu 7fb30000.iommu:    stage 2 translation
[    6.621713] 001: arm-smmu 7fb30000.iommu:    coherent table walk
[    6.621733] 001: arm-smmu 7fb30000.iommu:    stream matching with 2 register
groups
[    6.621753] 001: arm-smmu 7fb30000.iommu:    1 context banks (1 stage-2 only)
[    6.621773] 001: arm-smmu 7fb30000.iommu:    Supported page sizes: 0x60211000
[    6.621778] 001: arm-smmu 7fb30000.iommu:    Stage-2: 40-bit IPA -> 40-bit PA
[    6.798430] 002: loop: module loaded
[    7.085063] 002: iommu: Adding device 0000:03:00.0 to group 0
[    7.085499] 002: sata_sil24 0000:03:00.0: Linked as a consumer to 2b500000.io
mmu
[    7.103207] 001: scsi host0: sata_sil24
[    7.110520] 002: scsi host1: sata_sil24
[    7.113212] 002: ata1: SATA max UDMA/100 host m128@0x50084000 port 0x50080000
 irq 44
[    7.113221] 002: ata2: SATA max UDMA/100 host m128@0x50084000 port 0x50082000
 irq 44
[    7.139539] 002: libphy: Fixed MDIO Bus: probed
[    7.144091] 002: tun: Universal TUN/TAP device driver, 1.6
[    7.151548] 002: thunder_xcv, ver 1.0
[    7.152289] 002: thunder_bgx, ver 1.0
[    7.153037] 002: nicpf, ver 1.0
[    7.157187] 002: e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    7.157192] 002: e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    7.157927] 002: igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.
0-k
[    7.157931] 002: igb: Copyright (c) 2007-2014 Intel Corporation.
[    7.158677] 002: igbvf: Intel(R) Gigabit Virtual Function Network Driver - ve
rsion 2.4.0-k
[    7.158681] 002: igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    7.161936] 002: sky2: driver version 1.30
[    7.162778] 002: iommu: Adding device 0000:08:00.0 to group 0
[    7.163125] 002: sky2 0000:08:00.0: Linked as a consumer to 2b500000.iommu
[    7.163836] 002: sky2 0000:08:00.0: enabling device (0000 -> 0003)
[    7.164195] 002: sky2 0000:08:00.0: Yukon-2 UL 2 chip revision 0
[    7.174664] 002: sky2 0000:08:00.0 eth0: addr 00:02:f7:00:67:97
[    7.179651] 002: smsc911x 18000000.ethernet: Linked as a consumer to regulato
r.1
[    7.228756] 001: libphy: smsc911x-mdio: probed
[    7.233804] 001: smsc911x 18000000.ethernet eth1: MAC Address: 00:02:f7:00:67
:95
[    7.238474] 001: VFIO - User Level meta-driver version: 0.3
[    7.254318] 001: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    7.254325] 001: ehci-pci: EHCI PCI platform driver
[    7.255040] 001: ehci-platform: EHCI generic platform driver
[    7.256841] 001: iommu: Adding device 7ffc0000.ehci to group 1
[    7.257035] 001: ehci-platform 7ffc0000.ehci: Linked as a consumer to 7fb3000
0.iommu
[    7.257839] 001: ehci-platform 7ffc0000.ehci: EHCI Host Controller
[    7.258425] 001: ehci-platform 7ffc0000.ehci: new USB bus registered, assigne
d bus number 1
[    7.260383] 001: ehci-platform 7ffc0000.ehci: irq 35, io mem 0x7ffc0000
[    7.275051] 002: ehci-platform 7ffc0000.ehci: USB 2.0 started, EHCI 1.00
[    7.285735] 002: hub 1-0:1.0: USB hub found
[    7.286077] 002: hub 1-0:1.0: 1 port detected
[    7.292202] 002: ehci-orion: EHCI orion driver
[    7.293087] 002: ehci-exynos: EHCI EXYNOS driver
[    7.293884] 002: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    7.294012] 002: ohci-pci: OHCI PCI platform driver
[    7.294636] 002: ohci-platform: OHCI generic platform driver
[    7.295714] 002: iommu: Adding device 7ffb0000.ohci to group 1
[    7.295911] 002: ohci-platform 7ffb0000.ohci: Linked as a consumer to 7fb3000
0.iommu
[    7.296321] 002: ohci-platform 7ffb0000.ohci: Generic Platform OHCI controlle
r
[    7.296420] 002: ohci-platform 7ffb0000.ohci: new USB bus registered, assigne
d bus number 2
[    7.298172] 002: ohci-platform 7ffb0000.ohci: irq 34, io mem 0x7ffb0000
[    7.386190] 001: hub 2-0:1.0: USB hub found
[    7.386350] 001: hub 2-0:1.0: 1 port detected
[    7.390183] 001: ohci-exynos: OHCI EXYNOS driver
[    7.395448] 002: usbcore: registered new interface driver usb-storage
[    7.431372] 001: rtc-pl031 1c170000.rtc: registered as rtc0
[    7.437114] 002: i2c /dev entries driver
[    7.472397] 002: sp805-wdt 1c0f0000.wdt: registration successful
[    7.482756] 002: device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised:
 dm-devel@redhat.com
[    7.502586] 002: mmci-pl18x 1c050000.mmci: Linked as a consumer to regulator.
1
[    7.504003] 002: mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c05
0000 irq 9,0 (pio)
[    7.504049] 002: mmci-pl18x 1c050000.mmci: DMA channels RX none, TX none
[    7.532504] 002: sdhci: Secure Digital Host Controller Interface driver
[    7.532511] 002: sdhci: Copyright(c) Pierre Ossman
[    7.535959] 002: Synopsys Designware Multimedia Card Interface Driver
[    7.544338] 002: sdhci-pltfm: SDHCI platform and OF driver helper
[    7.557469] 002: leds-syscon 1c010000.apbregs:led0: registered LED vexpress:0
[    7.560353] 002: leds-syscon 1c010000.apbregs:led1: registered LED vexpress:1
[    7.561744] 002: leds-syscon 1c010000.apbregs:led2: registered LED vexpress:2
[    7.563405] 002: leds-syscon 1c010000.apbregs:led3: registered LED vexpress:3
[    7.564781] 002: leds-syscon 1c010000.apbregs:led4: registered LED vexpress:4
[    7.566167] 002: leds-syscon 1c010000.apbregs:led5: registered LED vexpress:5
[    7.567894] 002: leds-syscon 1c010000.apbregs:led6: registered LED vexpress:6
[    7.569380] 002: leds-syscon 1c010000.apbregs:led7: registered LED vexpress:7
[    7.587851] 002: usbcore: registered new interface driver usbhid
[    7.587858] 002: usbhid: USB HID core driver
[    7.589228] 002: mhu 2b1f0000.mhu: ARM MHU Mailbox registered
[    7.628988] 002: NET: Registered protocol family 10
[    7.635099] 001: usb 1-1: new high-speed USB device number 2 using ehci-platf
orm
[    7.639884] 002: Segment Routing with IPv6
[    7.640270] 002: NET: Registered protocol family 17
[    7.640854] 002: bridge: filtering via arp/ip/ip6tables is no longer availabl
e by default. Update your scripts to load br_netfilter if you need this.
[    7.642725] 002: 9pnet: Installing 9P2000 support
[    7.643471] 002: Key type dns_resolver registered
[    7.649760] 002: registered taskstats version 1
[    7.649766] 002: Loading compiled-in X.509 certificates
[    7.668024] 002: Btrfs loaded, crc32c=crc32c-generic
[    7.708889] 001: scpi_protocol scpi: SCP Protocol 1.0 Firmware 1.9.0 version
[    7.776463] 001: thermal thermal_zone1: failed to read out thermal zone (-95)
[    7.801766] 001: hub 1-1:1.0: USB hub found
[    7.802318] 001: hub 1-1:1.0: 4 ports detected
[    7.811541] 002: input: smb@8000000:motherboard:gpio-keys as /devices/platfor
m/smb@8000000/smb@8000000:motherboard/smb@8000000:motherboard:gpio-keys/input/in
put1
[    7.820343] 002: rtc-pl031 1c170000.rtc: setting system clock to 2019-03-22T1
7:41:19 UTC (1553276479)
[    7.821150] 002: ALSA device list:
[    7.821154] 002:   No soundcards found.
[    7.832931] 003: uart-pl011 7ff80000.uart: no DMA platform data
[    8.427455] 000: atkbd serio0: keyboard reset failed on 1c060000.kmi
[    9.303681] 000: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    9.307339] 003: ata1.00: ATA-8: TOSHIBA DT01ACA100, MS2OA750, max UDMA/133
[    9.307355] 003: ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32
)
[    9.310195] 003: ata1.00: configured for UDMA/100
[    9.336629] 004: scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA1 A7
50 PQ: 0 ANSI: 5
[    9.363457] 005: sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00
TB/932 GiB)
[    9.363475] 005: sd 0:0:0:0: [sda] 4096-byte physical blocks
[    9.364009] 003: sd 0:0:0:0: [sda] Write Protect is off
[    9.364919] 003: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,
 doesn't support DPO or FUA
[    9.442405] 002:  sda: sda1 sda2 sda3
[    9.463290] 002: sd 0:0:0:0: [sda] Attached SCSI disk
[    9.675229] 000: atkbd serio1: keyboard reset failed on 1c070000.kmi
[   11.439160] 002: ata2: SATA link down (SStatus 0 SControl 0)
[   11.444798] 001: Freeing unused kernel memory: 1792K
[   11.445124] 001: Run /init as init process
Loading, please wait...
Starting version 240
[   15.848316] 001: sky2 0000:08:00.0 enp8s0: renamed from eth0
[   16.432556] 000: input: PS/2 Generic Mouse as /devices/platform/smb@8000000/s
mb@8000000:motherboard/smb@8000000:motherboard:iofpga@3,00000000/1c060000.kmi/se
rio0/input/input3
[   16.590387] 000: psmouse serio0: Failed to enable mouse on 1c060000.kmi
Begin: Loading essential drivers ... modprobe: can't change directory to '5.0.3-
rt1-00007-g42ede9a0fed6': No such file or directory
modprobe: can't change directory to '5.0.3-rt1-00007-g42ede9a0fed6': No such fil
e or directory
modprobe: can't change directory to '5.0.3-rt1-00007-g42ede9a0fed6': No such fil
e or directory
modprobe: can't change directory to '5.0.3-rt1-00007-g42ede9a0fed6': No such fil
e or directory[   18.736890] 002: random: lvm: uninitialized urandom read (4 byt
es read)
 
modprobe: can't change directory to '5.0.3-rt1-00007-g42ede9a0fed6': No such fil
e or directory
modprobe: can't change directory to '5.0.3-rt1-00007-g42ede9a0fed6': No such fil
e or directory[   19.427711] 002: random: lvm: uninitialized urandom read (2 byt
es read)
 
modprobe: can't change directory to '5.0.3-rt1-00007-g42ede9a0fed6': No such fil
e or directory
modprobe: can't change directory to '5.0.3-rt1-00007-g42ede9a0fed6': No such fil
e or directory
done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... [   2
0.455367] 002: random: lvm: uninitialized urandom read (4 bytes read)
[   21.167948] 002: random: lvm: uninitialized urandom read (2 bytes read)
[   23.156960] 000: input: PS/2 Generic Mouse as /devices/platform/smb@8000000/s
mb@8000000:motherboard/smb@8000000:motherboard:iofpga@3,00000000/1c070000.kmi/se
rio1/input/input4
[   23.283223] 000: psmouse serio1: Failed to enable mouse on 1c070000.kmi
[   23.288572] 002: random: crng init done
done.
Begin: Running /scripts/local-premount ... modprobe: can't change directory to '
5.0.3-rt1-00007-g42ede9a0fed6': No such file or directory
done.
Begin: Will now check root file system ... fsck from util-linux 2.33.1
[/sbin/fsck.ext4 (1) -- /dev/mapper/juno2--julieng--vg-root] fsck.ext4 -a -C0 /d
ev/mapper/juno2--julieng--vg-root
/dev/mapper/juno2--julieng--vg-root: clean, 142882/1525920 files, 3407101/610304
0 blocks
done.
[   24.012961] 001: EXT4-fs (dm-0): mounted filesystem with ordered data mode. O
pts: (null)
done.
Begin: Running /scripts/local-bottom ... done.
Begin: Running /scripts/init-bottom ... done.
[   26.009761] 001: systemd[1]: systemd 240 running in system mode. (+PAM +AUDIT
 +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +
ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy
=hybrid)
[   26.016472] 001: systemd[1]: Detected architecture arm64.
 
Welcome to Debian GNU/Linux buster/sid!
 
[   26.115596] 002: systemd[1]: Set hostname to <juno2-julieng>.
[   27.537463] 001: systemd-sysv-generator[1874]: Overwriting existing symlink /
run/systemd/generator.late/xen.service with real service.
[   27.614314] 001: systemd[1]: File /lib/systemd/system/systemd-journald.servic
e:12 configures an IP firewall (IPAddressDeny=any), but the local system does no
t support BPF/cgroup based firewalling.
[   27.614332] 001: systemd[1]: Proceeding WITHOUT firewalling in effect! (This
warning is only shown for the first loaded unit using IP firewalling.)
[   28.238091] 001: systemd[1]: Listening on RPCbind Server Activation Socket.
[  OK  ] Listening on RPCbind Server Activation Socket.
[  OK  ] Created slice ystemd[1]: Created slice User and Session Slice.
1;39mUser and Session Slice.
[  OK  ] Started D[   28.309731] 001: systemd[1]: Started Dispatch Password Requ
ests to Console Directory Watch.
ispatch Password â¦ts to Console Directory Watch.
[  OK  ] Created slice ystemd[1]: Created slice system-systemd\x2dfsck.slice.
1;39msystem-systemd\x2dfsck.slice.
[  OK  ] Listening on ystemd[1]: Listening on Device-mapper event daemon FIFOs.
;39mDevice-mapper event daemon FIFOs.
[  OK  ] Reached target Slices.
[  OK  ] Listening on Journal Audit Socket.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[  OK  ] Listening on LVM2 poll daemon socket.
[  OK  ] Created slice system-getty.slice.
[  OK  ] Started Forward Password Râ¦uests to Wall Directory Watch.
[  OK  ] Listening on fsck to fsckd communication Socket.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Reached target Local Encrypted Volumes.
[  OK  ] Listening on Journal Socket.
         Starting Availability of block devices...
         Mounting Kernel Debug File System...
         Mounting RPC Pipe File System...
         Mounting POSIX Message Queue File System...
         Starting Monitoring of LVMâ¦meventd or progress polling...
         Starting Set the console keyboard layout...
         Starting Remount Root and Kernel File Systems...
         Starting Load Kernel Modules...
[  OK  ] Listening on udev Control Socket.
         Starting udev Coldplug all Devices...
[  OK  ] Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Syslog Socket.
         Starting Journal Service...
[   29.320627] 005: EXT4-fs (dm-0): re-mounted. Opts: errors=remount-ro
         Mounting Huge Pages File System...
[  OK  ] Started Availability of block devices.
[  OK  ] Mounted Kernel Debug File System.
[  OK  ] Mounted RPC Pipe File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Started Set the console keyboard layout.
[  OK  ] Started Remount Root and Kernel File Systems.
[  OK  ] Started Load Kernel Modules.
[  OK  ] Mounted Huge Pages File System.
         Mounting Kernel Configuration File System...
         Starting Apply Kernel Variables...
         Starting Create System Users...
[  OK  ] Started Monitoring of LVM2â¦ dmeventd or progress polling.
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Started Apply Kernel Variables.
[[   31.018329] 001: systemd[1]: Started Create System Users.
  OK  ] Started Create System Users.
         Starting Create [   31.110079] 001: systemd[1]: Starting Create Static
Device Nodes in /dev...
Static Device Nodes in /dev...
[  OK  ] Started Journal Service.
[   31.316402] 002: systemd[1]: Started Journal Service.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Started udev Kernel Device Manager.
[*     ] (1 of 8) A start job is running forâ¦julieng--vg-swap_1 (8s / 1min 30s)
 
[**    ] (1 of 8) A start job is running forâ¦julieng--vg-swap_1 (9s / 1min 30s)
 
[***   ] (1 of 8) A start job is running forâ¦julieng--vg-swap_1 (9s / 1min 30s)
 
[ ***  ] (2 of 8) A start job is running forâ¦--julieng--vg-tmp (10s / 1min 31s)
 
[  *** ] (2 of 8) A start job is running forâ¦--julieng--vg-tmp (10s / 1min 31s)
 
[   ***] (2 of 8) A start job is running forâ¦--julieng--vg-tmp (11s / 1min 31s)
 
[    **] (3 of 8) A start job is running forâ¦a209-95fc8052ec97 (11s / 1min 30s)
 
[  OK  ] Found device /dev/ttyAMA0.
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Found device TOSHIBA_DT01ACA100 1.
[  OK  ] Found device TOSHIBA_DT01ACA100 2.
[  OK  ] Found device /dev/mapper/juno2--julieng--vg-swap_1.
         Activating swap /dev/mapper/juno2--julieng--vg-swap_1...
         Starting File System Checkâ¦2abc-474d-a209-95fc8052ec97...
         Starting File System Checkâ¦/dev/disk/by-uuid/F1B0-6A82...
[  OK  ] Created slice system-lvm2\x2dpvscan.slice.
         Starting LVM event activation on device 8:3...
[   46.860198] 004: Adding 15900668k swap on /dev/mapper/juno2--julieng--vg-swap
_1.  Priority:-2 extents:1 across:15900668k
         Starting Helper to synchronize boot up for ifupdown...
[  OK  ] Activated swap /dev/mapper/juno2--julieng--vg-swap_1.
[  OK  ] Started File System Check â¦2-2abc-474d-a209-95fc8052ec97.
[  OK  ] Started Helper to synchronize boot up for ifupdown.
[  OK  ] Started File System Check on /dev/disk/by-uuid/F1B0-6A82.
[  OK  ] Started File System Check Daemon to report status.
         Mounting /boot...
[  OK  ] Reached target Swap.
Checking in progress on 0 disks (100.0% complete[   47.862327] 001: EXT4-fs (sda
2): mounting ext3 file system using the ext4 subsystem
[   47.917009] 001: EXT4-fs (sda2): mounted filesystem with ordered data mode. O
pts: (null)
[  OK  ] Mounted /boot.
         Mounting /boot/efi...
[  OK  ] Mounted /boot/efi.
[  OK  ] Found device /dev/mapper/juno2--julieng--vg-var.
         Starting File System Checkâ¦pper/juno2--julieng--vg-var...
[  OK  ] Started LVM event activation on device 8:3.
[  OK  ] Started File System Check â¦mapper/juno2--julieng--vg-var.
[  OK  ] Found device /dev/mapper/juno2--julieng--vg-tmp.
[  OK  ] Found device /dev/mapper/juno2--julieng--vg-home.
         Starting File System Checkâ¦per/juno2--julieng--vg-home...
         Starting File System Checkâ¦pper/juno2--julieng--vg-tmp...
         Mounting /var...
[   50.216985] 001: EXT4-fs (dm-2): mounted filesystem with ordered data mode. O
pts: (null)
[  OK  ] Mounted /var.
         Starting Load/Save Random Seed...
         Starting Flush Journal to Persistent Storage...
[  OK  ] Started File System Check â¦mapper/juno2--julieng--vg-tmp.
         Mounting /tmp... disks (100.0% complete)
[  OK  ] Started File System Check â¦apper/juno2--julieng--vg-home.
[  OK  ] Started Load/Save Random Seed.
[   50.770460] 001: EXT4-fs (dm-3): mounted filesystem with ordered data mode. O
pts: (null)
[  OK  ] Mounted /tmp.
[   50.819715] 001: systemd-journald[1889]: Received request to flush runtime jo
urnal from PID 1
         Mounting /home...
[  OK  ] Started Flush Journal to Persistent Storage.
[   51.165161] 002: EXT4-fs (dm-4): mounted filesystem with ordered data mode. O
pts: (null)
[  OK  ] Mounted /home.
[  OK  ] Reached target Local File Systems.
         Starting Set console font and keymap...
         Starting Create Volatile Files and Directories...
         Starting Preprocess NFS configuration...
         Starting Raise network interfaces...
         Starting Enable support foâ¦l executable binary formats...
[  OK  ] Started Set console font and keymap.
[  OK  ] Started Preprocess NFS configuration.
[  OK  ] Reached target NFS client services.
[  OK  ] Started Enable support forâ¦nal executable binary formats.
[  OK  ] Started Create Volatile Files and Directories.
         Starting Network Time Synchronization...
         Starting RPC bind portmap service...
         Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[   52.294280] 005:
[   52.294291] 005: =====================================================
[   52.294295] 005: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[  OK  [   52.294301] 005: 5.0.3-rt1-00007-g42ede9a0fed6 #43 Not tainted
] Started RPC bind portmap[   52.294306] 005: ----------------------------------
-------------------
 service.
[   52.294310] 005: ip/2108 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[   52.294323] 005: ffff80096d78fd30 (&cookie->msi_lock){+.+.}, at: iommu_dma_ma
p_msi_msg+0x5c/0x1d8
[   52.294348] 005:
[   52.294348] 005: and this task is already holding:
[   52.294354] 005: ffff80096d7338c8 (&irq_desc_lock_class){-...}, at: __setup_i
rq+0xd8/0x6c0
[   52.294374] 005: which would create a new lock dependency:
[   52.294379] 005:  (&irq_desc_lock_class){-...} -> (&cookie->msi_lock){+.+.}
[   52.294397] 005:
[   52.294397] 005: but this new dependency connects a HARDIRQ-irq-safe lock:
[   52.294402] 005:  (&irq_desc_lock_class){-...}
[   52.294408] 005:
[   52.294408] 005: ... which became HARDIRQ-irq-safe at:
[[   52.294413] 005:   lock_acquire+0xf8/0x318
[   52.294423] 005:   _raw_spin_lock+0x3c/0x50
  OK  [   52.294432] 005:   handle_fasteoi_irq+0x24/0x1d8
] [   52.294440] 005:   generic_handle_irq+0x24/0x38
Reached target RPC Port [   52.294448] 005:   __handle_domain_irq+0x90/0x100
Mapper.[   52.294457] 005:   gic_handle_irq+0x50/0xa0
 
[   52.294465] 005:   el1_irq+0xb4/0x140
[   52.294473] 005:   arch_cpu_idle+0x20/0x2e0
[   52.294481] 005:   default_idle_call+0x28/0x40
[   52.294489] 005:   do_idle+0x248/0x308
[   52.294498] 005:   cpu_startup_entry+0x24/0x28
[[   52.294507] 005:   rest_init+0x1d4/0x330
[   52.294516] 005:   arch_call_rest_init+0xc/0x14
  OK  [   52.294528] 005:   start_kernel+0x454/0x47c
] [   52.294537] 005:
[   52.294537] 005: to a HARDIRQ-irq-unsafe lock:
Reached target Remote File S[   52.294542] 005:  (&cookie->msi_lock){+.+.}
ystems (Pre).
[   52.294547] 005:
[   52.294547] 005: ... which became HARDIRQ-irq-unsafe at:
[   52.294553] 005: ...
[   52.294554] 005:   lock_acquire+0xf8/0x318
[  OK  ] Reached target
t_spin_lock+0x48/0x70  lock_acquire+0xf8/0x318
[0;1;39mRemote File Systems.[   52.294570] 005:   iommu_dma_map_msi_msg+0x5c/0x1
d8OK  [   52.294432] 005:   handle_fasteoi_irq+0x24/0x1d8
] [   52.294440] 005:   generic_handle_irq+0x24/0x38
[   52.294577] 005:   gicv2m_compose_msi_msg+0x3c/0x48_domain_irq+0x90/0x100
[   52.294585] 005:   irq_chip_compose_msi_msg+0x40/0x58
[   52.294593] 005:   msi_domain_activate+0x38/0x98
[   52.294602] 005:   __irq_domain_activate_irq+0x58/0xa0
[   52.294610] 005:   irq_domain_activate_irq+0x34/0x58
[   52.294618] 005:   msi_domain_alloc_irqs+0x158/0x2b0
[   52.294627] 005:   pci_msi_setup_msi_irqs+0x38/0x40
[   52.294638] 005:   __pci_enable_msi_range+0x24c/0x428
[   52.294645] 005:   pci_enable_msi+0x18/0x28
[   52.294652] 005:   sky2_probe+0x40c/0x988c/0x14
[   52.294662] 005:   local_pci_probe+0x3c/0xb00x47c
[   52.294670] 005:   pci_device_probe+0x128/0x1e8
[   52.294678] 005:   really_probe+0x1c8/0x298ck:
[  OK  [   52.294688] 005:   driver_probe_device+0x60/0x108msi_lock){+.+.}
] Started Network Time S[   52.294697] 005:   __driver_attach+0xfc/0x138
ynchronization.[   52.294705] 005:   bus_for_each_dev+0x70/0xc0
[   52.294714] 005:   driver_attach+0x20/0x28irq-unsafe at:
[   52.294553] 005: ...
[   52.294722] 005:   bus_add_driver+0x1b8/0x238
[   52.294730] 005:   driver_register+0x60/0x110
[   52.294739] 005:   __pci_register_driver+0x78/0x88
[   52.294746] 005:   sky2_init_module+0x2c/0x34
[   52.294756] 005:   do_one_initcall+0xa0/0x528
[   52.294763] 005:   kernel_init_freeable+0x6ec/0x784
[   52.294773] 005:   kernel_init+0x10/0x118
[[   52.294781] 005:   ret_from_fork+0x10/0x18
  OK  ] [   52.294789] 005:
[   52.294789] 005: other info that might help us debug this:
[   52.294789] 005:
Reached target System Ti[   52.294793] 005:  Possible interrupt unsafe locking s
cenario:
[   52.294793] 005:
me Synchronized.[   52.294797] 005:        CPU0                    CPU1
 
[   52.294800] 005:        ----                    ----
[   52.294804] 005:   lock(&cookie->msi_lock);
[   52.294810] 005:                                local_irq_disable();
[   52.294814] 005:                                lock(&irq_desc_lock_class);
[  OK  [   52.294822] 005:                                lock(&cookie->msi_lock
);
] Reached target System [   52.294827] 005:   <Interrupt>
Initialization.[   52.294831] 005:     lock(&irq_desc_lock_class);
[   52.294837] 005:
[   52.294837] 005:  *** DEADLOCK ***
[   52.294837] 005:
 
[   52.294840] 005: 3 locks held by ip/2108:
[   52.294847] 005:  #0: ffff000011ca27e8 (rtnl_mutex){+.+.}, at: rtnetlink_rcv_
msg+0x150/0x640
[   52.294870] 005:  #1: ffff80096d733ae8 (&desc->request_mutex){+.+.}, at: __se
tup_irq+0xb4/0x6c0
[   52.294891] 005:  #2: ffff80096d7338c8 (&irq_desc_lock_class){-...}, at: __se
tup_irq+0xd8/0x6c0
[   52.294910] 005:
[   52.294910] 005: the dependencies between HARDIRQ-irq-safe lock and the holdi
ng lock:
[   52.294920] 005: -> (&irq_desc_lock_class){-...} ops: 33415 {
         Starting Docker S[   52.294937] 005:    IN-HARDIRQ-W at:
ocket for the API.
[   52.294941] 005:                     lock_acquire+0xf8/0x318
[   52.294949] 005:                     _raw_spin_lock+0x3c/0x50
[   52.294958] 005:                     handle_fasteoi_irq+0x24/0x1d8
[   52.294965] 005:                     generic_handle_irq+0x24/0x38
[   52.294973] 005:                     __handle_domain_irq+0x90/0x100
[   52.294981] 005:                     gic_handle_irq+0x50/0xa0
[   52.294988] 005:                     el1_irq+0xb4/0x140
[   52.294996] 005:                     arch_cpu_idle+0x20/0x2e0
[   52.295004] 005:                     default_idle_call+0x28/0x40
[   52.295011] 005:                     do_idle+0x248/0x308
[   52.295020] 005:                     cpu_startup_entry+0x24/0x28
[   52.295028] 005:                     rest_init+0x1d4/0x330
[   52.295037] 005:                     arch_call_rest_init+0xc/0x14
[   52.295046] 005:                     start_kernel+0x454/0x47c
[   52.295058] 005:    INITIAL USE at:
[   52.295062] 005:                    lock_acquire+0xf8/0x318
[  OK  [   52.295070] 005:                    _raw_spin_lock_irqsave+0x4c/0x68
] [   52.295078] 005:                    __irq_get_desc_lock+0x54/0x90
Started Daily man-db reg[   52.295086] 005:                    irq_modify_status
+0x3c/0x140
eneration.[   52.295096] 005:                    irq_set_percpu_devid_partition+
0x80/0xa8
 
[   52.295105] 005:                    irq_set_percpu_devid+0x10/0x18
[   52.295113] 005:                    gic_irq_domain_map+0x30/0xd8
[   52.295124] 005:                    gic_irq_domain_alloc+0x7c/0xb0
[   52.295133] 005:                    __irq_domain_alloc_irqs+0x13c/0x2c8
[   52.295142] 005:                    irq_create_fwspec_mapping+0x10c/0x318
[   52.295150] 005:                    irq_create_of_mapping+0xa0/0xf0
[   52.295158] 005:                    irq_of_parse_and_map+0x38/0x60
[   52.295166] 005:                    gic_of_init+0x338/0x43c
[   52.295177] 005:                    of_irq_init+0x17c/0x2dc
[   52.295185] 005:                    irqchip_init+0x14/0x38
[[   52.295194] 005:                    init_IRQ+0x190/0x1c8
  OK  [   52.295201] 005:                    start_kernel+0x304/0x47c
] [   52.295210] 005:  }
Started Daily Cleanup of[   52.295213] 005:  ... key      at: [<ffff0000128b9420
>] irq_desc_lock_class+0x0/0x8
 Temporary Directories.[   52.295224] 005:  ... acquired at:
 
[   52.295228] 005:    lock_acquire+0xf8/0x318
[   52.295235] 005:    rt_spin_lock+0x48/0x70
[   52.295243] 005:    iommu_dma_map_msi_msg+0x5c/0x1d8
[   52.295249] 005:    gicv2m_compose_msi_msg+0x3c/0x48
[   52.295256] 005:    irq_chip_compose_msi_msg+0x40/0x58
[   52.295264] 005:    msi_domain_activate+0x38/0x98
[   52.295272] 005:    __irq_domain_activate_irq+0x58/0xa0
[[   52.295279] 005:    irq_domain_activate_irq+0x34/0x58
  OK  [   52.295287] 005:    irq_activate+0x28/0x30
] [   52.295294] 005:    __setup_irq+0x2b0/0x6c0
Started ACPI Events Chec[   52.295303] 005:    request_threaded_irq+0xdc/0x188
k.[   52.295312] 005:    sky2_setup_irq+0x44/0xf8
[   52.295320] 005:    sky2_open+0x1a4/0x240
 
[   52.295328] 005:    __dev_open+0xd8/0x188
[   52.295337] 005:    __dev_change_flags+0x164/0x1f0
[   52.295344] 005:    dev_change_flags+0x20/0x60
[   52.295352] 005:    do_setlink+0x2a0/0xd30
[   52.295360] 005:    __rtnl_newlink+0x5b4/0x6d8
[   52.295368] 005:    rtnl_newlink+0x50/0x78
[   52.295376] 005:    rtnetlink_rcv_msg+0x178/0x640
[   52.295384] 005:    netlink_rcv_skb+0x58/0x118
[   52.295392] 005:    rtnetlink_rcv+0x14/0x20
[   52.295400] 005:    netlink_unicast+0x188/0x200
[   52.295407] 005:    netlink_sendmsg+0x248/0x3d8
[   52.295414] 005:    sock_sendmsg+0x18/0x40
[   52.295424] 005:    ___sys_sendmsg+0x294/0x2d0
[[   52.295433] 005:    __sys_sendmsg+0x68/0xb8
  OK  [   52.295440] 005:    __arm64_sys_sendmsg+0x20/0x28
] [   52.295447] 005:    el0_svc_common+0x90/0x118
Reached target Paths[   52.295456] 005:    el0_svc_handler+0x2c/0x80
.[   52.295465] 005:    el0_svc+0x8/0xc
 
[   52.295471] 005:
[   52.295476] 005:
[   52.295476] 005: the dependencies between the lock to be acquired
[   52.295477] 005:  and HARDIRQ-irq-unsafe lock:
[   52.295487] 005: -> (&cookie->msi_lock){+.+.} ops: 2 {
[   52.295504] 005:    HARDIRQ-ON-W at:
[[   52.295508] 005:                     lock_acquire+0xf8/0x318
  OK  [   52.295516] 005:                     rt_spin_lock+0x48/0x70
] [   52.295524] 005:                     iommu_dma_map_msi_msg+0x5c/0x1d8
Started Daily rotation o[   52.295531] 005:                     gicv2m_compose_m
si_msg+0x3c/0x48
f log files.
[   52.295538] 005:                     irq_chip_compose_msi_msg+0x40/0x58
[   52.295545] 005:                     msi_domain_activate+0x38/0x98
[   52.295554] 005:                     __irq_domain_activate_irq+0x58/0xa0
[[   52.295562] 005:                     irq_domain_activate_irq+0x34/0x58
  OK  [   52.295570] 005:                     msi_domain_alloc_irqs+0x158/0x2b0
] [   52.295579] 005:                     pci_msi_setup_msi_irqs+0x38/0x40
Started Daily apt downlo[   52.295589] 005:                     __pci_enable_msi
_range+0x24c/0x428
ad activities.[   52.295596] 005:                     pci_enable_msi+0x18/0x28
 
[   52.295603] 005:                     sky2_probe+0x40c/0x988
[   52.295611] 005:                     local_pci_probe+0x3c/0xb0
[   52.295619] 005:                     pci_device_probe+0x128/0x1e8
[   52.295626] 005:                     really_probe+0x1c8/0x298
[[   52.295635] 005:                     driver_probe_device+0x60/0x108
  OK  [   52.295644] 005:                     __driver_attach+0xfc/0x138
] [   52.295653] 005:                     bus_for_each_dev+0x70/0xc0
Started Daily apt upgrad[   52.295662] 005:                     driver_attach+0x
20/0x28
e and clean activities.[   52.295670] 005:                     bus_add_driver+0x
1b8/0x238
 
[   52.295679] 005:                     driver_register+0x60/0x110
[   52.295688] 005:                     __pci_register_driver+0x78/0x88
[   52.295695] 005:                     sky2_init_module+0x2c/0x34
[  OK  ] [   52.295704] 005:                     do_one_initcall+0xa0/0x528
Reached target Timers[   52.295712] 005:                     kernel_init_freeabl
e+0x6ec/0x784
.
[   52.295722] 005:                     kernel_init+0x10/0x118
[   52.295730] 005:                     ret_from_fork+0x10/0x18
[   52.295741] 005:    SOFTIRQ-ON-W at:
[   52.295745] 005:                     lock_acquire+0xf8/0x318
[   52.295753] 005:                     rt_spin_lock+0x48/0x70
[   52.295760] 005:                     iommu_dma_map_msi_msg+0x5c/0x1d8
[   52.295768] 005:                     gicv2m_compose_msi_msg+0x3c/0x48
[   52.295775] 005:                     irq_chip_compose_msi_msg+0x40/0x58
[   52.295782] 005:                     msi_domain_activate+0x38/0x98
[   52.295791] 005:                     __irq_domain_activate_irq+0x58/0xa0
[   52.295799] 005:                     irq_domain_activate_irq+0x34/0x58
[  OK  [   52.295807] 005:                     msi_domain_alloc_irqs+0x158/0x2b0
] Listening on ACPID List[   52.295815] 005:                     pci_msi_setup_m
si_irqs+0x38/0x40
en Socket.
[   52.295825] 005:                     __pci_enable_msi_range+0x24c/0x428
[   52.295832] 005:                     pci_enable_msi+0x18/0x28
[   52.295838] 005:                     sky2_probe+0x40c/0x988
[  OK  ] [   52.295847] 005:                     local_pci_probe+0x3c/0xb0
Listening on D-Bus Syste[   52.295854] 005:                     pci_device_probe
+0x128/0x1e8
m Message Bus Socket.
[   52.295862] 005:                     really_probe+0x1c8/0x298
[   52.295871] 005:                     driver_probe_device+0x60/0x108
[   52.295880] 005:                     __driver_attach+0xfc/0x138
[   52.295889] 005:                     bus_for_each_dev+0x70/0xc0
[   52.295897] 005:                     driver_attach+0x20/0x28
[   52.295905] 005:                     bus_add_driver+0x1b8/0x238
[   52.295914] 005:                     driver_register+0x60/0x110
[   52.295923] 005:                     __pci_register_driver+0x78/0x88
[   52.295930] 005:                     sky2_init_module+0x2c/0x34
[[   52.295938] 005:                     do_one_initcall+0xa0/0x528
  OK  [   52.295946] 005:                     kernel_init_freeable+0x6ec/0x784
[   52.295956] 005:                     kernel_init+0x10/0x118
] [   52.295964] 005:                     ret_from_fork+0x10/0x18
Listening on Docker Sock[   52.295974] 005:    INITIAL USE at:
et for the API.[   52.295978] 005:                    lock_acquire+0xf8/0x318
 
[   52.295986] 005:                    rt_spin_lock+0x48/0x70
[   52.295994] 005:                    iommu_dma_map_msi_msg+0x5c/0x1d8
[   52.296001] 005:                    gicv2m_compose_msi_msg+0x3c/0x48
[   52.296008] 005:                    irq_chip_compose_msi_msg+0x40/0x58
[   52.296015] 005:                    msi_domain_activate+0x38/0x98
[   52.296023] 005:                    __irq_domain_activate_irq+0x58/0xa0
[   52.296031] 005:                    irq_domain_activate_irq+0x34/0x58
[   52.296039] 005:                    msi_domain_alloc_irqs+0x158/0x2b0
[   52.296048] 005:                    pci_msi_setup_msi_irqs+0x38/0x40
[   52.296057] 005:                    __pci_enable_msi_range+0x24c/0x428
[   52.296064] 005:                    pci_enable_msi+0x18/0x28
[   52.296071] 005:                    sky2_probe+0x40c/0x988
[   52.296080] 005:                    local_pci_probe+0x3c/0xb0
[   52.296087] 005:                    pci_device_probe+0x128/0x1e8
[[   52.296095] 005:                    really_probe+0x1c8/0x298
  OK  ] [   52.296104] 005:                    driver_probe_device+0x60/0x108
Reached target Sockets
[[   52.295938] 005:  river_attach+0xfc/0x138ne_initcall+0xa0/0x528
0m.[   52.296122] 005:                    bus_for_each_dev+0x70/0xc0x6ec/0x784
[   52.295956] 005:                     kernel_init+0x10/0x118
[   52.296130] 005:                    driver_attach+0x20/0x28x18
[   52.296139] 005:                    bus_add_driver+0x1b8/0x238
[   52.296147] 005:                    driver_register+0x60/0x110e+0xf8/0x318
[   52.296156] 005:                    __pci_register_driver+0x78/0x88
[[   52.296163] 005:                    sky2_init_module+0x2c/0x34
  OK  [   52.296172] 005:                    do_one_initcall+0xa0/0x528
] [   52.296179] 005:                    kernel_init_freeable+0x6ec/0x784
Reached target Basic Sys[   52.296189] 005:                    kernel_init+0x10/
0x1182.296015] 005:                    msi_domain_activate+0x38/0x98
tem.[   52.296197] 005:                    ret_from_fork+0x10/0x18x58/0xa0
[   52.296031] 005:                    irq_domain_activate_irq+0x34/0x58
[   52.296205] 005:  }                 msi_domain_alloc_irqs+0x158/0x2b0
[   52.296208] 005:  ... key      at: [<ffff0000128fdb90>] __key.44800+0x0/0x8
[   52.296219] 005:  ... acquired at:  __pci_enable_msi_range+0x24c/0x428
[   52.296223] 005:    lock_acquire+0xf8/0x318ble_msi+0x18/0x28
[   52.296230] 005:    rt_spin_lock+0x48/0x70robe+0x40c/0x988
[   52.296238] 005:    iommu_dma_map_msi_msg+0x5c/0x1d80x3c/0xb0
[   52.296244] 005:    gicv2m_compose_msi_msg+0x3c/0x48+0x128/0x1e8
         [   52.296251] 005:    irq_chip_compose_msi_msg+0x40/0x58
Starting Deferred execut[   52.296258] 005:    msi_domain_activate+0x38/0x988
ion scheduler...[   52.296266] 005:    __irq_domain_activate_irq+0x58/0xa0
[   52.296274] 005:    irq_domain_activate_irq+0x34/0x58
 
[   52.296282] 005:    irq_activate+0x28/0x30
[   52.296288] 005:    __setup_irq+0x2b0/0x6c0
[   52.296297] 005:    request_threaded_irq+0xdc/0x188
[   52.296306] 005:    sky2_setup_irq+0x44/0xf8
[   52.296314] 005:    sky2_open+0x1a4/0x240
         [   52.296322] 005:    __dev_open+0xd8/0x188
Starting System Logging S[   52.296329] 005:    __dev_change_flags+0x164/0x1f0
ervice...
[   52.296337] 005:    dev_change_flags+0x20/0x60
[   52.296345] 005:    do_setlink+0x2a0/0xd30
[   52.296353] 005:    __rtnl_newlink+0x5b4/0x6d8
[   52.296361] 005:    rtnl_newlink+0x50/0x78
[   52.296369] 005:    rtnetlink_rcv_msg+0x178/0x640
[   52.296376] 005:    netlink_rcv_skb+0x58/0x118
[   52.296384] 005:    rtnetlink_rcv+0x14/0x20
[   52.296391] 005:    netlink_unicast+0x188/0x200
[   52.296398] 005:    netlink_sendmsg+0x248/0x3d8
[   52.296405] 005:    sock_sendmsg+0x18/0x40
[   52.296414] 005:    ___sys_sendmsg+0x294/0x2d0
[   52.296423] 005:    __sys_sendmsg+0x68/0xb8
[   52.296430] 005:    __arm64_sys_sendmsg+0x20/0x28
[   52.296437] 005:    el0_svc_common+0x90/0x118
[   52.296446] 005:    el0_svc_handler+0x2c/0x80
[   52.296454] 005:    el0_svc+0x8/0xc
[   52.296461] 005:
[   52.296464] 005:
[   52.296464] 005: stack backtrace:
         Starting Login Service...
[   52.296469] 005: CPU: 5 PID: 2108 Comm: ip Not tainted 5.0.3-rt1-00007-g42ede
9a0fed6 #43
[   52.296477] 005: Hardware name: ARM LTD ARM Juno Development Platform/ARM Jun
o Development Platform, BIOS EDK II Jan 23 2017
[   52.296483] 005: Call trace:
[   52.296486] 005:  dump_backtrace+0x0/0x140
[   52.296493] 005:  show_stack+0x14/0x20
[   52.296499] 005:  dump_stack+0xa0/0xd4
[   52.296506] 005:  check_usage+0x4e8/0x590
[   52.296513] 005:  __lock_acquire+0xf3c/0x2020
[   52.296520] 005:  lock_acquire+0xf8/0x318
[   52.296527] 005:  rt_spin_lock+0x48/0x70
[   52.296534] 005:  iommu_dma_map_msi_msg+0x5c/0x1d8
[   52.296540] 005:  gicv2m_compose_msi_msg+0x3c/0x48
[   52.296547] 005:  irq_chip_compose_msi_msg+0x40/0x58
[   52.296554] 005:  msi_domain_activate+0x38/0x98
[   52.296562] 005:  __irq_domain_activate_irq+0x58/0xa0
[   52.296569] 005:  irq_domain_activate_irq+0x34/0x58
[   52.296577] 005:  irq_activate+0x28/0x30
         Starting LSB: Xen[   52.296583] 005:  __setup_irq+0x2b0/0x6c0
 daemons...
[   52.296591] 005:  request_threaded_irq+0xdc/0x188
[   52.296599] 005:  sky2_setup_irq+0x44/0xf8
[   52.296607] 005:  sky2_open+0x1a4/0x240
[   52.296615] 005:  __dev_open+0xd8/0x188
[   52.296622] 005:  __dev_change_flags+0x164/0x1f0
[   52.296630] 005:  dev_change_flags+0x20/0x60
[   52.296637] 005:  do_setlink+0x2a0/0xd30
[   52.296645] 005:  __rtnl_newlink+0x5b4/0x6d8
[   52.296652] 005:  rtnl_newlink+0x50/0x78
[   52.296660] 005:  rtnetlink_rcv_msg+0x178/0x640
[   52.296667] 005:  netlink_rcv_skb+0x58/0x118
[   52.296675] 005:  rtnetlink_rcv+0x14/0x20
[   52.296682] 005:  netlink_unicast+0x188/0x200
[   52.296688] 005:  netlink_sendmsg+0x248/0x3d8
[   52.296695] 005:  sock_sendmsg+0x18/0x40
[   52.296704] 005:  ___sys_sendmsg+0x294/0x2d0
[   52.296712] 005:  __sys_sendmsg+0x68/0xb8
[   52.296718] 005:  __arm64_sys_sendmsg+0x20/0x28
[   52.296725] 005:  el0_svc_common+0x90/0x118
[   52.296733] 005:  el0_svc_handler+0x2c/0x80
[   52.296742] 005:  el0_svc+0x8/0xc
[  OK  ] Started Regular background program processing daemon.
[   52.296750] 005: BUG: sleeping function called from invalid context at kernel
/locking/rtmutex.c:974
[   52.296756] 005: in_atomic(): 1, irqs_disabled(): 128, pid: 2108, name: ip
[   52.296762] 005: INFO: lockdep is turned off.
[   52.296766] 005: irq event stamp: 9572
[   52.296770] 005: hardirqs last  enabled at (9571): [<ffff0000110d2568>] _raw_
spin_unlock_irqrestore+0x88/0x90
[   52.296780] 005: hardirqs last disabled at (9572): [<ffff0000110d2324>] _raw_
spin_lock_irqsave+0x24/0x68
[   52.296790] 005: softirqs last  enabled at (0): [<ffff0000100ec690>] copy_pro
cess.isra.1.part.2+0x8d8/0x1970
[   52.296803] 005: softirqs last disabled at (0): [<0000000000000000>]
  (null)
[   52.296810] 005: Preemption disabled at:
[  OK  ] Started
fff000010189c18>] __setup_irq+0xd8/0x6c048/0x3d8
mACPI event daemon.  sock_sendmsg+0x18/0x40
[   52.296824] 005: CPU: 5 PID: 2108 Comm: ip Not tainted 5.0.3-rt1-00007-g42ede
9a0fed6 #4312] 005:  __sys_sendmsg+0x68/0xb8
[   52.296831] 005: Hardware name: ARM LTD ARM Juno Development Platform/ARM Jun
o Development Platform, BIOS EDK II Jan 23 2017
[   52.296836] 005: Call trace:ndler+0x2c/0x80
[   52.296839] 005:  dump_backtrace+0x0/0x140
[   52.296846] 005:  show_stack+0x14/0x20am processing daemon.
[   52.296852] 005:  dump_stack+0xa0/0xd4n called from invalid context at kernel
[   52.296858] 005:  ___might_sleep+0x16c/0x1f8
[   52.296867] 005:  rt_spin_lock+0x5c/0x70sabled(): 128, pid: 2108, name: ip
[   52.296874] 005:  iommu_dma_map_msi_msg+0x5c/0x1d8
[   52.296881] 005:  gicv2m_compose_msi_msg+0x3c/0x48
[   52.296888] 005:  irq_chip_compose_msi_msg+0x40/0x58<ffff0000110d2568>] _raw_
[   52.296895] 005:  msi_domain_activate+0x38/0x98
[   52.296902] 005:  __irq_domain_activate_irq+0x58/0xa0ffff0000110d2324>] _raw_
[   52.296910] 005:  irq_domain_activate_irq+0x34/0x58
[   52.296917] 005:  irq_activate+0x28/0x30at (0): [<ffff0000100ec690>] copy_pro
[   52.296923] 005:  __setup_irq+0x2b0/0x6c0
[   52.296931] 005:  request_threaded_irq+0xdc/0x188<0000000000000000>]
[   52.296940] 005:  sky2_setup_irq+0x44/0xf8
[   52.296947] 005:  sky2_open+0x1a4/0x240:
[   52.296955] 005:  __dev_open+0xd8/0x188
[[   52.296962] 005:  __dev_change_flags+0x164/0x1f0
[   52.296970] 005:  dev_change_flags+0x20/0x60
  OK  [   52.296977] 005:  do_setlink+0x2a0/0xd30
] [   52.296985] 005:  __rtnl_newlink+0x5b4/0x6d8
[   52.296993] 005:  rtnl_newlink+0x50/0x78
Started D-Bus System Mes[   52.297000] 005:  rtnetlink_rcv_msg+0x178/0x640
sage Bus.[   52.297008] 005:  netlink_rcv_skb+0x58/0x118
[   52.297015] 005:  rtnetlink_rcv+0x14/0x20
 
[   52.297022] 005:  netlink_unicast+0x188/0x200
[   52.297028] 005:  netlink_sendmsg+0x248/0x3d8
[   52.297035] 005:  sock_sendmsg+0x18/0x40
[   52.297044] 005:  ___sys_sendmsg+0x294/0x2d0
[   52.297053] 005:  __sys_sendmsg+0x68/0xb8
[   52.297059] 005:  __arm64_sys_sendmsg+0x20/0x28
[   52.297066] 005:  el0_svc_common+0x90/0x118
[   52.297074] 005:  el0_svc_handler+0x2c/0x80
[   52.297082] 005:  el0_svc+0x8/0xc
[   52.300019] 004: sky2 0000:08:00.0 enp8s0: enabling interface
[   52.745020] 001: xenbr0: port 1(enp8s0) entered blocking state
[   52.745028] 001: xenbr0: port 1(enp8s0) entered disabled state
[   52.748480] 004: device enp8s0 entered promiscuous mode
[  OK  ] Started irqbalance daemon.
[  OK  ] Started System Logging Service.
[  OK  ] Started Deferred execution scheduler.
[  OK  ] Started Login Service.
[  OK  ] Started LSB: Xen daemons.
[   55.269085] 000: sky2 0000:08:00.0 enp8s0: Link is up at 1000 Mbps, full dupl
ex, flow control both
[   55.269271] 000: xenbr0: port 1(enp8s0) entered blocking state
[   55.269282] 000: xenbr0: port 1(enp8s0) entered forwarding state
[   55.269660] 000: IPv6: ADDRCONF(NETDEV_CHANGE): xenbr0: link becomes ready
[  OK  ] Started Raise network interfaces.
[  OK  ] Reached target Network.
         Starting Docker Application Container Engine...
         Starting OpenBSD Secure Shell server...
         Starting Permit User Sessions...
[  OK  ] Reached target Network is Online.
         Starting LSB: exim Mail Transport Agent...
         Starting /etc/rc.local Compatibility...
[  OK  ] Started Permit User Sessions.
[  OK  ] Started /etc/rc.local Compatibility.
[  OK  ] Started Getty on tty1.
[  OK  ] Started Serial Getty on ttyAMA0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started OpenBSD Secure Shell server.
[   65.300756] 003: device-mapper: table: 253:6: thin-pool: unknown target type
[   65.300772] 003: device-mapper: ioctl: error adding target to table
[FAILED] Failed to start Docker Application Container Engine.
See 'systemctl status docker.service' for details.
[  OK  ] Started LSB: exim Mail Transport Agent.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.
         Starting Update UTMP about System Runlevel Changes...
[  OK  ] Started Update UTMP about System Runlevel Changes.
 
Debian GNU/Linux buster/sid juno2-julieng ttyAMA0
 
-- 
Julien Grall
