Return-Path: <SRS0=Qk+l=Z4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C359C43603
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Dec 2019 19:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA75205ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Dec 2019 19:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLFTj5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:39:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:58350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbfLFTj4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Dec 2019 14:39:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E70DB2E4;
        Fri,  6 Dec 2019 19:39:55 +0000 (UTC)
Date:   Fri, 6 Dec 2019 20:39:54 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] lib: Check for migrate_disable only on SMP systems
Message-ID: <20191206193954.yi5hac366agt7k3o@beryllium.lan>
References: <20191206142103.29647-1-dwagner@suse.de>
 <4513f4a584586a4c17ef14f7365f6275042c3071.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4513f4a584586a4c17ef14f7365f6275042c3071.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Scott,

On Fri, Dec 06, 2019 at 12:49:12PM -0600, Scott Wood wrote:
> On Fri, 2019-12-06 at 15:21 +0100, Daniel Wagner wrote:
> > In case the kernel configuration is UP is, the migrate_disable member
> > in task_struct is missing.
> > 
> > linux/lib/smp_processor_id.c: In function ‘check_preemption_disabled’:
> > linux/lib/smp_processor_id.c:26:13: error: ‘struct task_struct’ has no
> > member named ‘migrate_disable’
> >     26 |  if (current->migrate_disable)
> >        |             ^~
> > 
> > Fixes: 425c5b38779a ("sched: Lazy migrate_disable processing")
> > Cc: Scott Wood <swood@redhat.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >  lib/smp_processor_id.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
> > index 5f2618d346c4..a914f73e3652 100644
> > --- a/lib/smp_processor_id.c
> > +++ b/lib/smp_processor_id.c
> > @@ -23,8 +23,10 @@ unsigned int check_preemption_disabled(const char
> > *what1, const char *what2)
> >  	 * Kernel threads bound to a single CPU can safely use
> >  	 * smp_processor_id():
> >  	 */
> > +#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
> >  	if (current->migrate_disable)
> >  		goto out;
> > +#endif
> 
> Won't this give false positives on UP with CONFIG_PREEMPT_RT_BASE and
> CONFIG_DEBUG_PREEMPT? If we have CONFIG_SCHED_DEBUG then we can still check
> migrate_disable.

Ohhh, I see what you mean. I didn't realize that migrate_disable is
also available with CONFIG_SCHED_DEBUG. So the ifdef should be
something like:

#if defined(CONFIG_PREEMP_RT_BASE) && \
    (defined(CONFIG_SMP) || \
      (!defined(CONFIG_SMP) && defined(CONFIG_SCHED_DEBUG)))

?

Hmm, looks a bit ugly but I haven't found a simplification. Long time
since I did logic algebra...

Thanks,
Daniel
