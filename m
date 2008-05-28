From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/3] sched: misc sched-devel fixes for PREEMPT_RT
Date: Tue, 27 May 2008 18:59:29 -0600
Message-ID: <20080528005647.4146.13252.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lsg.lsg.lab.novell.com ([151.155.230.1]:3889 "EHLO
	lsg.lsg.lab.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbYE1B1u (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 May 2008 21:27:50 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven,
   The following series are patches that have been accepted by Ingo in
   sched-devel post 2.6.25.  They probably should be considered for the
   next RT release as well.  The series applies to 25.4-rt3.

Regards,
-Greg
