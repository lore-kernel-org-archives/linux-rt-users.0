From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/7] RT: RT-Overload/Sched enhancements (v2)
Date: Fri, 12 Oct 2007 20:15:33 -0400
Message-ID: <20071013001052.7444.8363.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:33462
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751983AbXJMA27 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Oct 2007 20:28:59 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This series applies to 2.6.23-rt1 + Steven Rostedt's last published "push-rt"
patch.

Changes since v1:

- Rebased to the final 23-rt1 from 23-rt1-pre1
- Rebased to Steve's last published patch
- Removed controversial "cpupri" algorithm (may revisit later, drop for now)
- Fixed a missing priority update in the set_user_nice() code
- Added experimental "phase 3" patch for limiting pulls to when necessary

Comments/suggestions/feedback are all welcome.

Regards,
-Greg 
