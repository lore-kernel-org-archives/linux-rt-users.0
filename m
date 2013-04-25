From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT v2] x86/mce: Defer mce wakeups to threads for
 PREEMPT_RT
Date: Thu, 25 Apr 2013 13:09:37 -0400
Message-ID: <1366909777.10248.17.camel@gandalf.local.home>
References: <1365705214.9609.58.camel@gandalf.local.home>
	 <20130425164441.GG5561@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:11706 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757319Ab3DYRJl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 13:09:41 -0400
In-Reply-To: <20130425164441.GG5561@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2013-04-25 at 18:44 +0200, Sebastian Andrzej Siewior wrote:
> * Steven Rostedt | 2013-04-11 14:33:34 [-0400]:
>=20
> >Comments?
>=20
> So you don't mind if I take this for v3.8?
> I fixed
>=20
> |arch/x86/kernel/cpu/mcheck/mce.c:1392:13: warning: function declarat=
ion isn=E2=80=99t a prototype [-Wstrict-prototypes]
>=20
> >+static void mce_notify_work()

Thanks, I didn't look hard at the warnings.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
