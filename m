From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: [PATCH RT 3/3 - take two ] fix get_monotonic_cycles for latency tracer
Date: Sat, 25 Aug 2007 07:06:54 -0400
Message-ID: <y0modgv50vl.fsf@ton.toronto.redhat.com>
References: <1187978236.2941.19.camel@localhost.localdomain>
	<1187982149.4574.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:45251 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764295AbXHYLHr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Aug 2007 07:07:47 -0400
In-Reply-To: <1187982149.4574.1.camel@localhost.localdomain> (Steven Rostedt's message of "Fri, 24 Aug 2007 15:02:29 -0400")
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> [...]
> +		 * [...] We don't need to grab
> +		 * any locks, we just keep trying until get all the
> +		 * calculations together in one state.
> +		 *
> +		 * In fact, we __cant__ grab any locks. This
> +		 * function is called from the latency_tracer which can
> +		 * be called anywhere. To grab any locks (including
> +		 * seq_locks) we risk putting ourselves into a deadlock.

Perhaps you could add a comment about why the loop, which appears
potentially infinite as written, avoids livelock.  (It looks rather
like a seqlock read loop.)

- FChE
