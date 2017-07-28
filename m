From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH v3] cpu_pm: replace raw_notifier to atomic_notifier
Date: Fri, 28 Jul 2017 15:10:04 +0800
Message-ID: <48ec77b5-e0b0-e15c-c705-201bf5fb4af9@linaro.org>
References: <1501205977-10774-1-git-send-email-alex.shi@linaro.org>
 <20170728064455.GJ10026@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: rafael@kernel.org, open list <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tony Lindgren <tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170728064455.GJ10026@atomide.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 07/28/2017 02:44 PM, Tony Lindgren wrote:
> * Alex Shi <alex.shi@linaro.org> [170727 18:42]:
>> Tony Lezcano found a miss use that rcu_read_lock used after rcu_idle_enter
>> Paul E. McKenney suggested trying RCU_NONIDLE.
> 
> Hmm I think you have a hybrid name typo above in case you mean me :)

Sorry. Resent.

> 
> Tony
> 
