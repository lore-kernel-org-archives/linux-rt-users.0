Return-Path: <SRS0=sCGC=UU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C165DC43613
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jun 2019 16:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FBF20665
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jun 2019 16:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUQir (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:38:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55381 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUQir (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Jun 2019 12:38:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1heMYP-000124-OW; Fri, 21 Jun 2019 18:38:21 +0200
Date:   Fri, 21 Jun 2019 18:38:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Scott Wood <swood@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical
 section nesting
Message-ID: <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-5-swood@redhat.com>
 <20190620211826.GX26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620211826.GX26519@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-20 14:18:26 [-0700], Paul E. McKenney wrote:
> > Example #1:
> > 
> > 1. preempt_disable()
> > 2. local_bh_disable()
> > 3. preempt_enable()
> > 4. local_bh_enable()
> > 
> > Example #2:
> > 
> > 1. rcu_read_lock()
> > 2. local_irq_disable()
> > 3. rcu_read_unlock()
> > 4. local_irq_enable()
> > 
> > Example #3:
> > 
> > 1. preempt_disable()
> > 2. local_irq_disable()
> > 3. preempt_enable()
> > 4. local_irq_enable()
> 
> OK for -rt, but as long as people can code those sequences without getting
> their wrists slapped, RCU needs to deal with it.  So I cannot accept
> this in mainline at the current time.  Yes, I will know when it is safe
> to accept it when rcutorture's virtual wrist gets slapped in mainline.

All three examples are not symmetrical so if people use this mainline
then they should get their wrists slapped. Since RT trips over each one
of those I try to get rid of them if I notice something like that.

In example #3 you would lose a scheduling event if TIF_NEED_RESCHED gets
set between step 1 and 2 (as local schedule requirement) because the
preempt_enable() would trigger schedule() which does not happen due to
IRQ-off.

Sebastian
