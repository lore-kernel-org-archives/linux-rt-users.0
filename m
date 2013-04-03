From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V4 3/4] block: queue work on unbound wq
Date: Wed, 3 Apr 2013 14:54:12 -0700
Message-ID: <20130403215412.GG3411@htj.dyndns.org>
References: <cover.1364740180.git.viresh.kumar@linaro.org>
 <91239cde99aaba2715f63db1f88241d9f4a36e13.1364740180.git.viresh.kumar@linaro.org>
 <20130331181931.GA7533@htj.dyndns.org>
 <CAKohpo=nWsUh5y7y_tacGez7uN76QbRFRVPSQcKQMGM1nUBWtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org,
	robin.randhawa@arm.com, Steve.Bannister@arm.com,
	Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com,
	arvind.chauhan@arm.com, davem@davemloft.net, airlied@redhat.com,
	axboe@kernel.dk, tglx@linutronix.de, peterz@infradead.org,
	mingo@redhat.com, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpo=nWsUh5y7y_tacGez7uN76QbRFRVPSQcKQMGM1nUBWtw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello, Viresh.

Sorry about the delay.  Lost this one somehow.

On Mon, Apr 01, 2013 at 12:01:05PM +0530, Viresh Kumar wrote:
> Just wanted to make this clear before writing it:
> 
> You want me to do something like (With better names):
> 
> int wq_unbound_for_power_save_enabled = 0;
> 
> #ifdef CONFIG_WQ_UNBOUND_FOR_POWER_SAVE
> #define WQ_UNBOUND_FOR_POWER_SAVE   wq_unbound_for_power_save_enabled
> #else
> #define WQ_UNBOUND_FOR_POWER_SAVE 0
> 
> And provide a call to enable/disable wq_unbound_for_power_save_enabled ??

Not a call, probably a module_param() so that it can be switched
on/off during boot.  You can make the param writable so that it can be
flipped run-time but updating existing workqueues would be non-trivial
and I don't think it's gonna be worthwhile.

Thanks!

-- 
tejun
