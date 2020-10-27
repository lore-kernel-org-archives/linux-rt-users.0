Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE7DC4363A
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 10:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0597B22264
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 10:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898455AbgJ0KgA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 06:36:00 -0400
Received: from mail.monom.org ([188.138.9.77]:54478 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898415AbgJ0KeO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 06:34:14 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C727C50046C;
        Tue, 27 Oct 2020 11:34:11 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 65E70500299;
        Tue, 27 Oct 2020 11:34:11 +0100 (CET)
Date:   Tue, 27 Oct 2020 11:34:11 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] v5.9.1-rt19
Message-ID: <20201027103411.h5ushvwsrovxls5u@beryllium.lan>
References: <20201024091838.gzhn2dlx2j7xnixg@linutronix.de>
 <20201027093616.5vn6xinmthxulhvx@beryllium.lan>
 <20201027100049.xtkmjqdwkn7zec2f@linutronix.de>
 <20201027102547.y6wop7j2ovzg2tyx@beryllium.lan>
 <20201027102851.gizepjlu4opensqb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027102851.gizepjlu4opensqb@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Oct 27, 2020 at 11:28:51AM +0100, Sebastian Andrzej Siewior wrote:
> Is it running as a RT task?

root@c2d:~/rt-tests# ./pi_stress
Starting PI Stress Test
Number of thread groups: 1
Duration of test run: infinite
Number of inversions per group: unlimited
     Admin thread SCHED_FIFO priority 4
1 groups of 3 threads will be created
      High thread SCHED_FIFO priority 3
       Med thread SCHED_FIFO priority 2
       Low thread SCHED_FIFO priority 1

It says so, let me double check if those task really run with SCHED_FIFO.

> Do you have RCU-boosting enabled?

Yes

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
CONFIG_RCU_NOCB_CPU=y
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

> Otherwise it looks that if you throw enough non-RT load on the system,
> RCU can not catch up which does not sound good.

I think this is what Clark tried to tell me. If I understood him
correctly the test tool is not correct though.
