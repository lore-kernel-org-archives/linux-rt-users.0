From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/4] RT: RT-Overload/Sched v3
Date: Tue, 16 Oct 2007 12:08:52 -0400
Message-ID: <20071016160226.5202.53965.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:43754
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750754AbXJPQWq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Oct 2007 12:22:46 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

v3 contains the following changes since v2:

This is still based on 23-rt1 + Steve's last public patch (I think Steve has a
newer version available, but we have not rebased yet).

1) No longer includes the per-cpu-rtoverload patch, since Steve has already
   ACKed it
2) Dropped the affinity patch because it was buggy.  Will revisit later
3) Dropped the pull-patch, since it was RFC only anyway.  Will revisit later
4) Addressed review comments/feedback (added patch descriptions across the
   board, moved semi-colon in while loop, removed superfluous
   smp_processor_id() etc.
5) Got rid of the second TASK_PREEMPTS_CURR() check, since my anaylsys
   determined it was not needed.

With this patch series applied, my RT test now passes and we get an average of
23us wake-up latency under load. You can find the test here: 

 ftp://ftp.novell.com/dev/ghaskins/preempt.cc

Note: Do not use the "affinity" option, as the validator has a bug related to
it and may yield a false negative.

Regards,
-Greg
