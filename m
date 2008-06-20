From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: locking_selftest triggers WARN_ON by exceeding MAX_RWLOCK_DEPTH
Date: Fri, 20 Jun 2008 16:42:39 -0700
Message-ID: <1214005359.10102.26.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:36463 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858AbYFTXmn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Jun 2008 19:42:43 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5KNgg46013416
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Jun 2008 19:42:42 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5KNgfVU169718
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Jun 2008 17:42:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5KNgfCv010865
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Jun 2008 17:42:41 -0600
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The new multiple-reader rtmutex code keeps an array of =EF=BB=BFMAX_RWL=
OCK_DEPTH
read-lock owners in task_struct.  As described in the original patch:

> =EF=BB=BFThe max depth is currently set to 5. A task may own the same=
 lock
> multiple times for read without affecting this limit. It is bad
> programming practice to hold more than 5 different locks for read at
> the same time anyway so this should not be a problem. The 5 lock limi=
t
> should be way more than enough."

However, CONFIG_DEBUG_LOCKING_API_SELFTESTS includes tests which
intentionally use locks incorrectly, and in particular it locks without
unlocking.  This quickly reaches the 5 lock limit.  AA_rlock locks twic=
e
without unlocking, AA_rsem locks twice more without unlocking, and
ABBA_rlock locks twice more before it unlocks; this nests read locks si=
x
deep, triggering the WARN_ON.

Given that =EF=BB=BF=EF=BB=BFCONFIG_DEBUG_LOCKING_API_SELFTESTS exists =
to use locks
incorrectly, I don't think this necessarily needs fixing.  However,
perhaps locking_selftest should print a big warning in advance if run
without lockdep turned on, saying to expect locking-related
warnings/bugs/panics?

- Josh Triplett


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
