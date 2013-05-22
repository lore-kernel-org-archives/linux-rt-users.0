From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 Resend 4/4] timer: Migrate running timer
Date: Wed, 22 May 2013 11:06:43 +0200
Message-ID: <20130522090643.GB18810@twins.programming.kicks-ass.net>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
 <d12b25130db5a8b645929eb93d1cf4ddc2d68826.1352196505.git.viresh.kumar@linaro.org>
 <1354024039.6276.72.camel@gandalf.local.home>
 <CAKohponv-AKZzM98Ujeek4oXQx+8ba+sMgMbM9eV8PgQR38kZw@mail.gmail.com>
 <CAKohpo=St0z0L9ei248s3KL_DqZtewQ50o7d=BTdwLFcpM+x3w@mail.gmail.com>
 <CAKohpo=0r=HY5w-XqnXv42eSJcH08C47J+TqWn7vY1aNBhGT_A@mail.gmail.com>
 <CAKohpo=eAGVA540jN8+t0aaqCV9qJRkH0q9-q6QVUYusWQqSYw@mail.gmail.com>
 <alpine.LFD.2.02.1305131223470.2863@ionos>
 <CAKohpokfKPQ3EhMf3WB8koXuH2rF6QoejwNOTw08X+XfnVhpEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, pjt@google.com,
	paul.mckenney@linaro.org, tj@kernel.org, mingo@redhat.com,
	Arvind.Chauhan@arm.com, linaro-dev@lists.linaro.org,
	patches@linaro.org, pdsw-power-team@arm.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	john stultz <johnstul@us.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpokfKPQ3EhMf3WB8koXuH2rF6QoejwNOTw08X+XfnVhpEg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, May 22, 2013 at 02:04:16PM +0530, Viresh Kumar wrote:

> So, this is the clean draft for the idea I had.. (Naming is poor for
> now):
> 
> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index 8c5a197..ad00ebe 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -20,6 +20,7 @@ struct timer_list {
> 
>         void (*function)(unsigned long);
>         unsigned long data;
> +       int wait_for_migration_to_complete;

If you play games with the alignment constraints of struct tvec_base you
can get extra low bits to play with for TIMER_FLAG_MASK. See struct
pool_workqueue for similar games.

That would avoid the struct bloat and I suppose make tglx happy :-)
