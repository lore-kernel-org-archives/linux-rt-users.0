From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: bad return value in __mutex_lock_check_stamp
Date: Sun, 15 Dec 2013 17:18:29 +0100
Message-ID: <20131215161829.GA18302@opentech.at>
References: <20131215144047.GB32756@opentech.at> <52ADC653.7090005@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:37524 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741Ab3LOQSb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 11:18:31 -0500
Content-Disposition: inline
In-Reply-To: <52ADC653.7090005@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 15 Dec 2013, Sebastian Andrzej Siewior wrote:

> On 12/15/2013 03:40 PM, Nicholas Mc Guire wrote:
> > 
> > Bad return value in _mutex_lock_check_stamp - this problem only would show 
> > up with 3.12.1 rt4 applied but CONFIG_PREEMPT_RT_FULL not enabled 
> > currently it would be returning what ever vprintk_emit ended up with 
> > (atleast on x86), which probably is not the intended behavior. Added a
> > return 0; as in the case with CONFIG_PREEMPT_RT_FULL enabled.
> 
> Interesting. How do you trigger this? This BUG()-only function should
> get completely removed by gcc because
> - ctx argument should be always NULL
> - BUG() has unreachable() so gcc knows it does not return.
>
poped up with randconfig seed 0xBE96A834

Don't get it - why could gcc optimize it out ? it gets called
in the mutex slowpath (kernel/mutex.c) if CONFIG_PREEMPT_RT_FULL
is not set ?

Am I confusing some ifdefs ?

thx!
hofrat
