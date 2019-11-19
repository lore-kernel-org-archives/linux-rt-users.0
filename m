Return-Path: <SRS0=wgqT=ZL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC47C43215
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Nov 2019 14:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3AC222EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Nov 2019 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574174837;
	bh=gDox6nHTvPDLYkDr0P7VZdMIOKHTU1y6ZfkQibEdeqY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XB56RtQZVCATTt4l1ldvF/2NFUmGH78JkPxdMxlXaT4kZprqf1818SyB0ca0CY8va
	 Eac9quSF0QAnsFVsv+qenamjyy9B/W5hrOXbFx4IWpEPTNRBuY8cY7k+xp3HulK4Gn
	 egPk+O0pCvlMXV4qQ8VKVtO4UBmDNKADFzK8xjv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfKSOrM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbfKSOrM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Nov 2019 09:47:12 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 256DB222D1;
        Tue, 19 Nov 2019 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574174831;
        bh=gDox6nHTvPDLYkDr0P7VZdMIOKHTU1y6ZfkQibEdeqY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nkyzsi3CC68t2roIyojFz6hHMc8BpahtgdhYcQzsb7zj9RVkfOYo90feQ8Hzc7LEk
         CUiBN+PMozu+9IVJdT5Ub5V2Eiw6PTT5TqinkBtvISHH/Ehe7Zhlz40fzRkFpuRAXF
         d8ZpH1y8RZ0HZW0D3ZxYnkcRDMpHulmJNlW3dwig=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C8E0C3520B06; Tue, 19 Nov 2019 06:47:10 -0800 (PST)
Date:   Tue, 19 Nov 2019 06:47:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] locking: Make spinlock_t and rwlock_t a RCU section
 on RT
Message-ID: <20191119144710.GW2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191119084640.wgsxghvc62mxlqc3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119084640.wgsxghvc62mxlqc3@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Nov 19, 2019 at 09:46:40AM +0100, Sebastian Andrzej Siewior wrote:
> On !RT a locked spinlock_t and rwlock_t disables preemption which
> implies a RCU read section. There is code that relies on that behaviour.
> 
> Add an explicit RCU read section on RT while a sleeping lock (a lock
> which would disables preemption on !RT) acquired.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/locking/rtmutex.c   | 6 ++++++
>  kernel/locking/rwlock-rt.c | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index cf09f8e7ed0f4..602eb7821a1b1 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1141,6 +1141,7 @@ void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
>  void __lockfunc rt_spin_lock(spinlock_t *lock)
>  {
>  	sleeping_lock_inc();
> +	rcu_read_lock();
>  	migrate_disable();
>  	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
>  	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
> @@ -1156,6 +1157,7 @@ void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
>  void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
>  {
>  	sleeping_lock_inc();
> +	rcu_read_lock();
>  	migrate_disable();
>  	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
>  	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
> @@ -1169,6 +1171,7 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
>  	spin_release(&lock->dep_map, 1, _RET_IP_);
>  	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
>  	migrate_enable();
> +	rcu_read_unlock();
>  	sleeping_lock_dec();
>  }
>  EXPORT_SYMBOL(rt_spin_unlock);
> @@ -1200,6 +1203,7 @@ int __lockfunc rt_spin_trylock(spinlock_t *lock)
>  	ret = __rt_mutex_trylock(&lock->lock);
>  	if (ret) {
>  		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
> +		rcu_read_lock();
>  	} else {
>  		migrate_enable();
>  		sleeping_lock_dec();
> @@ -1216,6 +1220,7 @@ int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
>  	ret = __rt_mutex_trylock(&lock->lock);
>  	if (ret) {
>  		sleeping_lock_inc();
> +		rcu_read_lock();
>  		migrate_disable();
>  		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>  	} else
> @@ -1232,6 +1237,7 @@ int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
>  	ret = __rt_mutex_trylock(&lock->lock);
>  	if (ret) {
>  		sleeping_lock_inc();
> +		rcu_read_lock();
>  		migrate_disable();
>  		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>  	}
> diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
> index c3b91205161cc..0ae8c62ea8320 100644
> --- a/kernel/locking/rwlock-rt.c
> +++ b/kernel/locking/rwlock-rt.c
> @@ -310,6 +310,7 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
>  	ret = do_read_rt_trylock(rwlock);
>  	if (ret) {
>  		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
> +		rcu_read_lock();
>  	} else {
>  		migrate_enable();
>  		sleeping_lock_dec();
> @@ -327,6 +328,7 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
>  	ret = do_write_rt_trylock(rwlock);
>  	if (ret) {
>  		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
> +		rcu_read_lock();
>  	} else {
>  		migrate_enable();
>  		sleeping_lock_dec();
> @@ -338,6 +340,7 @@ EXPORT_SYMBOL(rt_write_trylock);
>  void __lockfunc rt_read_lock(rwlock_t *rwlock)
>  {
>  	sleeping_lock_inc();
> +	rcu_read_lock();
>  	migrate_disable();
>  	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
>  	do_read_rt_lock(rwlock);
> @@ -347,6 +350,7 @@ EXPORT_SYMBOL(rt_read_lock);
>  void __lockfunc rt_write_lock(rwlock_t *rwlock)
>  {
>  	sleeping_lock_inc();
> +	rcu_read_lock();
>  	migrate_disable();
>  	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
>  	do_write_rt_lock(rwlock);
> @@ -358,6 +362,7 @@ void __lockfunc rt_read_unlock(rwlock_t *rwlock)
>  	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
>  	do_read_rt_unlock(rwlock);
>  	migrate_enable();
> +	rcu_read_unlock();
>  	sleeping_lock_dec();
>  }
>  EXPORT_SYMBOL(rt_read_unlock);
> @@ -367,6 +372,7 @@ void __lockfunc rt_write_unlock(rwlock_t *rwlock)
>  	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
>  	do_write_rt_unlock(rwlock);
>  	migrate_enable();
> +	rcu_read_unlock();
>  	sleeping_lock_dec();
>  }
>  EXPORT_SYMBOL(rt_write_unlock);
> -- 
> 2.24.0
> 
