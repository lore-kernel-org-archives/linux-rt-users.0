Return-Path: <SRS0=CUgu=T6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8056BC28CC0
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E89826156
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 20:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfE3UPp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 May 2019 16:15:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfE3UPp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 May 2019 16:15:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07732307CB5F;
        Thu, 30 May 2019 20:15:45 +0000 (UTC)
Received: from amt.cnet (ovpn-112-13.gru2.redhat.com [10.97.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE6215C324;
        Thu, 30 May 2019 20:15:42 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id E520610519B;
        Thu, 30 May 2019 16:38:16 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id x4UJc9Jp027708;
        Thu, 30 May 2019 16:38:09 -0300
Date:   Thu, 30 May 2019 16:38:08 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 0/3] do not raise timer softirq unconditionally
 (spinlockless version)
Message-ID: <20190530193806.GB23199@amt.cnet>
References: <20190415201213.600254019@amt.cnet>
 <alpine.DEB.2.21.1905291651500.1395@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1905291651500.1395@somnus>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 30 May 2019 20:15:45 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 29, 2019 at 04:52:37PM +0200, Anna-Maria Gleixner wrote:
> Hi,
> 
> I had a look at the queue and have several questions about your
> implementation. 
> 
> First of all, I had some troubles to understand your commit messages. So I
> first had to read the code and then tried to understand the commit
> messages. It is easier, if it works the other way round.

Right. Commit message seemed descriptive to me, but i should probably
try to improve the explanation in the commit message.

> On Mon, 15 Apr 2019, Marcelo Tosatti wrote:
> 
> > For isolated CPUs, we'd like to skip awakening ktimersoftd
> > (the switch to and then back from ktimersoftd takes 10us in
> > virtualized environments, in addition to other OS overhead,
> > which exceeds telco requirements for packet forwarding for
> > 5G) from the sched tick.
> 
> You would like to prevent raising the timer softirq in general from the
> sched tick for isolated CPUs? Or you would like to prevent raising the
> timer softirq if no pending timer is available?

With DPDK and CPU isolation, there are no low resolution timers running on
the isolated CPUs. So prevent raising timer softirq if no pending timer 
is available is enough.

> Nevertheless, this change is not PREEMPT_RT specific. It is a NOHZ
> dependand change. So it would be nice, if the queue is against
> mainline. But please correct me, if I'm wrong.

Since it was based on the idea of 

https://lore.kernel.org/patchwork/patch/446045/

Which was an -RT patch, i decided to submit it against the -RT kernel.

But it can be merged through the mainline kernel queue as well, 
i believe.

> [...]
> 
> > This patchset reduces cyclictest latency from 25us to 14us
> > on my testbox. 
> > 
> 
> A lot of information is missing: How does your environment looks like for
> this test, what is your workload,...?

x86 hardware, with KVM virtualized, running -RT kernel on both host
and guest. Relevant host kernel command line:

isolcpus=1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,14
intel_pstate=disable nosoftlockup nohz=on
nohz_full=1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,14
rcu_nocbs=1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,14

Relevant guest kernel command line:
isolcpus=1 nosoftlockup nohz=on nohz_full=1
rcu_nocbs=1

And workload in question is cyclictest (the production
software is DPDK, but cyclictest is used to gather 
latency data).

> Did you also run other tests?

Yes, have a custom module stress test to attempt to hit the race.
Daniel (CC'ed) ran it under a kernel with debugging enabled, 
with no apparent problems.

So one downside of this patch is that raises the softirq 
unnecessarily sometimes. However, its impact is reduced to
isolated CPUs.





