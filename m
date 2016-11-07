From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 14:47:38 -0500
Message-ID: <20161107144738.4811a5dd@gandalf.local.home>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
        <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org>
        <20161107133207.4282de69@gandalf.local.home>
        <alpine.DEB.2.20.1611071328470.19249@east.gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:54595 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751736AbcKGTui (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Nov 2016 14:50:38 -0500
In-Reply-To: <alpine.DEB.2.20.1611071328470.19249@east.gentwo.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 7 Nov 2016 13:30:15 -0600 (CST)
Christoph Lameter <cl@linux.com> wrote:

> SCHED_RR tasks alternately running on on cpu can cause endless deferral of
> kworker threads. With the global effect of the OS processing reserved
> it may be the case that the processor we are executing never gets any
> time. And if that kworker threads role is releasing a mutex (like the
> cgroup_lock) then deadlocks can result.

I believe SCHED_RR tasks will still throttle if they use up too much of
the CPU. But I still don't see how this patch helps your situation.

-- Steve


