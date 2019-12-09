Return-Path: <SRS0=ajRN=Z7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54091C43603
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Dec 2019 10:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AC82073D
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Dec 2019 10:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLIKEt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:04:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:36256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727060AbfLIKEt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Dec 2019 05:04:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2A879AC90;
        Mon,  9 Dec 2019 10:04:48 +0000 (UTC)
Date:   Mon, 9 Dec 2019 11:04:47 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] lib: Check for migrate_disable only on SMP systems
Message-ID: <20191209100447.codml4nop4ibbjkz@beryllium.lan>
References: <20191206142103.29647-1-dwagner@suse.de>
 <4513f4a584586a4c17ef14f7365f6275042c3071.camel@redhat.com>
 <20191206193954.yi5hac366agt7k3o@beryllium.lan>
 <3ce4699f987e784e84b2030aa3a1c529b274b498.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce4699f987e784e84b2030aa3a1c529b274b498.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Scott,

On Fri, Dec 06, 2019 at 09:21:36PM -0600, Scott Wood wrote:
> On Fri, 2019-12-06 at 20:39 +0100, Daniel Wagner wrote:
> > On Fri, Dec 06, 2019 at 12:49:12PM -0600, Scott Wood wrote:
> > > On Fri, 2019-12-06 at 15:21 +0100, Daniel Wagner wrote:
> > > Won't this give false positives on UP with CONFIG_PREEMPT_RT_BASE and
> > > CONFIG_DEBUG_PREEMPT? If we have CONFIG_SCHED_DEBUG then we can still
> > > check migrate_disable.
> >
> > Ohhh, I see what you mean. I didn't realize that migrate_disable is
> > also available with CONFIG_SCHED_DEBUG. So the ifdef should be
> > something like:
> >
> > #if defined(CONFIG_PREEMP_RT_BASE) && \
> >     (defined(CONFIG_SMP) || \
> >       (!defined(CONFIG_SMP) && defined(CONFIG_SCHED_DEBUG)))
>
> That would still leave the issue with false positives if you have
> CONFIG_DEBUG_PREEMPT but not CONFIG_SCHED_DEBUG (which should be the only
> config currently experiencing build problems).

I didn't realize that smp_processor_id.c is only build with
CONFIG_DEBUG_PREEMPT. It should be enough to add

	#if defined(CONFIG_SCHED_DEBUG)

Did I get it finally correct? :)

Thanks,
Daniel
