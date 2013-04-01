From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH V4 1/4] workqueue: Add system wide system_freezable_unbound_wq
Date: Mon, 1 Apr 2013 10:50:09 +0530
Message-ID: <CAP245DV-4d4hRGCnKUtyVV1ycHuYF4dKwh568kvHfKHdJR3xpw@mail.gmail.com>
References: <cover.1364740180.git.viresh.kumar@linaro.org>
	<147bfb5aa81790f94df75858bf20570cbacc9dca.1364740180.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tejun Heo <tj@kernel.org>, axboe@kernel.dk,
	Robin Randhawa <robin.randhawa@arm.com>,
	linux-rt-users@vger.kernel.org,
	Patch Tracking <patches@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
	Steve Bannister <Steve.Bannister@arm.com>, airlied@redhat.com,
	Arvind Chauhan <arvind.chauhan@arm.com>, mingo@redhat.com,
	davem@davemloft.net,
	Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <147bfb5aa81790f94df75858bf20570cbacc9dca.1364740180.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Mar 31, 2013 at 8:01 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This patch adds system wide system_freezable_unbound_wq which will be used by
> code that currently uses system_freezable_wq and can be moved to unbound
> workqueues.

_Why_ do i need this change?

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/workqueue.h | 4 ++++
>  kernel/workqueue.c        | 7 ++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 835d12b..ab7597b 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -325,11 +325,15 @@ enum {
>   *
>   * system_freezable_wq is equivalent to system_wq except that it's
>   * freezable.
> + *
> + * system_freezable_unbound_wq is equivalent to system_unbound_wq except that
> + * it's freezable.
>   */
>  extern struct workqueue_struct *system_wq;
>  extern struct workqueue_struct *system_long_wq;
>  extern struct workqueue_struct *system_unbound_wq;
>  extern struct workqueue_struct *system_freezable_wq;
> +extern struct workqueue_struct *system_freezable_unbound_wq;
>
>  static inline struct workqueue_struct * __deprecated __system_nrt_wq(void)
>  {
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index df2f6c4..771a5cc 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -281,6 +281,8 @@ struct workqueue_struct *system_unbound_wq __read_mostly;
>  EXPORT_SYMBOL_GPL(system_unbound_wq);
>  struct workqueue_struct *system_freezable_wq __read_mostly;
>  EXPORT_SYMBOL_GPL(system_freezable_wq);
> +struct workqueue_struct *system_freezable_unbound_wq __read_mostly;
> +EXPORT_SYMBOL_GPL(system_freezable_unbound_wq);
>
>  static int worker_thread(void *__worker);
>  static void copy_workqueue_attrs(struct workqueue_attrs *to,
> @@ -4467,8 +4469,11 @@ static int __init init_workqueues(void)
>                                             WQ_UNBOUND_MAX_ACTIVE);
>         system_freezable_wq = alloc_workqueue("events_freezable",
>                                               WQ_FREEZABLE, 0);
> +       system_freezable_unbound_wq = alloc_workqueue("events_unbound_freezable",
> +                                             WQ_FREEZABLE | WQ_UNBOUND, 0);
>         BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
> -              !system_unbound_wq || !system_freezable_wq);
> +              !system_unbound_wq || !system_freezable_wq ||
> +              !system_freezable_unbound_wq);
>         return 0;
>  }
>  early_initcall(init_workqueues);
> --
> 1.7.12.rc2.18.g61b472e
>
>
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
