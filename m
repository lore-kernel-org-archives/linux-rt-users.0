Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8550C43460
	for <linux-rt-users@archiver.kernel.org>; Sat,  1 May 2021 22:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D7E61458
	for <linux-rt-users@archiver.kernel.org>; Sat,  1 May 2021 22:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhEAWEq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 1 May 2021 18:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229912AbhEAWEq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 1 May 2021 18:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619906635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Js+GaB17CMiaTOtjm6gUVj7FN3DfTKpTGNOBnmvNMzg=;
        b=jLFezkvffYrG8gVbyVj63AA0/OSqtSTC0OeVyBGjKPep2zRugxk0LKtgiYDxAWCbNb7GpR
        pmUahds85nQXNsbIKN3ko9QtVsRbCplRv8Yo/wk+HdOIpOtVXoNr3nwSpdI+5GjFlbHybO
        v9Qk4Vy9u2y9TDnYErNSbwdIMBwp+XY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-zrr61oAkOaeaeyWmK0PJbg-1; Sat, 01 May 2021 18:03:53 -0400
X-MC-Unique: zrr61oAkOaeaeyWmK0PJbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF767801B20;
        Sat,  1 May 2021 22:03:51 +0000 (UTC)
Received: from ovpn-112-143.rdu2.redhat.com (ovpn-112-143.rdu2.redhat.com [10.10.112.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 634EB5D6AB;
        Sat,  1 May 2021 22:03:48 +0000 (UTC)
Message-ID: <7b796a085b0bc638c9df70d3a20718f8d1d776c8.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] newidle_balance() PREEMPT_RT latency mitigations
From:   Scott Wood <swood@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sat, 01 May 2021 17:03:47 -0500
In-Reply-To: <CAKfTPtBrJNBg3847R_b8A-1c5rb9Fb5FFNMX+z11QGAiO0ofkw@mail.gmail.com>
References: <20210428232821.2506201-1-swood@redhat.com>
         <CAKfTPtBrJNBg3847R_b8A-1c5rb9Fb5FFNMX+z11QGAiO0ofkw@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2021-04-29 at 09:12 +0200, Vincent Guittot wrote:
> Hi Scott,
> 
> On Thu, 29 Apr 2021 at 01:28, Scott Wood <swood@redhat.com> wrote:
> > These patches mitigate latency caused by newidle_balance() on large
> > systems when PREEMPT_RT is enabled, by enabling interrupts when the lock
> > is dropped, and exiting early at various points if an RT task is
> > runnable
> > on the current CPU.
> > 
> > On a system with 128 CPUs, these patches dropped latency (as measured by
> > a 12 hour rteval run) from 1045us to 317us (when applied to
> > 5.12.0-rc3-rt3).
> 
> The patch below has been queued for v5.13 and removed the update of
> blocked load what seemed to be the major reason for long preempt/irq
> off during newly idle balance:
> https://lore.kernel.org/lkml/20210224133007.28644-1-vincent.guittot@linaro.org/
> 
> I would be curious to see how it impacts your cases

I still get 1000+ ms latencies with those patches applied.

-Scott


