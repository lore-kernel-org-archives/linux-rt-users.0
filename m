Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835C1514E9
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Jun 2024 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718751147; cv=none; b=n0m7srZy/Ox7h6SiXlkZJZLudQy+seduzFnlO+twCL7qPBonkYV7FevdMAMir/nsLHjjv51qbMV19p0KKNSxlb6oQveR3uq+eIwors7HF5fYLJNZXVTKM1dCtC3o31hbsY6aIEUjxoEz9CRnAVnjOFGNAF3DRU8uYjSiFiSch+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718751147; c=relaxed/simple;
	bh=e2pvSkCKsMUoMhsH1uDg/+WoPiovslM5kGL2aLX3HNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyLpq2sB+d6A9njMuGQPcJ9RzQ/LZgFYG+hjwJhsjgCMShepE9IzqnKm7yrulYP96jmSrfyZPvcCGCp1Ae+ahvBjkTdqM7d3IJhcOf0m1lS3TFJqympAd4gxjhwuKRwAd+piJiPR31B4Ic+hfsnVuSredqlOCTyqoblB9w+Pp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZ9Ans++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZ9Ans++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718751144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6PYRDHAEOrsEQYqt4ALM5DfeZsOT84H07asKMje9Rlk=;
	b=TZ9Ans++n3MHlTUH7Xm1k4LVbGZZYYgeIDNt2HuN8oC2oDEcfHiLxEe3G8A7Ck7n8vEWdi
	NgWmdWp1JX9MzeE0hHMsfwCO9FHnZQGP926tnlyG65iiSYuiP1qh+FAUhjfRhL9dj7LhGz
	ICDEravwjt4ZUBIeeZFvD0AongDUQdM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-VpUyhLA9NhmQ7sU8gM7ufw-1; Tue, 18 Jun 2024 18:52:22 -0400
X-MC-Unique: VpUyhLA9NhmQ7sU8gM7ufw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-797f788afa8so56429385a.0
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Jun 2024 15:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718751142; x=1719355942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PYRDHAEOrsEQYqt4ALM5DfeZsOT84H07asKMje9Rlk=;
        b=drPktYmz3ZbClgFSZz2UQycR6pNHAFSTrDzuSu67l+B5T18QgzXdPGKhwRN0TO4ghv
         MD/cDiPnLF5ElGUYH6chZGG/sum0msyz1+CJ3FuEiga9qshclez1OR1e2wBSEEDdcPPJ
         4ExWSpaKKX3saCV9JUhaqovAPJsxD2dr3VntabxyIp86XZENrGvfQUnqFEcWpjr3Y7cA
         /sWYoc5//qWWAB9lsVGIjnMX6gnD/JICmLT5QApjVdc3ygv8+6bFKcnyUFJ8qmJY3Ixh
         SDprrUvrV5EjzHzPNsvibPUubdDxVTLTEAz56sqhd54MFhQyfFLSkzv5LHhjH2lA1qt4
         qGdw==
X-Forwarded-Encrypted: i=1; AJvYcCWpr471+gyAjoIs0AAQtZltMFKnSlyfmauDvQlFUDQ86/aQeQAJhkftYHo7hXF4D63/J3DADgyGmHSS4+AE2zOl2knF+3YfUpyg5gGdBhI=
X-Gm-Message-State: AOJu0YwybfKj7KYwU6C9b1cRLE3x33grVP6Hc6q6mA3pm1A0ZwFFjXpo
	Tug2g/gyIbmdaN3qeAfe5rCnMVhNDGH9UtwhefDuuQ6KfMQR5V4g5bJsDvuk9ktVp2hPC52sRnr
	uUwgGPjUburCkb1Kppoblsg9eR8JdE8sT2pzTwDfRMSvRP5QstSu74NV5HU67ehl3
X-Received: by 2002:a05:620a:444d:b0:794:eb81:32c4 with SMTP id af79cd13be357-79ba76cc979mr750322385a.10.1718751142070;
        Tue, 18 Jun 2024 15:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGs8zP+3/nlcr37k2pnt8WwRoZ+C9itpNTkcNF6ZrMfz1XZC7a2iYOjqBzyRZYnosJbU47Qg==
X-Received: by 2002:a05:620a:444d:b0:794:eb81:32c4 with SMTP id af79cd13be357-79ba76cc979mr750319385a.10.1718751141577;
        Tue, 18 Jun 2024 15:52:21 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798d9dd524bsm468494285a.66.2024.06.18.15.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 15:52:21 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:52:19 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Derek Barbosa <debarbos@redhat.com>, pmladek@suse.com, 
	rostedt@goodmis.org, senozhatsky@chromium.org, linux-rt-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, williams@redhat.com, jlelli@redhat.com, lgoncalv@redhat.com, 
	jwyatt@redhat.com, aubaker@redhat.com
Subject: Re: [BUG] printk/nbcon.c: watchdog BUG: softlockup - CPU#x stuck for
 78s
Message-ID: <dtde47mfm3amxg4mbrnbct53ehpfbekdvrjhhd6j5tzl7lulwj@zwdsvkq3orag>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <87msni13lv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msni13lv.fsf@jogness.linutronix.de>

On Tue, Jun 18, 2024 at 09:03:00PM GMT, John Ogness wrote:
> Hi Derek,
> 
> On 2024-06-18, Derek Barbosa <debarbos@redhat.com> wrote:
> > The realtime team at Red Hat has recently backported the latest printk
> > changes present in 6.6-rt stable (HEAD at 20fd4439f644 printk: nbcon:
> > move locked_port flag to struct uart_port) to CentOS Stream 9 for
> > performance improvements and printk-related bugfixes.
> >
> > Since merging this said code, we've hit an interesting bug during
> > testing, specifically, on larger systems, a softlockup may be reported
> > by the watchdog when there is a heavy amount of printing to tty
> > devices (whether it be through printk, /dev/kmsg, etc).
> >
> > We have a modicum of reasonable suspicion to believe that
> > nbcon_reacquire, or some other nbcon mechanism *may* be causing such
> > behavior.
> >
> > Since we've succesfully reproduced this in the Kernel-ARK/Fedora-ELN
> > (osbuild-rt), and linux-rt-devel 6.10.rc4-rt6, we are reporting this
> > bug upstream.
> >
> > Anyway, here is a more in-depth description, along with some call traces.
> >
> > Description:
> >
> > On x86 systems with a large amount of logical cores (nproc ~> 60), a
> > softlockup can be observed with accompanying call trace when a large
> > amount of "printing" activity is taking place.
> >
> > As shown in the call traces appended below, during some kind of numa
> > balancing/numa_migration after a task_numa_fault --where a set of
> > processess are being migrated/swapped between two CPUs-- there is a
> > busy thread that is being waited on (in the order of seconds), causing
> > a livelock. Additional investigation of collected vmcores by toggling
> > panic on softlockup shows that the waiting thread may be waiting for a
> > thread looping with nbcon_reacquire.
> >
> > I suspect that some logic within nbcon_context_try_acquire may be a
> > good place to start. My understanding of the code becomes a bit fuzzy
> > here, so apologies in advance for any erroneous statements. As I see
> > it, there may be something happening during migration (or under heavy
> > load) in which nbcon_reacquire() is in a non-migratable or
> > non-preemtible state as it is attempting to regain access to a
> > lost/taken console. It could very well be a situation in which context
> > was forcefully taken from the printing thread.
> >
> > Alternatively, Andrew Halaney <ahalaney@redhat.com> suspects that it
> > is the loop within nbcon_kthread_func() -- since there is nothing that
> > would yield the task in said loop (cant_migrate()), the migrate code
> > would be essentially waiting forever for the aforementioned loop to
> > "finish". I believe in PREEMPT_RT, there would be a preemption point
> > here. Furthermore, in his investigation, there were signs that the
> > loop was just iterating up until the crash, leaving reason to believe
> > that task would be the culprit.
> >
> > In fact, with the following diff, we noticed this output:
> >
> > ```
> > ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % git diff | cat
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index bb9689f94d30..d716b72bf2f8 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -1075,6 +1075,7 @@ static int nbcon_kthread_func(void *__console)
> >       *
> >       * This pairs with rcuwait_has_sleeper:A and nbcon_kthread_wake:A.
> >       */
> > +    trace_printk("Before rcuwait_wait_event()\n");
> >      ret = rcuwait_wait_event(&con->rcuwait,
> >                   nbcon_kthread_should_wakeup(con, ctxt),
> >                   TASK_INTERRUPTIBLE); /* LMM(nbcon_kthread_func:A) */
> > @@ -1086,7 +1087,10 @@ static int nbcon_kthread_func(void *__console)
> >      if (ret)
> >          goto wait_for_event;
> >
> > +    trace_printk("Starting do while(backlog) loop \n");
> > +    unsigned long int loop = 0;
> >      do {
> > +        trace_printk("On loop %lu\n", ++loop);
> >          backlog = false;
> >
> >          cookie = console_srcu_read_lock();
> > @@ -1121,6 +1125,7 @@ static int nbcon_kthread_func(void *__console)
> >          console_srcu_read_unlock(cookie);
> >
> >      } while (backlog);
> > +    trace_printk("End of while(backlog) loop, looped %lu times \n", loop);
> >
> >      goto wait_for_event;
> > ```
> >
> > The output:
> >
> > ```
> > [ 1681.309720] pr/ttyS0-18       21.N... 893365994us : nbcon_kthread_func: On loop 2117
> > [ 1681.309727] pr/ttyS0-18       21.N... 893374418us : nbcon_kthread_func: On loop 2118
> > [ 1681.309734] pr/ttyS0-18       21.N... 893382860us : nbcon_kthread_func: On loop 2119
> > (...)
> > [ 1681.396193] pr/ttyS0-18       21.N... 954571399us : nbcon_kthread_func: On loop 14025
> > [ 1681.396200] pr/ttyS0-18       21.N... 954576525us : nbcon_kthread_func: On loop 14026
> > [ 1681.396207] pr/ttyS0-18       21.N... 954581561us : nbcon_kthread_func: On loop 14027
> > [ 1681.396213] pr/ttyS0-18       21.N... 954584954us : nbcon_kthread_func: On loop 14028
> > [ 1681.396220] pr/ttyS0-18       21.N... 954590111us : nbcon_kthread_func: On loop 14029
> > [ 1681.396223] ---------------------------------
> > [ 1681.396230] Kernel panic - not syncing: softlockup: hung tasks
> > (...)
> > ```
> >
> > Demonstrating evidence that the nbcon kthread function is invoked
> > continuously up until the point of panic. I do believe that this
> > approach is more sound than my initial hints (or it could be more than
> > a handful of threads). Some traces around
> > serial8250_console_write_thread() also denote continuous calls without
> > any holdups.
> >
> > As a sidenote, we are seeing the softlockup with !CONFIG_PREEMPT_RT
> 
> This trace shows that the thread is successfully printing
> lines. So I doubt nbcon_reacquire() is involved here.
> 
> Assuming the ringbuffer is getting filled as fast or faster than the
> thread can print, then we effectively have this:
> 
> DEFINE_STATIC_SRCU(test_srcu);
> static DEFINE_SPINLOCK(test_lock);
> 
> static int kthread_func(void *arg)
> {
> 	unsigned long flags;
> 
> 	do {
> 		srcu_read_lock_nmisafe(&test_srcu);
> 		spin_lock_irqsave(&test_lock, flags);
> 		udelay(5000);  // print a line to serial
> 		spin_unlock_irqrestore(&test_lock, flags);
> 		srcu_read_unlock_nmisafe(&test_srcu);
> 	} while (true);
> 
> 	return 0;
> }
> 
> And since the thread has a nice value of -20, it will get a lot of CPU
> time allocated to it. Is that a problem? Shouldn't the scheduler
> eventually kick the task off the CPU after its timeslice is up?

I trust you better than myself about this, but this is being reproduced
with a CONFIG_PREEMPT_DYNAMIC=y + CONFIG_PREEMPT_VOLUNTARY=y setup (so
essentially the current mode is VOLUNTARY). Does that actually work that
way for a kthread in that mode? I've been trying to reason with myself
on when the scheduler actually will get involved and stop the above
kthread_func() to run something else.

> 
> > Some questions arise from this, as we've never encountered this in our
> > testing with John Ogness' console_blast (kudos to <jwyatt@redhat.com>)
> > and other printk torture tests that have been compiled
> > [here](https://gitlab.com/debarbos/printktorture).
> 
> Yes, that is odd since those tests will ensure that the printing thread
> never exits its printing loop because it will never catch up. So it
> should be the same situation.
> 
> > We are curious to understand why is it that the printing thread is
> > chosen by the NUMA balancer for migration/swap, and how that
> > interaction is handled within the code (in other words, how else would
> > nbcon handle a migrated printing thread?).
> 
> The nbcon console can only be owned when migration is disabled. In the
> case of the printing thread for serial, this is under the
> spin_lock_irqsave(). The NUMA balancer would only be able to migrate the
> thread outside of the spin_lock critical section. And outside of the
> spin_lock critical section, the thread does not own/hold any resources
> at all. So it should be no problem to migrate it.
> 
> > Our next round of tests aim to disable numa balancing on
> > large-multi-core-systems to determine whether it is the NUMA
> > mechanisms + nbcon interactions are at fault here.
> 
> I am curious if starting a kthread using the code I wrote above (with
> nice=-20) would cause similar issues.
>

Just in case I did something dumb, here's the module I wrote up:

ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % cat kernel/printk/test_thread.c                         :(
/*
 * Test making a kthread similar to nbcon's (under load)
 * to see if it also has issues with migrate_swap()
 */
#include "linux/nmi.h"
#include <asm-generic/delay.h>
#include <linux/kthread.h>
#include <linux/module.h>
#include <linux/sched.h>

DEFINE_STATIC_SRCU(test_srcu);
static DEFINE_SPINLOCK(test_lock);
static struct task_struct *kt;
static bool dont_stop = true;

static int test_thread_func(void *unused) {
	unsigned long flags;

	pr_info("Starting the while true loop\n");
	do {
		int cookie = srcu_read_lock_nmisafe(&test_srcu);
		spin_lock_irqsave(&test_lock, flags);
		touch_nmi_watchdog();
		udelay(5000);  // print a line to serial
		spin_unlock_irqrestore(&test_lock, flags);
		srcu_read_unlock_nmisafe(&test_srcu, cookie);
	} while (dont_stop);

	return 0;
}

static int __init test_thread_init(void) {

	pr_info("Creating test_thread at -20 nice level\n");
	kt = kthread_run(test_thread_func, NULL, "test_thread");
	if (IS_ERR(kt)) {
		pr_err("Failed to make test_thread\n");
		return PTR_ERR(kt);
	}
	sched_set_normal(kt, -20);

	return 0;
}

static void __exit test_thread_exit(void) {
	dont_stop = false;
	kthread_stop(kt);
}

module_init(test_thread_init);
module_exit(test_thread_exit);
MODULE_LICENSE("GPL");
ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] %

That shows a softlockup quite quickly on the CPU that thread is
running on (as opposed to what Derek reports, where migrate_swap() is
going on and the softlockup reports on the other CPU in the swapping of
tasks). I guess that's because of the touch_nmi_watchdog() happening
in serial8250_console_write_thread().

The below is without the touch_nmi_watchdog() in the above snippet
(just to show what happens as written in your reply).

    [   72.018480] Creating test_thread at -20 nice level
    [   72.018632] Starting the while true loop
    [   99.673116] watchdog: BUG: soft lockup - CPU#53 stuck for 26s! [test_thread:2628]
    [   99.673119] Modules linked in: test_thread rfkill intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel mei_me ipmi_si kvm mei acpi_power_meter i2c_i801 mgag200 iTCO_wdt rapl acpi_ipmi i2c_algo_bit iTCO_vendor_support mxm_wmi pcspkr i2c_smbus joydev lpc_ich ioatdma intel_cstate intel_uncore ipmi_devintf ipmi_msghandler acpi_pad fuse xfs sd_mod t10_pi sg ahci crct10dif_pclmul libahci crc32_pclmul ixgbe crc32c_intel libata megaraid_sas ghash_clmulni_intel mdio dca wmi dm_mirror dm_region_hash dm_log dm_mod
    [   99.673159] CPU: 53 PID: 2628 Comm: test_thread Kdump: loaded Not tainted 6.10.0-rc4-rt6+ #7
    [   99.673162] Hardware name: Intel Corporation S2600CWR/S2600CWR, BIOS SE5C610.86B.01.01.0018.072020161249 07/20/2016
    [   99.673163] RIP: 0010:_raw_spin_unlock_irqrestore+0x1f/0x40
    [   99.673179] Code: 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 c6 07 00 0f 1f 00 f7 c6 00 02 00 00 74 01 fb 65 ff 0d 09 17 9c 4a <74> 06 c3 cc cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc cc 66 66 66
    [   99.673180] RSP: 0018:ffffb10887dafed0 EFLAGS: 00000246
    [   99.673182] RAX: 00000000e3ddc104 RBX: 0000000000000000 RCX: 0000000000001035
    [   99.673183] RDX: 0000000000af11a8 RSI: 0000000000000286 RDI: ffffffffc0e1b700
    [   99.673184] RBP: ffffb1088a4c77b0 R08: 0000000000000035 R09: 0000000000000035
    [   99.673185] R10: 0000000000017ffd R11: ffffffffb5649760 R12: ffff8b5f0caa4f00
    [   99.673186] R13: ffff8b4f87c04e80 R14: 0000000000000286 R15: ffff8b5f200e3380
    [   99.673187] FS:  0000000000000000(0000) GS:ffff8b6ebf880000(0000) knlGS:0000000000000000
    [   99.673189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   99.673190] CR2: 000055a7bd4f3b68 CR3: 0000001f35820003 CR4: 00000000001706f0
    [   99.673191] Call Trace:
    [   99.673192]  <IRQ>
    [   99.673193]  ? watchdog_timer_fn+0x21f/0x2a0
    [   99.673197]  ? __pfx_watchdog_timer_fn+0x10/0x10
    [   99.673198]  ? __hrtimer_run_queues+0xfa/0x270
    [   99.673202]  ? hrtimer_interrupt+0xf4/0x390
    [   99.673205]  ? __sysvec_apic_timer_interrupt+0x52/0x160
    [   99.673208]  ? sysvec_apic_timer_interrupt+0x6f/0x80
    [   99.673210]  </IRQ>
    [   99.673211]  <TASK>
    [   99.673212]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
    [   99.673215]  ? __pfx_delay_tsc+0x10/0x10
    [   99.673221]  ? _raw_spin_unlock_irqrestore+0x1f/0x40
    [   99.673222]  test_thread_func+0x5e/0xff0 [test_thread]
    [   99.673225]  ? __pfx_test_thread_func+0x10/0x10 [test_thread]
    [   99.673226]  kthread+0xec/0x110
    [   99.673230]  ? __pfx_kthread+0x10/0x10
    [   99.673232]  ret_from_fork+0x3a/0x50
    [   99.673235]  ? __pfx_kthread+0x10/0x10
    [   99.673237]  ret_from_fork_asm+0x1a/0x30
    [   99.673239]  </TASK>


If you mimic that touch_nmi_watchdog() above the udelay() in the function above,
then you have to get the system to decide to migrate. Something like:

    stress-ng --timeout 60000s --numa 64

seems to help tickle problems out. With that I got a bit different of a
backtrace than what Derek reported or above, but I'd guess its a similar
root cause:

    [  258.175904] Creating test_thread at -20 nice level
    [  258.176237] Starting the while true loop
    [  495.910816] INFO: task khugepaged:483 blocked for more than 122 seconds.
    [  495.910824]       Not tainted 6.10.0-rc4-rt6+ #7
    [  495.910827] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  495.910829] task:khugepaged      state:D stack:0     pid:483   tgid:483   ppid:2      flags:0x00004000
    [  495.910834] Call Trace:
    [  495.910836]  <TASK>
    [  495.910838]  __schedule+0x5e9/0x1420
    [  495.910845]  ? update_load_avg+0x1fb/0x860
    [  495.910851]  ? __update_curr+0x15d/0x3a0
    [  495.910854]  schedule+0x6d/0xf0
    [  495.910857]  schedule_timeout+0x32/0x1b0
    [  495.910860]  ? sched_clock+0x10/0x30
    [  495.910866]  wait_for_common+0xfe/0x1c0
    [  495.910869]  __flush_work+0x258/0x2d0
    [  495.910875]  ? __pfx_wq_barrier_func+0x10/0x10
    [  495.910878]  __lru_add_drain_all+0x19d/0x1e0
    [  495.910882]  khugepaged+0x160/0xa90
    [  495.910887]  ? __pfx_autoremove_wake_function+0x10/0x10
    [  495.910892]  ? __pfx_khugepaged+0x10/0x10
    [  495.910894]  kthread+0xec/0x110
    [  495.910898]  ? __pfx_kthread+0x10/0x10
    [  495.910900]  ret_from_fork+0x3a/0x50
    [  495.910902]  ? __pfx_kthread+0x10/0x10
    [  495.910904]  ret_from_fork_asm+0x1a/0x30
    [  495.910907]  </TASK>

I got that once this afternoon, haven't gotten anything since (was
hoping to see the exact same thing as Derek with that, but oh well).

Thanks,
Andrew

