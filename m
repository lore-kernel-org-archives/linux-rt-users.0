From: Stanislav Meduna <stano@meduna.org>
Subject: Livelock in handle_pte_fault [Was: Re: timerfd read does not return]
Date: Tue, 14 May 2013 10:31:09 +0200
Message-ID: <5191F64D.2050509@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org> <517B8D91.4010700@meduna.org> <518CEB45.9080705@meduna.org> <519023C0.2030603@meduna.org> <51909EAE.8070901@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:43977 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756600Ab3ENIbU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 May 2013 04:31:20 -0400
In-Reply-To: <51909EAE.8070901@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 13.05.2013 10:05, Stanislav Meduna wrote:

> 0d...0 62811.755394: function:  do_page_fault
> 0....0 62811.755396: function:     handle_mm_fault
> 0....0 62811.755398: function:        handle_pte_fault
> 0d...0 62811.755402: function:  do_page_fault
> 0....0 62811.755404: function:     handle_mm_fault
> 0....0 62811.755406: function:        handle_pte_fault

The flags in the pagefault handler are 0x28 - if I understand
it correctly, FAULT_FLAG_KILLABLE | FAULT_FLAG_ALLOW_RETRY.
The faulting address is indeed the one from stack that worked
for hours before, is mlockall()-ed and I have (of course)
no swap. I will add some code to print the content of
the offending pte.

The code in handle_pte_fault proceeds through the
  entry = pte_mkyoung(entry);
line and the following
  ptep_set_access_flags
returns zero. This repeats ad nauseum without anything run
in between. I will add some tracing prints to output
the content of the pte.

Adding flush_tlb_page(vma, address) at the beginning of
handle_pte_fault does not change anything.

The length of the hang could correlate with the time until
some SCHED_OTHER process is scheduled after the RT throttler
activates. There is a process running each 2 seconds and the
length of the hang is usually between 1 and 3 seconds. This
is not (yet) verified.

I am starting to think that the virtual memory mapping of the
process got somehow corrupted and is fixed at the next regular
context switch. There is no switch to other non-kernel process,
only to ksoftirqd, irq threads or other thread of the
same process afterwards. Shortly before there was some
switching between modprobe and kworker and sched_process_free
of kworker and modprobe in the RCU softirq.

The symptoms are similar to
http://lkml.indiana.edu/hypermail/linux/kernel/1103.0/01364.html

Regards
-- 
                                            Stano

