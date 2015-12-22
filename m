From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] rt: x86: enable preemption in IST exception for x86-32
Date: Tue, 22 Dec 2015 13:06:28 +0100
Message-ID: <20151222120628.GA27274@linutronix.de>
References: <1450134404-16662-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450134404-16662-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Yang Shi | 2015-12-14 15:06:44 [-0800]:

>Mainline kernel commit 959274753857efe9c5f1ba35fe727f51e9aa128d
>("x86, traps: Track entry into and exit from IST context"), introduced
>ist_enter which disables preemption uncondiontionally for both x86-64 and
>x86-32. However, x86-32 does not have an IST and the stack still belongs to
>the current task and there is no problem in scheduling out the task.

no no. So from a quick look I *assumed* you merged your v1 and revert of the
Steven's patch into one piece. But now I see that you don't disable preemption
64bit which means you revert upstream change.

Here is what happens:
- I drop your v2
- I merge your v1 with updated patch description
- I revert "x86: Do not disable preemption in int3 on 32bit". If someone
  wants to skip the delayed signal on 32bit please address this upstream
  first (that is skip the preempt_disable() on 32bit if it is not
  required there).
- Yang Shi, please send a changelong if you send incremental patches.

Sebastian
