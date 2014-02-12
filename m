From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Date: Wed, 12 Feb 2014 16:45:26 +0400
Message-ID: <268891392209126@web5h.yandex.ru>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com> <173231392194038@web29j.yandex.ru> <52FB5AEF.3040807@oracle.com> <341861392205386@web5h.yandex.ru> <52FB65AC.4000808@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Allen Pais <allen.pais@oracle.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward5h.mail.yandex.net ([84.201.186.23]:47608 "EHLO
	forward5h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbaBLMpb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Feb 2014 07:45:31 -0500
In-Reply-To: <52FB65AC.4000808@oracle.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



12.02.2014, 16:15, "Allen Pais" <allen.pais@oracle.com>:
> On Wednesday 12 February 2014 05:13 PM, Kirill Tkhai wrote:
>
>> =9A12.02.2014, 15:29, "Allen Pais" <allen.pais@oracle.com>:
>>>>>>> =9A=9A=9A=9A[ 1487.027884] I7: <rt_mutex_setprio+0x3c/0x2c0>
>>>>>>> =9A=9A=9A=9A[ 1487.027885] Call Trace:
>>>>>>> =9A=9A=9A=9A[ 1487.027887] =9A[00000000004967dc] rt_mutex_setpr=
io+0x3c/0x2c0
>>>>>>> =9A=9A=9A=9A[ 1487.027892] =9A[00000000004afe20] task_blocks_on=
_rt_mutex+0x180/0x200
>>>>>>> =9A=9A=9A=9A[ 1487.027895] =9A[0000000000819114] rt_spin_lock_s=
lowlock+0x94/0x300
>>>>>>> =9A=9A=9A=9A[ 1487.027897] =9A[0000000000817ebc] __schedule+0x3=
9c/0x53c
>>>>>>> =9A=9A=9A=9A[ 1487.027899] =9A[00000000008185fc] schedule+0x1c/=
0xc0
>>>>>>> =9A=9A=9A=9A[ 1487.027908] =9A[000000000048fff4] smpboot_thread=
_fn+0x154/0x2e0
>>>>>>> =9A=9A=9A=9A[ 1487.027913] =9A[000000000048753c] kthread+0x7c/0=
xa0
>>>>>>> =9A=9A=9A=9A[ 1487.027920] =9A[00000000004060c4] ret_from_sysca=
ll+0x1c/0x2c
>>>>>>> =9A=9A=9A=9A[ 1487.027922] =9A[0000000000000000] =9A=9A=9A=9A=9A=
=9A=9A=9A=9A=9A(null)
>>> =9AKirill, Well the change works. So far the machine is up and no s=
tall or crashes
>>> =9Awith Hackbench. I'll run it for longer period and check.
>> =9AOk, good.
>>
>> =9ABut I don't know is this the best fix. May we have to implement a=
nother optimization
>> =9Afor RT.
>
> No, unfortunately, the system hit a stall on about 8 cpu's.
> CPU: 31 PID: 28675 Comm: hackbench Tainted: G =9A=9A=9A=9A=9AD W =9A=9A=
=9A3.10.24-rt22+ #13
> [ 5725.097645] task: fffff80f929da8c0 ti: fffff80f8a4fc000 task.ti: f=
ffff80f8a4fc000
> [ 5725.097649] TSTATE: 0000000011001604 TPC: 0000000000671e54 TNPC: 0=
000000000671e58 Y: 00000000 =9A=9A=9ATainted: G =9A=9A=9A=9A=9AD W
> TPC: <do_raw_spin_lock+0xb4/0x120>
> [ 5725.097657] g0: 0000000000671e4c g1: 00000000000000ff g2: 00000000=
02625010 g3: 0000000000000000
> [ 5725.097661] g4: fffff80f929da8c0 g5: fffff80fd649c000 g6: fffff80f=
8a4fc000 g7: 0000000000000000
> [ 5725.097664] o0: 0000000000000001 o1: 00000000009dfc00 o2: 00000000=
00000000 o3: 0000000000000000
> [ 5725.097667] o4: 0000000000000002 o5: 0000000000000000 sp: fffff80f=
8a4fee21 ret_pc: 0000000000671e58
> [ 5725.097671] RPC: <do_raw_spin_lock+0xb8/0x120>
> [ 5725.097675] l0: 000000000933b401 l1: 000000003b99d190 l2: 00000000=
00e25c00 l3: 0000000000000000
> [ 5725.097678] l4: 0000000000000000 l5: 0000000000000000 l6: 00000000=
00000000 l7: fffff801001254c8
> [ 5725.097682] i0: fffff80f89a367c8 i1: 0000000000878be4 i2: 00000000=
00000000 i3: 0000000000000000
> [ 5725.097685] i4: 0000000000000002 i5: 0000000000000000 i6: fffff80f=
8a4feed1 i7: 0000000000879b14
> [ 5725.097690] I7: <_raw_spin_lock+0x54/0x80>
> [ 5725.097692] Call Trace:
> [ 5725.097697] =9A[0000000000879b14] _raw_spin_lock+0x54/0x80
> [ 5725.097702] =9A[0000000000878be4] rt_spin_lock_slowlock+0x24/0x340
> [ 5725.097707] =9A[00000000008790ac] rt_spin_lock+0xc/0x40
> [ 5725.097712] =9A[00000000008610bc] unix_stream_sendmsg+0x15c/0x380
> [ 5725.097717] =9A[00000000007ac114] sock_aio_write+0xf4/0x120
> [ 5725.097722] =9A[000000000055891c] do_sync_write+0x5c/0xa0
> [ 5725.097727] =9A[0000000000559e1c] vfs_write+0x15c/0x180
> [ 5725.097732] =9A[0000000000559ef8] SyS_write+0x38/0x80
> [ 5725.097738] =9A[0000000000406234] linux_sparc_syscall+0x34/0x44

No ideas right now.

> This(above) on a few cpu's and this(below) on the other
>
> BUG: soft lockup - CPU#13 stuck for 22s! [hackbench:28701]
> [ 5728.378345] Modules linked in: binfmt_misc usb_storage ehci_pci eh=
ci_hcd sg n2_rng rng_core ext4 jbd2 crc16 sr_mod mpt2sas scsi_transport=
_sas raid_class sunvnet sunvdc dm_mirror dm_region_hash dm_log dm_mod b=
e2iscsi iscsi_boot_sysfs bnx2i cnic uio ipv6 cxgb4i cxgb4 cxgb3i libcxg=
bi cxgb3 mdio libiscsi_tcp libiscsi scsi_transport_iscsi
> [ 5728.378347] irq event stamp: 0
> [ 5728.378350] hardirqs last =9Aenabled at (0): [< =9A=9A=9A=9A=9A=9A=
=9A=9A=9A(null)>] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A(null)
> [ 5728.378356] hardirqs last disabled at (0): [<000000000045eb38>] co=
py_process+0x418/0x1080
> [ 5728.378361] softirqs last =9Aenabled at (0): [<000000000045eb38>] =
copy_process+0x418/0x1080
> [ 5728.378364] softirqs last disabled at (0): [< =9A=9A=9A=9A=9A=9A=9A=
=9A=9A(null)>] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A(null)
> [ 5728.378368] CPU: 13 PID: 28701 Comm: hackbench Tainted: G =9A=9A=9A=
=9A=9AD W =9A=9A=9A3.10.24-rt22+ #13
> [ 5728.378371] task: fffff80f90efbb80 ti: fffff80f925ac000 task.ti: f=
ffff80f925ac000
> [ 5728.378374] TSTATE: 0000000011001604 TPC: 00000000004668b4 TNPC: 0=
0000000004668b8 Y: 00000000 =9A=9A=9ATainted: G =9A=9A=9A=9A=9AD W
> [ 5728.378378] TPC: <do_exit+0xb4/0xa40>
> [ 5728.378380] g0: 0000000000003f40 g1: 00000000000000ff g2: fffff80f=
90efbeb0 g3: 0000000000000002
> [ 5728.378383] g4: fffff80f90efbb80 g5: fffff80fd1c9c000 g6: fffff80f=
925ac000 g7: 0000000000000000
> [ 5728.378385] o0: fffff80f90efbb80 o1: fffff80f925ac400 o2: 00000000=
0087a654 o3: 0000000000000000
> [ 5728.378387] o4: 0000000000000000 o5: fffff80f925aff40 sp: fffff80f=
ff98f671 ret_pc: 000000000046689c
> [ 5728.378390] RPC: <do_exit+0x9c/0xa40>
> [ 5728.378393] l0: fffff80f90efbb80 l1: 0000004480001603 l2: 00000000=
0087a650 l3: 0000000000000400
> [ 5728.378395] l4: 0000000000000000 l5: 0000000000000003 l6: 00000000=
00000000 l7: 0000000000000008
> [ 5728.378397] i0: 000000000000000a i1: 000000000000000d i2: 00000000=
0042f608 i3: 0000000000000000
> [ 5728.378400] i4: 000000000000004f i5: 0000000000000002 i6: fffff80f=
ff98f741 i7: 000000000087a650
> [ 5728.378405] I7: <perfctr_irq+0x3d0/0x420>
> [ 5728.378406] Call Trace:
> [ 5728.378410] =9A[000000000087a650] perfctr_irq+0x3d0/0x420
> [ 5728.378415] =9A[00000000004209f4] tl0_irq15+0x14/0x20
> [ 5728.378419] =9A[000000000042f608] stick_get_tick+0x8/0x20
> [ 5728.378422] =9A[000000000042fa24] __delay+0x24/0x60
> [ 5728.378426] =9A[0000000000671e58] do_raw_spin_lock+0xb8/0x120
> [ 5728.378430] =9A[0000000000879b14] _raw_spin_lock+0x54/0x80
> [ 5728.378435] =9A[00000000004a1978] load_balance+0x538/0x860
> [ 5728.378438] =9A[00000000004a2154] idle_balance+0x134/0x1c0
> [ 5728.378442] =9A[0000000000877d54] switch_to_pc+0x1f4/0x2c0
> [ 5728.378445] =9A[0000000000877ec4] schedule+0x24/0xc0
> [ 5728.378449] =9A[0000000000876860] schedule_timeout+0x1c0/0x2a0
> [ 5728.378452] =9A[0000000000860ac0] unix_stream_recvmsg+0x240/0x6e0
> [ 5728.378456] =9A[00000000007ac23c] sock_aio_read+0xfc/0x120
> [ 5728.378460] =9A[0000000000558adc] do_sync_read+0x5c/0xa0
> [ 5728.378464] =9A[000000000055a04c] vfs_read+0x10c/0x120
> [ 5728.378467] =9A[000000000055a118] SyS_read+0x38/0x80
>
>> =9AFor example, collect only batches which does not require smp call=
 function. Or the
>> =9Amain goal of lazy tlb was to prevent smp calls?! It's good to dis=
cover this..
>>
>> =9AThe other serious thing is to know does __set_pte_at() execute in=
 preemption disable
>> =9Acontext on !RT kernel. Because the place is interesting.
>>
>> =9AIf yes, we have to do the same for RT. If not, then no.
>
> I am not convinced that I've covered all tlb/smp code. Guess I'll nee=
d to dig more.

++all above. May we have to add one more crutch... Put preempt_disable(=
) at begining of
__set_pte_at() and enable at end...


> Thanks,
>
> Allen
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
