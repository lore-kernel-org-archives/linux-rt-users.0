From: "Arnaud B." <discipleze1@gmail.com>
Subject: Re: Possible kernel regression between 3.0.31-rt51 and 3.4.x on PPC64 ?
Date: Thu, 12 Jul 2012 15:11:44 +0200
Message-ID: <CAJVbuyo3Y6=n6c-wyNsZgxAM0dkwiPrP7oN6aOMP=ozRtFJSug@mail.gmail.com>
References: <CAJVbuyqRZqtBat9hGWqK=EN1U4LA3uuQbwBmeazV83AuAP+Crg@mail.gmail.com>
	<4FFDBE71.2000705@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53815 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab2GLNLq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2012 09:11:46 -0400
Received: by wibhr14 with SMTP id hr14so2244293wib.1
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2012 06:11:44 -0700 (PDT)
In-Reply-To: <4FFDBE71.2000705@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Here are 2 crash logs. One is normal booting, the other is with
CONFIG_DEBUG_RT_MUTEXES choosen.
for sure w in rt_mutex_top_waiter, return by plist_first_entry is
corrupted. There is even ASCII in it from time to time :p

Without CONFIG_DEBUG_RT_MUTEXES:

w:0xc000000000beb700 w.lock:0x766500005f6e6c5f lock:0xc000000007900710
waitlist:0xc000000007900718
cpu 0x0: Vector: 700 (Program Check) at [c0000000fb0eb940]
    pc: c00000000009d934: .wakeup_next_waiter+0x7c/0xe8
    lr: c00000000009d920: .wakeup_next_waiter+0x68/0xe8
    sp: c0000000fb0ebbc0
   msr: 80029200
  current = 0xc0000000fb0d8040
  paca    = 0xc00000000fff9000   softe: 0        irq_happened: 0x09
    pid   = 3, comm = ksoftirqd/0
kernel BUG at /home/arnaud/ALU/KERNEL_34/TRY_12JUIL_64/build/linux/kernel/rtmutex_common.h:83!
enter ? for help
[c0000000fb0ebc50] c000000000825d94 .rt_spin_lock_slowunlock+0xa4/0x11c
[c0000000fb0ebce0] c0000000008267b8 .rt_spin_unlock+0x54/0x64
[c0000000fb0ebd60] c0000000000451e4 .__thread_do_softirq+0x160/0x1b4
[c0000000fb0ebdf0] c0000000000452f8 .run_ksoftirqd+0xc0/0x208
[c0000000fb0ebea0] c00000000006baf0 .kthread+0xb8/0xc4
[c0000000fb0ebf90] c000000000015564 .original_kernel_thread+0x54/0x70

0:mon> d 0xc000000000beb700 <== There shoundn't be ASCII there :D
c000000000beb700 7070656400000000 72616e6765735b63  |pped....ranges[c|
c000000000beb710 6e745d2e66726f6d 203e3d2066726f6d  |nt].from >= from|
c000000000beb720 000000005f6e6c5f 617263686976655f  |...._nl_archive_|
c000000000beb730 7375626672656572 657300002f757372  |subfreeres../usr|

0:mon> t
[c0000000fb0ebc50] c000000000825d94 .rt_spin_lock_slowunlock+0xa4/0x11c
[c0000000fb0ebce0] c0000000008267b8 .rt_spin_unlock+0x54/0x64
[c0000000fb0ebd60] c0000000000451e4 .__thread_do_softirq+0x160/0x1b4
[c0000000fb0ebdf0] c0000000000452f8 .run_ksoftirqd+0xc0/0x208
[c0000000fb0ebea0] c00000000006baf0 .kthread+0xb8/0xc4
[c0000000fb0ebf90] c000000000015564 .original_kernel_thread+0x54/0x70

0:mon> e
cpu 0x0: Vector: 700 (Program Check) at [c0000000fb0eb940]
    pc: c00000000009d934: .wakeup_next_waiter+0x7c/0xe8
    lr: c00000000009d920: .wakeup_next_waiter+0x68/0xe8
    sp: c0000000fb0ebbc0
   msr: 80029200
  current = 0xc0000000fb0d8040
  paca    = 0xc00000000fff9000   softe: 0        irq_happened: 0x09
    pid   = 3, comm = ksoftirqd/0
kernel BUG at /home/arnaud/ALU/KERNEL_34/TRY_12JUIL_64/build/linux/kernel/rtmutex_common.h:83!

0:mon> r
R00 = 0000000000000001   R16 = 0000000000000000
R01 = c0000000fb0ebbc0   R17 = 000000007fe31430
R02 = c000000000df3160   R18 = 0000000000000000
R03 = 0000000000000000   R19 = 000000007ff88068
R04 = c000000000a89f18   R20 = 000000007ff88068
R05 = 0000000000000002   R21 = 000000007ff88068
R06 = 0000000000000006   R22 = 0000000000000000
R07 = 05000affffffffff   R23 = 0000000000000000
R08 = 0000000000000063   R24 = 0000000000000001
R09 = b665000058fe6b4e   R25 = 0000000000000000
R10 = 000000000000000f   R26 = c000000000c88dd0
R11 = 0000000000000001   R27 = c0000000fb0e8080
R12 = 0000000024044044   R28 = 0000000000000000
R13 = c00000000fff9000   R29 = c000000000beb700
R14 = 0000000000000000   R30 = c000000000d285b8
R15 = 000000007ffa1254   R31 = c000000007900710
pc  = c00000000009d934 .wakeup_next_waiter+0x7c/0xe8
lr  = c00000000009d920 .wakeup_next_waiter+0x68/0xe8
msr = 0000000080029200   cr  = 48044048
ctr = c00000000001ebf4   xer = 0000000020000000   trap =  700

0:mon> S
msr  = 0000000080021200  sprg0= c00000000fff9000
pvr  = 0000000080240010  sprg1= c00000000fff9000
dec  = 0000000000000000  sprg2= c00000000fff9180
sp   = c0000000fb0eb0e0  sprg3= 0000000000000000
cpu 0x0: Vector: 700 (Program Check) at [c0000000fb0eae60]
    pc: c000000000032a64: .cmds+0xcb4/0x1748
    lr: c000000000032a60: .cmds+0xcb0/0x1748
    sp: c0000000fb0eb0e0
   msr: 80021200
  current = 0xc0000000fb0d8040
  paca    = 0xc00000000fff9000   softe: 0        irq_happened: 0x09
    pid   = 3, comm = ksoftirqd/0
cpu 0x0: Exception 700 (Program Check) in xmon, returning to main loop


0:mon> la c00000000009d934
c00000000009d934: .wakeup_next_waiter+0x7c/0xe8

0:mon> di c00000000009d934:
c00000000009d934  0b000000      tdnei   r0,0
c00000000009d938  e88d0388      ld      r4,904(r13)
c00000000009d93c  387d0028      addi    r3,r29,40
c00000000009d940  388406e0      addi    r4,r4,1760
c00000000009d944  483ac9a9      bl      c00000000044a2ec        #
.plist_del+0x0/0x94
c00000000009d948  60000000      nop
c00000000009d94c  e93f0008      ld      r9,8(r31)
c00000000009d950  381f0008      addi    r0,r31,8
c00000000009d954  7d200278      xor     r0,r9,r0
c00000000009d958  3120ffff      addic   r9,r0,-1
c00000000009d95c  7c090110      subfe   r0,r9,r0
c00000000009d960  f81f0018      std     r0,24(r31)
c00000000009d964  e86d0388      ld      r3,904(r13)
c00000000009d968  386306d8      addi    r3,r3,1752
c00000000009d96c  7f84e378      mr      r4,r28
c00000000009d970  48789561      bl      c000000000826ed0        #
._raw_spin_unlock_irqrestore+0x0/0xc8



 CONFIG_DEBUG_RT_MUTEXES:
[    0.337296] ftrace: allocating 23126 entries in 137 pages
[    0.355391] mpic: requesting IPIs...
[    0.412420] e500 family performance monitor hardware support registered
w:0xc000000000bf1780 w.lock:0x          (null) lock:0xc000000007900790
waitlist:0xc000000007900798
cpu 0x0: Vector: 700 (Program Check) at [c0000000fb0eb840]
    pc: c00000000009d4e8: .__try_to_take_rt_mutex+0xa4/0x214
    lr: c00000000009d4d4: .__try_to_take_rt_mutex+0x90/0x214
    sp: c0000000fb0ebac0
   msr: 80029200
  current = 0xc0000000fb0d2040
  paca    = 0xc00000000fff9000   softe: 0        irq_happened: 0x01
    pid   = 3, comm = ksoftirqd/0
kernel BUG at /home/arnaud/ALU/KERNEL_34/TRY_12JUIL_64/build/linux/kernel/rtmutex_common.h:83!
enter ? for help
[c0000000fb0ebb70] c000000000826bc4 .rt_spin_lock_slowlock+0xa4/0x454
[c0000000fb0ebcc0] c0000000008270f8 .rt_spin_lock+0x20/0x30
[c0000000fb0ebd40] c000000000045154 .__thread_do_softirq+0xc4/0x1b4
[c0000000fb0ebdd0] c000000000045304 .run_ksoftirqd+0xc0/0x208
[c0000000fb0ebe80] c00000000006bb08 .kthread+0xb8/0xc4
[c0000000fb0ebf90] c000000000015564 .original_kernel_thread+0x54/0x70

0:mon> e
cpu 0x0: Vector: 700 (Program Check) at [c0000000fb0eb840]
    pc: c00000000009d4e8: .__try_to_take_rt_mutex+0xa4/0x214
    lr: c00000000009d4d4: .__try_to_take_rt_mutex+0x90/0x214
    sp: c0000000fb0ebac0
   msr: 80029200
  current = 0xc0000000fb0d2040
  paca    = 0xc00000000fff9000   softe: 0        irq_happened: 0x01
    pid   = 3, comm = ksoftirqd/0
kernel BUG at /home/arnaud/ALU/KERNEL_34/TRY_12JUIL_64/build/linux/kernel/rtmutex_common.h:83!

0:mon> r
R00 = 0000000000000001   R16 = 0000000000000000
R01 = c0000000fb0ebac0   R17 = 000000007fe31430
R02 = c000000000dfc950   R18 = 0000000000000000
R03 = 0000000000000000   R19 = 000000007ff88068
R04 = c000000000a8b94d   R20 = 000000007ff88068
R05 = 0000000000000002   R21 = 000000007ff88068
R06 = 0000000000000006   R22 = 0000000000000000
R07 = 05000affffffffff   R23 = 0000000000000000
R08 = 0000000000000063   R24 = 0000000000000001
R09 = c00000000790078f   R25 = 0000000000000001
R10 = 000000000000000f   R26 = 0000000000000000
R11 = 0000000000000001   R27 = c000000000bf1780
R12 = 0000000024044042   R28 = c000000007900798
R13 = c00000000fff9000   R29 = c0000000fb0d2040
R14 = 0000000000000000   R30 = c000000000d31a88
R15 = 000000007ffa1254   R31 = c000000007900790
pc  = c00000000009d4e8 .__try_to_take_rt_mutex+0xa4/0x214
lr  = c00000000009d4d4 .__try_to_take_rt_mutex+0x90/0x214
msr = 0000000080029200   cr  = 48044088
ctr = c00000000001ebf4   xer = 0000000020000000   trap =  700

0:mon> S
msr  = 0000000080021200  sprg0= c00000000fff9000
pvr  = 0000000080240010  sprg1= c00000000fff9000
dec  = 0000000000000000  sprg2= c00000000fff9180
sp   = c0000000fb0eafe0  sprg3= 0000000000000000
cpu 0x0: Vector: 700 (Program Check) at [c0000000fb0ead60]
    pc: c000000000032a64: .cmds+0xcb4/0x1748
    lr: c000000000032a60: .cmds+0xcb0/0x1748
    sp: c0000000fb0eafe0
   msr: 80021200
  current = 0xc0000000fb0d2040
  paca    = 0xc00000000fff9000   softe: 0        irq_happened: 0x01
    pid   = 3, comm = ksoftirqd/0
cpu 0x0: Exception 700 (Program Check) in xmon, returning to main loop

0:mon> d 0xc000000000bf1780
c000000000bf1780 0000000000000000 0000000000000000  |................|
c000000000bf1790 0000000000000000 c000000000bf1798  |................|
c000000000bf17a0 c000000000bf1798 0000000000000000  |................|
c000000000bf17b0 0000000100000000 c000000000a849df  |..............I.|
0:mon> d 0xc000000007900790
c000000007900790 8000000000000000 c000000000bf1798  |................|
c0000000079007a0 c000000000bf1798 0000000000000001  |................|
c0000000079007b0 0000000100000000 c000000000a849df  |..............I.|
c0000000079007c0 c000000000a84ab3 0000019800000000  |......J.........|
0:mon> d 0xc000000007900798
c000000007900798 c000000000bf1798 c000000000bf1798  |................|
c0000000079007a8 0000000000000001 0000000100000000  |................|
c0000000079007b8 c000000000a849df c000000000a84ab3  |......I.......J.|
c0000000079007c8 0000019800000000 0000000000000000  |................|

0:mon> di c00000000009d4e8
c00000000009d4e8  0b000000      tdnei   r0,0
c00000000009d4ec  e93b0050      ld      r9,80(r27)
c00000000009d4f0  7fbd4800      cmpd    cr7,r29,r9
c00000000009d4f4  419e0028      beq     cr7,c00000000009d51c    #
.__try_to_take_rt_mutex+0xd8/0x214
c00000000009d4f8  2fb90000      cmpdi   cr7,r25,0
c00000000009d4fc  419e0010      beq     cr7,c00000000009d50c    #
.__try_to_take_rt_mutex+0xc8/0x214
c00000000009d500  e81d003a      lwa     r0,56(r29)
c00000000009d504  2f800063      cmpwi   cr7,r0,99
c00000000009d508  41bd0110      bgt     cr7,c00000000009d618    #
.__try_to_take_rt_mutex+0x1d4/0x214
c00000000009d50c  817d0038      lwz     r11,56(r29)
c00000000009d510  80090038      lwz     r0,56(r9)
c00000000009d514  7f8b0000      cmpw    cr7,r11,r0
c00000000009d518  409c00f8      bge     cr7,c00000000009d610    #
.__try_to_take_rt_mutex+0x1cc/0x214
c00000000009d51c  2fba0000      cmpdi   cr7,r26,0
c00000000009d520  409e0010      bne     cr7,c00000000009d530    #
.__try_to_take_rt_mutex+0xec/0x214
c00000000009d524  e81f0008      ld      r0,8(r31)

0:mon> di c00000000009d4d4
c00000000009d4d4  60000000      nop
c00000000009d4d8  e81b0058      ld      r0,88(r27)
c00000000009d4dc  7fe00278      xor     r0,r31,r0
c00000000009d4e0  3120ffff      addic   r9,r0,-1
c00000000009d4e4  7c090110      subfe   r0,r9,r0
c00000000009d4e8  0b000000      tdnei   r0,0
c00000000009d4ec  e93b0050      ld      r9,80(r27)
c00000000009d4f0  7fbd4800      cmpd    cr7,r29,r9
c00000000009d4f4  419e0028      beq     cr7,c00000000009d51c    #
.__try_to_take_rt_mutex+0xd8/0x214
c00000000009d4f8  2fb90000      cmpdi   cr7,r25,0
c00000000009d4fc  419e0010      beq     cr7,c00000000009d50c    #
.__try_to_take_rt_mutex+0xc8/0x214
c00000000009d500  e81d003a      lwa     r0,56(r29)
c00000000009d504  2f800063      cmpwi   cr7,r0,99
c00000000009d508  41bd0110      bgt     cr7,c00000000009d618    #
.__try_to_take_rt_mutex+0x1d4/0x214
c00000000009d50c  817d0038      lwz     r11,56(r29)
c00000000009d510  80090038      lwz     r0,56(r9)

0:mon> la c00000000009d4d4
c00000000009d4d4: .__try_to_take_rt_mutex+0x90/0x214

2012/7/11 Frank Rowand <frank.rowand@am.sony.com>:
> On 07/11/12 09:02, Arnaud B. wrote:
>> Hi all,
>
> < snip >
>
>>
>> At this point the rtmutex plist is trashed. Data are bad when it crash
>> as pointer is not pointing to RAM anymore ;)
>> I tried add  call to plist_check_head at some place, and eventually I
>> got always a data access in init_lists (rtmutex.c). So at this point
>> plist is already corrupted.
>>
>>
>> So here is the call stack. Remember, it's alway the same :)
>>
>> cpu 0x0: Vector: 700 (Program Check) at [c0000000fb0e7830]
>> pc: c0000000000a2ba4: .__try_to_take_rt_mutex+0x74/0x1b0
>> lr: c0000000007d9f10: .rt_spin_lock_slowlock+0xa4/0x414
>> sp: c0000000fb0e7ab0
>> msr: 80029000
>> current = 0xc0000000fb0e20c0
>> paca = 0xc00000000fff9000 softe: 0 irq_happened: 0x01
>> pid = 3, comm = ksoftirqd/0
>> *kernel BUG at
>> /home/arnaud/ALU/KERNEL_34/HOME/build/linux/kernel/rtmutex_common.h:75!*
>> 0:mon>  t
>> [c0000000fb0e7b60] c0000000007d9f10 .rt_spin_lock_slowlock+0xa4/0x414
>> [c0000000fb0e7cb0] c0000000007da6c0 .rt_spin_lock+0x20/0x30
>> [c0000000fb0e7d30] c00000000004532c .__thread_do_softirq+0xc4/0x1b4
>> [c0000000fb0e7dc0] c0000000000454dc .run_ksoftirqd+0xc0/0x208
>> [c0000000fb0e7e70] c00000000006becc .kthread+0xb8/0xc4
>>
>> If you need an more information, I got all this boards in front of me :)
>
> Can you show a little bit more of the messages aound the crash?  For example
> the register contents.  Disassembly of the instruction at pc, and a few before
> that.
>
> -Frank
