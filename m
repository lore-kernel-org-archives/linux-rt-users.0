From: Darren Hart <dvhltc@us.ibm.com>
Subject: [PATCH 0/2] futex: requeue_pi lock steal deadlock fixes
Date: Wed, 05 Aug 2009 14:58:54 -0700
Message-ID: <4A7A009E.2000202@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
	mingo@elte.hu, dino@in.ibm.com, johnstul@us.ibm.com
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43905 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517AbZHEV65 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Aug 2009 17:58:57 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[resend: quilt mail wasn't making it to the lists for some reason]

The following patch series addresses a deadlock and a race related to the
newly introduced requeue_pi futex op codes.  I discovered this while running
I modified version of pthread_cond_many from ltp/testcases/realtime (with a PI
aware mutex) and a patched glibc (for new futex op codes).  These patches fix
the deadlock and close the race window considerably - but not 100%.  My test
case, however, now runs to completion without deadlock, and without triggering
the pi_state related WARN_ON()'s.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team

