From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.12.8-rt11
Date: Mon, 27 Jan 2014 13:24:11 -0500
Message-ID: <20140127132411.6f420c8f@gandalf.local.home>
References: <20140125134519.GA9845@linutronix.de>
	<52E57D42.60206@pavlinux.ru>
	<52E61C52.6070104@linutronix.de>
	<52E62A05.7080802@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: pavel@pavlinux.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:53148 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753639AbaA0SYN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Jan 2014 13:24:13 -0500
In-Reply-To: <52E62A05.7080802@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 27 Jan 2014 13:42:29 +0400
Pavel Vasilyev <pavel@pavlinux.ru> wrote:

> 27.01.2014 12:44, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> > On 01/26/2014 10:25 PM, Pavel Vasilyev wrote:
> >> 25.01.2014 17:45, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> >>> Dear RT folks!
> >>
> >>
> >> Gentlemen, let's have a month of stress testing! Divide tasks
> >> testing subsystem: USB, NET, MM, ACPI, AUDIO, VIDEO By CPUs:
> >> ARM/PPC/X86/X86_64...
> >>
> >> Purely on observations noted that in September 2013, the quality
> >> and stability of the code has deteriorated dramatically.
> >=20
> > By September 2k13, do you mean a specific v3.10-RT release?
> >=20
>=20
> Any after 3.2.x-rt
>=20
> Maybe I'm doing something wrong, but:
>=20
> 1) All kernels (3.2, 3.8, 3.12, 3.13,...) are working normally withou=
t patches;
>=20
> 2) 3.2 works fine in CONFIG_PREEMPT_RT_BASE or CONFIG_PREEMPT_RT_FULL=
 modes;
>=20
> 3) 3.10 not works at all, even without -RT patches;

Please report the problems here to LKML (linux-kernel@vger.kernel.org)
to the appropriate maintainers. As well as the stable@vger.kernel.org
mailing list.

>=20
> 4) 3.12 work only as CONFIG_PREEMPT_RT_BASE or CONFIG_PREEMPT_RT_FULL=
 in
> uniprocessor mode (maxcpus=3D0, nosmp).  Newer patches (Oct.-Dec.) di=
d not work,
> even in RT_BASE mode.

Does 3.12 work without the -rt patches?

>=20
> Varia hardware: One Opteron 285, 2-cpus (4 cores). Six Intel Atoms de=
vices
> kernels compiled as x86_32.

I have an intel atom dev board hanging around somewhere. I'll see if I
can test this. Can you send me your config privately.

Thanks,

-- Steve

>=20
> I have my patches, but I tested both with them and without them.
> ---
>=20
> Behold! 3.12.8-rt11, RT_FULL mode, kernel cmdline: init=3D/bin/bash
>=20
> 1.
> bash: cannot set terminal process group (-1): Inappropriate ioctl for=
 device
> bash: no job control in this shell
>=20
> 2.
> in single mode: After 2 minutes timeout: see screenshot
> http://i59.fastpic.ru/big/2014/0127/bc/0f9e04536181286f820ecaae5a8481=
bc.jpg
>=20
> 3.
> command killall -15 freezed system!
>=20
>=20
> Kernel compiled with debug information starts to work normally, but o=
f course
> slower. :D
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
