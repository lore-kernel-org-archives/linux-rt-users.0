From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] Timer: Migrate running timers
Date: Wed, 20 Nov 2013 19:57:29 +0530
Message-ID: <528CC6D1.9010209@linaro.org>
References: <3a0ef8e5a838fcf1a3cdaecc029cc97dea5edf65.1384940804.git.viresh.kumar@linaro.org> <alpine.DEB.2.02.1311201148272.30673@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org,
	bigeasy@linutronix.de, rostedt@goodmis.org, tj@kernel.org,
	mingo@redhat.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	john.stultz@linaro.org, paulmck@linux.vnet.ibm.com
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1311201148272.30673@ionos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday 20 November 2013 05:12 PM, Thomas Gleixner wrote:
> Viresh,
> 
> On Wed, 20 Nov 2013, Viresh Kumar wrote:
> 
>> Migration of timers from idle cores to non-idle ones for power saving is very
>> well working and really saves a lot of power for us. What's currently not
>> working is the migration of running timers Or timers which re-arms themselves.
>>
>> There are complications with migrating timers which schedules themselves again
>> from their handler. del_timer_sync() can't detect that the timer's handler
>> yet has not finished.
> 
> Because you try to violate the semantics of the existing code. There
> is a reason why we enforce that running timers must be requeued on the
> base they are running on.
> 
> Now you try to duct tape it into submission. That's not going to fly.
> 
> The timer wheel code is not designed to allow that and it has lots of
> other short comings and historic burdens. I'm not going to accept more
> duct tape and fragile hackery into that code.
> 
> I'm already working on a complete replacement infrastructure, which
> avoids all the short comings of the current timer implementation
> including this one. 
> 
> It's going to be a massive effort to convert everything over to the
> new infrastructure so we can kill the timer wheel, but that's less
> scary and less risky than trying to add more fragility to the existing
> code.

Thanks for the feedback. I Atleast know now that this patch doesn't have a future :)
