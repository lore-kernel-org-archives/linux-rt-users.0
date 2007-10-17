From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/9] RT: RT-Overload/Sched enhancements v4
Date: Wed, 17 Oct 2007 14:50:27 -0400
Message-ID: <20071017184745.11272.10024.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:53130
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756760AbXJQTE2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 15:04:28 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Applies to 23-rt1 + Steve's latest push_rt patch

Changes since v3:

1) Rebased to Steve's latest
2) Added a "highest_prio" feature to eliminate a race w.r.t. activating a task
   and the time it takes to actually reschedule the RQ.
3) Dropped the PI patch, because the highest_prio patch obsoletes it.
4) Few small tweaks
5) Few small fixes

Regards,
-Greg
