From: Bob Liu <lliubbo@gmail.com>
Subject: [HELP] Bug: Badness at kernel/rcutree_plugin.h
Date: Wed, 1 Sep 2010 17:21:37 +0800
Message-ID: <AANLkTinW5jAJPTE__dVhzGAkLJg-ni6jmrL=h+W_pwi+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44173 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab0IAJVi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Sep 2010 05:21:38 -0400
Received: by qwh6 with SMTP id 6so6105396qwh.19
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Sep 2010 02:21:37 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, All

I try to patch the 2.6.33.7-rt29 to 2.6.34.6.
Now I can boot the kernel successfully without config SCSI.
But if I add SCSI support in kernel config it always failed. Detail
log is below.
Is there any suggestion?
Thanks a lot!

=======================================
Blackfin support (C) 2004-2010 Analog Devices, Inc.
Compiled for ADSP-BF548 Rev 0.2
Blackfin Linux support by http://blackfin.uclinux.org/
Processor Speed: 525 MHz core clock and 131 MHz System Clock
NOMPU: setting up cplb tables
Instruction Cache Enabled for CPU0
  External memory: cacheable in instruction cache
  L2 SRAM        : uncacheable in instruction cache
Data Cache Enabled for CPU0
  External memory: cacheable (write-through) in data cache
  L2 SRAM        : uncacheable in data cache
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 15748
Kernel command line: root=/dev/mtdblock0 rw
earlyprintk=serial,uart1,57600 console=ttyBF1,57600
ip=10.100.4.50:10.100.4.174:10.99.29.1:255.255.255.0:bf548-ezkit:eth0:off
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory available: 52664k/65536k RAM, (7664k init code, 1757k kernel
code, 831k data, 2048k dma, 572k reserved)
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Experimental preemptable hierarchical RCU implementation.
NR_IRQS:295
Configuring Blackfin Priority Driven Interrupts
Console: colour dummy device 80x25
console [ttyBF1] enabled, bootconsole disabled
console [ttyBF1] enabled, bootconsole disabled
Calibrating delay loop... 1044.48 BogoMIPS (lpj=2088960)
Mount-cache hash table entries: 512
Blackfin Scratchpad data SRAM: 4 KB
Blackfin L1 Data A SRAM: 16 KB (16 KB free)
Blackfin L1 Data B SRAM: 16 KB (16 KB free)
Blackfin L1 Instruction SRAM: 48 KB (41 KB free)
Blackfin L2 SRAM: 128 KB (128 KB free)
NET: Registered protocol family 16
Blackfin DMA Controller
ezkit_init(): registering device resources
bio: create slab <bio-0> at 0
------------[ cut here ]------------
Badness at kernel/rcutree_plugin.h:132

ADSP-BF548-0.2 525(MHz CCLK) 131(MHz SCLK) (mpu off)
Linux version 2.6.34.6-rt-ADI-2010R1-pre-svn9115 (root@adam-desktop)
(gcc version 4.3.5 (ADI-trunk/svn-4813) ) #74 PREEMPT RT Wed Sep 1
17:11:32 CST 2010

SEQUENCER STATUS:               Not tainted
 SEQSTAT: 00000021  IPEND: 8008  IMASK: 003f  SYSCFG: 0006
  Peripheral interrupts masked off
  Kernel interrupts masked off
  EXCAUSE   : 0x21
  physical IVG3 asserted : <0xffa007c4> { _trap + 0x0 }
  physical IVG15 asserted : <0xffa010b8> { _evt_system_call + 0x0 }
  logical irq   6 mapped  : <0xffa003fc> { _bfin_coretmr_interrupt + 0x0 }
 RETE: <0x00000000> /* Maybe null pointer? */
Double Fault
Kernel OOPS in progress
Deferred Exception context
CURRENT PROCESS:
COMM= PID=33676352  CPU=0
invalid mm
return address: [0x0000776c]; contents of:
0x00007740:  0c05  e10c  7860  e12f  00d0  b1f5  0204  5abc
0x00007750:  9152  e149  0026  e109  7860  3262  443c  084c
0x00007760:  1920  020c  1859  0000  0000  0000 [e425] 003b
0x00007770:  0c05  1bee  321d  6d63  3043  e301  3251  0c00

ADSP-BF548-0.2 525(MHz CCLK) 131(MHz SCLK) (mpu off)
Linux version 2.6.34.6-rt-ADI-2010R1-pre-svn9115 (root@adam-desktop)
(gcc version 4.3.5 (ADI-trunk/svn-4813) ) #74 PREEMPT RT Wed Sep 1
17:11:32 CST 2010

SEQUENCER STATUS:               Not tainted
 SEQSTAT: 00060024  IPEND: 8028  IMASK: 003f  SYSCFG: 0006
  Peripheral interrupts masked off
  Kernel interrupts masked off
  EXCAUSE   : 0x24
  physical IVG3 asserted : <0xffa007c4> { _trap + 0x0 }
  physical IVG5 asserted : <0xffa00dbc> { _evt_ivhw + 0x0 }
  physical IVG15 asserted : <0xffa010b8> { _evt_system_call + 0x0 }
  logical irq   6 mapped  : <0xffa003fc> { _bfin_coretmr_interrupt + 0x0 }
 RETE: <0x00000000> /* Maybe null pointer? */
 RETN: <0x0201f920> /* kernel dynamic memory (maybe user-space) */
 RETX: <0x0000776c> { _decode_address + 0x17c }
 RETS: <0x0000773a> { _decode_address + 0x14a }
 PC  : <0x0000776c> { _decode_address + 0x17c }
DCPLB_FAULT_ADDR: <0x0025cc92> /* kernel dynamic memory (maybe user-space) */
ICPLB_FAULT_ADDR: <0x00034f56> { _rcu_preempt_note_context_switch + 0x10e }
PROCESSOR STATE:
 R0 : 00000000    R1 : 0201e000    R2 : 0201e000    R3 : 00000004
 R4 : 00000000    R5 : 0000100d    R6 : 0201fd68    R7 : 0201fb11
 P0 : 0026c4f8    P1 : 00267860    P2 : 0201d851    P3 : 0201e008
 P4 : 0201d781    P5 : 0201fb04    FP : 000000d0    SP : 0201f844
 LB0: 000be334    LT0: 000be332    LC0: 00000000
 LB1: 000bd312    LT1: 000bd308    LC1: 00000000
 B0 : 0000001b    L0 : 00000000    M0 : ffffffff    I0 : 00000000
 B1 : 00000000    L1 : 00000000    M1 : 00000000    I1 : 001c5194
 B2 : 00000000    L2 : 00000000    M2 : 00000000    I2 : 00000020
 B3 : 00000000    L3 : 00000000    M3 : 00000000    I3 : 0000000f
A0.w: 020d0000   A0.x: 00000000   A1.w: 000036da   A1.x: 00000000
USP : 00000000  ASTAT: 02003045

Hardware Trace:
   0 Target : <0x00003ff8> { _trap_c + 0x0 }
     Source : <0xffa00758> { _exception_to_level5 + 0xa4 } JUMP.L
   1 Target : <0xffa006b4> { _exception_to_level5 + 0x0 }
     Source : <0xffa00568> { _bfin_return_from_exception + 0x18 } RTX
   2 Target : <0xffa00550> { _bfin_return_from_exception + 0x0 }
     Source : <0xffa0060c> { _ex_trap_c + 0x74 } JUMP.S
   3 Target : <0xffa00598> { _ex_trap_c + 0x0 }
     Source : <0xffa0081e> { _trap + 0x5a } JUMP (P4)
   4 Target : <0xffa007c4> { _trap + 0x0 }
      FAULT : <0x00034f56> { _rcu_preempt_note_context_switch + 0x10e } BUG
     Source : <0x00034f54> { _rcu_preempt_note_context_switch + 0x10c
} IF !CC JUMP pcrel (BP)
   5 Target : <0x00034f48> { _rcu_preempt_note_context_switch + 0x100 }
     Source : <0x00034eec> { _rcu_preempt_note_context_switch + 0xa4 }
IF !CC JUMP pcrel
   6 Target : <0x00034ec6> { _rcu_preempt_note_context_switch + 0x7e }
     Source : <0x0000b7a8> { _add_preempt_count + 0x2c } RTS
   7 Target : <0x0000b7a4> { _add_preempt_count + 0x28 }
     Source : <0x0000b7da> { _add_preempt_count + 0x5e } IF CC JUMP pcrel (BP)
   8 Target : <0x0000b7d2> { _add_preempt_count + 0x56 }
     Source : <0x0000b7a2> { _add_preempt_count + 0x26 } IF CC JUMP pcrel
   9 Target : <0x0000b790> { _add_preempt_count + 0x14 }
     Source : <0x0000b7b6> { _add_preempt_count + 0x3a } IF !CC JUMP pcrel (BP)
  10 Target : <0x0000b7aa> { _add_preempt_count + 0x2e }
     Source : <0x0000b78e> { _add_preempt_count + 0x12 } IF CC JUMP pcrel
  11 Target : <0x0000b77c> { _add_preempt_count + 0x0 }
     Source : <0x00034ec2> { _rcu_preempt_note_context_switch + 0x7a } JUMP.L
  12 Target : <0x00034eaa> { _rcu_preempt_note_context_switch + 0x62 }
     Source : <0x00034e68> { _rcu_preempt_note_context_switch + 0x20 }
IF CC JUMP pcrel
  13 Target : <0x00034e48> { _rcu_preempt_note_context_switch + 0x0 }
     Source : <0x00034f88> { _rcu_sched_qs + 0x14 } CALL pcrel
  14 Target : <0x00034f74> { _rcu_sched_qs + 0x0 }
     Source : <0x001b668a> { ___schedule + 0xe } JUMP.L
  15 Target : <0x001b6686> { ___schedule + 0xa }
     Source : <0x000c15f8> { _debug_smp_processor_id + 0x20 } RTS
Kernel panic - not syncing: Double Fault - unrecoverable event

-- 
Regards,
--Bob
