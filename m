Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1EDC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jun 2022 12:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347433AbiFOMYz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348478AbiFOMYx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jun 2022 08:24:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EB363A19D
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jun 2022 05:24:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3B40152B;
        Wed, 15 Jun 2022 05:24:51 -0700 (PDT)
Received: from [10.57.5.38] (unknown [10.57.5.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C47F73F73B;
        Wed, 15 Jun 2022 05:24:50 -0700 (PDT)
Message-ID: <19f21e80-ce44-07f0-2361-ece8e6a60ad4@arm.com>
Date:   Wed, 15 Jun 2022 14:24:31 +0200
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

Hello Sebastian,


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

Since starting the threads represents some work that can disturb
the threads, shouldn't the main thread be migrated to the
'mainaffinity' mask early as it is right now ?

I think it would be better to:
1. Save the initial mask of the main thread somewhere
2. Set the affinity of the main thread
3. Use the initial mask when setting the affinity of the threads

Regards,
Pierre

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
