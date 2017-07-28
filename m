From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] cpu_pm: replace raw_notifier to atomic_notifier
Date: Thu, 27 Jul 2017 23:44:55 -0700
Message-ID: <20170728064455.GJ10026@atomide.com>
References: <1501205977-10774-1-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rafael@kernel.org, open list <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Alex Shi <alex.shi@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501205977-10774-1-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Alex Shi <alex.shi@linaro.org> [170727 18:42]:
> Tony Lezcano found a miss use that rcu_read_lock used after rcu_idle_enter
> Paul E. McKenney suggested trying RCU_NONIDLE.

Hmm I think you have a hybrid name typo above in case you mean me :)

Tony
