Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85112C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 18:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350499AbhKXSG4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:06:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350225AbhKXSGi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 13:06:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E61E61053;
        Wed, 24 Nov 2021 18:03:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpwcB-0027tD-5G;
        Wed, 24 Nov 2021 13:03:27 -0500
Message-ID: <20211124180326.998091329@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Nov 2021 13:03:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH RT 05/13] mm: Disable NUMA_BALANCING_DEFAULT_ENABLED and TRANSPARENT_HUGEPAGE
 on PREEMPT_RT
References: <20211124180303.574562279@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.10.78-rt56-rc3 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

TRANSPARENT_HUGEPAGE:
There are potential non-deterministic delays to an RT thread if a critical
memory region is not THP-aligned and a non-RT buffer is located in the same
hugepage-aligned region. It's also possible for an unrelated thread to migrate
pages belonging to an RT task incurring unexpected page faults due to memory
defragmentation even if khugepaged is disabled.

Regular HUGEPAGEs are not affected by this can be used.

NUMA_BALANCING:
There is a non-deterministic delay to mark PTEs PROT_NONE to gather NUMA fault
samples, increased page faults of regions even if mlocked and non-deterministic
delays when migrating pages.

[Mel Gorman worded 99% of the commit description].

Link: https://lore.kernel.org/all/20200304091159.GN3818@techsingularity.net/
Link: https://lore.kernel.org/all/20211026165100.ahz5bkx44lrrw5pt@linutronix.de/
Cc: stable-rt@vger.kernel.org
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20211028143327.hfbxjze7palrpfgp@linutronix.de
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 7ba2b602b707..9bfc60e7eead 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -861,7 +861,7 @@ config NUMA_BALANCING
 	bool "Memory placement aware NUMA scheduler"
 	depends on ARCH_SUPPORTS_NUMA_BALANCING
 	depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
-	depends on SMP && NUMA && MIGRATION
+	depends on SMP && NUMA && MIGRATION && !PREEMPT_RT
 	help
 	  This option adds support for automatic NUMA aware memory/task placement.
 	  The mechanism is quite primitive and is based on migrating memory when
-- 
2.33.0
