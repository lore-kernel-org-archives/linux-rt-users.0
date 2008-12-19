From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 1/7] ftrace: fix task state printout
Date: Fri, 19 Dec 2008 22:36:41 +0100
Message-ID: <20081219213641.GB2351@elte.hu>
References: <20081219155504.735865178@linutronix.de> <20081219155555.919550408@linutronix.de> <c62985530812190825k4e4f5a7apa37e1ab4bc35753a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Gregory Haskins <ghaskins@novell.com>,
	Linux-rt <linux-rt-users@vger.kernel.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:42253 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbYLSVgz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Dec 2008 16:36:55 -0500
Content-Disposition: inline
In-Reply-To: <c62985530812190825k4e4f5a7apa37e1ab4bc35753a@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Fr=E9d=E9ric Weisbecker <fweisbec@gmail.com> wrote:

> Hi Thomas,
>=20
> 2008/12/19 Thomas Gleixner <tglx@linutronix.de>:
> > Impact: tracer task state decoding is wrong, size check is buggy
> >
> > The tracing code has interesting varieties of printing out task sta=
te.
> > Unfortunalely only one of the instances is correct as it copies the
> > code from sched.c:sched_show_task(). The others are plain wrong as
> > they treatthe bitfield as an integer offset into the character
> > array. Also the size check of the character array is wrong as it
> > includes the trailing \0.
> >
> > Use a common state decoder inline which does the Right Thing.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>=20
> You've already sent it out. It has been applied on -tip :-)

That's why the subject line of the series says "2.6.24.7-rt24 bugfixes"=
 i=20
guess :-)

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
