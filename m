From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.23-rt1 trouble
Date: Wed, 17 Oct 2007 18:39:04 +0100
Message-ID: <471648B8.1030007@rncbc.org>
References: <1192154640.15992.10.camel@localhost.localdomain>          <38542.213.58.131.130.1192445349.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4.netcabo.pt ([212.113.174.31]:51965 "EHLO
	exch01smtp12.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932856AbXJQRjW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 13:39:22 -0400
In-Reply-To: <38542.213.58.131.130.1192445349.squirrel@www.rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, October 15, 2007 11:49, Rui Nuno Capela wrote:
> On Fri, October 12, 2007 03:04, Steven Rostedt wrote:
>=20
>> We are pleased to announce the 2.6.23-rt1 tree, which can be
>> downloaded from the location:
>>=20
>> http://www.kernel.org/pub/linux/kernel/projects/rt/
>>=20
>> Changes since 2.6.23-rc9-rt2
>>=20
>> - updated to 2.6.23
>>=20
>> - spin_trylock_irqsave macro fix (S=E9bastien Dugu=E9)
>>=20
>> - move rcu_preempt_boost init earlier (Steven Rostedt)
>>=20
>> - rt task send IPI condition update (Mike Kravetz)
>>=20
>=20
> I am experiencing some highly annoying but intermitent freezing on a
> pentium4 2.80G HT/SMT box, when doing normal desktop work with 2.6.23=
-rt1.
>=20
>=20
> The same crippling behavior does not occur on a Core 2 Due T7200 2.0G
> SMP, so I suspect it's something due specific to the SMT scheduling
> support (Hyper-Threading). But can't tell for sure, obviously :)
>

I was wrong. After several trials the same behavior also occurs on the
Core2 Duo T7200. It just took longer to show its nasty.


> The symptoms are noticeable primarily as some X/GUI intermitent freez=
ing,
> sometimes only one application, then several and ultimately the whole=
 X=20
> desktop becomes completely unresponsive. It looks like scheduling=20
> problems. There is this hint that switching to a spare console termin=
al=20
> (via Ctrl+Alt+Fn) might cause later recovery. But its just a question=
 of
> some more time for it just happens again and again, one after another=
,=20
> several applications becoming temporarily frozen and just by luck the=
=20
> system gets back to normal, probably due to some incidental shake-up =
:)=20
> but there are other times that nothing seems to help with no alternat=
ive=20
> to the power-reset switch.
>=20
> I could not find any evidence on dmesg or in the system logs, of any
> apparent trouble. No BUGs, no oops, no panics, no nothing. It just
> freezes, this and that, now and then. It just makes it all unworkable
> and obviously subject to ditching.
>=20
> Again, this only happens on this P4/HT box. On a Core2 Duo laptop, wi=
th
> same 2.6.23-rt1 with the very same kernel configuration, it does not =
show=20
> any illness and is running quite fine.
>=20

=46alse. It used to run fine, until the creeps happen first time :(


> Remember one report I had about a similar freezing behavior? Now it's
> happening the other way around: the core2 is OK, the pentium4 is KO.
>=20

Now it applies to all 2.6.23-rt1 images I could test upon.


> One naive suspicion goes like the new rcu-preempt code is to blame, s=
ince
>  I don't remember having this or any other trouble with 2.6.23-rc8-rt=
1.
>=20

Not be sure anymore, but this seems to be still a valid assumption.

Just in case someone might try in reproducing this showstopper, the
kernel .config is available from here:

  http://www.rncbc.org/datahub/config-2.6.23-rt1.0

dmesg output as right after init:

  http://www.rncbc.org/datahub/dmesg-2.6.23-rt1.0

which can't really tell where to look :)


Cheers.
--=20
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
