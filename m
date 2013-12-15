From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: bad return value in __mutex_lock_check_stamp
Date: Sun, 15 Dec 2013 16:10:11 +0100
Message-ID: <52ADC653.7090005@linutronix.de>
References: <20131215144047.GB32756@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55748 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab3LOPKO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 10:10:14 -0500
In-Reply-To: <20131215144047.GB32756@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/15/2013 03:40 PM, Nicholas Mc Guire wrote:
> 
> Bad return value in _mutex_lock_check_stamp - this problem only would show 
> up with 3.12.1 rt4 applied but CONFIG_PREEMPT_RT_FULL not enabled 
> currently it would be returning what ever vprintk_emit ended up with 
> (atleast on x86), which probably is not the intended behavior. Added a
> return 0; as in the case with CONFIG_PREEMPT_RT_FULL enabled.

Interesting. How do you trigger this? This BUG()-only function should
get completely removed by gcc because
- ctx argument should be always NULL
- BUG() has unreachable() so gcc knows it does not return.

Sebastian
