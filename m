Return-Path: <SRS0=GyRq=5E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB219C4332D
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Mar 2020 00:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BD820767
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Mar 2020 00:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UyUB0eHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCSArb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:47:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33158 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCSArb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Mar 2020 20:47:31 -0400
Received: by mail-io1-f67.google.com with SMTP id o127so545968iof.0
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Mar 2020 17:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nikfs2mITY1YnXregatCfjsnN0VxQx1MLHWWy5mZepo=;
        b=UyUB0eHGnGw9m1dq+wwqfipb+e49FVRrNMBxA7casT2HN+Z9yLj4EKGNR9lyGbcx55
         KkQujx6BOLkfj/DMsoWnz4gc8HQgeuNk7J/Ymzcgcr9a3WZRujV1KBRPHVHqxxFqrHsL
         rC6cZTsbs2NrBW6LkZ8snTeMclPM8M1h3wAvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nikfs2mITY1YnXregatCfjsnN0VxQx1MLHWWy5mZepo=;
        b=E0bD6gQwUQ72lAPxIzFVW/wpH0FnuMvDvS+EK3BXmzc6myjaAu/2DnZuvXJm520L0L
         uzb9kQ2IhMgsxKotW63Tapt1JA2Ap0vH7KcHzlW3pFKURbBdxxQZIBncWsL0v7DGEAI3
         wjVphuKmDPNLTojWLlJWzAVG47qeCvPMuhbEG8hGRNEa7WCKo0i5DraRY7cL0qx8jDpt
         9GT/ARIBnQ3JWwvkt49BG/OkEJ+BBP21J8Tx4T7Rgw1Tj28KWmGwXi6nNDuvet8vbynG
         vaf9L9cKUTqvG+m0LGLIZFEy9QO94iwzlnfUn6Oo4yMfe3ie1KQ2Tkji31Au9uPL9W5D
         aj6Q==
X-Gm-Message-State: ANhLgQ1wOEeVOqHN7A1oRgB54AuC5ICQwyyHbhbl0VxOZT5F6cvGfGI2
        w6KXBIApgFDgppXxa2NyiXWr0FvbDJhUyTS42I/T0w==
X-Google-Smtp-Source: ADFU+vsUlxX18RINXbTIKk/71K/n1UmMkxX3JU9OJ9HNcL+q/mSD0Gp2PA3I1g/jz2/K2Yt2Ke+h8g36hOL7IzNEeJg=
X-Received: by 2002:a02:c85a:: with SMTP id r26mr829137jao.74.1584578849973;
 Wed, 18 Mar 2020 17:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200305003526.GA20601@paulmck-ThinkPad-P72> <20200305081135.yg7wryd3hrqzocrm@linutronix.de>
In-Reply-To: <20200305081135.yg7wryd3hrqzocrm@linutronix.de>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 18 Mar 2020 20:47:18 -0400
Message-ID: <CAEXW_YSiKrT50mTR1a4tB5x_jQzZKnuAo6JY-Vc5w7r=XLv+OA@mail.gmail.com>
Subject: Re: RCU use of swait
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Scott Wood <swood@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-rt-users@vger.kernel.org, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Mar 5, 2020 at 3:11 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-03-04 16:35:26 [-0800], Paul E. McKenney wrote:
> > Hello!
> Hi Paul,
>
> > Or is there some other reason why {S,}RCU needs to use swait that I
> > am forgetting?
>
> swait can be used in hardirq-context (on RT) that is in a section within
> local_irq_save() / raw_spin_lock() and so.
> wait on the hand uses spinlock_t which can not be used in this context.
> So if you have no users which fall into that category then you could
> move back to wait.h.

In RCU, there are some truly-atomic code sections containing an
swake_upXX() call, which would be considered atomic also on
PREEMPT_RT, one example is:

rcu_core() contains an local_irq_{save,restore}() section.

        /* No grace period and unregistered callbacks? */
        if (!rcu_gp_in_progress() &&
            rcu_segcblist_is_enabled(&rdp->cblist) && !offloaded) {
                local_irq_save(flags);
                if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
                        rcu_accelerate_cbs_unlocked(rnp, rdp);
                local_irq_restore(flags);
        }

And rcu_accelerate_cbs_unlocked(rnp, rdp) calls rcu_gp_kthread_wake()
which does an swake_up_one(), so I think we will have to leave it as
swake_up() the way it is.

thanks,

 - Joel
