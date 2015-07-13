From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference on
 3.18.13-rt10
Date: Mon, 13 Jul 2015 11:34:30 -0400
Message-ID: <20150713113430.4c18c965@gandalf.local.home>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
	<alpine.DEB.2.11.1507091605410.5134@nanos>
	<c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com>
	<20150710132318.GA27402@linutronix.de>
	<3c9ae4a1f9cb4ac3a96a28c3f65f9442@FE-MBX1012.de.bosch.com>
	<20150713091237.GA31747@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:37948 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751492AbbGMPed convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2015 11:34:33 -0400
In-Reply-To: <20150713091237.GA31747@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 13 Jul 2015 11:12:37 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Koehrer Mathias (ETAS/ESW5) | 2015-07-13 06:18:22 [+0000]:
>=20
> >> if you managed to trigger it that reliably, could you revert
> >> slub_delay_ctor_on_rt.patch in the queue and try again?
> >>=20
> >Over the weekend I ran a test that rebooted the PC permanently.
> >After about 400 reboots I got another NULL pointer dereference.=20
> >However the slub_delay_ctor_on_rt.patch has not been reverted yet.
> >And: This looks somehow differently than the previous BUGs.
> >
> >
> >[    3.299329] BUG: unable to handle kernel NULL pointer dereference=
 at 0000008c
> >[    3.299332] IP: [<c10df66c>] function_trace_call+0xc/0x190
>=20
> This is=20
> | static void
> | function_trace_call(unsigned long ip, unsigned long parent_ip,
> |                     struct ftrace_ops *op, struct pt_regs *pt_regs)
> | {
> |         struct trace_array *tr =3D op->private;
> |=E2=80=A6
> |=20
> |         if (unlikely(!tr->function_enabled))
> |                 return;
>=20
> and it looks like tr is null. BUG_ON(!tr) should prove this.
> Steven, is it somehow possible that on module load we get "op" set
> without its private member initialized?
>=20

What's the test that was run, and how did it enable function tracing?

-- Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
