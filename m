From: Jan Blunck <jblunck@suse.de>
Subject: Re: [PATCH 00/18] tracing/ring-buffer: fixes for latency tracer
	[2.6.32]
Date: Mon, 7 Sep 2009 12:20:50 +0200
Message-ID: <4de7f8a60909070320j692d746drb06bd635ca7f7c55@mail.gmail.com>
References: <20090904235527.520961911@goodmis.org>
	 <20090905150658.GA13387@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:22156 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbZIGKUt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Sep 2009 06:20:49 -0400
In-Reply-To: <20090905150658.GA13387@ghostprotocols.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Sep 5, 2009 at 5:06 PM, Arnaldo Carvalho de Melo<acme@redhat.com> wrote:
>
> I did a quick port to tip/rt/head and couldn't reproduce the problems I
> was experiencing, thanks!
>
> I've put the ported patch series at:
>
> http://userweb.kernel.org/~acme/rostedt-rb-rt
>

Nice, this also seems to fix my problem with the hanging wakup
selftest. At least the system continues to boot. However, I still get
this:

[   13.739115] Testing tracer sched_switch: PASSED
[   14.002071] Testing tracer function: PASSED
[   14.158816] Testing dynamic ftrace: PASSED
[   14.512524] Testing tracer irqsoff: PASSED
[   14.693519] Testing tracer preemptoff: PASSED
[   14.853519] Testing tracer preemptirqsoff: PASSED
[   15.013506] Testing tracer wakeup:
[   15.134004] hrtimer: interrupt too slow, forcing clock min delta to
27508383 ns
[   15.134010] hrtimer: interrupt too slow, forcing clock min delta to
27544629 ns
[   15.134016] hrtimer: interrupt too slow, forcing clock min delta to
27543582 ns
[   15.134022] hrtimer: interrupt too slow, forcing clock min delta to
27543372 ns
[   15.134028] hrtimer: interrupt too slow, forcing clock min delta to
27543162 ns
[   15.134034] hrtimer: interrupt too slow, forcing clock min delta to
27542325 ns
[   15.134040] hrtimer: interrupt too slow, forcing clock min delta to
27542952 ns
[   15.134046] hrtimer: interrupt too slow, forcing clock min delta to
27543579 ns
[   15.134052] hrtimer: interrupt too slow, forcing clock min delta to
27543582 ns
[   15.134058] hrtimer: interrupt too slow, forcing clock min delta to
27543789 ns
[   15.134063] hrtimer: interrupt too slow, forcing clock min delta to
27543372 ns
[   15.134070] hrtimer: interrupt too slow, forcing clock min delta to
27542532 ns
[   15.134076] hrtimer: interrupt too slow, forcing clock min delta to
27542745 ns
[   15.134082] hrtimer: interrupt too slow, forcing clock min delta to
27543372 ns
[   15.134088] hrtimer: interrupt too slow, forcing clock min delta to
27542742 ns
[   15.134094] hrtimer: interrupt too slow, forcing clock min delta to
27542325 ns
[   15.134101] hrtimer: interrupt too slow, forcing clock min delta to
27544419 ns
[   15.134107] hrtimer: interrupt too slow, forcing clock min delta to
27544419 ns
[   15.134113] hrtimer: interrupt too slow, forcing clock min delta to
27544209 ns
[   15.134119] hrtimer: interrupt too slow, forcing clock min delta to
27544419 ns
[   15.134126] hrtimer: interrupt too slow, forcing clock min delta to
27544419 ns
[   15.134132] hrtimer: interrupt too slow, forcing clock min delta to
27544422 ns
[   15.134161] hrtimer: interrupt too slow, forcing clock min delta to
27492249 ns
[   15.133993] hrtimer: interrupt too slow, forcing clock min delta to
28730742 ns
[   15.810670] PASSED
[   15.865758] Testing tracer wakeup_rt: PASSED

And this time I have lockdep really disabled.

Jan
