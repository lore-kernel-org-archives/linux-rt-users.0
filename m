From: Allen Martin <amartin@nvidia.com>
Subject: Interference from CFS scheduler
Date: Tue, 12 Sep 2017 18:53:00 -0700
Message-ID: <20170913015300.GB5931@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2180 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbdIMBxW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Sep 2017 21:53:22 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've been trying to eliminate sources of unpredictability in the
latency of interrupt response in my real-time application, and I'm
struggling a bit with the CFS scheduler.  If a SCHED_OTHER task was
preempted the rt scheduler eventually calls put_prev_task() which
results in a rb tree insert in the CFS scheduler.  So the latency of
my real-time task depends on the scheduling class of the task I'm
interrupting and how many SCHED_OTHER tasks are in the runqueue, which
seems like a priority inversion.

Are there any ways to mitigate this other than trying to minimize the
number of SCHED_OTHER tasks in the system?  Ideally what I'd really
like is to defer the work in put_prev_task_fair() until there's no
real-time work to do.

-Allen
