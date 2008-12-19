From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 0/7] 2.6.24.7-rt24 bugfixes
Date: Fri, 19 Dec 2008 16:02:28 -0000
Message-ID: <20081219155504.735865178@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Gregory Haskins <ghaskins@novell.com>,
	Linux-rt <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:48451 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbYLSQS3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Dec 2008 11:18:29 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The following patchset fixes a long standing wakeup bug and a state
printout problem in the tracer.

Thanks,

	tglx
-- 

