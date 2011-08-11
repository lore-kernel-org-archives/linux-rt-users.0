From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [ANNOUNCE] 3.0.1-rt8 - Regression to 3.0-rt7
Date: Thu, 11 Aug 2011 18:39:41 +0200
Message-ID: <1313080781.8491.6.camel@twins>
References: <1312580681.28695.44.camel@twins>
	 <201108111330.28168.tim.sander@hbm.com> <1313066498.8491.1.camel@twins>
	 <201108111804.11136.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35602 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab1HKQkV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Aug 2011 12:40:21 -0400
In-Reply-To: <201108111804.11136.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2011-08-11 at 18:04 +0200, Tim Sander wrote:
> Yes it works for CONFIG_PREEMPT_RTB=y and as you say not for 
> CONFIG_PREEMPT_LL=y.

> +++ b/mm/filemap.c
> @@ -2040,7 +2040,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
>         char *kaddr;
>         size_t copied;
>  
> -       BUG_ON(!current->pagefault_disabled);
> +       BUG_ON(!(in_atomic() || current->pagefault_disabled)); 

Ah, I had hoped that bit would have cured the PREEMPT_LL=y config.


But let me untangle that posix_cpu_timer stuff first, maybe that's in
the way.
