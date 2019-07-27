Return-Path: <SRS0=S77f=VY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DA5C7618B
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Jul 2019 05:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDD420869
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Jul 2019 05:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfG0F4o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Jul 2019 01:56:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfG0F4o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Jul 2019 01:56:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6150836899;
        Sat, 27 Jul 2019 05:56:44 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-116-73.phx2.redhat.com [10.3.116.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AA6819C71;
        Sat, 27 Jul 2019 05:56:38 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RT PATCH 0/8] migrate disable fixes and performance
Date:   Sat, 27 Jul 2019 00:56:30 -0500
Message-Id: <20190727055638.20443-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 27 Jul 2019 05:56:44 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

With these patches, a kernel build on a 104-cpu machine took around 75%
less wall time and 85% less system time.  Note that there is a difference
in v5.2-rt compared to v5.0-rt.  The performance with these patches is
similar in both cases, but without these patches v5.2-rt is substantially
slower.  In v5.0-rt with a previous version of these patches, lazy
migrate disable reduced kernel build time by around 15-20% wall and
70-75% system.

Scott Wood (8):
  sched: migrate_enable: Use sleeping_lock to indicate involuntary sleep
  sched: __set_cpus_allowed_ptr: Check cpus_mask, not cpus_ptr
  sched: Remove dead __migrate_disabled() check
  sched: migrate disable: Protect cpus_ptr with lock
  sched/deadline: Reclaim cpuset bandwidth in .migrate_task_rq()
  sched: migrate_enable: Set state to TASK_RUNNING
  sched: migrate_enable: Use select_fallback_rq()
  sched: Lazy migrate_disable processing

 include/linux/cpu.h      |   4 -
 include/linux/sched.h    |  15 ++--
 init/init_task.c         |   4 +
 kernel/cpu.c             |  97 ++++++++---------------
 kernel/rcu/tree_plugin.h |   2 +-
 kernel/sched/core.c      | 200 +++++++++++++++++++----------------------------
 kernel/sched/deadline.c  |  67 ++++++++--------
 kernel/sched/sched.h     |   4 +
 lib/smp_processor_id.c   |   3 +
 9 files changed, 166 insertions(+), 230 deletions(-)

-- 
1.8.3.1

