Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC77C4CECD
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8962171F
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfIQOGl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:06:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfIQOGk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 10:06:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68568308212F;
        Tue, 17 Sep 2019 14:06:40 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 711A760852;
        Tue, 17 Sep 2019 14:06:39 +0000 (UTC)
Message-ID: <779eddcc937941e65659a11b1867c6623a2c8890.camel@redhat.com>
Subject: Re: [PATCH RT v3 3/5] sched: migrate_dis/enable: Use rt_invol_sleep
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Tue, 17 Sep 2019 09:06:34 -0500
In-Reply-To: <20190917075943.qsaakyent4dxjkq4@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
         <20190911165729.11178-4-swood@redhat.com>
         <20190917075943.qsaakyent4dxjkq4@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 17 Sep 2019 14:06:40 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-09-17 at 09:59 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-11 17:57:27 [+0100], Scott Wood wrote:
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 885a195dfbe0..32c6175b63b6 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -308,7 +308,9 @@ void pin_current_cpu(void)
> >  	preempt_lazy_enable();
> >  	preempt_enable();
> >  
> > +	rt_invol_sleep_inc();
> >  	__read_rt_lock(cpuhp_pin);
> > +	rt_invol_sleep_dec();
> >  
> >  	preempt_disable();
> >  	preempt_lazy_disable();
> 
> I understand the other one. But now looking at it, both end up in
> rt_spin_lock_slowlock_locked() which would be the proper place to do
> that annotation. Okay.

FWIW, if my lazy migrate patchset is accepted, then there will be no users
of __read_rt_lock() outside rwlock-rt.c and it'll be moot.

-Scott


