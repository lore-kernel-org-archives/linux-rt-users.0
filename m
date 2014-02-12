From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Date: Wed, 12 Feb 2014 12:33:58 +0400
Message-ID: <173231392194038@web29j.yandex.ru>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Allen Pais <allen.pais@oracle.com>
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <52FB2751.2070101@oracle.com>
Sender: sparclinux-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

12.02.2014, 11:48, "Allen Pais" <allen.pais@oracle.com>:

> =9AOn Wednesday 12 February 2014 02:43 AM, Kirill Tkhai wrote:
>> =9A=9A06.01.2014, 07:56, "Allen Pais" <allen.pais@oracle.com>:
>>> =9A=9AIn the attempt of get PREEMPT_RT working on sparc64 using
>>> =9A=9Alinux-stable-rt version 3.10.22-rt19+, the kernel crash
>>> =9A=9Awith the following trace:
>>>
>>> =9A=9A[ 1487.027884] I7: <rt_mutex_setprio+0x3c/0x2c0>
>>> =9A=9A[ 1487.027885] Call Trace:
>>> =9A=9A[ 1487.027887] =9A[00000000004967dc] rt_mutex_setprio+0x3c/0x=
2c0
>>> =9A=9A[ 1487.027892] =9A[00000000004afe20] task_blocks_on_rt_mutex+=
0x180/0x200
>>> =9A=9A[ 1487.027895] =9A[0000000000819114] rt_spin_lock_slowlock+0x=
94/0x300
>>> =9A=9A[ 1487.027897] =9A[0000000000817ebc] __schedule+0x39c/0x53c
>>> =9A=9A[ 1487.027899] =9A[00000000008185fc] schedule+0x1c/0xc0
>>> =9A=9A[ 1487.027908] =9A[000000000048fff4] smpboot_thread_fn+0x154/=
0x2e0
>>> =9A=9A[ 1487.027913] =9A[000000000048753c] kthread+0x7c/0xa0
>>> =9A=9A[ 1487.027920] =9A[00000000004060c4] ret_from_syscall+0x1c/0x=
2c
>>> =9A=9A[ 1487.027922] =9A[0000000000000000] =9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A(null)
> =9ANow, consistently I've been getting sun4v_data_access_exception.
> =9AHere's the trace:
> =9A[ 4673.360121] sun4v_data_access_exception: ADDR[0000080000000000]=
 CTX[0000] TYPE[0004], going.

I've never dived at sparc's tlb before, but it seems now I'm understand=
ing.

arch_enter_lazy_mmu_mode() makes possible delayed tlb flushing. In !RT =
kernel
you collect flush requests before you really flush all of them.

In RT you collect them too, but you are able to be preempted in any mom=
ent.
So, you may switch to other process with unflushed tlb, which is very b=
ad.

Try to not to set tb->active =3D 1; in arch_enter_lazy_mmu_mode(). Set =
it to zero.
We will look if this robust fix helps.


> =9A[ 4673.360124] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A\|/ ____ =
\|/
> =9A[ 4673.360124] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A"@'/ .. \=
`@"
> =9A[ 4673.360124] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A/_| \__/ =
|_\
> =9A[ 4673.360124] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
\__U_/
> =9A[ 4673.360128] hackbench(4183): Dax [#1]
> =9A[ 4673.360137] CPU: 5 PID: 4183 Comm: hackbench Tainted: G =9A=9A=9A=
=9A=9A=9A=9AW =9A=9A=9A3.10.24-rt22+ #12
> =9A[ 4673.360141] task: fffff80f9c793840 ti: fffff80f9b270000 task.ti=
: fffff80f9b270000
> =9A[ 4673.360146] TSTATE: 0000004411e01606 TPC: 0000000000407b64 TNPC=
: 0000000000407b68 Y: 00000000 =9A=9A=9ATainted: G =9A=9A=9A=9A=9A=9A=9A=
W
> =9A[ 4673.360157] TPC: <tsb_flush+0x4/0x40>
> =9A[ 4673.360160] g0: fffff80f9c7c54b8 g1: 0000000000000001 g2: 00000=
00000008000 g3: 0000000000000000
> =9A[ 4673.360163] g4: fffff80f9c793840 g5: fffff80fcfc9c000 g6: fffff=
80f9b270000 g7: 0000000000000000
> =9A[ 4673.360167] o0: 0000080000000130 o1: 000003ffffe00400 o2: 00000=
00000878e48 o3: 0000000000000000
> =9A[ 4673.360170] o4: 0000000000000002 o5: 0000000000000000 sp: fffff=
80f9b272ec1 ret_pc: 00000000004520d0
> =9A[ 4673.360177] RPC: <flush_tsb_user+0x70/0x120>
> =9A[ 4673.360180] l0: 0000000000000001 l1: fffff80fd0800870 l2: 00000=
80000000000 l3: 00000000000001ff
> =9A[ 4673.360183] l4: fffff80f9852ea00 l5: fffff80f9852ee10 l6: 00000=
00000a87000 l7: 0000000000000000
> =9A[ 4673.360185] i0: fffff80fd0800868 i1: 0000000000000000 i2: 00000=
00000000000 i3: 0000000000000000
> =9A[ 4673.360187] i4: 0000000000000002 i5: 0000000000000030 i6: fffff=
80f9b272f71 i7: 00000000004515a8
> =9A[ 4673.360192] I7: <flush_tlb_pending+0x68/0xe0>
> =9A[ 4673.360193] Call Trace:
> =9A[ 4673.360198] =9A[00000000004515a8] flush_tlb_pending+0x68/0xe0
> =9A[ 4673.360203] =9A[000000000045185c] arch_leave_lazy_mmu_mode+0x3c=
/0x60
> =9A[ 4673.360210] =9A[000000000052e520] unmap_single_vma+0x400/0x6c0
> =9A[ 4673.360213] =9A[000000000052e808] unmap_vmas+0x28/0x60
> =9A[ 4673.360220] =9A[0000000000530cc8] exit_mmap+0x88/0x160
> =9A[ 4673.360226] =9A[000000000045e0d4] mmput+0x34/0xe0
> =9A[ 4673.360236] =9A[00000000004669fc] do_exit+0x1fc/0xa40
> =9A[ 4673.360241] =9A[0000000000467270] do_group_exit+0x30/0xe0
> =9A[ 4673.360245] =9A[000000000046733c] SyS_exit_group+0x1c/0x40
> =9A[ 4673.360256] =9A[0000000000406234] linux_sparc_syscall+0x34/0x44
> =9A[ 4673.360260] Caller[00000000004515a8]: flush_tlb_pending+0x68/0x=
e0
> =9A[ 4673.360264] Caller[000000000045185c]: arch_leave_lazy_mmu_mode+=
0x3c/0x60
> =9A[ 4673.360267] Caller[000000000052e520]: unmap_single_vma+0x400/0x=
6c0
> =9A[ 4673.360270] Caller[000000000052e808]: unmap_vmas+0x28/0x60
> =9A[ 4673.360274] Caller[0000000000530cc8]: exit_mmap+0x88/0x160
> =9A[ 4673.360277] Caller[000000000045e0d4]: mmput+0x34/0xe0
> =9A[ 4673.360280] Caller[00000000004669fc]: do_exit+0x1fc/0xa40
> =9A[ 4673.360284] Caller[0000000000467270]: do_group_exit+0x30/0xe0
> =9A[ 4673.360287] Caller[000000000046733c]: SyS_exit_group+0x1c/0x40
> =9A[ 4673.360291] Caller[0000000000406234]: linux_sparc_syscall+0x34/=
0x44
>
> =9A- Allen
--
To unsubscribe from this list: send the line "unsubscribe sparclinux" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
