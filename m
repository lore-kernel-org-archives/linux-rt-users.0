From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 3/4] block: queue work on unbound wq
Date: Fri, 5 Apr 2013 15:17:17 +0530
Message-ID: <CAKohpomTQj-S-32JdtY76_82NraB5uBqnKZXVxk28KxMZ-NSow@mail.gmail.com>
References: <cover.1364740180.git.viresh.kumar@linaro.org>
	<91239cde99aaba2715f63db1f88241d9f4a36e13.1364740180.git.viresh.kumar@linaro.org>
	<20130331181931.GA7533@htj.dyndns.org>
	<CAKohpo=nWsUh5y7y_tacGez7uN76QbRFRVPSQcKQMGM1nUBWtw@mail.gmail.com>
	<20130403215412.GG3411@htj.dyndns.org>
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
In-Reply-To: <20130403215412.GG3411@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 4 April 2013 03:24, Tejun Heo <tj@kernel.org> wrote:
> Not a call, probably a module_param() so that it can be switched
> on/off during boot.  You can make the param writable so that it can be
> flipped run-time but updating existing workqueues would be non-trivial
> and I don't think it's gonna be worthwhile.

module_param()?? We can't compile kernel/workqueue.c as a module and
hence i went with #define + a variable with functions to set/reset it...

I am not looking to update all existing workqueues to use it but workqueues
which are affecting power for us... And if there are some very very
performance critical ones, then we must better use queue_work_on() for
them to make it more clear.
