From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 13:30:46 -0500
Message-ID: <20161107133046.7e4458c1@gandalf.local.home>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
        <20161107122221.299d026a@tagon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:40729 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932846AbcKGSau (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Nov 2016 13:30:50 -0500
In-Reply-To: <20161107122221.299d026a@tagon>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 7 Nov 2016 12:22:21 -0600
Clark Williams <williams@redhat.com> wrote:

> I'm still reviewing the patch, but I have to wonder why bother with making it a scheduler feature?
> 
> The SCHED_FIFO definition allows a fifo thread to starve others
> because a fifo task will run until it yields. Throttling was added as
> a safety valve to allow starved SCHED_OTHER tasks to get some cpu
> time.  Adding this unconditionally gets us a safety valve for
> throttling a badly written fifo task, but allows the fifo task to
> continue to consume cpu cycles if it's not starving anyone. 
> 
> Or am I missing something that's blazingly obvious?

Or I say make it the default. If people want the old behavior, they can
modify SCHED_FEATURES to do so.

-- Steve
