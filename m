Return-Path: <SRS0=pVaS=TG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C234C04A6B
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 May 2019 18:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0360320675
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 May 2019 18:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfEFSna convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 May 2019 14:43:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:12507 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfEFSna (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 May 2019 14:43:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 11:43:29 -0700
X-IronPort-AV: E=Sophos;i="5.60,439,1549958400"; 
   d="scan'208";a="148910114"
Received: from svkelley-mac10.jf.intel.com ([10.24.10.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 11:43:29 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Real-time micro-conference proposal for Linux Plumbers 2019
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
In-Reply-To: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
Date:   Mon, 6 May 2019 11:43:28 -0700
Cc:     linux-rt-users@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1CDDA8A3-356F-4B37-9E2E-5D17C49E6657@linux.intel.com>
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



> On May 2, 2019, at 11:53 PM, Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
> Hi all!
> 
> Last year we had a very fun and productive real-time micro-conference at the
> Linux Plumbers Conference, so the idea is to repeat it this year!
> 
> Are you interested in participating? Do you have any suggestion of topic? Let us
> know!
> 
> This is the current proposal of micro-conference, we can still edit it and add
> your thoughts.
> 
> ======================== PROPOSAL ==============================
> Since 2004 a project has improved the Real-time and low-latency features for
> Linux. This project has become know as PREEMPT_RT, formally the real-time patch.
> Over the past decade, many parts of the PREEMPT RT became part of the official
> Linux code base. Examples of what came from PREEMPT_RT include: Real-time
> mutexes, high-resolution timers, lockdep, ftrace, RT scheduling, SCHED_DEADLINE,
> RCU_PREEMPT, generic interrupts, priority inheritance futexes, threaded
> interrupt handlers and more. The number of patches that needs integration has
> been reduced on the last years, and the pieces left are now mature enough to
> make its way into mainline Linux. This year could possibly be the year
> PREEMPT_RT is merged (tm)!
> 
> In the final lap of this race, the last patches are on the way to be merged, but
> there are still some pieces missing. When the merge occurs, the preempt-rt will
> start to follow a new pace: the Linus one. So, it is possible to raise the
> following discussions:
> 
>  1) The status of the merge, and how can we resolve the last issues that block
> the merge;
>  2) How can we improve the testing of the -rt, to follow the problems raised as
> Linus tree advances;
>  3) What's next?
> 
> Possible topics:
>   - Status of the PREEMPT_RT Merge
> 
>   - Merge - what is missing and who can help?
> 
>   - How do we teach the rest of the kernel developers how not to break
>     PREEMPT_RT?
> 
>   - Stable maintainers tools discussion & improvements.
> 
>   - Interrupt threads are RT and are not protected by the RT Throttling.
>     How can we prevent interrupt thread starvation from a rogue RT task?
> 
>   - Improvements on full CPU isolation
> 
>   - Newer methods like proxy execution, hierarchical scheduler?
> 
>   - What tools can we add into tools/ that other kernel developers can use to
>     test and learn about PREEMMPT_RT?
> 
>   - What tests can we add into tools/testing/selftests?
> 
>   - New tools for timing regression test, e.g. locking, overheads...
> 
>   - What kernel boot self-tests can be added?
> 
>   - Discuss various types of failures that can happen with PREEMPT_RT
>     that normally would not happen in the vanilla kernel, e.g, with lockdep,
>     preemption model.


I’d definitely be interested in many of these topics at LPC.  Hoping to make it.

Thanks,

Sean


> 
> I will suggest the continuation of the discussions of the topics I presented
> last year, based in the results of the work I did this year (spoiler: I am doing
> model verification in the kernel, and it is very efficient!).
> 
> Paul already told that he could talk about ongoing work to make RCU's forward
> progress be more robust in overloaded cloud deployments. There will be some
> connection to real-time response involving rcu_poll and the infamous RCU kthread
> priority!
> 
> The continuation of the discussion of topics from last year's micro-conference,
> including the development done during this (almost) year, are also welcome!
> 
> -- Daniel

