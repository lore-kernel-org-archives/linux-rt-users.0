From: Jonathan Haws <jhaws@sdl.usu.edu>
Subject: Re: [RFC][PATCH] ipc: mqueue: wq_add priority changed to dynamic
 priority
Date: Mon, 11 Dec 2017 17:12:05 +0000
Message-ID: <1513012323038.16494@sdl.usu.edu>
References: <1513006652-7014-1-git-send-email-jhaws@sdl.usu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "mingo@kernel.org" <mingo@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from perses.usurf.usu.edu ([129.123.197.145]:56094 "EHLO
        Perses.usurf.usu.edu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750707AbdLKRMH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Dec 2017 12:12:07 -0500
In-Reply-To: <1513006652-7014-1-git-send-email-jhaws@sdl.usu.edu>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Adding linux-rt-users group to thread.
________________________________________
From: Jonathan Haws <jhaws@sdl.usu.edu>
Sent: Monday, December 11, 2017 08:37
To: mingo@kernel.org; viro@zeniv.linux.org.uk; arnd@arndb.de; akpm@linux-foundation.org; deepa.kernel@gmail.com
Cc: linux-kernel@vger.kernel.org; tglx@linutronix.de; bigeasy@linutronix.de; rostedt@goodmis.org; Jonathan Haws
Subject: [RFC][PATCH] ipc: mqueue: wq_add priority changed to dynamic priority

Previous behavior added tasks to the work queue using the static_prio value
instead of the dynamic priority value in prio. This caused RT tasks to be
added to the work queue in a FIFO manner rather than by priority. Normal
tasks were handled by priority.

This fix utilizes the dynamic priority of the task to ensure that both RT
and normal tasks are added to the work queue in priority order. Utilizing
the dynamic priority (prio) rather than the base priority (normal_prio) was
chosen to ensure that if a task had a boosted priority when it was added to
the work queue, it would be woken sooner to to ensure that it releases any
other locks it may be holding in a more timely manner. It is understood that
the task could have a lower priority when it wakes than when it was added to
the queue in this (unlikely) case.

Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
---
 ipc/mqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 9649ecd..cb96db9 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -546,7 +546,7 @@ static void wq_add(struct mqueue_inode_info *info, int sr,
        ewp->task = current;

        list_for_each_entry(walk, &info->e_wait_q[sr].list, list) {
-               if (walk->task->static_prio <= current->static_prio) {
+               if (walk->task->prio <= current->prio) {
                        list_add_tail(&ewp->list, &walk->list);
                        return;
                }
--
2.7.4

