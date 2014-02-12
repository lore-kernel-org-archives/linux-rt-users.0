From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Date: Wed, 12 Feb 2014 15:43:06 +0400
Message-ID: <341861392205386@web5h.yandex.ru>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com> <341392153219@web17g.yandex.ru> <52FB2751.2070101@oracle.com> <173231392194038@web29j.yandex.ru> <52FB5AEF.3040807@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Allen Pais <allen.pais@oracle.com>
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <52FB5AEF.3040807@oracle.com>
Sender: sparclinux-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

12.02.2014, 15:29, "Allen Pais" <allen.pais@oracle.com>:
>>>>> =9A=9A=9A[ 1487.027884] I7: <rt_mutex_setprio+0x3c/0x2c0>
>>>>> =9A=9A=9A[ 1487.027885] Call Trace:
>>>>> =9A=9A=9A[ 1487.027887] =9A[00000000004967dc] rt_mutex_setprio+0x=
3c/0x2c0
>>>>> =9A=9A=9A[ 1487.027892] =9A[00000000004afe20] task_blocks_on_rt_m=
utex+0x180/0x200
>>>>> =9A=9A=9A[ 1487.027895] =9A[0000000000819114] rt_spin_lock_slowlo=
ck+0x94/0x300
>>>>> =9A=9A=9A[ 1487.027897] =9A[0000000000817ebc] __schedule+0x39c/0x=
53c
>>>>> =9A=9A=9A[ 1487.027899] =9A[00000000008185fc] schedule+0x1c/0xc0
>>>>> =9A=9A=9A[ 1487.027908] =9A[000000000048fff4] smpboot_thread_fn+0=
x154/0x2e0
>>>>> =9A=9A=9A[ 1487.027913] =9A[000000000048753c] kthread+0x7c/0xa0
>>>>> =9A=9A=9A[ 1487.027920] =9A[00000000004060c4] ret_from_syscall+0x=
1c/0x2c
>>>>> =9A=9A=9A[ 1487.027922] =9A[0000000000000000] =9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9A(null)
>>> =9A=9ANow, consistently I've been getting sun4v_data_access_excepti=
on.
>>> =9A=9AHere's the trace:
>>> =9A=9A[ 4673.360121] sun4v_data_access_exception: ADDR[000008000000=
0000] CTX[0000] TYPE[0004], going.
>> =9AI've never dived at sparc's tlb before, but it seems now I'm unde=
rstanding.
>>
>> =9Aarch_enter_lazy_mmu_mode() makes possible delayed tlb flushing. I=
n !RT kernel
>> =9Ayou collect flush requests before you really flush all of them.
>>
>> =9AIn RT you collect them too, but you are able to be preempted in a=
ny moment.
>> =9ASo, you may switch to other process with unflushed tlb, which is =
very bad.
>>
>> =9ATry to not to set tb->active =3D 1; in arch_enter_lazy_mmu_mode()=
=2E Set it to zero.
>> =9AWe will look if this robust fix helps.
>
> Kirill, Well the change works. So far the machine is up and no stall =
or crashes
> with Hackbench. I'll run it for longer period and check.

Ok, good.

But I don't know is this the best fix. May we have to implement another=
 optimization
for RT.

=46or example, collect only batches which does not require smp call fun=
ction. Or the
main goal of lazy tlb was to prevent smp calls?! It's good to discover =
this..

The other serious thing is to know does __set_pte_at() execute in preem=
ption disable
context on !RT kernel. Because the place is interesting.

If yes, we have to do the same for RT. If not, then no.

Kirill

>
> Thanks,
>
> Allen
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe sparclinux" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
