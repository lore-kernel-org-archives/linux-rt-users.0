Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43EC13CAAD
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317295; cv=none; b=UBxVYa3ISXSqBUMBUjU59u5K1a8D3A2qfnjTPq7n4tvM6uFnwvAGRa8A/gTlyhIGaE+d/SVwiFQvQP1cRsfKRmXLciqczIM4eQGmHQRa+0lDTFJ2of0i7PEf+/aLoikYaSKa7IgcCrCwnT3vLSrhNyfA3eaY3T0cFFo3gjbiAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317295; c=relaxed/simple;
	bh=E+HhLOHYZ9pd2CvcjxUbQi/DWPX+ZCwsUvDTuj836w4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fC4ulcmGcMs9DZQKm2H1a8JVCd02721RiJDzMcvu1nXgFvi3OuC7rkxfnj12u6f+6DLRG+Fe9QxgaU+AnTaDr9JZY7LsEj/I55YQfXqXp7DavAtF9M8WQ+KQ8Hpppp0X3SYcmFosghQaMabYosfYMsoEx6YOBgqEUKrSjzRvE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVUTxjId; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVUTxjId"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721317292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ui6ktcTcQv8hrZqC4F52ccyN06V6WKflUU8pTbacBWU=;
	b=UVUTxjIdCrMpxDTttuMnMqHzS2KzM4fE2eClad7woUAI7Z2mo0yrqSNyiaqWjmdAxEMuCD
	lPB7yph2udxJs25xgLpbs/FfqJs5zrRvFWUPtzLerzovbohXRTiutm20Cbm6JDKoBXQxso
	yW91yRxhig9Fmq9pTXHKx61uHlisufY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-2HgBlSSOOyu6vdfgl_Ugrg-1; Thu, 18 Jul 2024 11:41:31 -0400
X-MC-Unique: 2HgBlSSOOyu6vdfgl_Ugrg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79f006f9f14so83673485a.0
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 08:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721317289; x=1721922089;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui6ktcTcQv8hrZqC4F52ccyN06V6WKflUU8pTbacBWU=;
        b=Bvm+2VSY6vGPc5kDok0X6aIDGpjCxF1fG2B878qaTDMQaJIJsKJ82iCrdTCm4K7nbj
         K22O32Fj1fpFpY9XMehI8L+78ENZP50iTYQCrj+IpzIf+mXtwUdHgEP7W0vU5djkoagu
         7an0bWLLqh/m0OBqFt+o7kP7Vor0B4yXhMkPKpcA7n6umb89vDWIhUgUjIkWgwBXPsTw
         7GlHWpTQWzAI4HyAr50Fm/BoFu3CFgxcMfN4CC6f22qT3omhSvi3HCfnW6yTKBFPyLWT
         CYsku0RW1UBYXjncRPm13Vc0jKJHzFty0UVK3MuSkCq4khVyMGiIuc9sGUxFfEkVGS4l
         PJlQ==
X-Gm-Message-State: AOJu0Yyduw2xCSVU8apObn2QKFtNQc3chGHw73Wlxie13c+WFD3GAv+8
	T2WIVlAVz1ox/d5jyXyDF9A4SqT9Q0R6UMPtVE/SakeJFRUuujTPatIQ64dXrrrOEey5iyRanag
	8YGcoEXmeRkSY1/dt5eU1c2qsVuiqXoKcldf9t17x8LwuDGlhjmZ0Qz5SVI5C+jjd
X-Received: by 2002:a05:620a:4724:b0:794:eb81:32c4 with SMTP id af79cd13be357-7a193912ec3mr249196585a.10.1721317289018;
        Thu, 18 Jul 2024 08:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeN5Cku3a9PAWQht8T9RieSc4SsdTnniULFd6nsjupu4TVFiLWCEmIjv4sChfGgE4DW4ZV9A==
X-Received: by 2002:a05:620a:4724:b0:794:eb81:32c4 with SMTP id af79cd13be357-7a193912ec3mr249193085a.10.1721317288616;
        Thu, 18 Jul 2024 08:41:28 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f96acd157sm3411681cf.95.2024.07.18.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 08:41:28 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:41:25 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de, 
	senozhatsky@chromium.org, debarbos@redhat.com, williams@redhat.com, jlelli@redhat.com
Cc: linux-rt-users@vger.kernel.org
Subject: [BUG] printk/nbcon can use RCU illegally prior to CPU online
Message-ID: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Recently I was made aware of an issue when running 6.10.0-rc6-rt11+
(with a !PREEMPT_RT config, although I'm not sure it matters here).

Its easy to reproduce, just printk on a CPU that's coming online (I got
pointed to a real splat, but this suffices to reproduce).
For example:

    diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
    index 0c35207320cb..eb75a7cffe31 100644
    --- a/arch/x86/kernel/smpboot.c
    +++ b/arch/x86/kernel/smpboot.c
    @@ -274,6 +274,10 @@ static void notrace start_secondary(void *unused)
            cpuhp_ap_sync_alive();

            cpu_init();
    +
    +       /* Let's printk() and see if RCU whines */
    +       printk(KERN_ERR "RCU, what do you think?!\n");
    +
            fpu__init_cpu();
            rcutree_report_cpu_starting(raw_smp_processor_id());
            x86_cpuinit.early_percpu_clock_init();

Results in the following on boot:

    [    2.376218] .... node  #0, CPUs:   #46
    [    2.377276] .... node  #1, CPUs:   #47
    [    1.890157] RCU, what do you think?!

    [    1.890157] =============================
    [    1.890157] WARNING: suspicious RCU usage
    [    1.890157] 6.10.0-rc6-rt11+ #12 Not tainted
    [    1.890157] -----------------------------
    [    1.890157] kernel/printk/nbcon.c:1157 suspicious rcu_dereference_check() usage!
    [    1.890157] 
                   other info that might help us debug this:

    [    1.890157] 
                   RCU used illegally from offline CPU!
                   rcu_scheduler_active = 1, debug_locks = 1
    [    1.890157] 2 locks held by swapper/1/0:
    [    1.890157]  #0: ffffffff8b87efd0 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x30/0x60
    [    1.890157]  #1: ffffffff8bc04050 (rcu_read_lock){....}-{1:3}, at: nbcon_wake_threads+0x4d/0x190
    [    1.890157] 
                   stack backtrace:
    [    1.890157] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.10.0-rc6-rt11+ #12
    [    1.890157] Hardware name: Dell Inc. PowerEdge R660/0NN3RP, BIOS 2.1.5 03/14/2024
    [    1.890157] Call Trace:
    [    1.890157]  <TASK>
    [    1.890157]  dump_stack_lvl+0x86/0xc0
    [    1.890157]  lockdep_rcu_suspicious+0x154/0x1a0
    [    1.890157]  ? nbcon_wake_threads+0x4d/0x190
    [    1.890157]  nbcon_wake_threads+0x176/0x190
    [    1.890157]  vprintk_emit+0x170/0x450
    [    1.890157]  _printk+0x5d/0x80
    [    1.890157]  ? initialize_tlbstate_and_flush+0xb5/0x1d0
    [    1.890157]  start_secondary+0x29/0xb0
    [    1.890157]  common_startup_64+0x13e/0x140
    [    1.890157]  </TASK>

Basically, we're using RCU during a printk() (rcuwait_has_sleeper()
in nbcon_wake_threads()) to figure out if we need to wake a rcuwait'ing thread
with an irq_work + rcuwait_wake_up() dance, and that "figuring out" with RCU is
not allowed prior to a CPU coming online.

I scratched my head and read up on RCU some more, but I don't have any solutions
brainstormed up yet that are proper seeming (can't just blindly use SRCU with rcuwait,
not sure if we should try scheduling an irq_work always until we're "RCU online"
via checking with something akin to rcu_cpu_online(), etc)...

Anyone more familiar with this neck of the woods have a good tip on how
to handle a printk()/nbcon prior to a CPU coming online?

Thanks,
Andrew

