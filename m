From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: [PATCH] ftrace: Actually call function pointer in ftrace_stop
Date: Tue, 15 Jul 2008 08:09:29 -0700
Message-ID: <1216134569.1014.1.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51344 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbYGOPJ2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Jul 2008 11:09:28 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6FF9RGD020502
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Jul 2008 11:09:27 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m6FF9Rwi205166
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Jul 2008 11:09:27 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m6FF9Qs1026887
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Jul 2008 11:09:27 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

ftrace_stop used a function pointed as a no-op expression, rather than
actually calling it.

Signed-off-by: Josh Triplett <josh@kernel.org>
---
 kernel/trace/trace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0a38f84..5f7f421 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3283,7 +3283,7 @@ void ftrace_stop(void)
 	if (tr->ctrl) {
 		tr->ctrl = 0;
 		if (saved_tracer && saved_tracer->ctrl_update)
-			saved_tracer->ctrl_update;
+			saved_tracer->ctrl_update(tr);
 	}
 

-- 
1.5.6.2


