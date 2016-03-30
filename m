From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RT] Warning from swake_up_all_locked in rt-4.4.4-rt11
Date: Wed, 30 Mar 2016 16:24:57 +0200
Message-ID: <56FBE1B9.3080806@linutronix.de>
References: <20160313225358.4eb9316a@sluggy.hsv.redhat.com>
 <alpine.DEB.2.11.1603140948560.3657@nanos>
 <20160330102251.GB21849@linutronix.de>
 <20160330085218.32f13bd2@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Daniel Wagner <wagi@monom.org>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160330085218.32f13bd2@sluggy.hsv.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/30/2016 03:52 PM, Clark Williams wrote:
> On Wed, 30 Mar 2016 12:22:51 +0200
> I'm seeing output like this with between 3 and 9 wakeups per kworker:
same here. And with

--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -32,17 +32,24 @@ EXPORT_SYMBOL(swake_up_locked);
 void swake_up_all_locked(struct swait_queue_head *q)
 {
        struct swait_queue *curr;
+       char comms[512];
        int wakes = 0;

+       comms[0] = '\0';
        while (!list_empty(&q->task_list)) {

                curr = list_first_entry(&q->task_list, typeof(*curr),
                                        task_list);
+               strcat(comms, curr->task->comm);
+               strcat(comms, " ");
                wake_up_process(curr->task);
                list_del_init(&curr->task_list);
                wakes++;
        }
-       WARN_ON(wakes > 2);
+       if (wakes > 2) {
+               pr_err("%s(%d) %d\n", __func__, __LINE__, wakes);
+               pr_err("%s(%d) %s\n", __func__, __LINE__, comms);
+       }
 }
 EXPORT_SYMBOL(swake_up_all_locked);

you would see that it wakes other kworker :)

Sebastian
