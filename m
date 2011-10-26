From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 0/1] Incorrect name of the idle tasks in SMP kernels v3
Date: Wed, 26 Oct 2011 23:14:15 +0200
Message-ID: <20111026211415.787299186@osadl.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <C.Emde@osadl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:59414 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab1JZVjc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Oct 2011 17:39:32 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo,

The command name of the idle tasks in SMP kernels was incorrect which
resulted in misleading trace output. This patch fixes it.

	-Carsten.
