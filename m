From: Xander Huff <xander.huff@ni.com>
Subject: Re: [PATCH -rt] lockdep: selftest: fix warnings due to missing PREEMPT_RT
 conditionals
Date: Wed, 28 Jan 2015 15:06:59 -0600
Message-ID: <54C94F73.3010006@ni.com>
References: <1422472125-21979-1-git-send-email-xander.huff@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, josh.cartwright@ni.com,
	gratian.crisan@ni.com, linux-kernel@vger.kernel.org,
	jaeden.amero@ni.com, ben.shelton@ni.com, brad.mouring@ni.com,
	rich.tollerton@ni.com
To: mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422472125-21979-1-git-send-email-xander.huff@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 1/28/2015 1:08 PM, Xander Huff wrote:
> From: Josh Cartwright <josh.cartwright@ni.com>
>
> "lockdep: Selftest: Only do hardirq context test for raw spinlock"
> disabled the execution of certain tests with PREEMPT_RT_FULL, but did
> not prevent the tests from still being defined.  This leads to warnings
> like:
>
>    ./linux/lib/locking-selftest.c:574:1: warning: 'irqsafe1_hard_rlock_12' defined but not used [-Wunused-function]
>    ./linux/lib/locking-selftest.c:574:1: warning: 'irqsafe1_hard_rlock_21' defined but not used [-Wunused-function]
>    ./linux/lib/locking-selftest.c:577:1: warning: 'irqsafe1_hard_wlock_12' defined but not used [-Wunused-function]
>    ./linux/lib/locking-selftest.c:577:1: warning: 'irqsafe1_hard_wlock_21' defined but not used [-Wunused-function]
>    ./linux/lib/locking-selftest.c:580:1: warning: 'irqsafe1_soft_spin_12' defined but not used [-Wunused-function]
>    ...
>
> Fixed by wrapping the test definitions in #ifndef CONFIG_PREEMPT_RT_FULL
> conditionals.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Signed-off-by: Xander Huff <xander.huff@ni.com>
> Acked-by: Gratian Crisan <gratian.crisan@ni.com>

FYI: To be clearer, this should apply to all stable RT releases 3.4 and later.

-- 
Xander Huff
Staff Software Engineer
National Instruments
