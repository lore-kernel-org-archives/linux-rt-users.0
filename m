Return-Path: <SRS0=sFXS=XG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24585C49ED6
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Sep 2019 16:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0083020872
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Sep 2019 16:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfIKQ5g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfIKQ5g (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Sep 2019 12:57:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 181183082B45;
        Wed, 11 Sep 2019 16:57:36 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-113.phx2.redhat.com [10.3.117.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D45860BEC;
        Wed, 11 Sep 2019 16:57:30 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH RT v3 0/5] RCU fixes
Date:   Wed, 11 Sep 2019 17:57:24 +0100
Message-Id: <20190911165729.11178-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 11 Sep 2019 16:57:36 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

With these patches, rcutorture works on PREEMPT_RT_FULL.

Scott Wood (5):
  rcu: Acquire RCU lock when disabling BHs
  sched: Rename sleeping_lock to rt_invol_sleep
  sched: migrate_dis/enable: Use rt_invol_sleep
  rcu: Disable use_softirq on PREEMPT_RT
  rcutorture: Avoid problematic critical section nesting

 include/linux/rcupdate.h   | 40 +++++++++++++++----
 include/linux/sched.h      | 19 ++++-----
 kernel/cpu.c               |  2 +
 kernel/locking/rtmutex.c   | 14 +++----
 kernel/locking/rwlock-rt.c | 16 ++++----
 kernel/rcu/rcutorture.c    | 96 +++++++++++++++++++++++++++++++++++++++-------
 kernel/rcu/tree.c          |  9 ++++-
 kernel/rcu/tree_plugin.h   |  8 ++--
 kernel/sched/core.c        |  4 ++
 kernel/softirq.c           | 14 +++++--
 kernel/time/hrtimer.c      |  4 +-
 11 files changed, 168 insertions(+), 58 deletions(-)

-- 
1.8.3.1

