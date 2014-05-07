From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patchlet] locking/rt: fix rt_read_lock() lockdep annotation.
Date: Wed, 7 May 2014 09:48:07 -0400
Message-ID: <20140507094807.229d88d8@gandalf.local.home>
References: <20140503170110.GA10652@linutronix.de>
	<1399449247.5142.14.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:37669 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755915AbaEGNsR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 May 2014 09:48:17 -0400
In-Reply-To: <1399449247.5142.14.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 07 May 2014 09:54:07 +0200
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:

> 
> rt-rw-lockdep-annotations.patch missed an rwlock_acquire_read()
> 
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> ---
>  kernel/locking/rt.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/kernel/locking/rt.c
> +++ b/kernel/locking/rt.c
> @@ -244,13 +244,12 @@ void __lockfunc rt_read_lock(rwlock_t *r
>  {
>  	struct rt_mutex *lock = &rwlock->lock;
>  
> -
>  	/*
>  	 * recursive read locks succeed when current owns the lock
>  	 */
>  	if (rt_mutex_owner(lock) != current) {
>  		migrate_disable();
> -		rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
> +		rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
>  		__rt_spin_lock(lock);

This looks like it reverse applies?

-- Steve

>  	}
>  	rwlock->read_depth++;
> 

