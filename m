Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C79C35666
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22403208C4
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320400;
	bh=46wTLqTtOUL+47Ba5LeJsq9AVdB7uqJCADIyE7DVbo0=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=qDQ09lFsG9AT/tBhDfFJj7ybzyTlgRAy5/5ov5txx+4k3ey9TY5BNewR6HKFbw9jt
	 fJodKJlJLb+68KAL2W6q9Js+IFKxhDgGB7RHEV0mKY48w67uSiwCaLSqzVm9E+k31i
	 U7trqlXAz9SnmyYDqvUy0Zplpq0flLqDEyPee4Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgBUV0e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:26:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbgBUVZZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:25 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43D8D207FD;
        Fri, 21 Feb 2020 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320325;
        bh=46wTLqTtOUL+47Ba5LeJsq9AVdB7uqJCADIyE7DVbo0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=eTf/aGjylq0z/O4zw2ek3xatRDHmMkbqqAIDpbfF6oIaGo74rJ+Qq90cULAgqvg1P
         f4PC0jmTHqbwfvSma/+ntZp4ewVB+/f+Pm3ZGwNA4vQCq+2dhbM4cMvK7zMNUDoWBi
         E/7/CJxJ5op2XoIUAZ99xgRx9FHS4kSSnETkEqnI=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 10/25] lib/smp_processor_id: Don't use cpumask_equal()
Date:   Fri, 21 Feb 2020 15:24:38 -0600
Message-Id: <369ed4fc17c81f4dddf50babcc39b07a5be7d741.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Waiman Long <longman@redhat.com>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 659252061477862f45b79e1de169e6030f5c8918 ]

The check_preemption_disabled() function uses cpumask_equal() to see
if the task is bounded to the current CPU only. cpumask_equal() calls
memcmp() to do the comparison. As x86 doesn't have __HAVE_ARCH_MEMCMP,
the slow memcmp() function in lib/string.c is used.

On a RT kernel that call check_preemption_disabled() very frequently,
below is the perf-record output of a certain microbenchmark:

  42.75%  2.45%  testpmd [kernel.kallsyms] [k] check_preemption_disabled
  40.01% 39.97%  testpmd [kernel.kallsyms] [k] memcmp

We should avoid calling memcmp() in performance critical path. So the
cpumask_equal() call is now replaced with an equivalent simpler check.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 lib/smp_processor_id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 6f4a4ae881c8..9f3c8bb62e57 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,7 +23,7 @@ notrace static unsigned int check_preemption_disabled(const char *what1,
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
-	if (cpumask_equal(current->cpus_ptr, cpumask_of(this_cpu)))
+	if (current->nr_cpus_allowed == 1)
 		goto out;
 
 	/*
-- 
2.14.1

