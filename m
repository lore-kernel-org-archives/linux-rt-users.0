Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51944C48BE1
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341C5206BA
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfFTVGw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:06:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFTVGv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 17:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55178C05D3F9;
        Thu, 20 Jun 2019 21:06:43 +0000 (UTC)
Received: from ovpn-117-83.phx2.redhat.com (ovpn-117-83.phx2.redhat.com [10.3.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5FCF1001B05;
        Thu, 20 Jun 2019 21:06:37 +0000 (UTC)
Message-ID: <1b6dfc95bba69aa53e4e84eebf6af60f0b9ed95c.camel@redhat.com>
Subject: Re: [PATCH RT 1/4] rcu: Acquire RCU lock when disabling BHs
From:   Scott Wood <swood@redhat.com>
To:     paulmck@linux.ibm.com
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190620205352.GV26519@linux.ibm.com>
References: <20190619011908.25026-1-swood@redhat.com>
         <20190619011908.25026-2-swood@redhat.com>
         <20190620205352.GV26519@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 20 Jun 2019 16:06:02 -0500
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 20 Jun 2019 21:06:51 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2019-06-20 at 13:53 -0700, Paul E. McKenney wrote:
> On Tue, Jun 18, 2019 at 08:19:05PM -0500, Scott Wood wrote:
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index fb267bc04fdf..aca4e5e25ace 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -637,10 +637,12 @@ static inline void rcu_read_unlock(void)
> >  static inline void rcu_read_lock_bh(void)
> >  {
> >  	local_bh_disable();
> > +#ifndef CONFIG_PREEMPT_RT_FULL
> 
> How about this instead?
> 
> 	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> 		return;

OK.

> > @@ -189,8 +193,10 @@ void __local_bh_enable_ip(unsigned long ip,
> > unsigned int cnt)
> >  	WARN_ON_ONCE(count < 0);
> >  	local_irq_enable();
> >  
> > -	if (!in_atomic())
> > +	if (!in_atomic()) {
> > +		rcu_read_unlock();
> >  		local_unlock(bh_lock);
> > +	}
> >  
> >  	preempt_check_resched();
> >  }
> 
> And I have to ask...
> 
> What did you do to test this change to kernel/softirq.c?  My past attempts
> to do this sort of thing have always run afoul of open-coded BH
> transitions.

Mostly rcutorture and loads such as kernel builds, on a debug kernel.  By
"open-coded BH transition" do you mean directly manipulating the preempt
count?  That would already be broken on RT.

-Scott


