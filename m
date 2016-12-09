From: Julia Cartwright <julia@ni.com>
Subject: Re: Blocked kworker in single core RT system
Date: Fri, 9 Dec 2016 16:20:09 -0600
Message-ID: <20161209222009.GJ1335@jcartwri.amer.corp.natinst.com>
References: <DB6PR0601MB24234A8580A50FC97001DD46E0870@DB6PR0601MB2423.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Rasmus Ahlberg <rasmus.ahlberg@electrolux.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:51950 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752273AbcLIWUN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Dec 2016 17:20:13 -0500
Content-Disposition: inline
In-Reply-To: <DB6PR0601MB24234A8580A50FC97001DD46E0870@DB6PR0601MB2423.eurprd06.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Dec 09, 2016 at 03:44:56PM +0000, Rasmus Ahlberg wrote:
> Hi,

Hello!

> We're running Linux with the RT patch on our single core ARM embedded
> system, kernel version 3.14. Our application has several threads, of
> which some are running in mode SCHED_RR, with different priorities.
>
> One of the higher prio SCHED_RR threads is dependent on data from the
> TTY driver. In the driver, a workqueue is used to deliver the data
> received, which is serviced by a kworker. The kworker runs in mode
> SCHED_OTHER. If one of the lower priority SCHED_RR threads is running,
> it will therefore block the kworker, and indirectly the higher prio
> SCHED_RR thread.

Is the workqueue usage that is problematic in the tty core?  Or, is it
in a specific driver?  This is a more generic problem with most of the
deferred work mechanisms that the kernel offers.

Any work deferral system that doesn't map work units one-to-one with
threads suffers the problem where the units cannot independently be
prioritized amongst other system tasks.

> Our tests show that the problem can be solved by setting mode SCHED_RR
> for the kworker, which makes sense. However, this is not easily
> implemented in the real system, as kworkers are created and destroyed
> dynamically.  Also, as the kworkers performs work for other drivers
> also, this might not be optimal.
>
> What is the recommended way to solve this problem? Is there some
> kernel option that solves this, or do we need to make our own
> implementation?

Everyone always asks "is there a kernel config option that magically
fixes my problem?", and the answer is almost always "no" :).

Without having more information about the case you are looking at, I
think it will be difficult to prescribe a potential solution.  If the
workqueue is being used to defer work from interrupt context, then the
use of request_threaded_irq() and pushing the work to thread context
would be better.

Hope that helps,

   Julia
