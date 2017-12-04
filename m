From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/rt: Do not pull from current CPU if only one cpu
 to pull
Date: Mon, 4 Dec 2017 10:07:57 +0100
Message-ID: <20171204090757.GB26712@localhost.localdomain>
References: <20171202130454.4cbbfe8d@vmware.local.home>
 <20171204074517.GA26712@localhost.localdomain>
 <20171204030916.0cf09b0f@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40677 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753528AbdLDJID (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Dec 2017 04:08:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id f206so6632886wmf.5
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Dec 2017 01:08:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171204030916.0cf09b0f@vmware.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/12/17 03:09, Steven Rostedt wrote:
> On Mon, 4 Dec 2017 08:45:17 +0100
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > Right. I was wondering however if for the truly UP case we shouldn't be
> > initiating/queueing callbacks (pull/push) at all?
> 
> If !CONFIG_SMP then it's not compiled in. The issue came up when Daniel
> ran a CONFIG_SMP kernel on an arch that only supports UP.
> 

Right, sorry. I meant num_online_cpus() == 1.

Best,

Juri
