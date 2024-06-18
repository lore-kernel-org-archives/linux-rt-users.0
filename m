Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122C15E5CA;
	Tue, 18 Jun 2024 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737025; cv=none; b=ZNgG0VaRPFcpYvaoK9w+Q6Hz6RKP49Jmm+JOMseA6++L4XS6p4WIBKh8/WJmCB+0OLcZH6ke2CESnpMZGDPDkQTTUus1muGn18G6Hy3NXhgCU+0S5cBISt73dtjY8lMZzdjV4+8b+pogman1jEQPastFblJ7NWv4Rib7scE6BDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737025; c=relaxed/simple;
	bh=xfSDyu97JueS0a9gLKLkYXG4Plr8J+murWmnStzkUrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ki7lN2Qrr6364MOuKz8zBX9/LUy5CWWggHrt2JyW0bxpQ7ZYXfY/M3KchP0lhOBgN+ov1vR/B0IOTZ2wXm88jv1VoXCRjUsNhIB/PrqRjSs+THvB+gWhTx8hh9kootPQtulCuPHyN9oNYQwFadltMnm4er/Imjwzfzbe6AL3JrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CABPPSSe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vrV0m/pk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CABPPSSe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vrV0m/pk"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718737021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KW1FZlJufvw9GbeqjoUcpDXZdjkkY+hrousdX2da4kY=;
	b=CABPPSSeAnuve3PoZ4tmzelTrmPomJLfBEl+r+5bUg7l2nXInhva9FnMNVQbvMl0H4Xpsn
	haIxLqtgSP4mjCqZOXUQkAjDSDRiOwMuUU+2XryH64F+GTTNU5OwsUJOEtWBe9YaSfa7Tr
	NV9dpxB/PIADGTi2Cb3J9AgduzNVDy91MkcgdaYVN0HBmZgM3RrjFpreKvP2CbpxKYYI44
	6jC7v96MYVwkhE9bMNMqtYKQNzGvXH+scLGxPsHz15ATkPoEaX54ffeeG0dX3d5Iip7yKR
	jzAPs1MTc0lp628xtkjmXJn3M1H34bVQ8qQ10dpwJ/f9sNNZjvq1U3/u0a2lUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718737021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KW1FZlJufvw9GbeqjoUcpDXZdjkkY+hrousdX2da4kY=;
	b=vrV0m/pkLdaEj8/zZF9i96CYG4ENPuCiJ6bqi1ZJs96tAnU4g555rKz7JeHGZvMB8qSvzM
	fM5PEoGgTuXFaCAQ==
To: Derek Barbosa <debarbos@redhat.com>, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: williams@redhat.com, jlelli@redhat.com, ahalaney@redhat.com,
 lgoncalv@redhat.com, jwyatt@redhat.com, aubaker@redhat.com
Subject: Re: [BUG] printk/nbcon.c: watchdog BUG: softlockup - CPU#x stuck
 for 78s
In-Reply-To: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
Date: Tue, 18 Jun 2024 21:03:00 +0206
Message-ID: <87msni13lv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Derek,

On 2024-06-18, Derek Barbosa <debarbos@redhat.com> wrote:
> The realtime team at Red Hat has recently backported the latest printk
> changes present in 6.6-rt stable (HEAD at 20fd4439f644 printk: nbcon:
> move locked_port flag to struct uart_port) to CentOS Stream 9 for
> performance improvements and printk-related bugfixes.
>
> Since merging this said code, we've hit an interesting bug during
> testing, specifically, on larger systems, a softlockup may be reported
> by the watchdog when there is a heavy amount of printing to tty
> devices (whether it be through printk, /dev/kmsg, etc).
>
> We have a modicum of reasonable suspicion to believe that
> nbcon_reacquire, or some other nbcon mechanism *may* be causing such
> behavior.
>
> Since we've succesfully reproduced this in the Kernel-ARK/Fedora-ELN
> (osbuild-rt), and linux-rt-devel 6.10.rc4-rt6, we are reporting this
> bug upstream.
>
> Anyway, here is a more in-depth description, along with some call traces.
>
> Description:
>
> On x86 systems with a large amount of logical cores (nproc ~> 60), a
> softlockup can be observed with accompanying call trace when a large
> amount of "printing" activity is taking place.
>
> As shown in the call traces appended below, during some kind of numa
> balancing/numa_migration after a task_numa_fault --where a set of
> processess are being migrated/swapped between two CPUs-- there is a
> busy thread that is being waited on (in the order of seconds), causing
> a livelock. Additional investigation of collected vmcores by toggling
> panic on softlockup shows that the waiting thread may be waiting for a
> thread looping with nbcon_reacquire.
>
> I suspect that some logic within nbcon_context_try_acquire may be a
> good place to start. My understanding of the code becomes a bit fuzzy
> here, so apologies in advance for any erroneous statements. As I see
> it, there may be something happening during migration (or under heavy
> load) in which nbcon_reacquire() is in a non-migratable or
> non-preemtible state as it is attempting to regain access to a
> lost/taken console. It could very well be a situation in which context
> was forcefully taken from the printing thread.
>
> Alternatively, Andrew Halaney <ahalaney@redhat.com> suspects that it
> is the loop within nbcon_kthread_func() -- since there is nothing that
> would yield the task in said loop (cant_migrate()), the migrate code
> would be essentially waiting forever for the aforementioned loop to
> "finish". I believe in PREEMPT_RT, there would be a preemption point
> here. Furthermore, in his investigation, there were signs that the
> loop was just iterating up until the crash, leaving reason to believe
> that task would be the culprit.
>
> In fact, with the following diff, we noticed this output:
>
> ```
> ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % git diff | cat
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index bb9689f94d30..d716b72bf2f8 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1075,6 +1075,7 @@ static int nbcon_kthread_func(void *__console)
>       *
>       * This pairs with rcuwait_has_sleeper:A and nbcon_kthread_wake:A.
>       */
> +    trace_printk("Before rcuwait_wait_event()\n");
>      ret = rcuwait_wait_event(&con->rcuwait,
>                   nbcon_kthread_should_wakeup(con, ctxt),
>                   TASK_INTERRUPTIBLE); /* LMM(nbcon_kthread_func:A) */
> @@ -1086,7 +1087,10 @@ static int nbcon_kthread_func(void *__console)
>      if (ret)
>          goto wait_for_event;
>
> +    trace_printk("Starting do while(backlog) loop \n");
> +    unsigned long int loop = 0;
>      do {
> +        trace_printk("On loop %lu\n", ++loop);
>          backlog = false;
>
>          cookie = console_srcu_read_lock();
> @@ -1121,6 +1125,7 @@ static int nbcon_kthread_func(void *__console)
>          console_srcu_read_unlock(cookie);
>
>      } while (backlog);
> +    trace_printk("End of while(backlog) loop, looped %lu times \n", loop);
>
>      goto wait_for_event;
> ```
>
> The output:
>
> ```
> [ 1681.309720] pr/ttyS0-18       21.N... 893365994us : nbcon_kthread_func: On loop 2117
> [ 1681.309727] pr/ttyS0-18       21.N... 893374418us : nbcon_kthread_func: On loop 2118
> [ 1681.309734] pr/ttyS0-18       21.N... 893382860us : nbcon_kthread_func: On loop 2119
> (...)
> [ 1681.396193] pr/ttyS0-18       21.N... 954571399us : nbcon_kthread_func: On loop 14025
> [ 1681.396200] pr/ttyS0-18       21.N... 954576525us : nbcon_kthread_func: On loop 14026
> [ 1681.396207] pr/ttyS0-18       21.N... 954581561us : nbcon_kthread_func: On loop 14027
> [ 1681.396213] pr/ttyS0-18       21.N... 954584954us : nbcon_kthread_func: On loop 14028
> [ 1681.396220] pr/ttyS0-18       21.N... 954590111us : nbcon_kthread_func: On loop 14029
> [ 1681.396223] ---------------------------------
> [ 1681.396230] Kernel panic - not syncing: softlockup: hung tasks
> (...)
> ```
>
> Demonstrating evidence that the nbcon kthread function is invoked
> continuously up until the point of panic. I do believe that this
> approach is more sound than my initial hints (or it could be more than
> a handful of threads). Some traces around
> serial8250_console_write_thread() also denote continuous calls without
> any holdups.
>
> As a sidenote, we are seeing the softlockup with !CONFIG_PREEMPT_RT

This trace shows that the thread is successfully printing
lines. So I doubt nbcon_reacquire() is involved here.

Assuming the ringbuffer is getting filled as fast or faster than the
thread can print, then we effectively have this:

DEFINE_STATIC_SRCU(test_srcu);
static DEFINE_SPINLOCK(test_lock);

static int kthread_func(void *arg)
{
	unsigned long flags;

	do {
		srcu_read_lock_nmisafe(&test_srcu);
		spin_lock_irqsave(&test_lock, flags);
		udelay(5000);  // print a line to serial
		spin_unlock_irqrestore(&test_lock, flags);
		srcu_read_unlock_nmisafe(&test_srcu);
	} while (true);

	return 0;
}

And since the thread has a nice value of -20, it will get a lot of CPU
time allocated to it. Is that a problem? Shouldn't the scheduler
eventually kick the task off the CPU after its timeslice is up?

> Some questions arise from this, as we've never encountered this in our
> testing with John Ogness' console_blast (kudos to <jwyatt@redhat.com>)
> and other printk torture tests that have been compiled
> [here](https://gitlab.com/debarbos/printktorture).

Yes, that is odd since those tests will ensure that the printing thread
never exits its printing loop because it will never catch up. So it
should be the same situation.

> We are curious to understand why is it that the printing thread is
> chosen by the NUMA balancer for migration/swap, and how that
> interaction is handled within the code (in other words, how else would
> nbcon handle a migrated printing thread?).

The nbcon console can only be owned when migration is disabled. In the
case of the printing thread for serial, this is under the
spin_lock_irqsave(). The NUMA balancer would only be able to migrate the
thread outside of the spin_lock critical section. And outside of the
spin_lock critical section, the thread does not own/hold any resources
at all. So it should be no problem to migrate it.

> Our next round of tests aim to disable numa balancing on
> large-multi-core-systems to determine whether it is the NUMA
> mechanisms + nbcon interactions are at fault here.

I am curious if starting a kthread using the code I wrote above (with
nice=-20) would cause similar issues.

> How to reproduce:

I am currently traveling, so my time/resources are limited. But next
week I will be able to look into this in detail. Thanks for this work!

John Ogness
