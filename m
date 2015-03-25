From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Wed, 25 Mar 2015 03:38:00 +0100
Message-ID: <1427251080.3459.8.camel@gmail.com>
References: <20150317163541.080310081@goodmis.org>
	 <20150317163617.218582800@goodmis.org>
	 <20150317163551.3093b6c2@gandalf.local.home>
	 <1426753029.4168.80.camel@gmail.com>
	 <20150319122611.0d002d48@gandalf.local.home> <550AFC6A.4050901@hp.com>
	 <1426960943.4677.34.camel@gmail.com> <20150324181520.GE1321@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35600 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbCYCiD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Mar 2015 22:38:03 -0400
In-Reply-To: <20150324181520.GE1321@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2015-03-24 at 19:15 +0100, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2015-03-21 19:02:23 [+0100]:
>=20
> >> Steve, I'm still working on the fix we discussed using dummy irq_t=
ask.
> >> I should be able to submit some time next week, if still intereste=
d.
> >>=20
> >> Either that, or I think we should remove the function
> >> spin_do_trylock_in_interrupt() to prevent any possibility of runni=
ng
> >> into similar problems in the future.
> >
> >Why can't we just Let swapper be the owner when in irq with no dummy=
?
>=20
> so you abuse the owner to be swapper and mask it out everywhere. It d=
oes
> not look like a final solution. I'm more inclined to take you other
> patch. In the end I hope we get a timer re-work and do not need any
> hackary around it=E2=80=A6

Yeah, it was just _a_ way to dodge the bullet.

	-Mike

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
