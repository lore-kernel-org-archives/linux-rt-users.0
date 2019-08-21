Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46537C3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 23:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E702332A
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 23:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfHUXTK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:19:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfHUXTK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 19:19:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4072A10F23E1;
        Wed, 21 Aug 2019 23:19:10 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D942660126;
        Wed, 21 Aug 2019 23:19:06 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH RT v2 0/3] RCU fixes
Date:   Wed, 21 Aug 2019 18:19:03 -0500
Message-Id: <20190821231906.4224-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Wed, 21 Aug 2019 23:19:10 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is a respin of the "Address rcutorture issues" patchset,
minus the actual rcutorture changes.

I still plan to implement detection of bad nesting scenarios, but it's
complicated by the need to distinguish (on a non-RT kernel) between
irq/preempt disabling that would and would not happen on an RT kernel
(which would also have the benefit of being able to detect nesting
regular spinlocks inside raw spinlocks on a non-RT debug kernel).  In
the meantime I could send the rcutorture changes as a PREEMPT_RT only
patch, though the extent of the changes depends on whether my migrate
disable patchset is applied since it removes a restriction.

Scott Wood (3):
  rcu: Acquire RCU lock when disabling BHs
  sched: migrate_enable: Use sleeping_lock to indicate involuntary sleep
  rcu: Disable use_softirq on PREEMPT_RT

 include/linux/rcupdate.h |  4 ++++
 include/linux/sched.h    |  4 ++--
 kernel/rcu/tree.c        |  9 ++++++++-
 kernel/rcu/tree_plugin.h |  2 +-
 kernel/rcu/update.c      |  4 ++++
 kernel/sched/core.c      |  8 ++++++++
 kernel/softirq.c         | 12 +++++++++---
 7 files changed, 36 insertions(+), 7 deletions(-)

-- 
1.8.3.1

