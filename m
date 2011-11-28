From: John Kacur <jkacur@redhat.com>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Mon, 28 Nov 2011 12:31:48 +0100
Message-ID: <CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
	<4EC384FD.1040106@tum.de>
	<alpine.LFD.2.02.1111161605580.4902@ionos>
	<4ED35D9A.7090401@tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Schauss <schauss@tum.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40255 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab1K1Lbt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Nov 2011 06:31:49 -0500
Received: by qyk4 with SMTP id 4so743159qyk.19
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Nov 2011 03:31:49 -0800 (PST)
In-Reply-To: <4ED35D9A.7090401@tum.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Nov 28, 2011 at 11:08 AM, Thomas Schauss <schauss@tum.de> wrote=
:
> On 11/16/2011 04:06 PM, Thomas Gleixner wrote:
>>
>> On Wed, 16 Nov 2011, Thomas Schauss wrote:
>>>
>>> Unfortunately, with 3.0-rt and the nvidia-driver we get complete sy=
stem
>>> freezes when starting X on several different hardware setups (a few
>>> systems
>>> work fine). This is certainly caused by this combination. When usin=
g the
>>> nouveau-driver everything works fine.
>>
>> Have you ever tried to run with CONFIG_PROVE_LOCKING=3Dy ?
>>
>
> Hello,
>
> thank you for that tip. I have tried this now and have not found any
> warnings which seem related to the nvidia-driver. Further testing rev=
ealed,
> that the driver works fine with CONFIG_PREEMPT_RTB and the freezes wh=
en
> running startx occur as soon as we switch to CONFIG_PREEMPT_RT_FULL.
>
> Regarding lockdep, we do get some warnings in slab.c -> cache_flushar=
ray
> that however seem unrelated to nvidia. As we could not find any other=
 bugs
> with the same locking warning I attached one example below. You can f=
ind
> some complete bootlogs (all with deadlock-warnings, all with slightly
> different call-stack) and my kernel-config at
>
> http://www.lsr.ei.tum.de/team/schauss/lockdep/
>
> On rt-base I also get a lockdep-warning which however seems unrelated=
 to the
> rt-full one (not in cache_flusharray). You can find that log on the s=
ame
> page.
>
> Best Regards,
> Thomas
>
>
>
> Nov 17 17:34:49 fix kernel: [ =A0 30.750925]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Nov 17 17:34:49 fix kernel: [ =A0 30.750927] [ INFO: possible recursi=
ve
> locking detected ]
> Nov 17 17:34:49 fix kernel: [ =A0 30.750930] 3.0.9-25-rt #0
> Nov 17 17:34:49 fix kernel: [ =A0 30.750931]
> ---------------------------------------------
> Nov 17 17:34:49 fix kernel: [ =A0 30.750933] udevd/517 is trying to a=
cquire
> lock:
> Nov 17 17:34:49 fix kernel: [ =A0 30.750935] (&parent->list_lock){+.+=
=2E..}, at:
> [<ffffffff81613e63>] cache_flusharray+0x47/0xd6
> Nov 17 17:34:49 fix kernel: [ =A0 30.750944]
> Nov 17 17:34:49 fix kernel: [ =A0 30.750945] but task is already hold=
ing lock:
> Nov 17 17:34:49 fix kernel: [ =A0 30.750946] (&parent->list_lock){+.+=
=2E..}, at:
> [<ffffffff81613e63>] cache_flusharray+0x47/0xd6
> Nov 17 17:34:49 fix kernel: [ =A0 30.750950]
> Nov 17 17:34:49 fix kernel: [ =A0 30.750951] other info that might he=
lp us
> debug this:
> Nov 17 17:34:49 fix kernel: [ =A0 30.750952] =A0Possible unsafe locki=
ng
> scenario:
> Nov 17 17:34:49 fix kernel: [ =A0 30.750953]
> Nov 17 17:34:49 fix kernel: [ =A0 30.750954] =A0 =A0 =A0 =A0CPU0
> Nov 17 17:34:49 fix kernel: [ =A0 30.750955] =A0 =A0 =A0 =A0----
> Nov 17 17:34:49 fix kernel: [ =A0 30.750956] =A0 lock(&parent->list_l=
ock);
> Nov 17 17:34:49 fix kernel: [ =A0 30.750958] =A0 lock(&parent->list_l=
ock);
> Nov 17 17:34:49 fix kernel: [ =A0 30.750959]
> Nov 17 17:34:49 fix kernel: [ =A0 30.750960] =A0*** DEADLOCK ***
> Nov 17 17:34:49 fix kernel: [ =A0 30.750961]
> Nov 17 17:34:49 fix kernel: [ =A0 30.750962] =A0May be due to missing=
 lock
> nesting notation
> Nov 17 17:34:49 fix kernel: [ =A0 30.750963]
> Nov 17 17:34:49 fix kernel: [ =A0 30.750964] 2 locks held by udevd/51=
7:
> Nov 17 17:34:49 fix kernel: [ =A0 30.750966] =A0#0: =A0(&per_cpu(slab=
_lock,
> __cpu).lock){+.+...}, at: [<ffffffff8116a5c6>] kfree+0xd6/0x380
> Nov 17 17:34:49 fix kernel: [ =A0 30.750973] =A0#1:
> (&parent->list_lock){+.+...}, at: [<ffffffff81613e63>]
> cache_flusharray+0x47/0xd6
> Nov 17 17:34:49 fix kernel: [ =A0 30.750977]
> Nov 17 17:34:49 fix kernel: [ =A0 30.750977] stack backtrace:
> Nov 17 17:34:49 fix kernel: [ =A0 30.750980] Pid: 517, comm: udevd No=
t tainted
> 3.0.9-25-rt #0
> Nov 17 17:34:49 fix kernel: [ =A0 30.750982] Call Trace:
> Nov 17 17:34:49 fix kernel: [ =A0 30.750987] =A0[<ffffffff810a0097>]
> print_deadlock_bug+0xf7/0x100
> Nov 17 17:34:49 fix kernel: [ =A0 30.750991] =A0[<ffffffff810a1add>]
> validate_chain.isra.37+0x67d/0x720
> Nov 17 17:34:49 fix kernel: [ =A0 30.750995] =A0[<ffffffff810a2478>]
> __lock_acquire+0x478/0x9c0
> Nov 17 17:34:49 fix kernel: [ =A0 30.750999] =A0[<ffffffff8162ae19>] =
?
> sub_preempt_count+0x29/0x60
> Nov 17 17:34:49 fix kernel: [ =A0 30.751003] =A0[<ffffffff81627475>] =
?
> _raw_spin_unlock+0x35/0x60
> Nov 17 17:34:49 fix kernel: [ =A0 30.751007] =A0[<ffffffff81625f0b>] =
?
> rt_spin_lock_slowlock+0x2eb/0x340
> Nov 17 17:34:49 fix kernel: [ =A0 30.751011] =A0[<ffffffff81056be1>] =
?
> get_parent_ip+0x11/0x50
> Nov 17 17:34:49 fix kernel: [ =A0 30.751014] =A0[<ffffffff81613e63>] =
?
> cache_flusharray+0x47/0xd6
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff810a2f64>]
> lock_acquire+0x94/0x160
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff81613e63>] =
?
> cache_flusharray+0x47/0xd6
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff81626999>]
> rt_spin_lock+0x39/0x40
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff81613e63>] =
?
> cache_flusharray+0x47/0xd6
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff8105a90b>] =
?
> migrate_disable+0x6b/0xe0
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff81613e63>]
> cache_flusharray+0x47/0xd6
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff81167a41>]
> kmem_cache_free+0x221/0x300
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff81167b8f>]
> slab_destroy+0x6f/0xa0
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff81167d32>]
> free_block+0x172/0x190
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff81613eb4>]
> cache_flusharray+0x98/0xd6
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff814f1110>] =
?
> __sk_free+0x130/0x160
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff814f1110>] =
?
> __sk_free+0x130/0x160
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff8116a806>]
> kfree+0x316/0x380
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff814f5328>] =
?
> skb_queue_purge+0x28/0x40
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff814f1110>]
> __sk_free+0x130/0x160
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff814f11d5>]
> sk_free+0x25/0x30
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff8152d908>]
> netlink_release+0x128/0x200
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff814ea388>]
> sock_release+0x28/0x90
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff814eaa57>]
> sock_close+0x17/0x30
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff8117b914>]
> __fput+0xb4/0x200
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff8117ba85>]
> fput+0x25/0x30
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff81177d0c>]
> filp_close+0x6c/0x90
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff81177df0>]
> sys_close+0xc0/0x130
> Nov 17 17:34:49 fix kernel: [ =A0 30.751015] =A0[<ffffffff8162ed02>]
> system_call_fastpath+0x16/0x1b
>

Hmm, I think I see how this can happen.

cache_flusharray()
spin_lock(&l3->list_lock);
free_block(cachep, ac->entry, batchcount, node);
        slab_destroy()
        kmem_cache_free()
                __cache_free()
                cache_flusharray()
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
