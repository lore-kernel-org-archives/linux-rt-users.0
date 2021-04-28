Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A3C433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Apr 2021 23:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A358261448
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Apr 2021 23:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhD1X3Q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 19:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229762AbhD1X3Q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Apr 2021 19:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619652510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MuW0xYh/Nimc7uonYeav+hC40VrHc8klYXZp4hIjqOY=;
        b=XqDbt8BjlL8BT8bDQabvq9+HrnIXmYANePX1ye15jYKMckWq237Rd4kK09oHa0Ei/uu2N2
        I8VsjXjUklzlLAXotvpeUf2BiqTZKogKeEOyQ2ZroquNiF5btC8FKrkJtPHmUYrZVs4PM5
        Z5M7iclunHH4gMu/lNAj8VEZ1ZsKN3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-G1Uom4KsO9CYVasR7DM-oQ-1; Wed, 28 Apr 2021 19:28:26 -0400
X-MC-Unique: G1Uom4KsO9CYVasR7DM-oQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBA93CC621;
        Wed, 28 Apr 2021 23:28:24 +0000 (UTC)
Received: from p1g2.redhat.com (ovpn-114-20.rdu2.redhat.com [10.10.114.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2A2361094;
        Wed, 28 Apr 2021 23:28:22 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/3] newidle_balance() PREEMPT_RT latency mitigations
Date:   Wed, 28 Apr 2021 18:28:18 -0500
Message-Id: <20210428232821.2506201-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

These patches mitigate latency caused by newidle_balance() on large
systems when PREEMPT_RT is enabled, by enabling interrupts when the lock
is dropped, and exiting early at various points if an RT task is runnable
on the current CPU.

On a system with 128 CPUs, these patches dropped latency (as measured by
a 12 hour rteval run) from 1045us to 317us (when applied to
5.12.0-rc3-rt3).

I tried a couple scheduler benchmarks (perf bench sched pipe, and
sysbench threads) to try to determine whether the overhead is measurable
on non-RT, but the results varied widely enough (with or without the patches)
that I couldn't draw any conclusions from them.  So at least for now, I
limited the balance callback change to when PREEMPT_RT is enabled.

Link to v1 RFC patches:
https://lore.kernel.org/lkml/20200428050242.17717-1-swood@redhat.com/

Scott Wood (3):
  sched/fair: Call newidle_balance() from balance_callback on PREEMPT_RT
  sched/fair: Enable interrupts when dropping lock in newidle_balance()
  sched/fair: break out of newidle balancing if an RT task appears

 kernel/sched/fair.c  | 66 ++++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |  6 ++++
 2 files changed, 64 insertions(+), 8 deletions(-)

-- 
2.27.0

