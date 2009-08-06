From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH 1/2] Update woken requeued futex_q lock_ptr
Date: Wed, 05 Aug 2009 22:15:03 -0700
Message-ID: <4A7A66D7.3090203@us.ibm.com>
References: <4A7A009E.2000202@us.ibm.com> <4A7A016C.1090002@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
	mingo@elte.hu, dino@in.ibm.com, johnstul@us.ibm.com,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:33050 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbZHFFPG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Aug 2009 01:15:06 -0400
In-Reply-To: <4A7A016C.1090002@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Darren Hart wrote:
> futex_requeue() can acquire the lock on behalf of a waiter during the 
> requeue
> loop in the event of a lock steal or owner died. futex_wait_requeue_pi() 
> cleans
> up the pi_state owner, using the lock_ptr to protect against concurrent 
> access
> to the pi_state.  The pi_state is found on the requeue target futex hash 
> bucket
> so the lock_ptr needs to be updated accordingly.  The problem manifested by
> triggering the WARN_ON in lookup_pi_state() about the pid != 
> pi_state->owner
> pid.
> The astute reviewer will note that still exists a race between the time
> futex_requeue() releases hb2->lock() and the time when 
> futex_wait_requeue_pi()
> acquires it.  During this time the pi_state and the futex uaddr are not 
> in sync
> with the rt_mutex ownership.  This patch closes the window to the point 
> where
> my tests now pass, but we still need to address it.
> 
> Note: Please apply to mainline and rt
> 


> static inline
> -void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key)
> +void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
> +               struct futex_hash_bucket *hb)
> {
>     drop_futex_key_refs(&q->key);
>     get_futex_key_refs(key);
>     q->key = *key;
> +    q->lock_ptr = &hb->lock;

Hrm... turns out changing this breaks the 
handle_early_requeue_pi_wakeup() logic.  I'll have to respin this patch 
to account for that as well.  Please hold off on this patch.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
