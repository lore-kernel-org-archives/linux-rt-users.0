From: Luis Henriques <henrix@sapo.pt>
Subject: Re: 2.6.26.6-rt10
Date: Mon, 13 Oct 2008 01:15:12 +0100
Message-ID: <48F29310.1030206@sapo.pt>
References: <1223839814.19319.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:37027 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753244AbYJMAPT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 12 Oct 2008 20:15:19 -0400
In-Reply-To: <1223839814.19319.5.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven,

Steven Rostedt wrote:
> We are pleased to announce the 2.6.26.6-rt10 tree, which can be
> downloaded from the location:
>=20
>   http://rt.et.redhat.com/download/
>=20
> Information on the RT patch can be found at:
>=20
>   http://rt.wiki.kernel.org/index.php/Main_Page
>=20
> Changes since 2.6.26.5-rt9
>=20
>   - ported to 2.6.26.6
>=20
>   - rwlock to handle unnested order unlocks (Steven Rostedt)
>=20
>   - rwlock update torture test to test unnested unlocks (Steven Roste=
dt)
>=20
>   - remove rt push comment (Gregory Haskins)
>=20
>   - rt sched fix to handle dequeue (Gregory Haskins)
>=20
>   - PPC: remove duplicate stack trace code (Robert Schwebel)
>=20
>   - ARM: ftrace event IRQ call fix (Alexander Pazdnikov)
>=20
>   - fair sched not to resched RT tasks (Peter Zijlstra)
>=20
>   - ftrace quick stop (Steven Rostedt)
>=20
>   - event trace of resched (Steven Rostedt)
>=20
>=20
> to build a 2.6.26.6-rt10 tree, the following patches should be applie=
d:
>=20
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.26.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.26.6.bz2
>   http://rt.et.redhat.com/download/patch-2.6.26.6-rt10.bz2
>=20
>=20
>=20
> And like always, my RT version of Matt Mackall's ketchup will get thi=
s
> for you nicely:
>=20
>   http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3
>=20
>=20
> The broken out patches are also available.
>=20
>=20
> -- Steve
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

I found a compilation error while compiling this new version of the rt
pach.  I guess the following line is enough for you to trace the proble=
m:

kernel/trace/trace_events.c:49: error: =91function_trace_stop=92 undecl=
ared
(first use in this function)

It seems that an 'extern int function_trace_stop' is missing somewhere.=
=2E.

Regards,
--
Luis Henriques
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
