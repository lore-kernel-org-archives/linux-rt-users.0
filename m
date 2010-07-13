From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][RT] futex: protect against pi_blocked_on corruption
 during requeue PI
Date: Tue, 13 Jul 2010 11:58:56 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1007131158220.3321@localhost.localdomain>
References: <1278478019.10245.77.camel@marge.simson.net> <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain> <4C3C1DCF.9090509@us.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "lkml, " <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mike Galbraith <efault@gmx.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:35193 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627Ab0GMJ7d (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Jul 2010 05:59:33 -0400
In-Reply-To: <4C3C1DCF.9090509@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 13 Jul 2010, Darren Hart wrote:
> diff --git a/kernel/futex.c b/kernel/futex.c
> index a6cec32..c92978d 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1336,6 +1336,9 @@ retry_private:
>  				requeue_pi_wake_futex(this, &key2, hb2);
>  				drop_count++;
>  				continue;
> +			} else if (ret == -EAGAIN) {
> +				/* Waiter woken by timeout or signal. */

  This leaks the pi_state.

