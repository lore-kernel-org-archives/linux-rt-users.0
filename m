Return-Path: <SRS0=eU8X=WU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5051C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Sat, 24 Aug 2019 03:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A743A2133F
	for <linux-rt-users@archiver.kernel.org>; Sat, 24 Aug 2019 03:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="l1NSD7h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfHXDKS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Aug 2019 23:10:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41159 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfHXDKS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Aug 2019 23:10:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so7806280pfz.8
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Aug 2019 20:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DVBI8U7MFOnPxjWhHMMwybf2/kLkyMHy0il0nS4Axi0=;
        b=l1NSD7h148KAJcPivD8eUnKxCYAG3N6oF973lbgEtLDfhIil0+SA2FTru/1hxnuhMw
         g1FdzQifGVVSfO8F6fFdEI69eX4OFfue8lN9f5fNHvyQTiSo/FdBf7519chN2jakBzM4
         6vzlRCf/4CazOdKya+viL47qFWrGoaP6tuLCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DVBI8U7MFOnPxjWhHMMwybf2/kLkyMHy0il0nS4Axi0=;
        b=l0bFtvHT6eNUot3dsPzTjNT/GBW1k8SbF4EnRfgIWxjxQ4Jqd3p4+oTH03aCZXTAlI
         ROPyYduPFJyPtxEnzF4PFQX3QljWl9y0c7XW4natoLtUDwWMSBM5mboflQDQKmfxxers
         Cb+p1+NykEPZnzdXDEIqh1HlfW8FVPWpPMNlhqh0/dYrVp29FhrfHSVXROuNAbTiYC79
         ATmFg8mhoGk9Fehb3zqfLYOrU/ozIFxTSal0mb9ow7lB/sRiD+T+pmGzNxyi5PffNgKT
         CICCQIQnLpYU8FA3tj8vrODicW9oZCpidoAnLguLT7Mx1iKbHno5UaFHQ6HgPCjgzFBZ
         dL6Q==
X-Gm-Message-State: APjAAAXt4IOLgOFWuXm41odnzwj3XJjSO+Tznx3Av28lcKoKknKybT2v
        7FYvADyX7ufqVAfPtDGSK1KUUg==
X-Google-Smtp-Source: APXvYqwHgI3V09sIWkGIdUgJ6jNLoczAE1Rhslp+VkaDbRX5PwaP3K4gw2ZGAkjMa7v3Fc0kUIjhxg==
X-Received: by 2002:a62:83c9:: with SMTP id h192mr8587378pfe.57.1566616217208;
        Fri, 23 Aug 2019 20:10:17 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k64sm3706998pge.65.2019.08.23.20.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 20:10:16 -0700 (PDT)
Date:   Fri, 23 Aug 2019 23:10:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190824031014.GB2731@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Aug 23, 2019 at 02:28:46PM -0500, Scott Wood wrote:
> On Fri, 2019-08-23 at 18:20 +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-08-21 18:19:05 [-0500], Scott Wood wrote:
> > > Without this, rcu_note_context_switch() will complain if an RCU read
> > > lock is held when migrate_enable() calls stop_one_cpu().
> > > 
> > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > ---
> > > v2: Added comment.
> > > 
> > > If my migrate disable changes aren't taken, then pin_current_cpu()
> > > will also need to use sleeping_lock_inc() because calling
> > > __read_rt_lock() bypasses the usual place it's done.
> > > 
> > >  include/linux/sched.h    | 4 ++--
> > >  kernel/rcu/tree_plugin.h | 2 +-
> > >  kernel/sched/core.c      | 8 ++++++++
> > >  3 files changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -7405,7 +7405,15 @@ void migrate_enable(void)
> > >  			unpin_current_cpu();
> > >  			preempt_lazy_enable();
> > >  			preempt_enable();
> > > +
> > > +			/*
> > > +			 * sleeping_lock_inc suppresses a debug check for
> > > +			 * sleeping inside an RCU read side critical section
> > > +			 */
> > > +			sleeping_lock_inc();
> > >  			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
> > > +			sleeping_lock_dec();
> > 
> > this looks like an ugly hack. This sleeping_lock_inc() is used where we
> > actually hold a sleeping lock and schedule() which is okay. But this
> > would mean we hold a RCU lock and schedule() anyway. Is that okay?
> 
> Perhaps the name should be changed, but the concept is the same -- RT-
> specific sleeping which should be considered involuntary for the purpose of
> debug checks.  Voluntary sleeping is not allowed in an RCU critical section
> because it will break the critical section on certain flavors of RCU, but
> that doesn't apply to the flavor used on RT.  Sleeping for a long time in an
> RCU critical section would also be a bad thing, but that also doesn't apply
> here.

I think the name should definitely be changed. At best, it is super confusing to
call it "sleeping_lock" for this scenario. In fact here, you are not even
blocking on a lock.

Maybe "sleeping_allowed" or some such.

thanks,

 - Joel

