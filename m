From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 3/4] block: queue work on unbound wq
Date: Mon, 1 Apr 2013 12:01:05 +0530
Message-ID: <CAKohpo=nWsUh5y7y_tacGez7uN76QbRFRVPSQcKQMGM1nUBWtw@mail.gmail.com>
References: <cover.1364740180.git.viresh.kumar@linaro.org>
	<91239cde99aaba2715f63db1f88241d9f4a36e13.1364740180.git.viresh.kumar@linaro.org>
	<20130331181931.GA7533@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org,
	robin.randhawa@arm.com, Steve.Bannister@arm.com,
	Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com,
	arvind.chauhan@arm.com, davem@davemloft.net, airlied@redhat.com,
	axboe@kernel.dk, tglx@linutronix.de, peterz@infradead.org,
	mingo@redhat.com, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130331181931.GA7533@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tejun,

On 31 March 2013 23:49, Tejun Heo <tj@kernel.org> wrote:
> So, let's please introduce a new flag to mark these workqueues, say,
> WQ_UNBOUND_FOR_POWER_SAVE or whatever (please come up with a better
> name) and provide a compile time switch with boot time override.

Just wanted to make this clear before writing it:

You want me to do something like (With better names):

int wq_unbound_for_power_save_enabled = 0;

#ifdef CONFIG_WQ_UNBOUND_FOR_POWER_SAVE
#define WQ_UNBOUND_FOR_POWER_SAVE   wq_unbound_for_power_save_enabled
#else
#define WQ_UNBOUND_FOR_POWER_SAVE 0

And provide a call to enable/disable wq_unbound_for_power_save_enabled ??
