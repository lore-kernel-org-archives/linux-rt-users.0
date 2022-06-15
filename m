Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C8C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jun 2022 16:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347125AbiFOQJY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245563AbiFOQJW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jun 2022 12:09:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F0C43B01E
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jun 2022 09:08:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 210B91570;
        Wed, 15 Jun 2022 09:08:56 -0700 (PDT)
Received: from [10.57.5.38] (unknown [10.57.5.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0458D3F7F5;
        Wed, 15 Jun 2022 09:08:54 -0700 (PDT)
Message-ID: <813cf21f-30da-f1e6-b0f5-a9369e07ed33@arm.com>
Date:   Wed, 15 Jun 2022 18:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] cyclictest: Delay setting of main_affinity_mask after
 creating threads.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
References: <YqnExv0GkIKTSwoI@linutronix.de>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <YqnExv0GkIKTSwoI@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 6/15/22 13:38, Sebastian Andrzej Siewior wrote:
> Assuming the current affinity mask of the task is 0x31 (CPUs 0, 4, 5).
> Starting cyclictest with '-S' option will fork the following threads:
> - monitor, mask 0x31
> - measure thread 1, mask 0x01
> - measure thread 2, mask 0x10
> - measure thread 3, mask 0x20
> 
> works as expected. Using the options '-S --mainaffinity=0' leads to:
> - monitor, mask 0x01
> - measure thread 1, mask 0x01
> - measure thread 2, mask 0x01
> - measure thread 3, mask 0x01
> 
> because the mask of the main thread has been reset early to 0x01 and
> does not allow a CPU mask outside of this mask while setting the
> affinity for the new threads.
> 
> Delay setting the affinity of the main/ monitor thread after the
> measuring threads have been deployed. This leads to the following
> state:
> - monitor, mask 0x01
> - measure thread 1, mask 0x01
> - measure thread 2, mask 0x10
> - measure thread 3, mask 0x20
> 
> Signed-off-by: Sebastian Andrzej Savior <bigeasy@linutronix.de>
> ---
>   src/cyclictest/cyclictest.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index be8285a072b4e..cbf8d00293ec6 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1816,10 +1816,7 @@ int main(int argc, char **argv)
>   		printf("Online CPUs = %d\n", online_cpus);
>   	}
>   
> -	/* Restrict the main pid to the affinity specified by the user */
> -	if (main_affinity_mask != NULL) {
> -		set_main_thread_affinity(main_affinity_mask);
> -	} else if (affinity_mask != NULL) {
> +	if (affinity_mask != NULL) {
>   		set_main_thread_affinity(affinity_mask);

2 other remarks (sorry for the spam):
- In the documentation, '-a' seems to indicate a mask for the threads, not for
   the main process. Should the main thread be restricted to the mask obtained
   for '-a' ?
- I think there is a bug (unrelated to the patch) when issuing:
./cyclictest -l20000 -v -a -t10
This is due to trying to print a NULL the affinity_mask at:
@@ -1088,9 +1093,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
  
                         if (setaffinity == AFFINITY_SPECIFIED && !affinity_mask)
                                 display_help(1);
-                       if (verbose)
-                               printf("Using %u cpus.\n",
-                                       numa_bitmask_weight(affinity_mask));
                         break;
                 case 'A':
                 case OPT_ALIGNED:

The command:
./cyclictest -l20000 -a -t10 -v
will work since '-v' is parsed at last and the 'if (verbose)' statement
is ignored.

>   		if (verbose)
>   			printf("Using %u cpus.\n",
> @@ -2094,6 +2091,10 @@ int main(int argc, char **argv)
>   			fatal("failed to create thread %d: %s\n", i, strerror(status));
>   
>   	}
> +	/* Restrict the main pid to the affinity specified by the user */
> +	if (main_affinity_mask != NULL)
> +		set_main_thread_affinity(main_affinity_mask);
> +
>   	if (use_fifo) {
>   		status = pthread_create(&fifo_threadid, NULL, fifothread, NULL);
>   		if (status)
