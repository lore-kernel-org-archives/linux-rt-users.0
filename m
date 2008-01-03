From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [PATCH 2/2] Markers Implementation for Preempt RCU Boost
	Tracing
Date: Thu, 3 Jan 2008 11:30:55 -0500
Message-ID: <20080103163055.GB27651@Krystal>
References: <20071231060911.GB6461@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, dipankar@in.ibm.com,
	ego@in.ibm.com, paulmck@linux.vnet.ibm.com
To: "K. Prasad" <prasad@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755499AbYACQgU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071231060911.GB6461@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* K. Prasad (prasad@linux.vnet.ibm.com) wrote:
> This patch converts the tracing mechanism of Preempt RCU boosting into
> markers. The handler functions for these markers are included inside
> rcupreempt_trace.c and will be included only when PREEMPT_RCU_BOOST is
> chosen.
>  
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> ---
>  include/linux/rcupreempt_trace.h |   46 ++++++++
>  kernel/rcupreempt-boost.c        |  211 ++++-----------------------------------
>  kernel/rcupreempt_trace.c        |  183 +++++++++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+), 189 deletions(-)
>  
> Index: linux-2.6.24-rc2-rt1.MARKER_PATCHES_NEW/include/linux/rcupreempt_trace.h
> ===================================================================
> --- linux-2.6.24-rc2-rt1.MARKER_PATCHES_NEW.orig/include/linux/rcupreempt_trace.h
> +++ linux-2.6.24-rc2-rt1.MARKER_PATCHES_NEW/include/linux/rcupreempt_trace.h
> @@ -102,5 +102,51 @@ extern int rcupreempt_flip_flag(int cpu)
>  extern int rcupreempt_mb_flag(int cpu);
>  extern char *rcupreempt_try_flip_state_name(void);
>  
> +#ifdef CONFIG_PREEMPT_RCU_BOOST
> +struct preempt_rcu_boost_trace {
> +	unsigned long rbs_stat_task_boost_called;
> +	unsigned long rbs_stat_task_boosted;
> +	unsigned long rbs_stat_boost_called;
> +	unsigned long rbs_stat_try_boost;
> +	unsigned long rbs_stat_boosted;
> +	unsigned long rbs_stat_unboost_called;
> +	unsigned long rbs_stat_unboosted;
> +	unsigned long rbs_stat_try_boost_readers;
> +	unsigned long rbs_stat_boost_readers;
> +	unsigned long rbs_stat_try_unboost_readers;
> +	unsigned long rbs_stat_unboost_readers;
> +	unsigned long rbs_stat_over_taken;
> +};
> +
> +#define DEFINE_PREEMPT_RCU_BOOST_MARKER_HANDLER(preempt_rcu_boost_var) \
> +void preempt_rcu_boost_var##_callback(const struct marker *mdata, \
> +				void *private_data, const char *format, ...) \
> +{ \
> +	va_list ap; \
> +	int cpu; \
> +	struct preempt_rcu_boost_trace *boost_trace; \
> +	va_start(ap, format); \
> +	cpu = va_arg(ap, typeof(unsigned int)); \

(sorry for late response, I just came back from vacation)

Instead of passing the cpu id as a marker parameter, why don't you
simply use smp_processor_id() right here ?

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
