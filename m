From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: bad return value in __mutex_lock_check_stamp
Date: Sun, 15 Dec 2013 17:48:04 +0100
Message-ID: <52ADDD44.8010102@linutronix.de>
References: <20131215144047.GB32756@opentech.at> <52ADC653.7090005@linutronix.de> <20131215161829.GA18302@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56302 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab3LOQsH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 11:48:07 -0500
In-Reply-To: <20131215161829.GA18302@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/15/2013 05:18 PM, Nicholas Mc Guire wrote:
>>> Bad return value in _mutex_lock_check_stamp - this problem only would show 
>>> up with 3.12.1 rt4 applied but CONFIG_PREEMPT_RT_FULL not enabled 
>>> currently it would be returning what ever vprintk_emit ended up with 
>>> (atleast on x86), which probably is not the intended behavior. Added a
>>> return 0; as in the case with CONFIG_PREEMPT_RT_FULL enabled.
>>
>> Interesting. How do you trigger this? This BUG()-only function should
>> get completely removed by gcc because
>> - ctx argument should be always NULL
>> - BUG() has unreachable() so gcc knows it does not return.
>>
> poped up with randconfig seed 0xBE96A834

Ach. Could you send me the defconfig (offlist) please? I'm trying to
check this later.

> Don't get it - why could gcc optimize it out ? it gets called
> in the mutex slowpath (kernel/mutex.c) if CONFIG_PREEMPT_RT_FULL
> is not set ?

Well, yes. There are two of that __mutex_lock_check_stamp() function,
one  in kernel/mutex.c and the other in rtmutex.c. In the non-RT case,
the www-mutex code is used from mutex.c
In rtmutex.c we end up in the BUG() only function. However all callers
of __rt_mutex_slowlock() have (or should have) ww_ctx set to NULL so we
never end up in __mutex_lock_check_stamp(). The compiler should see
this because all callers are static or static inline.

Your patch is correct, I am just curious why it triggers on your side.
It didn't trigger here why I come up with piece code during v3.12.

> Am I confusing some ifdefs ?
> 
> thx!
> hofrat
> 

Sebastian
