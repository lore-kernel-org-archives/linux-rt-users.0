From: Barry Song <21cnbao@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.33.6-rt26
Date: Mon, 19 Jul 2010 14:37:18 +0800
Message-ID: <AANLkTikWbQQC5ubR3JrCx_PlFJWGsoxGmldswwatgwVQ@mail.gmail.com>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain>
	<alpine.LFD.2.00.1002262041020.4245@localhost.localdomain>
	<alpine.LFD.2.00.1003121124120.22855@localhost.localdomain>
	<alpine.LFD.2.00.1003211158130.3147@localhost.localdomain>
	<alpine.LFD.2.00.1004071619490.32352@localhost.localdomain>
	<alpine.LFD.2.00.1004271744280.2951@localhost.localdomain>
	<alpine.LFD.2.00.1004301156590.2951@localhost.localdomain>
	<alpine.LFD.2.00.1005022109150.25342@localhost.localdomain>
	<alpine.LFD.2.00.1006091837410.2933@localhost.localdomain>
	<alpine.LFD.2.00.1007131745230.3321@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Stultz <johnstul@us.ibm.com>,
	Nick Piggin <npiggin@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55632 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab0GSGhj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Jul 2010 02:37:39 -0400
In-Reply-To: <alpine.LFD.2.00.1007131745230.3321@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,
Just want to know when there will be released RT patch for 2.6.34? We
have some tasks to patch RT to our local 2.6.34 tree.
Thanks
Barry

On Tue, Jul 13, 2010 at 11:54 PM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
> We are pleased to announce the next update to our new preempt-rt
> series.
>
> Changes from 2.6.33.5-rt23 to 2.6.33.5-rt24:
>
> =C2=A042edbcb: gianfar: Fix TX ring processing on SMP machines
> =C2=A0faf3581: timer_stats: Convert table_lock to raw_spin_lock
> =C2=A0654e404: hvc_console: Fix race between hvc_close and hvc_remove
> =C2=A009fd768: hvc_console: Fix race between hvc_close and hvc_remove
> =C2=A0ea2d2a0: perf: Fix errors path in perf_output_begin()
> =C2=A060bd946: KEYS: find_keyring_by_name() can gain access to a free=
d keyring
> =C2=A0b5ac516: tracing: Update the comm field in the right variable i=
n update_max_tr
> =C2=A077cb7c1: lockdep: Reduce stack_trace usage
> =C2=A0cee9ee0: powerpc: Disable sparse irq for RT
> =C2=A0c7dec16: powerpc: Enable interrupts in do_signal()
>
> Changes from 2.6.33.5-rt24 to 2.6.33.5-rt25:
>
> =C2=A0ec646ea: vfs: Revert the scalability patches
>
> Changes from 2.6.33.5-rt26 to 2.6.33.6-rt26:
>
> =C2=A07e1af11: Merge git://git.kernel.org/pub/scm/linux/kernel/git/st=
able/linux-2.6.33.y
>
> Bulk of changes comes from the stable tree and from the big revert of
> the VFS scalability patches. They looked promising, but the nasty
> details bit us hard. We'll revisit them later.
>
> There are some pending issues:
> =C2=A0 =C2=A0 =C2=A0- rtc_lock suspend/resume (working on a patch)
> =C2=A0 =C2=A0 =C2=A0- futex requeue_pi (patch available, needs testin=
g/confirmation)
> =C2=A0 =C2=A0 =C2=A0- powerpc64 oddities (patch available, needs rewo=
rk)
>
> Download locations:
>
> =C2=A0 http://www.kernel.org/pub/linux/kernel/projects/rt/
>
> Git release branch:
> =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-ti=
p.git rt/2.6.33
>
> Gitweb:
> =C2=A0 http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.6-tip.=
git;a=3Dshortlog;h=3Drt/2.6.33
>
> Information on the RT patch can be found at:
>
> =C2=A0 http://rt.wiki.kernel.org/index.php/Main_Page
>
> To build the 2.6.33.6-rt26 tree, the following patches should be
> applied:
>
> =C2=A0 http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.33.6.tar=
=2Ebz2
> =C2=A0 http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.3=
3.6-rt26.bz2
>
> Enjoy !
>
> =C2=A0 =C2=A0 =C2=A0tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
