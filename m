From: gengdongjiu <gengdongjiu@huawei.com>
Subject: hrtimer become inaccurate with RT patch
Date: Mon, 2 Jul 2018 17:34:34 +0800
Message-ID: <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        <yangchuanlong@huawei.com>,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        <liupeifeng3@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <anna-maria@linutronix.de>, <john.stultz@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas/Anna/John,

  Recently I found that the hrtimer become inaccurate when there is a RT
process runs on the same cpu core, and the kernel has applied preempt_rt
patch.
  The Linux kernel version is v4.1.46, and the preempt_rt patch is
patch-4.1.46-rt52.patch.
  I know that in the preempt_rt environment the interrupt handlers no
longer run in interrupt context but in process context, so that RT
process will not be interrupt. But if the hrtimer is also runs in
process context the timer is useless when it's inaccurate. so I want to
consult you whether this is expected behavior? whether is reasonable to move the timer IRQ
handling to a thread?

  Check the patch-4.1.46-rt52.patch will found in function
'hrtimer_interrupt' the modify below:

@@ -1296,7 +1539,10 @@ retry:
 			if (basenow.tv64 < hrtimer_get_softexpires_tv64(timer))
 				break;

-			__run_hrtimer(timer, &basenow);
+			if (!hrtimer_rt_defer(timer))
+				__run_hrtimer(timer, &basenow);
+			else
+				raise = 1;
 		}
 	}
 	/* Reevaluate the clock bases for the next expiry */

@@ -1357,6 +1603,9 @@ retry:
 	tick_program_event(expires_next, 1);
 	printk_once(KERN_WARNING "hrtimer: interrupt took %llu ns\n",
 		    ktime_to_ns(delta));
+out:
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }

I think this is why hrtimer is run as a thread, I tried to set
hrtimer.irqsafe to 1, but the timer still seemed not right. Could anyone
give some advise? Thanks.
