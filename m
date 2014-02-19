From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3.12.9-rt13: BUG: soft lockup
Date: Wed, 19 Feb 2014 10:50:29 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402191049260.4468@ionos.tec.linutronix.de>
References: <52FBF2F1.8040504@localhost> <alpine.DEB.2.02.1402132324230.21991@ionos.tec.linutronix.de> <52FD4D89.2000207@localhost> <alpine.DEB.2.02.1402140053000.21991@ionos.tec.linutronix.de> <52FDB71F.2020000@ccrma.stanford.edu>
 <alpine.DEB.2.02.1402141040460.21991@ionos.tec.linutronix.de> <52FE6681.8090807@ccrma.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52FE6681.8090807@ccrma.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 14 Feb 2014, Fernando Lopez-Lezcano wrote:
> I could try to boot one of the machines into 3.12.xrtyy, replicate the
> conditions and wait. What should I look for if I can catch this in the act?

dmesg and sysrq-t output would be a good start I guess.

Thanks,

	tglx
