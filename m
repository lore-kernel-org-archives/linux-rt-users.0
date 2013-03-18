From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/7] sched: Create sched_select_cpu() to give preferred
 CPU for power saving
Date: Mon, 18 Mar 2013 21:14:11 +0530
Message-ID: <CAKohpokB3yeXuLVe_0fWuMRVMKWJktDU7UrMepfd+3N0GmNtMw@mail.gmail.com>
References: <cover.1363617402.git.viresh.kumar@linaro.org>
	<9f0fd16f792b9f9b399a4c91c98de37c56067d47.1363617402.git.viresh.kumar@linaro.org>
	<CAFTL4hxJUnnBvHNty1FgxbBGOrrPPNotJGaE03B8s_t1Lx5vRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de,
	tj@kernel.org, suresh.b.siddha@intel.com, venki@google.com,
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
	linaro-kernel@lists.linaro.org, robin.randhawa@arm.com,
	Steve.Bannister@arm.com, Liviu.Dudau@arm.com,
	charles.garcia-tobin@arm.com, Arvind.Chauhan@arm.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFTL4hxJUnnBvHNty1FgxbBGOrrPPNotJGaE03B8s_t1Lx5vRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Mar 18, 2013 at 9:09 PM, Frederic Weisbecker <fweisbec@gmail.com> wrote:
> 2013/3/18 Viresh Kumar <viresh.kumar@linaro.org>:

>> +static inline int sched_select_cpu(unsigned int sd_flags)
>> +{
>> +       return raw_smp_processor_id();
>
> I feel this should be symetric with the requirement of having
> preemption disabled as in the CONFIG_NO_HZ version. This should be
> smp_processor_id().

Yes, my fault.

>> +int sched_select_cpu(unsigned int sd_flags)
>
> It would be nice to have some more precise naming. sched_select_busy_cpu() ?

You are correct that name can be improved but busy may give it a different
meaning. Maybe sched_select_non_idle_cpu()?

Thanks for your instantaneous review :)
