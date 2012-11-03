From: Ove Karlsen <ove.karlsen@paradoxuncreated.com>
Subject: Re: [ANNOUNCE] 3.6.5-rt14
Date: Sat, 03 Nov 2012 20:04:58 +0100
Message-ID: <50956ADA.6090108@paradoxuncreated.com>
References: <alpine.LFD.2.02.1211012148170.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.54]:44149 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab2KCUEt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 Nov 2012 16:04:49 -0400
In-Reply-To: <alpine.LFD.2.02.1211012148170.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Den 01.11.2012 21:57, skrev Thomas Gleixner:
> Dear RT Folks,
>
> I'm pleased to announce the 3.6.5-rt14 release. 3.6.4-rt12 is an
> intermediate release with a few changes. 3.6.5-rt13 is an update to
> 3.6.5 and 3.6.5-rt14 has a fix for my stupidity to release from the
> wrong tree missing a fix for x86-32.
>
> Changes since 3.6.3-rt11:
>
>     * Fix the fallout of preempt_lazy
>
>     * Add preempt_lazy support for ARM and POWERPC
>
>     * Fix a 32bit compile warning which got introduced with the
>       random fixes.
>
>     * Fix a missing lock conversion in the decive tree code
>
> The delta patch against 3.6.4-rt11 is can be found here:
>
>    http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-=
3.6.4-rt11-rt12.patch.xz
>
> The RT patch against 3.6.5 can be found here:
>
>    http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.5=
-rt14.patch.xz
>
> The split quilt queue is available at:
>
>    http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patches-3.6=
=2E5-rt14.tar.xz
>
> Enjoy,
>
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Heya I see jitter is a focus on the RT patch.
I was wondering, what settings in features.h gives the least jitter? (I=
=20
am a real perfectionist)
Also what kind of threadpriorities gives the least jitter, particulary=20
with a focus on OpenGL? (Should some kernelthreads be reniced, for=20
instance softirqs etc)
And have you given consideration to the fact that most distros and OS=20
grow with some levels of bloat, and everyone can`t be an expert, so=20
maybe one shold consider a (scheduler) queue for "bloat", and one queue=
=20
for main app, so that even bloated distros can run with the jitteramoun=
t=20
of a highly specialized distro? (for instance=20
mainapp,service1,mainapp,service2,mainapp,service3), if bloat is on=20
queue 2. Or is thins kind of thinking already in batch, or idle?
--=20
=46red v=E6re med deg / Peace Be with You,
Ove Karlsen
http://www.paradoxuncreated.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
