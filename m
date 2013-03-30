From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/7] workqueue: Add helpers to schedule work on any cpu
Date: Sat, 30 Mar 2013 09:00:22 +0530
Message-ID: <CAKohpokUFCjYh0C=RVaenGTFSnJN5R=Rw0n3EJVv0WDbpC+TeA@mail.gmail.com>
References: <cover.1363617402.git.viresh.kumar@linaro.org>
	<fb2e721fc43fbc3517a7ebb905aa573b12bb83a5.1363617402.git.viresh.kumar@linaro.org>
	<20130321001211.GC31256@htj.dyndns.org>
	<CAKohponKUGbwEZ_edu353Y7YVZKgFOhZunTSUi04FGYWveftkw@mail.gmail.com>
	<20130321182937.GB20500@htj.dyndns.org>
	<20130328181332.GD14088@htj.dyndns.org>
	<CAKohpomkGxUy6-7tByBjQvAGSUn4EdVCpGo+94fn7vF8YgKRLQ@mail.gmail.com>
	<20130329174003.GA9862@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: pjt@google.com, paul.mckenney@linaro.org, tglx@linutronix.de,
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
	linaro-kernel@lists.linaro.org, robin.randhawa@arm.com,
	Steve.Bannister@arm.com, Liviu.Dudau@arm.com,
	charles.garcia-tobin@arm.com, Arvind.Chauhan@arm.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130329174003.GA9862@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 29 March 2013 23:10, Tejun Heo <tj@kernel.org> wrote:
> So the scheduler does know what it's doing after all, which is a nice
> news.  Given the result, the best thing to do would be somehow marking
> these workqueues as unbound for powersaving?

Yes. I am going to do it soon.
