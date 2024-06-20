Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258F1AB8F0
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904441; cv=none; b=q1FHfF5qAfODMdHeEx9jCdFgQCLo4WdWcdF529nhO0WgBxALzXrTLCBBIKhk01HYtHqsyHgy7fSXbhwOMAXTHXC6iCIvHrKulSEE+akEeOyyxbQJMy67U9e4TiZeLOPBUEKrAcb3YE0Xz4OdjWg7VbZOITnAUpUkhpdyFWXfP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904441; c=relaxed/simple;
	bh=21Z2KoSY4xBNDnfqbWZnENwlbbY4zm00qHp8dh5UZJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdLW3Mb+dsfZCU/MmVpLrWWu+JE2kuOYzkdeQpiH77QEg57/ps+mVk7bu93ngJm/I7PwbFuGP1nMMQycOicS4ExPbK8cXZxPoNFLy9AneHhvd9E9cVJwvPQX+BtajssVrdlfwX2p0FjfBPSHMTdR8e1MLBTX0nVRIYE1q5m9Aro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NV+SjlI5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NV+SjlI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0k//qXc3WKzLba11jjH2L7NUDmBJVHz0KH+EMGhJYYM=;
	b=NV+SjlI5vFLWkk78T9qE1Ra/oDt2iAQdP1JxD7gpslaqch8pPuAGn+2+89MepJjbpS+trc
	12EK/AnF5wAfKz7DDv4OzNit4uJe+ARq3/fNNzEfGePuSS4DsK6pZOlxk0e+y4ZKr67fMN
	6vWQDBDjbk8lpEO2kAzVtx4JgvJzVYI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-BoKsN3sPNnSyrEpl_2DXXQ-1; Thu, 20 Jun 2024 13:27:16 -0400
X-MC-Unique: BoKsN3sPNnSyrEpl_2DXXQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6f9810627daso1302000a34.2
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2024 10:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718904436; x=1719509236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k//qXc3WKzLba11jjH2L7NUDmBJVHz0KH+EMGhJYYM=;
        b=TtVM3qlOupqb5jlvVhdh/Y9Uv3xBM9aP7TSaxE1L6D1QKXORoNZtVjODoSm9Fs/lzg
         LzkEhXIQBQp7TBCcpOOwjES7Rsxaaa2XoZJDaApE2LvnI9hpHESvNhHAaB4rDsR3JST8
         NcFn1xksvhFdyatpHLyItSYrXcjBhDs2pi+TpjLTl5zks00wuMhba8qJ2uVu0d+tvKZL
         egR+aScMol+4XI/k6FakDY0MzTghaem+mVeNI0XEVFruKEiqjkk8kV84jzsuHJ4hLJb5
         kzXL3YDiHind1XmFrBfLv+mCX4FQxVnPelRLGBvJT4eSBWS9VSSIk1WJQBZrHSpITcCB
         mW1g==
X-Forwarded-Encrypted: i=1; AJvYcCVqpaQrVF3YEStOH5Wdi4cFebP1VHX6BLdPMXWoWVpK6R3xhCPFAvTJneen79Mb3ufA1bdGjo3geeftH/eiYFwFVakkFvq1viy7EW9fPx0=
X-Gm-Message-State: AOJu0YxdmfK3LiLSkIUhPnDTGnuXkDUFhyUem7NuiPT1pNufhHiuJVAu
	mfXGkwc95gRfn94DQ4/ItIQbz43bWyOpQH/Xkl3p4Y9D4qWvsVLyfrQ8CKeiF/HzpO6Zr+YEXfn
	jw6sEZeqJ7yE0mvmWvtjFuTHLVIuYSTbYsNxxBRppgbKYyOzYzhUsTTNybSdp5J5Y
X-Received: by 2002:a9d:7f91:0:b0:6fd:5875:5c87 with SMTP id 46e09a7af769-700776c3a7bmr6406441a34.36.1718904435506;
        Thu, 20 Jun 2024 10:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi6RpORxFfYuissfKgzZ7acsH/4bISUB8Kn89g72eJZyt0ZCQmvv35tSwJt/0Mgnd5BRxyXg==
X-Received: by 2002:a9d:7f91:0:b0:6fd:5875:5c87 with SMTP id 46e09a7af769-700776c3a7bmr6406415a34.36.1718904434998;
        Thu, 20 Jun 2024 10:27:14 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee8bc0sm90981666d6.121.2024.06.20.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:27:14 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:27:12 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Derek Barbosa <debarbos@redhat.com>, rostedt@goodmis.org, senozhatsky@chromium.org, 
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, williams@redhat.com, 
	jlelli@redhat.com, lgoncalv@redhat.com, jwyatt@redhat.com, aubaker@redhat.com
Subject: Re: [BUG] printk/nbcon.c: watchdog BUG: softlockup - CPU#x stuck for
 78s
Message-ID: <xt5rhuygy2wwugsbdxemfrlkfcj6czfsmdkkjlqpmf4lcvc4pk@o6j6errohzfs>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <87msni13lv.fsf@jogness.linutronix.de>
 <dtde47mfm3amxg4mbrnbct53ehpfbekdvrjhhd6j5tzl7lulwj@zwdsvkq3orag>
 <ZnKo_n9LJnMCPSCA@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKo_n9LJnMCPSCA@pathway.suse.cz>

On Wed, Jun 19, 2024 at 11:46:38AM GMT, Petr Mladek wrote:
> On Tue 2024-06-18 17:52:19, Andrew Halaney wrote:
> > On Tue, Jun 18, 2024 at 09:03:00PM GMT, John Ogness wrote:
> > > Hi Derek,
> > > 
> > > On 2024-06-18, Derek Barbosa <debarbos@redhat.com> wrote:
> > > > The realtime team at Red Hat has recently backported the latest printk
> > > > changes present in 6.6-rt stable (HEAD at 20fd4439f644 printk: nbcon:
> > > > move locked_port flag to struct uart_port) to CentOS Stream 9 for
> > > > performance improvements and printk-related bugfixes.
> > > >
> > > > Since merging this said code, we've hit an interesting bug during
> > > > testing, specifically, on larger systems, a softlockup may be reported
> > > > by the watchdog when there is a heavy amount of printing to tty
> > > > devices (whether it be through printk, /dev/kmsg, etc).
> > > >
> > > > We have a modicum of reasonable suspicion to believe that
> > > > nbcon_reacquire, or some other nbcon mechanism *may* be causing such
> > > > behavior.
> > > >
> > > > Since we've succesfully reproduced this in the Kernel-ARK/Fedora-ELN
> > > > (osbuild-rt), and linux-rt-devel 6.10.rc4-rt6, we are reporting this
> > > > bug upstream.
> > > >
> > > > Anyway, here is a more in-depth description, along with some call traces.
> > > >
> > > > Description:
> > > >
> > > > On x86 systems with a large amount of logical cores (nproc ~> 60), a
> > > > softlockup can be observed with accompanying call trace when a large
> > > > amount of "printing" activity is taking place.
> > > >
> > > > As shown in the call traces appended below, during some kind of numa
> > > > balancing/numa_migration after a task_numa_fault --where a set of
> > > > processess are being migrated/swapped between two CPUs-- there is a
> > > > busy thread that is being waited on (in the order of seconds), causing
> > > > a livelock. Additional investigation of collected vmcores by toggling
> > > > panic on softlockup shows that the waiting thread may be waiting for a
> > > > thread looping with nbcon_reacquire.
> > > >
> > > > I suspect that some logic within nbcon_context_try_acquire may be a
> > > > good place to start. My understanding of the code becomes a bit fuzzy
> > > > here, so apologies in advance for any erroneous statements. As I see
> > > > it, there may be something happening during migration (or under heavy
> > > > load) in which nbcon_reacquire() is in a non-migratable or
> > > > non-preemtible state as it is attempting to regain access to a
> > > > lost/taken console. It could very well be a situation in which context
> > > > was forcefully taken from the printing thread.
> > > >
> > > > Alternatively, Andrew Halaney <ahalaney@redhat.com> suspects that it
> > > > is the loop within nbcon_kthread_func() -- since there is nothing that
> > > > would yield the task in said loop (cant_migrate()), the migrate code
> > > > would be essentially waiting forever for the aforementioned loop to
> > > > "finish". I believe in PREEMPT_RT, there would be a preemption point
> > > > here. Furthermore, in his investigation, there were signs that the
> > > > loop was just iterating up until the crash, leaving reason to believe
> > > > that task would be the culprit.
> > > >
> > > > In fact, with the following diff, we noticed this output:
> > > >
> > > > ```
> > > > ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % git diff | cat
> > > > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > > > index bb9689f94d30..d716b72bf2f8 100644
> > > > --- a/kernel/printk/nbcon.c
> > > > +++ b/kernel/printk/nbcon.c
> > > > @@ -1075,6 +1075,7 @@ static int nbcon_kthread_func(void *__console)
> > > >       *
> > > >       * This pairs with rcuwait_has_sleeper:A and nbcon_kthread_wake:A.
> > > >       */
> > > > +    trace_printk("Before rcuwait_wait_event()\n");
> > > >      ret = rcuwait_wait_event(&con->rcuwait,
> > > >                   nbcon_kthread_should_wakeup(con, ctxt),
> > > >                   TASK_INTERRUPTIBLE); /* LMM(nbcon_kthread_func:A) */
> > > > @@ -1086,7 +1087,10 @@ static int nbcon_kthread_func(void *__console)
> > > >      if (ret)
> > > >          goto wait_for_event;
> > > >
> > > > +    trace_printk("Starting do while(backlog) loop \n");
> > > > +    unsigned long int loop = 0;
> > > >      do {
> > > > +        trace_printk("On loop %lu\n", ++loop);
> > > >          backlog = false;
> > > >
> > > >          cookie = console_srcu_read_lock();
> > > > @@ -1121,6 +1125,7 @@ static int nbcon_kthread_func(void *__console)
> > > >          console_srcu_read_unlock(cookie);
> > > >
> > > >      } while (backlog);
> > > > +    trace_printk("End of while(backlog) loop, looped %lu times \n", loop);
> > > >
> > > >      goto wait_for_event;
> > > > ```
> > > >
> > > > The output:
> > > >
> > > > ```
> > > > [ 1681.309720] pr/ttyS0-18       21.N... 893365994us : nbcon_kthread_func: On loop 2117
> > > > [ 1681.309727] pr/ttyS0-18       21.N... 893374418us : nbcon_kthread_func: On loop 2118
> > > > [ 1681.309734] pr/ttyS0-18       21.N... 893382860us : nbcon_kthread_func: On loop 2119
> > > > (...)
> > > > [ 1681.396193] pr/ttyS0-18       21.N... 954571399us : nbcon_kthread_func: On loop 14025
> > > > [ 1681.396200] pr/ttyS0-18       21.N... 954576525us : nbcon_kthread_func: On loop 14026
> > > > [ 1681.396207] pr/ttyS0-18       21.N... 954581561us : nbcon_kthread_func: On loop 14027
> > > > [ 1681.396213] pr/ttyS0-18       21.N... 954584954us : nbcon_kthread_func: On loop 14028
> > > > [ 1681.396220] pr/ttyS0-18       21.N... 954590111us : nbcon_kthread_func: On loop 14029
> > > > [ 1681.396223] ---------------------------------
> > > > [ 1681.396230] Kernel panic - not syncing: softlockup: hung tasks
> > > > (...)
> > > > ```
> > > >
> > > > Demonstrating evidence that the nbcon kthread function is invoked
> > > > continuously up until the point of panic. I do believe that this
> > > > approach is more sound than my initial hints (or it could be more than
> > > > a handful of threads). Some traces around
> > > > serial8250_console_write_thread() also denote continuous calls without
> > > > any holdups.
> > > >
> > > > As a sidenote, we are seeing the softlockup with !CONFIG_PREEMPT_RT
> > > 
> > > This trace shows that the thread is successfully printing
> > > lines. So I doubt nbcon_reacquire() is involved here.
> > > 
> > > Assuming the ringbuffer is getting filled as fast or faster than the
> > > thread can print, then we effectively have this:
> > > 
> > > DEFINE_STATIC_SRCU(test_srcu);
> > > static DEFINE_SPINLOCK(test_lock);
> > > 
> > > static int kthread_func(void *arg)
> > > {
> > > 	unsigned long flags;
> > > 
> > > 	do {
> > > 		srcu_read_lock_nmisafe(&test_srcu);
> > > 		spin_lock_irqsave(&test_lock, flags);
> > > 		udelay(5000);  // print a line to serial
> > > 		spin_unlock_irqrestore(&test_lock, flags);
> > > 		srcu_read_unlock_nmisafe(&test_srcu);
> > > 	} while (true);
> > > 
> > > 	return 0;
> > > }
> > > 
> > > And since the thread has a nice value of -20, it will get a lot of CPU
> > > time allocated to it. Is that a problem? Shouldn't the scheduler
> > > eventually kick the task off the CPU after its timeslice is up?
> > 
> > I trust you better than myself about this, but this is being reproduced
> > with a CONFIG_PREEMPT_DYNAMIC=y + CONFIG_PREEMPT_VOLUNTARY=y setup (so
> > essentially the current mode is VOLUNTARY). Does that actually work that
> > way for a kthread in that mode? I've been trying to reason with myself
> > on when the scheduler actually will get involved and stop the above
> > kthread_func() to run something else.
> > 
> > > 
> > > > Some questions arise from this, as we've never encountered this in our
> > > > testing with John Ogness' console_blast (kudos to <jwyatt@redhat.com>)
> > > > and other printk torture tests that have been compiled
> > > > [here](https://gitlab.com/debarbos/printktorture).
> > > 
> > > Yes, that is odd since those tests will ensure that the printing thread
> > > never exits its printing loop because it will never catch up. So it
> > > should be the same situation.
> > > 
> > > > We are curious to understand why is it that the printing thread is
> > > > chosen by the NUMA balancer for migration/swap, and how that
> > > > interaction is handled within the code (in other words, how else would
> > > > nbcon handle a migrated printing thread?).
> > > 
> > > The nbcon console can only be owned when migration is disabled. In the
> > > case of the printing thread for serial, this is under the
> > > spin_lock_irqsave(). The NUMA balancer would only be able to migrate the
> > > thread outside of the spin_lock critical section. And outside of the
> > > spin_lock critical section, the thread does not own/hold any resources
> > > at all. So it should be no problem to migrate it.
> > > 
> > > > Our next round of tests aim to disable numa balancing on
> > > > large-multi-core-systems to determine whether it is the NUMA
> > > > mechanisms + nbcon interactions are at fault here.
> > > 
> > > I am curious if starting a kthread using the code I wrote above (with
> > > nice=-20) would cause similar issues.
> > >
> > 
> > Just in case I did something dumb, here's the module I wrote up:
> > 
> > ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % cat kernel/printk/test_thread.c                         :(
> > /*
> >  * Test making a kthread similar to nbcon's (under load)
> >  * to see if it also has issues with migrate_swap()
> >  */
> > #include "linux/nmi.h"
> > #include <asm-generic/delay.h>
> > #include <linux/kthread.h>
> > #include <linux/module.h>
> > #include <linux/sched.h>
> > 
> > DEFINE_STATIC_SRCU(test_srcu);
> > static DEFINE_SPINLOCK(test_lock);
> > static struct task_struct *kt;
> > static bool dont_stop = true;
> > 
> > static int test_thread_func(void *unused) {
> > 	unsigned long flags;
> > 
> > 	pr_info("Starting the while true loop\n");
> > 	do {
> > 		int cookie = srcu_read_lock_nmisafe(&test_srcu);
> > 		spin_lock_irqsave(&test_lock, flags);
> > 		touch_nmi_watchdog();
> > 		udelay(5000);  // print a line to serial
> > 		spin_unlock_irqrestore(&test_lock, flags);
> > 		srcu_read_unlock_nmisafe(&test_srcu, cookie);
> 
> Does it help to add here?
> 
> 		cond_resched();
> 
> > 	} while (dont_stop);
> > 
> > 	return 0;
> > }
> > 
> > static int __init test_thread_init(void) {
> > 
> > 	pr_info("Creating test_thread at -20 nice level\n");
> > 	kt = kthread_run(test_thread_func, NULL, "test_thread");
> > 	if (IS_ERR(kt)) {
> > 		pr_err("Failed to make test_thread\n");
> > 		return PTR_ERR(kt);
> > 	}
> > 	sched_set_normal(kt, -20);
> > 
> > 	return 0;
> > }
> > 
> > static void __exit test_thread_exit(void) {
> > 	dont_stop = false;
> > 	kthread_stop(kt);
> > }
> > 
> > module_init(test_thread_init);
> > module_exit(test_thread_exit);
> > MODULE_LICENSE("GPL");
> > ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] %
> > 
> > That shows a softlockup quite quickly on the CPU that thread is
> > running on (as opposed to what Derek reports, where migrate_swap() is
> > going on and the softlockup reports on the other CPU in the swapping of
> > tasks). I guess that's because of the touch_nmi_watchdog() happening
> > in serial8250_console_write_thread().
> > 
> > The below is without the touch_nmi_watchdog() in the above snippet
> > (just to show what happens as written in your reply).
> > 
> >     [   72.018480] Creating test_thread at -20 nice level
> >     [   72.018632] Starting the while true loop
> >     [   99.673116] watchdog: BUG: soft lockup - CPU#53 stuck for 26s! [test_thread:2628]
> >     [   99.673119] Modules linked in: test_thread rfkill intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel mei_me ipmi_si kvm mei acpi_power_meter i2c_i801 mgag200 iTCO_wdt rapl acpi_ipmi i2c_algo_bit iTCO_vendor_support mxm_wmi pcspkr i2c_smbus joydev lpc_ich ioatdma intel_cstate intel_uncore ipmi_devintf ipmi_msghandler acpi_pad fuse xfs sd_mod t10_pi sg ahci crct10dif_pclmul libahci crc32_pclmul ixgbe crc32c_intel libata megaraid_sas ghash_clmulni_intel mdio dca wmi dm_mirror dm_region_hash dm_log dm_mod
> >     [   99.673159] CPU: 53 PID: 2628 Comm: test_thread Kdump: loaded Not tainted 6.10.0-rc4-rt6+ #7
> >     [   99.673162] Hardware name: Intel Corporation S2600CWR/S2600CWR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
> >     [   99.673163] RIP: 0010:_raw_spin_unlock_irqrestore+0x1f/0x40
> 
> This is the point where the interrupts were enabled. It allowed to
> handle pending timers, including watchdog_timer_fn().
> It printed this softlockup report.
> 
> It means that test_thread() never scheduled in the do while() loop.
> 
> I believe that the cond_resched() would cure the problem.
> 
> 
> >     [   99.673179] Code: 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 c6 07 00 0f 1f 00 f7 c6 00 02 00 00 74 01 fb 65 ff 0d 09 17 9c 4a <74> 06 c3 cc cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc cc 66 66 66
> >     [   99.673180] RSP: 0018:ffffb10887dafed0 EFLAGS: 00000246
> >     [   99.673182] RAX: 00000000e3ddc104 RBX: 0000000000000000 RCX: 0000000000001035
> >     [   99.673183] RDX: 0000000000af11a8 RSI: 0000000000000286 RDI: ffffffffc0e1b700
> >     [   99.673184] RBP: ffffb1088a4c77b0 R08: 0000000000000035 R09: 0000000000000035
> >     [   99.673185] R10: 0000000000017ffd R11: ffffffffb5649760 R12: ffff8b5f0caa4f00
> >     [   99.673186] R13: ffff8b4f87c04e80 R14: 0000000000000286 R15: ffff8b5f200e3380
> >     [   99.673187] FS:  0000000000000000(0000) GS:ffff8b6ebf880000(0000) knlGS:0000000000000000
> >     [   99.673189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     [   99.673190] CR2: 000055a7bd4f3b68 CR3: 0000001f35820003 CR4: 00000000001706f0
> >     [   99.673191] Call Trace:
> >     [   99.673192]  <IRQ>
> >     [   99.673193]  ? watchdog_timer_fn+0x21f/0x2a0
> >     [   99.673197]  ? __pfx_watchdog_timer_fn+0x10/0x10
> >     [   99.673198]  ? __hrtimer_run_queues+0xfa/0x270
> >     [   99.673202]  ? hrtimer_interrupt+0xf4/0x390
> >     [   99.673205]  ? __sysvec_apic_timer_interrupt+0x52/0x160
> >     [   99.673208]  ? sysvec_apic_timer_interrupt+0x6f/0x80
> >     [   99.673210]  </IRQ>
> >     [   99.673211]  <TASK>
> >     [   99.673212]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> >     [   99.673215]  ? __pfx_delay_tsc+0x10/0x10
> >     [   99.673221]  ? _raw_spin_unlock_irqrestore+0x1f/0x40
> >     [   99.673222]  test_thread_func+0x5e/0xff0 [test_thread]
> >     [   99.673225]  ? __pfx_test_thread_func+0x10/0x10 [test_thread]
> >     [   99.673226]  kthread+0xec/0x110
> >     [   99.673230]  ? __pfx_kthread+0x10/0x10
> >     [   99.673232]  ret_from_fork+0x3a/0x50
> >     [   99.673235]  ? __pfx_kthread+0x10/0x10
> >     [   99.673237]  ret_from_fork_asm+0x1a/0x30
> >     [   99.673239]  </TASK>
> > 
> > 
> > If you mimic that touch_nmi_watchdog() above the udelay() in the function above,
> 
> The touch_nmi_watchdog() caused that watchdog_timer_fn() did not see
> that "test_thread" kthread did not schedule. By other words, it did
> hide the problem.
> 

Is it reasonable to consider removing the touch_nmi_watchdog()'s in
8250_port.c? There's some rather old ones, and some new ones with the
nbcon transition, and they sort of made finding this issue more
indirect.

Could be some valid reason they exist still, but to me it seems sensible
to remove if we can't think of any good reasons.

Thanks,
Andrew

