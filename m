From: Ankita Garg <ankita@in.ibm.com>
Subject: Re: 2.6.24.7-rt18
Date: Wed, 10 Sep 2008 11:36:24 +0530
Message-ID: <20080910060624.GA7484@in.ibm.com>
References: <1221018283.22713.20.camel@localhost.localdomain>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([59.145.155.7]:54881 "EHLO
	e28esmtp07.in.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750859AbYIJGHH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Sep 2008 02:07:07 -0400
Content-Disposition: inline
In-Reply-To: <1221018283.22713.20.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven,

On Tue, Sep 09, 2008 at 11:44:42PM -0400, Steven Rostedt wrote:
> We are pleased to announce the 2.6.24.7-rt18 tree, which can be
> downloaded from the location:
> 
>   http://rt.et.redhat.com/download/
> 
> Information on the RT patch can be found at:
> 
>   http://rt.wiki.kernel.org/index.php/Main_Page
> 
> Changes since 2.6.24.7-rt17
> 
>   - seqlock serialize writes (Gregory Haskins)
> 
>   - Fix above patch that broke non PREEMPT_RT (Steven Rostedt)
> 
>   - Add sysctl to warn on RT task using non PI futex (Steven Rostedt)
>

A trivial patch to remove the hard coded value of MAX_RT_PRIO in the
above patch.
 
Signed-off-by: Ankita Garg <ankita@in.ibm.com> 

Index: linux-2.6.26.5/kernel/futex.c
===================================================================
--- linux-2.6.26.5.orig/kernel/futex.c	2008-09-09 22:58:19.000000000 -0700
+++ linux-2.6.26.5/kernel/futex.c	2008-09-09 22:58:38.000000000 -0700
@@ -1241,7 +1241,7 @@
 			       "RT task %s:%d with priority %d"
 			       " using non PI futex\n",
 			       current->comm, current->pid,
-			       100 - current->prio);
+			       MAX_RT_PRIO - current->prio);
 		}
 	}
 
-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
