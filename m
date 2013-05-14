From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V5 4/5] block: queue work on power efficient wq
Date: Tue, 14 May 2013 10:57:25 -0700
Message-ID: <20130514175725.GJ6795@mtj.dyndns.org>
References: <cover.1366803121.git.viresh.kumar@linaro.org>
 <2e89f7f3943438f8b1e58f2034242a5b53e31b43.1366803121.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davem@davemloft.net, airlied@redhat.com, axboe@kernel.dk,
	tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.randhawa@arm.com,
	Steve.Bannister@arm.com, Liviu.Dudau@arm.com,
	charles.garcia-tobin@arm.com, arvind.chauhan@arm.com,
	linaro-kernel@lists.linaro.org, patches@linaro.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2e89f7f3943438f8b1e58f2034242a5b53e31b43.1366803121.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Apr 24, 2013 at 05:12:56PM +0530, Viresh Kumar wrote:
> Block layer uses workqueues for multiple purposes. There is no real dependency
> of scheduling these on the cpu which scheduled them.
> 
> On a idle system, it is observed that and idle cpu wakes up many times just to
> service this work. It would be better if we can schedule it on a cpu which the
> scheduler believes to be the most appropriate one.
> 
> This patch replaces normal workqueues with power efficient versions.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Jens, applied this to wq/for-3.11.  Please holler if you wanna route
this differently.

Thanks.

-- 
tejun
