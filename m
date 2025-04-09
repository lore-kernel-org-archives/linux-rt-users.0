Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF525DCEC
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Apr 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200813; cv=none; b=mGPkppPgTuzDCcE5BonCDSQmnQFhvopqV6+6ktaLzbpHhDLDAh3WdPGjZAWjlIyAmGxwsKze1rKzSvNJRDoVokXKipQYJHTw5f3/rGutIeQucSU1Km1hLzl4kE5tt6hTGfA9LE+HiZoYgqZ5q5uEj2EEOEQtY19ChNN0xQUOlxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200813; c=relaxed/simple;
	bh=uLn5GIoPLrkARjPodEfensH+0uhiUlOZga+O53EO634=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cygdH5sEEqvmY5r5USSoMlVN1juTlsDC4UBFdP00baojv/t2EHAuBnxlKe5KU1nPqvT64q92DZIt1s4CMjhcDysWA2aY2KIgNo++ElPqqGv95IURAP+e4vvra4WUaOt9jOPnFZruws9m16IfgnIZSWOgs/LvU2nyPvOHpho9cmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VvW7XENW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VvW7XENW"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso4940712a91.1
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Apr 2025 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744200811; x=1744805611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgsiI30TGvgspe8R+pdeRFEtMQXVok/mIXoMIGkkMX4=;
        b=VvW7XENWuiPAIeXCJmAZZyRGBWPf5CZiUDjfRjxNhdPVes6dme5rsm7bObbZOxq5CO
         n2Yb8sjlvEOCcUB9GAArVugXxsKn5w01/ZKE+d1qs8amdNk8ATv6RsHVWjutmvlnsVfF
         UAjkZDT+Sl3Pxt1mJY9GxalC292LcQQDAjqC7lJGA2q5SUhY/jJKYHDNncOh4BF4M/QM
         931lMvVZwrEBBiCTdQFUF1wpnfvWpp7s0VcLYkMAVo+CDwbGYQRDZXuXWqGFcmxEpo/J
         U/dJ1PYsjCmlZRtDR2LCv6W0F1EG/t0qh2ax6IFSItR4Ba3CUFR0er2v79GcVkXY1oVi
         uz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744200811; x=1744805611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgsiI30TGvgspe8R+pdeRFEtMQXVok/mIXoMIGkkMX4=;
        b=BMiiAoHtcubEJNY3v69JIChdYwvISGyIfEdKFF1hbglXz6LPZzgkk/YZWs16fnXbO1
         Q2+xujMadx8XdKrIbDiRbV37qNr/B7LdSkT7r+XJTLlMoEO4eqp0JppiPDvTmYAEx7HD
         zVY0XoVTN34Ii/ttyBdwL68TaESEiCIfu2mKPuGBM3vSBx14md+5WGpdEHDgeWuQCcAE
         /HGaO34bX2YKk4JlAem0aCrasbIlBuJiOYx31QUAXSZMQ23HPpX+RMos/YiGwp0nBfho
         /aKqrYgo5RHGyGN4v/B/mAs9e63eH9xf4wLpMCnZV6/aiGOQiEUs5JmCtYJL5nvYeMvs
         nfsw==
X-Forwarded-Encrypted: i=1; AJvYcCUoz/iggBIxBCqktlkWyzIYxem2K5yuyzIl8sNMfqxwYDq3okywoeQPnWAJnNpulbJqiCL93nGGlQX5BMwdqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjI5gVoqfddgWs/0+gqcvErJrKxubcIpoVaDFW5OE5/OlADv8T
	HNNKhgIrDkH6XttfSAVyvm5pOaqnAbymz8Qo54xhNQuACl1zAPiEbNRSM+twyg==
X-Gm-Gg: ASbGnctl91LFufjvT5D7nl9FegunLOtqmBMyvb3Bm85jiK9wnEzoMbiJ2MalVZMPkpx
	VzSxA2GYOfUMECcoTSbj8q+0avZuaIUUxrBni+R0RoPQt/yn03DgjK43VW0QsqcXv8zAj61S45Z
	+5ybmmhmxsda7Be7ROmXyImHGlB78kNbZwqNKzCF0lFewJv0bY9UJ2q85Qv93QTSntGbkXYDLd8
	nO2RGw9QJs8EP3E61zYkeE7Fo8pTwX04pP8NjEVRMUjAUXHbPL/tnWbYFFUr5mRWLdCKDYCQrHn
	MTjX1g7De9U6gxPuq7qbkqM2UYmRLdLqfBIKndlz
X-Google-Smtp-Source: AGHT+IHdKelabDkbvzKXiANw+PXuH7EVfs/N8db2NUhSXas5y1ky5O/gUNQ0KhorKji2P2VwWg+LLA==
X-Received: by 2002:a17:90b:58e4:b0:2f9:9ddd:689b with SMTP id 98e67ed59e1d1-306dd5565e7mr2787087a91.22.1744200810965;
        Wed, 09 Apr 2025 05:13:30 -0700 (PDT)
Received: from bytedance ([115.190.40.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e672sm1433513a91.17.2025.04.09.05.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:13:30 -0700 (PDT)
Date: Wed, 9 Apr 2025 20:13:14 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Jan Kiszka <jan.kiszka@siemens.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
Message-ID: <20250409121314.GA632990@bytedance>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>

On Wed, Apr 09, 2025 at 02:59:18PM +0530, K Prateek Nayak wrote:
> (+ Aaron)

Thank you Prateek for bring me in.

> Hello Jan,
> 
> On 4/9/2025 12:11 PM, Jan Kiszka wrote:
> > On 12.10.23 17:07, Valentin Schneider wrote:
> > > Hi folks,
> > > 
> > > We've had reports of stalls happening on our v6.0-ish frankenkernels, and while
> > > we haven't been able to come out with a reproducer (yet), I don't see anything
> > > upstream that would prevent them from happening.
> > > 
> > > The setup involves eventpoll, CFS bandwidth controller and timer
> > > expiry, and the sequence looks as follows (time-ordered):
> > > 
> > > p_read (on CPUn, CFS with bandwidth controller active)
> > > ======
> > > 
> > > ep_poll_callback()
> > >    read_lock_irqsave()
> > >    ...
> > >    try_to_wake_up() <- enqueue causes an update_curr() + sets need_resched
> > >                        due to having no more runtime
> > >      preempt_enable()
> > >        preempt_schedule() <- switch out due to p_read being now throttled
> > > 
> > > p_write
> > > =======
> > > 
> > > ep_poll()
> > >    write_lock_irq() <- blocks due to having active readers (p_read)
> > > 
> > > ktimers/n
> > > =========
> > > 
> > > timerfd_tmrproc()
> > > `\
> > >    ep_poll_callback()
> > >    `\
> > >      read_lock_irqsave() <- blocks due to having active writer (p_write)
> > > 
> > > 
> > >  From this point we have a circular dependency:
> > > 
> > >    p_read -> ktimers/n (to replenish runtime of p_read)
> > >    ktimers/n -> p_write (to let ktimers/n acquire the readlock)
> > >    p_write -> p_read (to let p_write acquire the writelock)
> > > 
> > > IIUC reverting
> > >    286deb7ec03d ("locking/rwbase: Mitigate indefinite writer starvation")
> > > should unblock this as the ktimers/n thread wouldn't block, but then we're back
> > > to having the indefinite starvation so I wouldn't necessarily call this a win.
> > > 
> > > Two options I'm seeing:
> > > - Prevent p_read from being preempted when it's doing the wakeups under the
> > >    readlock (icky)
> > > - Prevent ktimers / ksoftirqd (*) from running the wakeups that have
> > >    ep_poll_callback() as a wait_queue_entry callback. Punting that to e.g. a
> > >    kworker /should/ do.
> > > 
> > > (*) It's not just timerfd, I've also seen it via net::sock_def_readable -
> > > it should be anything that's pollable.
> > > 
> > > I'm still scratching my head on this, so any suggestions/comments welcome!
> > > 
> > 
> > We are hunting for quite some time sporadic lock-ups or RT systems,
> > first only in the field (sigh), now finally also in the lab. Those have
> > a fairly high overlap with what was described here. Our baselines so
> > far: 6.1-rt, Debian and vanilla. We are currently preparing experiments
> > with latest mainline.
> 
> Do the backtrace from these lockups show tasks (specifically ktimerd)
> waiting on a rwsem? Throttle deferral helps if cfs bandwidth throttling
> becomes the reason for long delay / circular dependency. Is cfs bandwidth
> throttling being used on these systems that run into these lockups?
> Otherwise, your issue might be completely different.

Agree.

> > 
> > While this thread remained silent afterwards, we have found [1][2][3] as
> > apparently related. But this means we are still with this RT bug, even
> > in latest 6.15-rc1?
> 
> I'm pretty sure a bunch of locking related stuff has been reworked to
> accommodate PREEMPT_RT since v6.1. Many rwsem based locking patterns
> have been replaced with alternatives like RCU. Recently introduced
> dl_server infrastructure also helps prevent starvation of fair tasks
> which can allow progress and prevent lockups. I would recommend
> checking if the most recent -rt release can still reproduce your
> issue:
> https://lore.kernel.org/lkml/20250331095610.ulLtPP2C@linutronix.de/
> 
> Note: Aaron Lu is working on Valentin's approach of deferring cfs
> throttling to exit to user mode boundary
> https://lore.kernel.org/lkml/20250313072030.1032893-1-ziqianlu@bytedance.com/
> 
> If you still run into the issue of a lockup / long latencies on latest
> -rt release and your system is using cfs bandwidth controls, you can
> perhaps try running with Valentin's or Aaron's series to check if
> throttle deferral helps your scenario.

I just sent out v2 :-)
https://lore.kernel.org/all/20250409120746.635476-1-ziqianlu@bytedance.com/

Hi Jan,

If you want to give it a try, please try v2.

Thanks.
