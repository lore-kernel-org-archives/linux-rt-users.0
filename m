From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] RT: Cache cpus_allowed weight for optimizing migration
Date: Fri, 26 Oct 2007 12:30:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710261228040.4130@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0710261114270.3280@gandalf.stny.rr.com>
 <20071026154625.6195.36378.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42454 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbXJZQbu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Oct 2007 12:31:50 -0400
In-Reply-To: <20071026154625.6195.36378.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


I forgot to tell you this the last time. You need to add:

---
 include/linux/init_task.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.23-rt3/include/linux/init_task.h
===================================================================
--- linux-2.6.23-rt3.orig/include/linux/init_task.h
+++ linux-2.6.23-rt3/include/linux/init_task.h
@@ -142,6 +142,7 @@ extern struct group_info init_groups;
 	.policy		= SCHED_NORMAL,					\
 	INIT_RCU_BOOST_PRIO						\
 	.cpus_allowed	= CPU_MASK_ALL,					\
+	.nr_cpus_allowed = NR_CPUS,					\
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\

-- Steve
