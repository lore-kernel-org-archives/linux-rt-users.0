From: Darren Hart <dvhltc@linux.vnet.ibm.com>
Subject: Using CONFIG_FUNCTION_TRACE
Date: Thu, 13 Dec 2007 22:11:22 -0800
Message-ID: <200712132211.23003.dvhltc@linux.vnet.ibm.com>
Reply-To: Darren Hart <dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "lkml, " <linux-kernel@vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:41636 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbXLNGLY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Dec 2007 01:11:24 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I was trying to use CONFIG_FUNCTION_TRACE with the example trace-it.c in 
linux/scripts.  On both 2.6.23.9-rt13 and 2.6.24-rc2-rt1 the system 
slower becomes less responsive (measured by typing in ssh and a serial 
console) until after a couple minutes it doesn't respond to anything 
including sysrq, requiring a power cycle.

The trace-it.c program defaults to 10 seconds of tracing, I even tried 
dropping that to 100 us in case it just added so much overhead that 10 
seconds of idle turned into minutes.  But the 100us sleep hung too.

I tested on a 4 way (2x2) opteron.  

I enabled:

CONFIG_EVENT_TRACE
CONFIG_FUNCTION_TRACE

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
