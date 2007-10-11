From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/7] RT: (RFC) RT-Overload/Sched enhancements
Date: Thu, 11 Oct 2007 17:59:43 -0400
Message-ID: <20071011213916.27097.42597.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:45337
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754905AbXJKWNJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2007 18:13:09 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The current series applies to 23-rt1-pre1.

This is a snapshot of the current work-in-progress for the rt-overload
enhancements.  The primary motivation for the series to to improve the
algorithm for distributing RT tasks to keep the highest tasks active.  The
current system tends to blast IPIs "shotgun" style, and we aim to reduce that
overhead where possible.  We mitigate this behavior by trying to place tasks
on the ideal runqueue before an overload even occurs.

Note that this series is *not* currently stable.  There is at
least one bug resulting in a hard-lock.  And the hard-lock could be masking
other yet-to-be-discovered issues.

My primary motivation for sending it out right now is to share the latest
series with Peter Zijlstra and Steven Rostedt.  However, in the interest of
keeping the development open we are sending to a wider distribution.
Comments/suggestions from anyone are, of course, welcome.  But please note
this is not quite ready for prime-time in any capacity. 

The series includes patches from both Steven and myself, with serious
input/guidance/discussion from Peter.

Regards,
-Greg
