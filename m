From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Do not do push/pull when there is only one
 CPU
Date: Sat, 2 Dec 2017 13:05:41 -0500
Message-ID: <20171202130541.7dcfde88@vmware.local.home>
References: <20171201133222.66d41219@gandalf.local.home>
        <20171202125330.xrxspjeedbpr4hk5@linutronix.de>
        <20171202121252.0bada310@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:50929 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752426AbdLBSFo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 2 Dec 2017 13:05:44 -0500
In-Reply-To: <20171202121252.0bada310@vmware.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2 Dec 2017 12:12:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> v2 coming up.

Not really a v2, but a different approach. Look for the patch with the
subject:

 "[PATCH] sched/rt: Do not pull from current CPU if only one cpu to pull"

-- Steve
