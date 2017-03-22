From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH RT 1/1] remoteproc: Prevent schedule while atomic
Date: Wed, 22 Mar 2017 12:37:59 -0500
Message-ID: <20170322173759.GK10423@jcartwri.amer.corp.natinst.com>
References: <1490195923-9560-1-git-send-email-lionel.debieve@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bigeasy@linutronix.de>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>
To: Lionel Debieve <lionel.debieve@st.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:55529 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1759029AbdCVRiJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2017 13:38:09 -0400
Content-Disposition: inline
In-Reply-To: <1490195923-9560-1-git-send-email-lionel.debieve@st.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 22, 2017 at 04:18:43PM +0100, Lionel Debieve wrote:
> Use raw_spin_lock in enable/disable channel as it comes from
> interrupt context.
> 
> BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex.c:995
> in_atomic(): 1, irqs_disabled(): 128, pid: 307, name: pulseaudio
> Preemption disabled at:
> [<c01790fc>] __handle_domain_irq+0x4c/0xec
> CPU: 0 PID: 307 Comm: pulseaudio
> Hardware name: STi SoC with Flattened Device Tree
> [<c011046c>] (unwind_backtrace)
> [<c010c7f4>] (show_stack)
> [<c03d1578>] (dump_stack)
> [<c014e440>] (___might_sleep)
> [<c08e7f24>] (rt_spin_lock)
> [<c069bb04>] (sti_mbox_disable_channel)
> [<c069befc>] (sti_mbox_irq_handler)
> [<c0179900>] (__handle_irq_event_percpu)
> [<c01799dc>] (handle_irq_event_percpu)
> [<c0179a78>] (handle_irq_event)
> [<c017d1c8>] (handle_fasteoi_irq)
> [<c0178c08>] (generic_handle_irq)
> [<c017912c>] (__handle_domain_irq)
> [<c0101488>] (gic_handle_irq)

Which kernel were you testing on, here?  From what I can tell, this
should have been fixed with Thomas's commit:

   2a1d3ab8986d ("genirq: Handle force threading of irqs with primary and thread handler")

Which landed in 4.4.  It forces the primary handler to be threaded as
well.

   Julia
