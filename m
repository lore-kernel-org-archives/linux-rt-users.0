Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822622EE5
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721326392; cv=none; b=I21ke7DcSg/oWYbUCo8M0V5hzP9j266V9Sp1FanWa5GaYqiyhvNMwCeL4RTOZPJQzf1EbGm1OgIZhTNEi5sJlCEv1yjX8sx13DKvmVlC40Vvti8SWWrKaClYS6rtDAgeY6iZtD2WD3zGCOq8aPLbp+X8NM34wsiILq8VdMIp7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721326392; c=relaxed/simple;
	bh=dB9wA5NTztDH9E7pM0wn/Od/tyHDH1rLNZr61+7NBPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvbccmDAQ4zTJG1VLuQ87nMRC8V8TgWUY6L6k02w9uI4/vroUSofe0ARDytj4Wo8dFUntidlfpo3uQjC/XDW5Ofyht+7sEdBaDsqw7T3zF88teMLSpmzWApHti/THTbKsP0uAop6CU+3zcL2rshmuIFlEhIyBxmGC28UCjhe4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHsqUTfe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHsqUTfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721326389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBVf0yIruidjWgQSC4erl5bCCeaOqsOzxZru26YfTMc=;
	b=EHsqUTfeqJfFQq+T/fAf8U1noC66kMQle/lRzuPvAfbPYuoB7vB4mlzxedtRhgfmC47q5a
	BTRqYAO0Yyrgw9rdNikvM9wKw4HLiM8Acn7U3Hy3b+1yaLkg2x+KFYGXGcaKKNeqoYnfaR
	vWuzLzej/eb899PPoqJ7/q4Q5aK3+NM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-rMLE3rqQN1OAIjoU6ZJaQA-1; Thu, 18 Jul 2024 14:13:06 -0400
X-MC-Unique: rMLE3rqQN1OAIjoU6ZJaQA-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-703775b7dbeso1082169a34.1
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 11:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721326385; x=1721931185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBVf0yIruidjWgQSC4erl5bCCeaOqsOzxZru26YfTMc=;
        b=meLpENw/8yDYmevZJOLp13NiHOzdvBTqy7Lj2CwtZsznVUMFIaglW+cXi0GkOD6RLg
         f8hQfyLchhqQ2SHbtwoXjdMrJBtgpheejMmW/yuerXVIgQuusq6Del+F6vYUGktKk7hW
         +I7poDGzWMvvePnX01S7FLsz13ErgWq7lhNvWY53X3zUDmysaNX01gHmr8SCdY5XF1q5
         RhJ5fdQz+a3HIOh0OLo5dYgCy6weRPpwY5qUyfDpkzaWRnpJG4qfgQixRaQ4thLj6F91
         t4o6OKnyj2mjiGw/ivwiq63XsL+o6Thwi3vqw1PPhfz5m/dBwJovpiAI4DIh96d2KFYc
         9orw==
X-Forwarded-Encrypted: i=1; AJvYcCU+k5KqPviioeA/fD/fHCce6HsFPbPiRwkkHWl3Cvb7fe5DV2CaOqjz7D3ujSFMgOX51qY+EnLhqWqyLs5nX2RrnEFVN0Z1etrt1Sm2fBc=
X-Gm-Message-State: AOJu0Yxu3QlMZAgEdztNcc7PCjUN6Ur4XsHO5Y8UkMSMtKleE95sLJQs
	zgRhumn9umSzKShOKJpHbipHInuvXVMzoVqpeFNTTpYkpbKVdjFwaQPz2cNlEJb8Yl3ky3omnVG
	S8ACrBxxf5okKqlcJxuHpqjf1gkf7C5o2QY9tj26h2v7Ge0LxbZrhp7xwqmwOURnY
X-Received: by 2002:a05:6830:4392:b0:703:5fbe:e0ca with SMTP id 46e09a7af769-708e3786d2fmr6977715a34.4.1721326385410;
        Thu, 18 Jul 2024 11:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAF17tJ3h2fEcSAs+B5J4U4n9Otvd1FOoEiaa7hR9fVG/4W9vwoDBXo+TP2gYb9kWb0Ow9ZA==
X-Received: by 2002:a05:6830:4392:b0:703:5fbe:e0ca with SMTP id 46e09a7af769-708e3786d2fmr6977696a34.4.1721326385110;
        Thu, 18 Jul 2024 11:13:05 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c64aa60sm10441886d6.105.2024.07.18.11.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:13:04 -0700 (PDT)
Date: Thu, 18 Jul 2024 13:13:02 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: pmladek@suse.com, john.ogness@linutronix.de, senozhatsky@chromium.org, 
	debarbos@redhat.com, williams@redhat.com, jlelli@redhat.com, 
	linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
Message-ID: <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
 <20240718115704.0cd768bc@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718115704.0cd768bc@rorschach.local.home>

On Thu, Jul 18, 2024 at 11:57:04AM GMT, Steven Rostedt wrote:
> On Thu, 18 Jul 2024 10:41:25 -0500
> Andrew Halaney <ahalaney@redhat.com> wrote:
> 
> > Hi,
> > 
> > Recently I was made aware of an issue when running 6.10.0-rc6-rt11+
> > (with a !PREEMPT_RT config, although I'm not sure it matters here).
> > 
> > Its easy to reproduce, just printk on a CPU that's coming online (I got
> > pointed to a real splat, but this suffices to reproduce).
> 
> I'm more interested in the real splat. Where was the printk() that
> triggered it?

I'll be honest, I only considered this from a printk() point of view so
far and pretty much ignored the original splat (as someone else is
looking at that). Here's the original splat from a centos kernel, I have
yet to look into it other than "we took an exception prior to RCU coming
online for this CPU" and me naively thinking that printk() should work
everywhere. I'll post the splat here for now before considering it more,
but it sounds like my expectation is wrong and that if something goes
awry and needs to printk prior to the CPU coming online, then this RCU
warning is sort of expected?:

    [ 13.643007] smp: Bringing up secondary CPUs ...
    [ 13.644422] smpboot: x86: Booting SMP configuration:
    [ 13.644431] .... node #0, CPUs: #1 #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31 #32 #33 #34
    [ 13.680691] Callback from call_rcu_tasks_rude() invoked.
    [ 13.684308] #35 #36 #37 #38 #39 #40 #41 #42 #43 #44 #45 #46 #47 #48 #49 #50 #51 #52 #53 #54 #55
    [ 13.720218] .... node #1, CPUs: #56 #57 #58 #59 #60 #61 #62 #63 #64 #65 #66 #67 #68 #69 #70 #71 #72 #73 #74 #75 #76 #77 #78 #79 #80 #81 #82 #83 #84 #85 #86 #87 #88 #89 #90 #91 #92 #93 #94 #95 #96 #97 #98 #99
    [ 13.783247] Callback from call_rcu_tasks() invoked.
    [ 13.785941] #100 #101 #102 #103 #104 #105 #106 #107 #108 #109 #110 #111
    [ 5.061942] x2apic lock mismatch between BSP and AP.

    [ 5.061942] unchecked MSR access error: WRMSR to 0x83f (tried to write 0x00000000000000f6) at rIP: 0xffffffff877434d7 (native_apic_msr_write+0x27/0x40)
    [ 5.061942] Call Trace:
    [ 5.061942] <TASK>
    [ 5.061942] ? show_trace_log_lvl+0x1c4/0x2df
    [ 5.061942] ? show_trace_log_lvl+0x1c4/0x2df
    [ 5.061942] ? arch_irq_work_raise+0x75/0xb0
    [ 5.061942] ? native_apic_msr_write+0x27/0x40
    [ 5.061942] ? ex_handler_msr.cold+0xb3/0x151
    [ 5.061942] ? fixup_exception+0x8d1/0xab0
    [ 5.061942] ? gp_try_fixup_and_notify+0x20/0x50
    [ 5.061942] ? exc_general_protection+0xf1/0x220
    [ 5.061942] ? asm_exc_general_protection+0x22/0x30
    [ 5.061942] ? native_apic_msr_write+0x27/0x40
    [ 5.061942] arch_irq_work_raise+0x75/0xb0
    [ 5.061942] irq_work_queue+0x2f/0x50
    [ 5.061942] nbcon_wake_threads+0x196/0x270
    [ 5.061942] vprintk_emit+0x183/0x400
    [ 5.061942] _printk+0xb2/0xe7
    [ 5.061942] ? _pfx_printk+0x10/0x10
    [ 5.061942] ? __pfx_lock_acquire+0x10/0x10
    [ 5.061942] lockdep_rcu_suspicious+0x12d/0x200
    [ 5.061942] nbcon_wake_threads+0x1e1/0x270
    [ 5.061942] vprintk_emit+0x183/0x400
    [ 5.061942] _printk+0xb2/0xe7
    [ 5.061942] ? _pfx_printk+0x10/0x10
    [ 5.061942] ? setup_ghcb+0xa/0x120
    [ 5.061942] ? cpu_init_exception_handling+0x5bc/0x7a0
    [ 5.061942] x2apic_setup.cold+0xc/0x11
    [ 5.061942] cpu_init+0xe9/0x3a0
    [ 5.061942] ? __pfx_cpu_init+0x10/0x10
    [ 5.061942] start_secondary+0x6d/0x290
    [ 5.061942] ? __pfx_start_secondary+0x10/0x10
    [ 5.061942] ? set_bringup_idt_handler.constprop.0+0x98/0xc0
    [ 5.061942] ? soft_restart_cpu+0x15/0x15
    [ 5.061942] secondary_startup_64_no_verify+0x18f/0x19b
    [ 5.061942] </TASK>
    [ 5.061942] =============================
    [ 5.061942] WARNING: suspicious RCU usage
    [ 5.061942] 5.14.0-467.el9.x86_64+debug #1 Not tainted
    [ 5.061942] -----------------------------
    [ 5.061942] kernel/printk/nbcon.c:1118 suspicious rcu_dereference_check() usage!
    [ 5.061942]
    other info that might help us debug this:

    [ 5.061942]
    RCU used illegally from offline CPU!
    rcu_scheduler_active = 1, debug_locks = 1
    [ 5.061942] 2 locks held by swapper/1/0:
    [ 5.061942] #0: ffffffff8b721a10 (console_srcu)
    {....}-{0:0}, at: console_srcu_read_lock+0x44/0x60
    [ 5.061942] #1: ffffffff8b735080 (rcu_read_lock){....}

    -
    {1:2}

    , at: nbcon_wake_threads+0x11d/0x270
    [ 5.061942]
    stack backtrace:
    [ 5.061942] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.14.0-467.el9.x86_64+debug #1
    [ 5.061942] Hardware name: HPE ProLiant DL380 Gen11/ProLiant DL380 Gen11, BIOS 1.32 03/23/2023
    [ 5.061942] Call Trace:
    [ 5.061942] <TASK>
    [ 5.061942] dump_stack_lvl+0x57/0x81
    [ 5.061942] lockdep_rcu_suspicious.cold+0x96/0xfc
    [ 5.061942] nbcon_wake_threads+0x1e1/0x270
    [ 5.061942] vprintk_emit+0x183/0x400
    [ 5.061942] _printk+0xb2/0xe7
    [ 5.061942] ? _pfx_printk+0x10/0x10
    [ 5.061942] ? setup_ghcb+0xa/0x120
    [ 5.061942] ? cpu_init_exception_handling+0x5bc/0x7a0
    [ 5.061942] x2apic_setup.cold+0xc/0x11
    [ 5.061942] cpu_init+0xe9/0x3a0
    [ 5.061942] ? __pfx_cpu_init+0x10/0x10
    [ 5.061942] start_secondary+0x6d/0x290
    [ 5.061942] ? __pfx_start_secondary+0x10/0x10
    [ 5.061942] ? set_bringup_idt_handler.constprop.0+0x98/0xc0
    [ 5.061942] ? soft_restart_cpu+0x15/0x15
    [ 5.061942] secondary_startup_64_no_verify+0x18f/0x19b
    [ 5.061942] </TASK>
    [ 5.061942] numa_add_cpu cpu 1 node 0: mask now 0-1
    [ 5.061942] x2apic lock mismatch between BSP and AP.
    [ 5.061942] numa_add_cpu cpu 2 node 0: mask now 0-2
    [ 5.061942] x2apic lock mismatch between BSP and AP.
    [ 5.061942] numa_add_cpu cpu 3 node 0: mask now 0-3
    [ 5.061942] x2apic lock mismatch between BSP and AP.
> 
> > For example:
> > 
> >     diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> >     index 0c35207320cb..eb75a7cffe31 100644
> >     --- a/arch/x86/kernel/smpboot.c
> >     +++ b/arch/x86/kernel/smpboot.c
> >     @@ -274,6 +274,10 @@ static void notrace start_secondary(void *unused)
> >             cpuhp_ap_sync_alive();
> > 
> >             cpu_init();
> >     +
> >     +       /* Let's printk() and see if RCU whines */
> >     +       printk(KERN_ERR "RCU, what do you think?!\n");
> >     +
> 
> prink() is normally OK to use on boot up before SMP starts. That's
> because it has nothing to race against. But this is the secondary CPU,
> where we are entering SMP. RCU has to be active to use pretty much
> anything (printk, tracing, etc).
> 
> This is why I'm interested in knowing what the real splat was. It could
> be that it is used in an incorrect location.
> 
> But if you are just debugging, then you should be safely able to ignore
> this.

Thanks for the explanation.

Please see above for the splat actual splat from a centos kernel (which
is the main reason I didn't want to send the original writeup with the
downstream splat).

Thanks,
Andrew

