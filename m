Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C47C48BE5
	for <linux-rt-users@archiver.kernel.org>; Sat, 19 Jun 2021 08:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1912861245
	for <linux-rt-users@archiver.kernel.org>; Sat, 19 Jun 2021 08:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhFSIYz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 19 Jun 2021 04:24:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhFSIYz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 19 Jun 2021 04:24:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624090963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+U7odfbFJQovsecU7GWc8bZHX2YJeBH6Eg6K0NB8gM=;
        b=Fl+4IBB7n1c5fEc3KsVVeFX1RJWuf5GmifPMiOVdfYCjDLA5KCv+ZKyHrpGoiYKnW40/H8
        00tnO18BD7BQGnZtLkH9Z/yo8Eduu1mh4GX0Nhj5GsWDY0+y2D7snLgaiMd1oz5Iuuw+pB
        1/OSMpdPHD2jSCPwRyXPY/pVGQpIJtSWkbqrrrx9fv7WDVtaZH1XZHDgmJRTlxL8UUBuBK
        yNqNvEtewQiD1m/GscZaMAJkf1BfgrqG+hVuieodxwL1S2Tppf530XIRcF3Sc7Qbb/3MjD
        iv7JqVcMJGwruWXoWH22bILXrp0qOMPymz874eVxwEHNQrXVNqLCzKaiMLQLIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624090963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+U7odfbFJQovsecU7GWc8bZHX2YJeBH6Eg6K0NB8gM=;
        b=TKZd+OX6JDIsX7c0GvSmeNjKLCmA1+djgPZB5Q3kS5vK8B1UzDR1A6jsGHQvPfLH3cTDLq
        RopOStLAQUaM5KBQ==
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 2/2] timers: Make sure irq_work is handled when no pending timers
In-Reply-To: <87mtrmeqon.ffs@nanos.tec.linutronix.de>
References: <20210610125945.558872-1-nsaenzju@redhat.com> <20210610125945.558872-2-nsaenzju@redhat.com> <87mtrmeqon.ffs@nanos.tec.linutronix.de>
Date:   Sat, 19 Jun 2021 10:22:43 +0200
Message-ID: <875yyae018.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, Jun 19 2021 at 00:47, Thomas Gleixner wrote:
> On Thu, Jun 10 2021 at 14:59, Nicolas Saenz Julienne wrote:
> As we since then made work queues RT aware and it's possible to queue
> work from the irq_work IPI context, the obvious solution is to delegate
> this to a work queue.
>
> If we do a proper analysis of the affected irq work callbacks then this
> probably makes a lot of sense independent of RT. There are only a few
> really urgent irq work items which need to be handled immediately in the
> IPI.
>
> RT is special, but as we have demonstrated over time it's not _that_
> special. It just needs a proper analysis and a real good argument why
> something has to be special for RT and does not fit into the common
> case. Or to demonstrate that the common case approach of 'do it right
> away' is pointless or even harmfull.

I skimmed most of the ~40 irq_work instances.

Most of them have no urgency at all. And out of those non-urgent cases
the majority does not even have the requirement to run on the current
CPU, so they can be pushed off to a global work queue which moves them
away from NOHZ full CPUs completely.

That has nothing to do with RT, that's a benefit in general.

Thanks,

        tglx

