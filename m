From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/2] sched: hotplug and cpupri fixes (v2)
Date: Wed, 04 Jun 2008 15:03:59 -0400
Message-ID: <20080604185838.5108.54912.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutonix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 66-189-124-104.dhcp.oxfr.ma.charter.com ([66.189.124.104]:40155
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756112AbYFDTgN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Jun 2008 15:36:13 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo, Steven, Thomas, et. al.

The first patch is a refresh on the hotplug patch I sent last night:

http://lkml.org/lkml/2008/6/3/490

I incorporated most of Peter's review comments.  I skipped the
update_sched_domains() suggestion for now since I think there might be
some unrelated issues with that code that I didn't want to get into
(yet, anyway).

The second patch is something that Peter found while reviewing cpupri
as part of this investigation.

This series applies to 25.4-rt4, and as before it affects any cpupri enabled
kernels (later 23-rt, 24-rt, 25-rt, sched-devel, linux-next, and any
derivatives of such).  If you need a version of the patches for any of those,
let me know (though I anticipate they will merge trivially).

Comments/bug-fixes welcome!

Regards,
-Greg
