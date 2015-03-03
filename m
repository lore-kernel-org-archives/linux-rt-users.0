From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] pi_stress: Clear affinity for DEADLINE tasks
Date: Tue, 3 Mar 2015 13:59:55 +0100 (CET)
Message-ID: <alpine.LFD.2.10.1503031359220.5674@riemann>
References: <1424249713-2615-1-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org,
	jkacur@redhat.com
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:37965 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511AbbCCM77 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Mar 2015 07:59:59 -0500
Received: by wesw55 with SMTP id w55so39625864wes.5
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Mar 2015 04:59:58 -0800 (PST)
In-Reply-To: <1424249713-2615-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 18 Feb 2015, Daniel Wagner wrote:

> Deadline tasks are not allowed to set smp affinity.
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> ---
> 
> Hi Clark,
> 
> I missed that one because I tested it only on a UP. Sorry about that.
> 
> cheers,
> daniel
> 
> src/pi_tests/pi_stress.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index cf55712..aaa36c3 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -882,8 +882,21 @@ void *high_priority(void *arg)
>  	pthread_barrier_t *loop_barr = &p->loop_barr;
>  	pthread_mutex_t *loop_mtx = &p->loop_mtx;
>  	int *loop = &p->loop;
> +	cpu_set_t cpu_mask;
> +	int i;
>  
>  	if (high_sa.sched_policy == SCHED_DEADLINE) {
> +		CPU_ZERO(&cpu_mask);
> +		for (i = 0; i < num_processors; i++)
> +			CPU_SET(i, &cpu_mask);
> +		status = sched_setaffinity(0, sizeof(cpu_set_t), &cpu_mask);
> +		if (status < 0) {
> +			pi_error
> +			    ("high_priority[%d]: set cpu affinity*dl): %x\n",
> +			    p->id, status);
> +			return NULL;
> +		}
> +
>  		status = sched_setattr(gettid(), &high_sa, 0);
>  		if (status < 0) {
>  			pi_error
> -- 
> 2.1.0
> 
> --

Signed-off-by: John Kacur <jkacur@redhat.com>

(this will be in the next build)
