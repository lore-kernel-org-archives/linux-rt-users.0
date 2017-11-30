From: Daniel Wagner <wagi@monom.org>
Subject: Null pointer 4.14.1-rt3
Date: Thu, 30 Nov 2017 15:42:06 +0100
Message-ID: <80ce7c3e-2d01-f082-9c21-fc1084a836c8@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.monom.org ([188.138.9.77]:38004 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752566AbdK3OmK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Nov 2017 09:42:10 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Fresh after a boot I just got this:


root@beaglebone:~# cyclictest -p 80 -n -m 
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.62 0.19 0.07 1/65 361          

T: 0 (  361) P:80 I:1000 C:    [   46.747855] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   46.747863] pgd = db048000
[   46.747869] [00000000] *pgd=9b0a0831, *pte=00000000, *ppte=00000000
[   46.747901] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
[   46.747911] Modules linked in:
[   46.747927] CPU: 0 PID: 361 Comm: cyclictest Not tainted 4.14.1-rt3 #9
[   46.747930] Hardware name: Generic AM33XX (Flattened Device Tree)
[   46.747935] task: db225d00 task.stack: db164000
[   46.747944] PC is at 0x0
[   46.747960] LR is at smp_cross_call+0x40/0x160
[   46.747965] pc : [<00000000>]    lr : [<c010f15c>]    psr: 600a0093
[   46.747969] sp : db165d48  ip : db165d70  fp : db165d6c
[   46.747973] r10: c0905280  r9 : db226198  r8 : c01849dc
[   46.747977] r7 : df949050  r6 : c12f63c8  r5 : 00000003  r4 : c09049e0
[   46.747982] r3 : 00000000  r2 : c09049dc  r1 : 00000003  r0 : c09049e0
[   46.747988] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   46.747994] Control: 10c5387d  Table: 9b048019  DAC: 00000051
[   46.747999] Process cyclictest (pid: 361, stack limit = 0xdb164218)
[   46.748004] Stack: (0xdb165d48 to 0xdb166000)
[   46.748014] 5d40:                   00000000 dd823c84 00000000 df949050 c01849dc db226198
[   46.748024] 5d60: db165d7c db165d70 c010f990 c010f128 db165d94 db165d80 c024c1b8 c010f964
[   46.748033] 5d80: 00000000 df949040 db165ddc db165d98 c0183550 c024c120 df9494d4 df949040
[   46.748043] 5da0: db225d00 eef452d7 00000003 00000000 db165ddc df949040 db225d00 db165e2c
[   46.748052] 5dc0: df949050 df949040 db226198 c0905280 db165e04 db165de0 c01849dc c0183228
[   46.748062] 5de0: df949040 db225d00 db226190 00000000 df949040 db226198 db165e64 db165e08
[   46.748071] 5e00: c0880ff0 c0184990 200a0013 df944780 db165e34 db165e20 c0885344 00000001
[   46.748080] 5e20: c08813b8 df949050 00000000 00000000 00003c48 00000004 db165e64 db225d00
[   46.748089] 5e40: ffffe000 00000000 00000000 00000000 00000001 c0884804 db165e7c db165e68
[   46.748099] 5e60: c08813b8 c0880a4c db165ee8 ffffe000 db165edc db165e80 c0884864 c0881368
[   46.748108] 5e80: 00000000 00000000 00000000 00000001 c12104e8 db225d00 db165edc db165ea8
[   46.748117] 5ea0: c01cbd30 c01cb9e0 db165eec db165eb8 c01a80d4 00000000 00000001 e2624454
[   46.748127] 5ec0: 0000000a 00000000 00000000 db165f70 db165f4c db165ee0 c01cd350 c088477c
[   46.748136] 5ee0: e2624454 0000000a 00000001 c12fdfe0 df944d90 00000000 e2624454 0000000a
[   46.748145] 5f00: e2624454 0000000a c01cbe50 df944848 00000001 00000000 db225d00 c0906558
[   46.748155] 5f20: db165f70 c0906558 db225d00 00000001 00000001 b6d5b8e0 db164000 00000000
[   46.748164] 5f40: db165f5c db165f50 c01cd478 c01cd254 db165f6c db165f60 c01d6c6c c01cd468
[   46.748174] 5f60: db165fa4 db165f70 c01d87bc c01d6c4c 0000002e 00000000 2c91f854 c01c7340
[   46.748183] 5f80: 0000002e 00000001 00000000 b6d5b8e0 00000109 c0108564 00000000 db165fa8
[   46.748192] 5fa0: c01083a0 c01d8704 00000001 00000000 00000001 00000001 b6d5b8e0 00000000
[   46.748201] 5fc0: 00000001 00000000 b6d5b8e0 00000109 c4653600 0002d030 0002a4e0 88ca6c00
[   46.748210] 5fe0: 00000000 b6d5b880 00000000 b6e3a52c 800a0010 00000001 00000000 00000000
[   46.748234] [<c010f15c>] (smp_cross_call) from [<c010f990>] (arch_send_call_function_single_ipi+0x38/0x40)
[   46.748253] [<c010f990>] (arch_send_call_function_single_ipi) from [<c024c1b8>] (irq_work_queue_on+0xa4/0x114)
[   46.748277] [<c024c1b8>] (irq_work_queue_on) from [<c0183550>] (pull_rt_task+0x334/0x354)
[   46.748290] [<c0183550>] (pull_rt_task) from [<c01849dc>] (pick_next_task_rt+0x58/0x2bc)
[   46.748311] [<c01849dc>] (pick_next_task_rt) from [<c0880ff0>] (__schedule+0x5b0/0x91c)
[   46.748322] [<c0880ff0>] (__schedule) from [<c08813b8>] (schedule+0x5c/0xfc)
[   46.748334] [<c08813b8>] (schedule) from [<c0884864>] (do_nanosleep+0xf4/0x20c)
[   46.748350] [<c0884864>] (do_nanosleep) from [<c01cd350>] (__hrtimer_nanosleep+0x108/0x184)
[   46.748361] [<c01cd350>] (__hrtimer_nanosleep) from [<c01cd478>] (hrtimer_nanosleep+0x1c/0x20)
[   46.748372] [<c01cd478>] (hrtimer_nanosleep) from [<c01d6c6c>] (common_nsleep+0x2c/0x30)
[   46.748383] [<c01d6c6c>] (common_nsleep) from [<c01d87bc>] (SyS_clock_nanosleep+0xc4/0x110)
[   46.748400] [<c01d87bc>] (SyS_clock_nanosleep) from [<c01083a0>] (ret_fast_syscall+0x0/0x28)
[   46.748410] Code: bad PC value



omap2plus_defconfig +

CONFIG_PREEMPT_RT_FULL=y

CONFIG_CMDLINE="console=ttyO0,115200 root=/dev/mmcblk1p2"

CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE="/home/wagi/work/cip/core-image-minimal-beaglebone.cpio.xz"

CONFIG_CPU_FREQ=n
CONFIG_CPU_IDLE=n

CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_PROVE_LOCKING=n

CONFIG_NO_HZ=n
CONFIG_HZ_PERIODIC=y

CONFIG_HZ_1000=y
CONFIG_HZ=1000


CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_INTERRUPT_OFF_HIST=y
CONFIG_PREEMPT_OFF_HIST=y
CONFIG_WAKEUP_LATENCY_HIST=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_MISSED_TIMER_OFFSETS_HIST=y
CONFIG_ENABLE_DEFAULT_TRACERS=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y


cheers,
Daniel
