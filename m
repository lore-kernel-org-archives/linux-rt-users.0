From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: [RT] Lockdep warning on boot with 2.6.31-rc5-rt1.1
Date: Sat, 8 Aug 2009 22:07:40 +0800
Message-ID: <a8e1da0908080707y6a2ce4bfud20b496aad297ad8@mail.gmail.com>
References: <20090807094608.4b0efea1@torg> <20090808120026.GA13183@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Theodore Tso <tytso@mit.edu>, Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:65127 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZHHOHl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Aug 2009 10:07:41 -0400
In-Reply-To: <20090808120026.GA13183@mit.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Aug 8, 2009 at 8:00 PM, Theodore Tso<tytso@mit.edu> wrote:
> On Fri, Aug 07, 2009 at 09:46:08AM -0500, Clark Williams wrote:
>> Peter,
>>
>> I'm getting this warning from lockdep when booting on my T60.
>>
>> The two addresses reported (0xffffffff812664a2 and 0xffffffff812664a=
e)
>> actually bracket one call to mutex_lock() in driver_attach() so I'm =
not
>> sure what the complaint is.
>
> I'm getting a different lockdep warning when booting on my T400 using
> 2.6.31-rc5; not sure if it's related or not....
>
> In any case, it's screwing up the ability for lockdep to find any
> other problems.
>
> [ =C2=A0 =C2=A00.297775] INFO: trying to register non-static key.
> [ =C2=A0 =C2=A00.297775] the code is fine but needs lockdep annotatio=
n.
> [ =C2=A0 =C2=A00.297775] turning off the locking correctness validato=
r.
> [ =C2=A0 =C2=A00.297775] Pid: 1, comm: swapper Not tainted 2.6.31-rc5=
-00256-gf124845 #4
> [ =C2=A0 =C2=A00.297775] Call Trace:
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c0511a2f>] ? printk+0x14/0x1d
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c016de1f>] register_lock_class+0x5a/=
0x2a1
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c016e932>] ? mark_lock+0x1e/0x1e4
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c016f673>] __lock_acquire+0x9c/0xb1e
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c01be910>] ? mod_zone_page_state+0x9=
f/0xaf
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c016ed98>] ? trace_hardirqs_on_calle=
r+0x103/0x124
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c016e932>] ? mark_lock+0x1e/0x1e4
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c016eb3b>] ? mark_held_locks+0x43/0x=
5b
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c01d490f>] ? kmem_cache_alloc+0xaf/0=
x127
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c016ed98>] ? trace_hardirqs_on_calle=
r+0x103/0x124
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c0170189>] lock_acquire+0x94/0xb7
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c045d6bd>] ? alloc_netdev_mq+0x105/0=
x1cc
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c0513f8d>] _spin_lock_bh+0x28/0x58
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c045d6bd>] ? alloc_netdev_mq+0x105/0=
x1cc
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c045d6bd>] alloc_netdev_mq+0x105/0x1=
cc
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c03f7bbf>] ? loopback_setup+0x0/0x79
> [ =C2=A0 =C2=A00.297775] =C2=A0[<c03f7c6f>] loopback_net_init+0x25/0x=
68
> [ =C2=A0 =C2=A00.297782] =C2=A0[<c0457317>] register_pernet_operation=
s+0x2f/0xa1
> [ =C2=A0 =C2=A00.297832] =C2=A0[<c0512fcd>] ? mutex_lock_nested+0x33/=
0x3b
> [ =C2=A0 =C2=A00.297891] =C2=A0[<c0457435>] register_pernet_device+0x=
24/0x4c
> [ =C2=A0 =C2=A00.297951] =C2=A0[<c0796a09>] net_dev_init+0x101/0x150
> [ =C2=A0 =C2=A00.298010] =C2=A0[<c0796908>] ? net_dev_init+0x0/0x150
> [ =C2=A0 =C2=A00.298069] =C2=A0[<c010115c>] do_one_initcall+0x6a/0x17=
7
> [ =C2=A0 =C2=A00.298127] =C2=A0[<c016e932>] ? mark_lock+0x1e/0x1e4
> [ =C2=A0 =C2=A00.298185] =C2=A0[<c016e932>] ? mark_lock+0x1e/0x1e4
> [ =C2=A0 =C2=A00.298244] =C2=A0[<c01b371a>] ? get_page_from_freelist+=
0x28f/0x3be
> [ =C2=A0 =C2=A00.298304] =C2=A0[<c016ed98>] ? trace_hardirqs_on_calle=
r+0x103/0x124
> [ =C2=A0 =C2=A00.298364] =C2=A0[<c016edc4>] ? trace_hardirqs_on+0xb/0=
xd
> [ =C2=A0 =C2=A00.298423] =C2=A0[<c016e932>] ? mark_lock+0x1e/0x1e4
> [ =C2=A0 =C2=A00.298482] =C2=A0[<c016e932>] ? mark_lock+0x1e/0x1e4
> [ =C2=A0 =C2=A00.298540] =C2=A0[<c016edc4>] ? trace_hardirqs_on+0xb/0=
xd
> [ =C2=A0 =C2=A00.298600] =C2=A0[<c03104ad>] ? ida_get_new_above+0x157=
/0x171
> [ =C2=A0 =C2=A00.298660] =C2=A0[<c0213468>] ? proc_register+0x14b/0x1=
5c
> [ =C2=A0 =C2=A00.298719] =C2=A0[<c011e5f6>] ? sched_clock+0x8/0xb
> [ =C2=A0 =C2=A00.298777] =C2=A0[<c016d9b1>] ? lock_release_holdtime+0=
x30/0x131
> [ =C2=A0 =C2=A00.298837] =C2=A0[<c0213468>] ? proc_register+0x14b/0x1=
5c
> [ =C2=A0 =C2=A00.298896] =C2=A0[<c0513dfb>] ? _spin_unlock+0x22/0x25
> [ =C2=A0 =C2=A00.298954] =C2=A0[<c0213468>] ? proc_register+0x14b/0x1=
5c
> [ =C2=A0 =C2=A00.299013] =C2=A0[<c021359b>] ? create_proc_entry+0x80/=
0x96
> [ =C2=A0 =C2=A00.299073] =C2=A0[<c0191064>] ? register_irq_proc+0x91/=
0xad
> [ =C2=A0 =C2=A00.299132] =C2=A0[<c01910d8>] ? init_irq_proc+0x58/0x65
> [ =C2=A0 =C2=A00.299191] =C2=A0[<c0768301>] kernel_init+0x131/0x182
> [ =C2=A0 =C2=A00.299249] =C2=A0[<c07681d0>] ? kernel_init+0x0/0x182
>

It's a different problem, for this issue please see:

http://lkml.org/lkml/2009/8/5/49
http://lkml.org/lkml/2009/8/5/51

--=20
Regards
dave
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
