From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: 2.6.24-rc8-rt1: Strange latencies on mpc5200 powerpc - RCU	issue?
Date: Wed, 09 Jul 2008 14:53:20 +0200
Message-ID: <4874B4C0.5090500@pengutronix.de>
References: <20080130102255.GA24890@linux.vnet.ibm.com> <47A0552D.20605@grandegger.com> <20080130105715.GE24890@linux.vnet.ibm.com> <20080130111559.GC20089@pengutronix.de> <486A3EBB.6030905@grandegger.com> <Pine.LNX.4.58.0807011036510.26650@gandalf.stny.rr.com> <486A573E.60107@grandegger.com> <486B607F.9040903@grandegger.com> <Pine.LNX.4.58.0807052041350.8466@gandalf.stny.rr.com> <48709348.6000101@grandegger.com> <20080708150826.GA30586@pengutronix.de> <4873C363.3070306@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Luotao Fu <l.fu@pengutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:39141 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755435AbYGIMxk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jul 2008 08:53:40 -0400
In-Reply-To: <4873C363.3070306@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Wolfgang,

Wolfgang Grandegger wrote:
> Hi Fun,

What's so funny? ;-)

[...]

> But as Steven pointed out, the preempt_enable_noresched at that place
>  might be illegal, anyway. In 2.6.25-rt, trace_mark() is no longer
> used and I do not see an improvement with CONFIG_RCU_TRAC any more.
> Latencies go up to 600us. I also tried with CONFIG_RCU_BOOST
> disabled, but it did not improve the latencies. Actually, I still
> measure significantly different latencies with 2.6.24.4-rt4,
> 2.6.24.7-rt14 and 2.6.25.8-rt7, which is quite frustrating. As you
> seem not be able to reproduce my high latencies, I wonder if there
> are some toolchain or glibc related issues.

I took a quick look into the rcppreempt boost stuff in 2.6.24-rt and
2.6.25-rt. As you have mentioned, trace_mark is no more used in
2.6.24-rt. Instead of that flags are used to detect if the task is
preempted. It might indeed probably be some toolchain issue.
My powerpc toolchain I'm using here contains gcc 4.1.2 and glibc 2.5

Cheers
Fu (without n)
-- 
   Dipl.-Ing. Luotao Fu | Phone: +49-5121-206917-3
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de

