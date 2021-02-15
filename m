Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C806C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Feb 2021 04:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F90464E56
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Feb 2021 04:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhBOEJO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 14 Feb 2021 23:09:14 -0500
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:58814 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhBOEJN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 14 Feb 2021 23:09:13 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 11F46vcW021035; Mon, 15 Feb 2021 13:06:57 +0900
X-Iguazu-Qid: 34tKHZCCJBPwyzOvMx
X-Iguazu-QSIG: v=2; s=0; t=1613362016; q=34tKHZCCJBPwyzOvMx; m=xHyuVyAvyJTpM4LSmIt4loXgpX3GNKQB5L+bZRonYhk=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1510) id 11F46urp005842;
        Mon, 15 Feb 2021 13:06:56 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 11F46u6c013156;
        Mon, 15 Feb 2021 13:06:56 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 11F46tq1009308;
        Mon, 15 Feb 2021 13:06:55 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH rt-tests v4 03/16] cyclictest: Simplify --smp vs --affinity vs --threads argument logic
References: <20210210133450.6991-1-dwagner@suse.de>
        <20210210133450.6991-4-dwagner@suse.de>
Date:   Mon, 15 Feb 2021 13:06:52 +0900
In-Reply-To: <20210210133450.6991-4-dwagner@suse.de> (Daniel Wagner's message
        of "Wed, 10 Feb 2021 14:34:37 +0100")
X-TSB-HOP: ON
Message-ID: <877dnax9cz.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Daniel,

Spotted one typo below while browsing through the patches.

Daniel Wagner <dwagner@suse.de> writes:

> Allow each command line only to update one variable and do the final
> decission at the end of the parsing step. With this the order
  ^
  decision

Regards,
Punit

> of the command line is not important.
>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 34 ++++++++--------------------------
>  1 file changed, 8 insertions(+), 26 deletions(-)
>
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 4c02f067fbad..b5cca3ae166b 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -880,14 +880,13 @@ static int timermode = TIMER_ABSTIME;
>  static int use_system;
>  static int priority;
>  static int policy = SCHED_OTHER;	/* default policy if not specified */
> -static int num_threads = 1;
> +static int num_threads = -1;
>  static int max_cycles;
>  static int clocksel = 0;
>  static int quiet;
>  static int interval = DEFAULT_INTERVAL;
>  static int distance = -1;
>  static struct bitmask *affinity_mask = NULL;
> -static int smp = 0;
>  
>  static int clocksources[] = {
>  	CLOCK_MONOTONIC,
> @@ -953,7 +952,7 @@ enum option_values {
>  static void process_options(int argc, char *argv[], int max_cpus)
>  {
>  	int error = 0;
> -	int option_affinity = 0;
> +	int smp = 0;
>  
>  	for (;;) {
>  		int option_index = 0;
> @@ -1008,10 +1007,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		switch (c) {
>  		case 'a':
>  		case OPT_AFFINITY:
> -			option_affinity = 1;
> -			/* smp sets AFFINITY_USEALL in OPT_SMP */
> -			if (smp)
> -				break;
>  			if (optarg) {
>  				parse_cpumask(optarg, max_cpus, &affinity_mask);
>  			} else if (optind < argc &&
> @@ -1019,8 +1014,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  				    argv[optind][0] == '0' ||
>  				    argv[optind][0] == '!')) {
>  				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
> -			} else {
> -				num_threads = -1;
>  			}
>  			break;
>  		case 'A':
> @@ -1108,22 +1101,14 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		case OPT_SYSTEM:
>  			use_system = MODE_SYS_OFFSET; break;
>  		case 'S':
> -		case OPT_SMP: /* SMP testing */
> -			smp = 1;
> -			num_threads = -1; /* update after parsing */
> -			break;
> +		case OPT_SMP:
> +			smp = 1; break;
>  		case 't':
>  		case OPT_THREADS:
> -			if (smp) {
> -				warn("-t ignored due to smp mode\n");
> -				break;
> -			}
>  			if (optarg != NULL)
>  				num_threads = atoi(optarg);
>  			else if (optind < argc && atoi(argv[optind]))
>  				num_threads = atoi(argv[optind]);
> -			else
> -				num_threads = -1; /* update after parsing */
>  			break;
>  		case OPT_TRIGGER:
>  			trigger = atoi(optarg);
> @@ -1179,13 +1164,10 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		use_nanosleep = MODE_CLOCK_NANOSLEEP;
>  	}
>  
> -	if (option_affinity && smp) {
> -		warn("-a ignored due to smp mode\n");
> -		if (affinity_mask) {
> -			numa_bitmask_free(affinity_mask);
> -			affinity_mask = NULL;
> -		}
> -	}
> +	if (smp && num_threads != -1)
> +		warn("--threads overwrites smp mode\n");
> +	if (smp && affinity_mask)
> +		warn("--affinity overwrites smp mode\n");
>  
>  	if (smi) {
>  		if (affinity_mask)
