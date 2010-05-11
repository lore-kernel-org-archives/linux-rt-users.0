From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Real-time projects that could use userspace RCU
Date: Tue, 11 May 2010 08:21:40 -0400
Message-ID: <20100511122140.GA11000@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:47191 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751811Ab0EKMVo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 May 2010 08:21:44 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

Paul told me you were quite interested in the userspace RCU library when he told
you about it (http://lttng.org/urcu). Do you have some userspace applications or
libraries with real-time needs in mind that could use it ? We could help moving
them to liburcu. The wait-free read-side is, as you certainly know, a
characteristic of RCU that can be very useful to RT applications.

[CCing linux-rt-users, as it seems appropriate to ask them too.]

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
