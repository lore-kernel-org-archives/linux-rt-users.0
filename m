From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt 1/9] preempt rcu: check for underflow
Date: Mon, 30 Jul 2007 11:22:11 +0200
Message-ID: <20070730092211.GA25640@elte.hu>
References: <20070730024534.369897977@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:46480 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765851AbXG3JWX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 05:22:23 -0400
Content-Disposition: inline
In-Reply-To: <20070730024534.369897977@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> +	/*
> +	 * If our rcu_read_lock_nesting went negative, likely
> +	 * something is wrong..
> +	 */
> +	WARN_ON(current->rcu_read_lock_nesting < 0);

have you actually caught any rcu locking problem this way? Double 
unlocks should be caught by lockdep already, at a higher level.

in any case i've added a slightly different form of this change to the 
-rt queue that will also check for counter overflows. But i'm not sure 
we want to litter the code with trivial checks like this, so i'm keeping 
it separate and if it does not trigger anything real i'll remove it.

	Ingo
