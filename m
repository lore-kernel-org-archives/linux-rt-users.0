Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF2DC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Jan 2021 22:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5028B64DEC
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Jan 2021 22:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhA2WXE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhA2WXD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Jan 2021 17:23:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF33664DDF;
        Fri, 29 Jan 2021 22:22:21 +0000 (UTC)
Date:   Fri, 29 Jan 2021 17:22:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Chen <chensong_2000@189.cn>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] kernel: trace: preemptirq_delay_test: add cpu affinity
Message-ID: <20210129172220.5e9c87f4@gandalf.local.home>
In-Reply-To: <1611797713-20965-1-git-send-email-chensong_2000@189.cn>
References: <1611797713-20965-1-git-send-email-chensong_2000@189.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Joel,

Can you ack this patch?

-- Steve


On Thu, 28 Jan 2021 09:35:13 +0800
Song Chen <chensong_2000@189.cn> wrote:

> The kernel thread executing test can run on any cpu, which might be
> different cpu latency tracer is running on, as a result, the
> big latency caused by preemptirq delay test can't be detected.
> 
> Therefore, the argument cpu_affinity is added to be passed to test,
> ensure it's running on the same cpu with latency tracer.
> 
> e.g.
> cyclictest -p 90 -m -c 0 -i 1000 -a 3
> modprobe preemptirq_delay_test test_mode=preempt delay=500 \
> burst_size=3 cpu_affinity=3
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  kernel/trace/Kconfig                 |  4 ++++
>  kernel/trace/preemptirq_delay_test.c | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index c1a62ae..44dd5c0 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -886,6 +886,10 @@ config PREEMPTIRQ_DELAY_TEST
>  	  irq-disabled critical sections for 500us:
>  	  modprobe preemptirq_delay_test test_mode=irq delay=500 burst_size=3
>  
> +	  What's more, if you want to attach the test on the cpu which the latency
> +	  tracer is running on, specify cpu_affinity=cpu_num at the end of the
> +	  command.
> +
>  	  If unsure, say N
>  
>  config SYNTH_EVENT_GEN_TEST
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> index 312d1a0..8c4ffd0 100644
> --- a/kernel/trace/preemptirq_delay_test.c
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -21,13 +21,16 @@
>  static ulong delay = 100;
>  static char test_mode[12] = "irq";
>  static uint burst_size = 1;
> +static int  cpu_affinity = -1;
>  
>  module_param_named(delay, delay, ulong, 0444);
>  module_param_string(test_mode, test_mode, 12, 0444);
>  module_param_named(burst_size, burst_size, uint, 0444);
> +module_param_named(cpu_affinity, cpu_affinity, int, 0444);
>  MODULE_PARM_DESC(delay, "Period in microseconds (100 us default)");
>  MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt, irq, or alternate (default irq)");
>  MODULE_PARM_DESC(burst_size, "The size of a burst (default 1)");
> +MODULE_PARM_DESC(cpu_affinity, "Cpu num test is running on");
>  
>  static struct completion done;
>  
> @@ -36,7 +39,9 @@ static struct completion done;
>  static void busy_wait(ulong time)
>  {
>  	u64 start, end;
> +
>  	start = trace_clock_local();
> +
>  	do {
>  		end = trace_clock_local();
>  		if (kthread_should_stop())
> @@ -47,6 +52,7 @@ static void busy_wait(ulong time)
>  static __always_inline void irqoff_test(void)
>  {
>  	unsigned long flags;
> +
>  	local_irq_save(flags);
>  	busy_wait(delay);
>  	local_irq_restore(flags);
> @@ -113,6 +119,14 @@ static int preemptirq_delay_run(void *data)
>  {
>  	int i;
>  	int s = MIN(burst_size, NR_TEST_FUNCS);
> +	struct cpumask cpu_mask;
> +
> +	if (cpu_affinity > -1) {
> +		cpumask_clear(&cpu_mask);
> +		cpumask_set_cpu(cpu_affinity, &cpu_mask);
> +		if (set_cpus_allowed_ptr(current, &cpu_mask))
> +			pr_err("cpu_affinity:%d, failed\n", cpu_affinity);
> +	}
>  
>  	for (i = 0; i < s; i++)
>  		(testfuncs[i])(i);

