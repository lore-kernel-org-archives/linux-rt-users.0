Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3494654D;
	Wed, 19 Jun 2024 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718773775; cv=none; b=eAb+ZfEjpS7ESv4BMYMNTOHZimjHZN/Hu4ltPCs4bMf2N2sUTd9HRfb2oDy4bVcUl43TVsBn/8URU5xXkNIj1LyYLXoRsMwwnPHgrjQgRPviLhltoFwvRQqZ+Kui+rqV3nD2ArRVaUJvh1S/xmOXkPAnfm3KFB0CDZw/8IiGdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718773775; c=relaxed/simple;
	bh=HvU4FycJgR65oxc6jCJPrf6720UfjcTq3+O8wYNoyPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O5tgwJ/R5/eDD2OmYNNKTjm8okcujSESNnJUB2iDamFZdpQXXdDy7anh2cV1U6PIKJyXolKF8/8Bvph5ru5n9XjRKhKSjxL4UDD9EYk5tFuXhBx3tO6UsTdOZFkFNRKarXMOaOiHE+tPNky18LAOxMPxaFYL1GgG3SVOhRM4++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1LQMCBzn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sw07ljdf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1LQMCBzn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sw07ljdf"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718773771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J7eIouGxhOlxNIBd+SGRbnmq0Tn62kIpzfCobj7bvq8=;
	b=1LQMCBzniJT41zv196XOI3ajdfin4SO2Vr3xy5eHXQEBy99u/qTC7KLSD+oii+F7irl/1I
	i3QSbPdxo+yWjeDBBIH3zJRJEsPuIDTJQKEZ4e0e8vLFeICy326gPK3JfVQZDUgZET0rRZ
	dOmYRkP8dO1VxFOMtP3OGgoocYJ+ghQZc3VRyxEZHQuAx1Xzv+i4rrM50OBeDSI8Y4MRnF
	aOO9sBHbDHDcDqVvaD8E1JmH0qPoVBFHDNb7Ul3Ts+3fq/gvQjjJSni+KSH2t46ZnMMK0l
	Om7drctoTyv1/H+ivh6umBL1jxqVBKdpLFqBo93m0qO9cb3MG2ZsvGE1IWaXgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718773771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J7eIouGxhOlxNIBd+SGRbnmq0Tn62kIpzfCobj7bvq8=;
	b=sw07ljdftejZBvaWnHbudTvMih3eCIlCxaHYhnzmNK4edwF5rwmMJrXtP4w8b90vNw0Y/D
	T1nEWMfhU+oDqSAg==
To: Andrew Halaney <ahalaney@redhat.com>, tglx@linutronix.de
Cc: Derek Barbosa <debarbos@redhat.com>, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 williams@redhat.com, jlelli@redhat.com, lgoncalv@redhat.com,
 jwyatt@redhat.com, aubaker@redhat.com
Subject: Re: [BUG] printk/nbcon.c: watchdog BUG: softlockup - CPU#x stuck
 for 78s
In-Reply-To: <dtde47mfm3amxg4mbrnbct53ehpfbekdvrjhhd6j5tzl7lulwj@zwdsvkq3orag>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <87msni13lv.fsf@jogness.linutronix.de>
 <dtde47mfm3amxg4mbrnbct53ehpfbekdvrjhhd6j5tzl7lulwj@zwdsvkq3orag>
Date: Wed, 19 Jun 2024 07:15:31 +0206
Message-ID: <87o77xa584.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[ Explicitly added tglx, hoping he can chime in here. ]

On 2024-06-18, Andrew Halaney <ahalaney@redhat.com> wrote:
>> Shouldn't the scheduler eventually kick the task off the CPU after
>> its timeslice is up?
>
> I trust you better than myself about this, but this is being
> reproduced with a CONFIG_PREEMPT_DYNAMIC=y +
> CONFIG_PREEMPT_VOLUNTARY=y setup (so essentially the current mode is
> VOLUNTARY). Does that actually work that way for a kthread in that
> mode?

It would be good not to trust me better than yourself. I actually have
very little experience with the non-RT preemption models. I will need to
investigate this further.

> Just in case I did something dumb, here's the module I wrote up:
>
> ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % cat kernel/printk/test_thread.c                         :(
> /*
>  * Test making a kthread similar to nbcon's (under load)
>  * to see if it also has issues with migrate_swap()
>  */
> #include "linux/nmi.h"
> #include <asm-generic/delay.h>
> #include <linux/kthread.h>
> #include <linux/module.h>
> #include <linux/sched.h>
>
> DEFINE_STATIC_SRCU(test_srcu);
> static DEFINE_SPINLOCK(test_lock);
> static struct task_struct *kt;
> static bool dont_stop = true;
>
> static int test_thread_func(void *unused) {
> 	unsigned long flags;
>
> 	pr_info("Starting the while true loop\n");
> 	do {
> 		int cookie = srcu_read_lock_nmisafe(&test_srcu);
> 		spin_lock_irqsave(&test_lock, flags);
> 		touch_nmi_watchdog();
> 		udelay(5000);  // print a line to serial
> 		spin_unlock_irqrestore(&test_lock, flags);
> 		srcu_read_unlock_nmisafe(&test_srcu, cookie);
> 	} while (dont_stop);
>
> 	return 0;
> }
>
> static int __init test_thread_init(void) {
>
> 	pr_info("Creating test_thread at -20 nice level\n");
> 	kt = kthread_run(test_thread_func, NULL, "test_thread");
> 	if (IS_ERR(kt)) {
> 		pr_err("Failed to make test_thread\n");
> 		return PTR_ERR(kt);
> 	}
> 	sched_set_normal(kt, -20);
>
> 	return 0;
> }
>
> static void __exit test_thread_exit(void) {
> 	dont_stop = false;
> 	kthread_stop(kt);
> }
>
> module_init(test_thread_init);
> module_exit(test_thread_exit);
> MODULE_LICENSE("GPL");

Thanks for the functional test! This should quite accurately reproduce
the situation when the printing thread is unable to catch up to the
amount of incoming messages.

Some function to explicitly trigger the scheduler may be needed. Such as
adding cond_resched() outside the critical section, before repeating the
loop. We would like to remove such explicit preemption points from the
kernel code, but perhaps it is necessary for the VOLUNTARY preemption
scheme.

John
