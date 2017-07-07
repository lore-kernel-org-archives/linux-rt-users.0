From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] cpu_pm: replace raw_notifier to atomic_notifier
Date: Fri, 7 Jul 2017 12:25:28 +0200
Message-ID: <20170707102527.bg7ktbkazxl3qpqt@linutronix.de>
References: <1499330866-19520-1-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rik van Riel <riel@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Alex Shi <alex.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1499330866-19520-1-git-send-email-alex.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-07-06 16:47:46 [+0800], Alex Shi wrote:
> This patch replace a rwlock and raw notifier by atomic notifier which
+ is 
> protected by spin_lock and rcu.
…
> Sebastian suggested using atomic_notifier instead of rwlock, which is not
> only removing the sleeping in idle, but also getting better latency
> improvement.

Did you measure this / have numbers or did you write this because this
is what RCU does in general?

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
