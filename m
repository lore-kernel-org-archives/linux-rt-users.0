From: Stanislav Meduna <stano@meduna.org>
Subject: Re: timerfd read does not return - caused by MM fault
Date: Mon, 13 May 2013 10:05:02 +0200
Message-ID: <51909EAE.8070901@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org> <517B8D91.4010700@meduna.org> <518CEB45.9080705@meduna.org> <519023C0.2030603@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:53115 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab3EMIFO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 May 2013 04:05:14 -0400
In-Reply-To: <519023C0.2030603@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 13.05.2013 01:20, Stanislav Meduna wrote:

> So it looks like the problem happens inside the put_user,
> maybe a pagefault? The buf is an address on the stack:

Yep, this is a page fault. I added tracing of the
  mm_fault_error
  handle_mm_fault
  handle_pte_fault
  do_page_fault
functions


The result is

0....0 62811.755379: bprint:    timerfd_read: timerfd_read after unlock, res=0
0d...0 62811.755382: function:  do_page_fault
0....0 62811.755386: function:     handle_mm_fault
0....0 62811.755389: function:        handle_pte_fault
0d...0 62811.755394: function:  do_page_fault
0....0 62811.755396: function:     handle_mm_fault
0....0 62811.755398: function:        handle_pte_fault
0d...0 62811.755402: function:  do_page_fault
0....0 62811.755404: function:     handle_mm_fault
0....0 62811.755406: function:        handle_pte_fault


> Viewing the ps -o min_flt,maj_flt for the task shows 969701
> minor faults (that do not increment - I will check this when
> the hang happens again) and 0 major ones.

The number of minor faults of the thread jumped to 1433400 and
the process recovered after 2.77 seconds.

The trace file is at
  http://www.meduna.org/tmp/trace.mmfaulthang.dat.gz

Thanks
-- 
                                        Stano

