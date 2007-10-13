From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 3/7] RT: Initialize the priority value
Date: Fri, 12 Oct 2007 20:15:49 -0400
Message-ID: <20071013001549.7444.81409.stgit@novell1.haskins.net>
References: <20071013001052.7444.8363.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:33483
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760036AbXJMA3K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Oct 2007 20:29:10 -0400
In-Reply-To: <20071013001052.7444.8363.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index c9afc8a..50c88e8 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -7395,6 +7395,8 @@ void __init sched_init(void)
 		highest_cpu = i;
 		/* delimiter for bitsearch: */
 		__set_bit(MAX_RT_PRIO, array->bitmap);
+
+		set_rq_prio(rq, MAX_PRIO);
 	}
 
 	set_load_weight(&init_task);
