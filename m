From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH rt] fix "list_bl.h: make list head locking RT safe" for
 !SMP && !DEBUG_SPINLOCK
Date: Mon, 8 Jul 2013 18:44:10 -0400
Message-ID: <51DB40BA.60607@windriver.com>
References: <1373322392-27604-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <rostedt@goodmis.org>, <tglx@linutronix.de>,
	<paulmck@linux.vnet.ibm.com>, <linux-rt-users@vger.kernel.org>,
	<kernel@pengutronix.de>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51094 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab3GHWox (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jul 2013 18:44:53 -0400
In-Reply-To: <1373322392-27604-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 13-07-08 06:26 PM, Uwe Kleine-K=C3=B6nig wrote:
> The patch "list_bl.h: make list head locking RT safe" introduced
> an unconditional
>=20
> 	__set_bit(0, (unsigned long *)b);
>=20
> in void hlist_bl_lock(struct hlist_bl_head *b). This clobbers the val=
ue
> of b->first. When the value of b->first is retrieved using
> hlist_bl_first the clobbering is undone using
>=20
> 	(unsigned long)h->first & ~LIST_BL_LOCKMASK
>=20
> and so depending on LIST_BL_LOCKMASK being one. But LIST_BL_LOCKMASK =
is
> only one if at least on of CONFIG_SMP and CONFIG_DEBUG_SPINLOCK are
> defined. Without these the value returned by hlist_bl_first has the
> zeroth bit set which likely results in a crash.

The incorrect assumption that I made was that the bit spin locks
still set/cleared the bit in the !SMP case.  So if we set the bit
and the mask is zero, we get the mismatch, giving something like:

BUG: unable to handle kernel NULL pointer dereference at 00000000000000=
09
IP: [<ffffffff8112a87c>] __d_rehash+0x3c/0x90
PGD 0
Oops: 0002 [#1] PREEMPT
Modules linked in:
CPU 0
Pid: 14, comm: kworker/u:0 Not tainted 3.8.13-rt13+ #1 Dell Inc. OptiPl=
ex 990/0VNP2H
RIP: 0010:[<ffffffff8112a87c>]  [<ffffffff8112a87c>] __d_rehash+0x3c/0x=
90
RSP: 0000:ffff8802248cbb60  EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff880225335728 RCX: 0000000000000000
RDX: ffff880224404578 RSI: ffff880225335728 RDI: 0000000000000001
RBP: ffff8802248cbb70 R08: ffff88022df83770 R09: ffff8802248cbca0
R10: ffffffff81c57ce1 R11: 2f2f2f2f2f2f2f2f R12: ffff880224404570
R13: ffff8802244040e8 R14: ffff8802248cbca0 R15: 0000000000000041
=46S:  0000000000000000(0000) GS:ffffffff81c1f000(0000) knlGS:000000000=
0000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000009 CR3: 0000000001c0f000 CR4: 00000000000407f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process kworker/u:0 (pid: 14, threadinfo ffff8802248ca000, task ffff880=
2248769a0)
Stack:
 ffff8802244045d0 ffff880224404570 ffff8802248cbb80 ffffffff8112a901
 ffff8802248cbba0 ffffffff8112a937 ffff880224404570 ffff8802244040e8
 ffff8802248cbbb8 ffffffff8113a691 ffff880224404570 ffff8802248cbbd8
Call Trace:
 [<ffffffff8112a901>] _d_rehash+0x31/0x40
 [<ffffffff8112a937>] d_rehash+0x27/0x40
 [<ffffffff8113a691>] simple_lookup+0x41/0x50
 [<ffffffff8111ef08>] lookup_real+0x18/0x50
 [<ffffffff8111f483>] __lookup_hash+0x33/0x40

for !SMP and !DEBUG_SPINLOCK (i.e. !DEBUG_LIST).   The above is from
me reproducing Uwe's report on x86-64 UP.  I've also tested his fix
below on the same configuration, and confirmed it fixes it by making
the bitops be conditional on the same CONFIG options that the real
bit spinlock implementations are contingent on.

Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks,
Paul.
--


>=20
> So only do the clobbering in the cases where LIST_BL_LOCKMASK is one.
> An alternative would be to always define LIST_BL_LOCKMASK to one with
> CONFIG_PREEMPT_RT_BASE.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> this applies on top of 3.8-rt13 and makes my ARM board boot again.
>=20
> Best regards
> Uwe
>=20
>  include/linux/list_bl.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> index ddfd46a..becd7a6 100644
> --- a/include/linux/list_bl.h
> +++ b/include/linux/list_bl.h
> @@ -131,8 +131,10 @@ static inline void hlist_bl_lock(struct hlist_bl=
_head *b)
>  	bit_spin_lock(0, (unsigned long *)b);
>  #else
>  	raw_spin_lock(&b->lock);
> +#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>  	__set_bit(0, (unsigned long *)b);
>  #endif
> +#endif
>  }
> =20
>  static inline void hlist_bl_unlock(struct hlist_bl_head *b)
> @@ -140,7 +142,9 @@ static inline void hlist_bl_unlock(struct hlist_b=
l_head *b)
>  #ifndef CONFIG_PREEMPT_RT_BASE
>  	__bit_spin_unlock(0, (unsigned long *)b);
>  #else
> +#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>  	__clear_bit(0, (unsigned long *)b);
> +#endif
>  	raw_spin_unlock(&b->lock);
>  #endif
>  }
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
