From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 4/9] RT: Initialize the priority value
Date: Wed, 17 Oct 2007 14:50:47 -0400
Message-ID: <20071017185047.11272.13579.stgit@novell1.haskins.net>
References: <20071017184745.11272.10024.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:53156
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760880AbXJQTEl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 15:04:41 -0400
In-Reply-To: <20071017184745.11272.10024.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We should init the base value of the current RQ priority to "IDLE"

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 131f618..d68f600 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -7385,6 +7385,8 @@ void __init sched_init(void)
 		highest_cpu = i;
 		/* delimiter for bitsearch: */
 		__set_bit(MAX_RT_PRIO, array->bitmap);
+
+		set_rq_prio(rq, MAX_PRIO);
 	}
 
 	set_load_weight(&init_task);
