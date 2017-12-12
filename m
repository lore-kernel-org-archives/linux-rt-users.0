From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] sched/deadline: runtime overrun signal
Date: Tue, 12 Dec 2017 12:50:40 +0100
Message-ID: <20171212115040.iffj4plu3iow7qoi@gmail.com>
References: <1513077024-25461-1-git-send-email-claudio@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@gmail.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Claudio Scordino <claudio@evidence.eu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513077024-25461-1-git-send-email-claudio@evidence.eu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Claudio Scordino <claudio@evidence.eu.com> wrote:

> From: Juri Lelli <juri.lelli@gmail.com>

> -		~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM))
> +		~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM |
> +			SCHED_FLAG_DL_OVERRUN))

> +		if (dl_runtime_exceeded(dl_se) &&
> +				(dl_se->flags & SCHED_FLAG_DL_OVERRUN))

> +		pr_info("runtime overrun: %s[%d]\n",
> +				tsk->comm, task_pid_nr(tsk));

	Guys,
please,
	don't,
break
	code lines
in a hard to
	read
fashion, ok,
	just to
pacify
	checkpatch.pl

ok? :-)

Also, I'm not sure that pr_info() debug printout should be in an upstream version, 
correct?

Thanks,

	Ingo
