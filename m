From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] x86/mce: Defer mce wakeups to threads for
 PREEMPT_RT
Date: Thu, 25 Apr 2013 18:44:41 +0200
Message-ID: <20130425164441.GG5561@linutronix.de>
References: <1365705214.9609.58.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45075 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758900Ab3DYQou convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 12:44:50 -0400
Content-Disposition: inline
In-Reply-To: <1365705214.9609.58.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2013-04-11 14:33:34 [-0400]:

>Comments?

So you don't mind if I take this for v3.8?
I fixed

|arch/x86/kernel/cpu/mcheck/mce.c:1392:13: warning: function declaratio=
n isn=E2=80=99t a prototype [-Wstrict-prototypes]

>+static void mce_notify_work()
                             ^^

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
