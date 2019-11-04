Return-Path: <SRS0=3uTX=Y4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBACA9EB5
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Nov 2019 15:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251B02080F
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Nov 2019 15:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDP3e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:29:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37701 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDP3d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Nov 2019 10:29:33 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iReIN-0000JE-A3; Mon, 04 Nov 2019 16:29:31 +0100
Date:   Mon, 4 Nov 2019 16:29:31 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-rt-users@vger.kernel.org, tglx@linutronix.de
Subject: Re: rcu stalls with pi_stress in latest rt
Message-ID: <20191104152931.dzdhn3wwilohlttc@linutronix.de>
References: <20191028182258.76o6qnbgmzm525ff@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191028182258.76o6qnbgmzm525ff@linux-p48b>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-10-28 11:22:58 [-0700], Davidlohr Bueso wrote:
> Hi,
Hi,

> I've been running into rcu self-stalls as soon as I start running
> the pi_stress program on a v5.2.21-rt13 kernel - I've seen it on
> older rt 5.2 versions as well so it's not specific to 954ad80c23e
> (futex: Make the futex_hash_bucket spinlock_t again and bring back
> its old state), for example.
> 
> No other workload is running on the machine. The workload does not
> crash, but incurs in very long response times.
> 
> I'm attaching two different splats I'm seeing for the futex wait
> and wake paths. Does this ring any bells?

On 8-CPU system here I have:
|Starting PI Stress Test
|Number of thread groups: 7
|Duration of test run: infinite
|Number of inversions per group: unlimited
|     Admin thread SCHED_FIFO priority 4
|7 groups of 3 threads will be created
|      High thread SCHED_FIFO priority 3
|       Med thread SCHED_FIFO priority 2
|       Low thread SCHED_FIFO priority 1
|Current Inversions: 199678139

without any RCU-stalls. The system is slow but then the test kind of
asked for it… I see *only* the workqueue stalls which is hardly any news
since the system is busy on almost every CPU with RT tasks and the
workqueue is not of RT prio so, yes.
That means you might not have RCU-boost enabled.

CPU0 goes sometimes idle and hardly has any RT-task. CPU1-7 almost never
see idle and are busy scheduling/running RT-tasks.

> Thanks,
> Davidlohr

Sebastian
