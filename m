From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/7] workqueue: Add helpers to schedule work on any cpu
Date: Tue, 19 Mar 2013 18:53:32 +0530
Message-ID: <CAKohponERCYwBfqEZ8M5UMKCNHLPP1pXojcqq1v_0rVLKHVhmg@mail.gmail.com>
References: <cover.1363617402.git.viresh.kumar@linaro.org>
	<fb2e721fc43fbc3517a7ebb905aa573b12bb83a5.1363617402.git.viresh.kumar@linaro.org>
	<CAKohpo=BL_MOijb2k6cC44jv2R-7gv_BpnJ0N2mEkJ3rmAxzAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linaro-kernel@lists.linaro.org, robin.randhawa@arm.com,
	Steve.Bannister@arm.com, Liviu.Dudau@arm.com,
	charles.garcia-tobin@arm.com, Arvind.Chauhan@arm.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
To: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de,
	tj@kernel.org, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=BL_MOijb2k6cC44jv2R-7gv_BpnJ0N2mEkJ3rmAxzAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 19 March 2013 10:45, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18 March 2013 20:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> queue_work() queues work on current cpu. This may wake up an idle CPU, which is
>> actually not required.
>>
>> Some of these works can be processed by any CPU and so we must select a non-idle
>> CPU here. The initial idea was to modify implementation of queue_work(), but
>> that may end up breaking lots of kernel code that would be a nightmare to debug.
>>
>> So, we finalized to adding new workqueue interfaces, for works that don't depend
>> on a cpu to execute them.

Another fixup:

commit 8753c6d936faa6e3233cbf44a55913d05de05683
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue Mar 19 18:50:59 2013 +0530

    fixup! workqueue: Add helpers to schedule work on any cpu
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 68daf50..4e023ab 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1242,7 +1242,7 @@ retry:
        if (!(wq->flags & WQ_UNBOUND)) {
                if (cpu == WORK_CPU_UNBOUND) {
                        if (on_any_cpu)
-                               cpu = sched_select_non_idle_cpu(0);
+                               cpu = sched_select_non_idle_cpu();
                        else
                                cpu = raw_smp_processor_id();
                }
