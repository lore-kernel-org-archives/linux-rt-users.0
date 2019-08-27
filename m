Return-Path: <SRS0=YHoI=WX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF7DC3A5A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 13:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8252077B
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 13:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LSEXvsMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfH0NI5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:08:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38430 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbfH0NI5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Aug 2019 09:08:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id w11so11312522plp.5
        for <linux-rt-users@vger.kernel.org>; Tue, 27 Aug 2019 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fLKzn2mA80Hl5wtgJKSE5GefgidMmtcVKTEdAzrb1ys=;
        b=LSEXvsMXS1osnScXKbxTi3fKBv18wI+PDW4Nvq2+kpZ3c9bx+EpsaBZrkNHCXomYC2
         Oe+FabRp5243tsTmll1xu7EaOxuiawnzHzCpgy+Zm+DAuhzTdvReeHr3qeARxOrso8SH
         dEE3JRh/qDZ7MAM8FstRQ5DjpXQ6g5RNi2LBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fLKzn2mA80Hl5wtgJKSE5GefgidMmtcVKTEdAzrb1ys=;
        b=UlrZx9UiQAICHIuQ2eg8WlcjXmPwoFJ4ZeqWHl+UDvu+E5LYn9cGBpcp2krBaKaJlP
         FYUax43RRN498iT8MwoiiHZ4pW5QQSLvbzGhXuG961x5vt4vhGDd3+8g8Evwngl7sdX7
         JPvOqEC98CZV2F0UAxivwEL8QMHJjt6d+xg71iFlNitgs3tvjTaAVpFn1ICFpIBi0e7u
         2zw11gJF6TD+Pa96+H/y51TACbI+zGNEVQIvLGIsRmgT8iuxanMLW3MgS2pu+JQTz2d/
         vaPsqpVmrD8Fi6qF6IKKQhPznpZuljY0XuDFkJfjMZVuiNrojSBcYRVkXtr570p2+V9W
         B1fQ==
X-Gm-Message-State: APjAAAUagEbx0VLFHZ3Tj5CZ+eVfVBebE71AvTnlrixucWeMaBbKI32T
        dPT1hdWcjSgExnN3llnXagqblw==
X-Google-Smtp-Source: APXvYqzVB3vgR7JI2pMvsQbXOE2X3fasVmErUkh3HU5QGZ4MSD3bPdstKmA4ZesoUGssLrOqQ+uK4A==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr9131523plq.166.1566911335938;
        Tue, 27 Aug 2019 06:08:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 138sm16233198pfw.78.2019.08.27.06.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 06:08:55 -0700 (PDT)
Date:   Tue, 27 Aug 2019 09:08:53 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190827130853.GB132568@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <20190827092333.jp3darw7teyyw67g@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827092333.jp3darw7teyyw67g@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 27, 2019 at 11:23:33AM +0200, Sebastian Andrzej Siewior wrote:
[snip]
> > However, if this was instead an rcu_read_lock() critical section within
> > a PREEMPT=y kernel, then if a schedule() occured within stop_one_task(),
> > RCU would consider that critical section to be preempted.  This means
> > that any RCU grace period that is blocked by this RCU read-side critical
> > section would remain blocked until stop_one_cpu() resumed, returned,
> > and so on until the matching rcu_read_unlock() was reached.  In other
> > words, RCU would consider that RCU read-side critical section to span
> > the call to stop_one_cpu() even if stop_one_cpu() invoked schedule().
> 
> Isn't that my example from above and what we do in RT? My understanding
> is that this is the reason why we need BOOST on RT otherwise the RCU
> critical section could remain blocked for some time.

Not just for boost, it is needed to block the grace period itself on
PREEMPT=y. On PREEMPT=y, if rcu_note_context_switch() happens in middle of a
rcu_read_lock() reader section, then the task is added to a blocked list
(rcu_preempt_ctxt_queue). Then just after that, the CPU reports a QS state
(rcu_qs()) as you can see in the PREEMPT=y implementation of
rcu_note_context_switch(). Even though the CPU has reported a QS, the grace
period will not end because the preempted (or block as could be in -rt) task
is still blocking the grace period. This is fundamental to the function of
Preemptible-RCU where there is the concept of tasks blocking a grace period,
not just CPUs.

I think what Paul is trying to explain AIUI (Paul please let me know if I
missed something):

(1) Anyone calling rcu_note_context_switch() and expecting it to respect
RCU-readers that are readers as a result of interrupt disabled regions, have
incorrect expectations. So calling rcu_note_context_switch() has to be done
carefully.

(2) Disabling interrupts is "generally" implied as an RCU-sched flavor
reader. However, invoking rcu_note_context_switch() from a disabled interrupt
region is *required* for rcu_note_context_switch() to work correctly.

(3) On PREEMPT=y kernels, invoking rcu_note_context_switch() from an
interrupt disabled region does not mean that that the task will be added to a
blocked list (unless it is also in an RCU-preempt reader) so
rcu_note_context_switch() may immediately report a quiescent state and
nothing blockings the grace period.
So callers of rcu_note_context_switch() must be aware of this behavior.

(4) On PREEMPT=n, unlike PREEMPT=y, there is no blocked list handling and so
nothing will block the grace period once rcu_note_context_switch() is called.
So any path calling rcu_note_context_switch() on a PREEMPT=n kernel, in the
middle of something that is expected to be an RCU reader would be really bad
from an RCU view point.

Probably, we should add this all to documentation somewhere.

thanks!

 - Joel


> > On the other hand, within a PREEMPT=n kernel, the call to schedule()
> > would split even an rcu_read_lock() critical section.  Which is why I
> > asked earlier if sleeping_lock_inc() and sleeping_lock_dec() are no-ops
> > in !PREEMPT_RT_BASE kernels.  We would after all want the usual lockdep
> > complaints in that case.
> 
> sleeping_lock_inc() +dec() is only RT specific. It is part of RT's
> spin_lock() implementation and used by RCU (rcu_note_context_switch())
> to not complain if invoked within a critical section.
> 
> > Does that help, or am I missing the point?
> > 
> > 							Thanx, Paul
> Sebastian
