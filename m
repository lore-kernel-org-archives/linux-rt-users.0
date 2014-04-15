From: jordan <triplesquarednine@gmail.com>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init [which
 in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Tue, 15 Apr 2014 12:15:49 -0400
Message-ID: <CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:48939 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaDOQPu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Apr 2014 12:15:50 -0400
Received: by mail-vc0-f179.google.com with SMTP id ij19so9177613vcb.24
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Apr 2014 09:15:49 -0700 (PDT)
In-Reply-To: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Just an update on this;

> [ninez@localhost ~]$ uname -a
> Linux localhost 3.14.0-rt1-1-l-pa #1 SMP PREEMPT RT Sun Apr 13
> 10:44:19 EDT 2014 x86_64 GNU/Linux
>
> I've been running 3.14-rt for a couple of hours now and it appears to
> be stable, thus far - without those patches/fixes applied [and
> obviously doesn't boot at all with them applied...and as you know - i
> am not the only AMD user affected by the boot failures...so i am
> thinking those patches really need to be looked at again, as they
> cause serious regressions for some of us :\

My Phenom II 965 has uptime of two days, after being stress tested and
is running great [hackbench, cyclictest+100% load, etc] :)

All of my other machines [both Intel and AMD] also are running well,
without those three patches applied;

| timers-do-not-raise-softirq-unconditionally.patch
| timer-Raise-softirq-if-there-s-irq_work.patch
| timer-rt-Always-raise-the-softirq-if-there-s-irq_wor.patch

I did see a couple of "non-fatal" "NOHZ: local_softirq_pending 40"
messages [as expected, since i reverted those patches] but these are
harmless, when compared to my machines not being bootable with those
applied... I don't have the expertise to fix those patches to boot on
my AMD hardware, but i am hoping that someone who does; can take a
look at those patches again - and i am more than willing to test
subsequent revisions to see if we can get these troublesome AMD
machines to boot with them applied..

...regarding nvidia on PREEMPT_RT_FULL / EXPORT_SYMBOL_GPL for
__rt_mutex_init - i notified nvidia of the problem [although, it is an
upstream linux problem]. Interestingly, this problem has already
cropped up during 3.0 development cycle on PREEMPT_RT_FULL - where the
__rt_mutex_init was changed to gpl-only symbol - only to be changed
back to SYMBOL_EXPORT shortly thereafter.... and yes, i realize
'everybody hates nvidia' - but i have to imagine there might be an MIT
licensed out-of-tree module or two [or other gpl-compatible license]
that might rely on being able to use __rt_mutex_init and now can't...
meaning i doubt this is _just_ an nvidia problem :\

as it stands, one must either change nvidia's licenses to GPL [makeing
nvidia non-distibutable]...

or change 'kernel/locking/rtmutex.c' ~
EXPORT_SYMBOL_GPL(__rt_mutex_init) to EXPORT_SYMBOL(__rt_mutex_init)

...which obviously makes the kernel GPL-incompatible / non-distributable.

I may hit LKML on this issue too, as something needs to happen here -
but i thought i would wait and see if i got a response from someone
here, first. [being as rt-devs have a little more direct contact with
Ingo / subsystem maintainers than i do [ and i am not even subbed to
that list].

Jordan
