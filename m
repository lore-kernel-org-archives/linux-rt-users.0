From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v2] sched/completion: convert completions to use simple
 wait queues
Date: Fri, 29 Apr 2016 08:14:43 +0200
Message-ID: <88ea5752-29c4-09e9-e22f-942201826874@bmw-carit.de>
References: <1461848244-16469-1-git-send-email-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461848244-16469-1-git-send-email-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/28/2016 02:57 PM, Daniel Wagner wrote:
> Only one complete_all() user could been identified so far, which happens
> to be drivers/base/power/main.c. Several waiters appear when suspend
> to disk or mem is executed.

BTW, this is what I get when doing a 'echo "disk" > /sys/power/state' on
a 4 socket E5-4610 (Ivy Bridge EP) system.


swait_stat version 0.1
---------------------------------------------------------------------------------------------
                              class name     1 waiter    2 waiters    3 waiters   4+ waiters
---------------------------------------------------------------------------------------------
[...]
                             &x->wait#12           90           11            5            1
         [<ffffffff815dd462>] dpm_wait+0x32/0x40
                                                   20          [<ffffffff815de5d4>] __device_suspend+0x1b4/0x370
                                                    4          [<ffffffff815de1e4>] __device_suspend_late+0x74/0x210
                                                   22          [<ffffffff815ddf21>] __device_suspend_noirq+0x51/0x200
                                                    2          [<ffffffff815ddaf9>] device_resume_early+0x69/0x1b0
                                                   59          [<ffffffff815ddce0>] device_resume+0x50/0x1f0
[...]
