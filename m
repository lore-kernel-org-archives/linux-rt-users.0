From: Ankita Garg <ankita@in.ibm.com>
Subject: [RT] [PATCH 0/3] Few cleanups and RT updates to sched_debug
Date: Sun, 23 Mar 2008 20:20:29 +0530
Message-ID: <20080323145029.GB15554@in.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <ghaskins@novell.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP05.au.ibm.com ([202.81.18.174]:46473 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbYCWOui (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Mar 2008 10:50:38 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

The following 3 patches,

o Modify the names of several fields in the rt_rq, to be consistent
with the general naming convention. For eg, s/rt_nr_running/nr_running
in the rt_rq, 'rt' being implied by being associated with the rt_rq.

o Initialize rt.nr_running and rt.nr_uninterruptible fields explicitly.

o Update sched_debug to print values of the recently added fields to
rt_rq.

Some of these changes are not rt specific. But there are bits which are
missing from sched-devel latest, like rt_nr_uniterruptible, which is
added by preempt-realtime-sched.patch. I am not sure how to write
patches in this scenario. Pl do let me know if I need to generate patch
against the git tree instead, wherever possible.

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
