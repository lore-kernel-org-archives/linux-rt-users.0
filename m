Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAADC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 08:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2713E61163
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 08:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbhJOIY4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 04:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbhJOIYo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Oct 2021 04:24:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7431BC061777
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Oct 2021 01:22:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s136so4684048pgs.4
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Oct 2021 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2ov929KePKsPaFPc1VrmABScxzdAPHfHq3b58XUkzC0=;
        b=dLGh1j4f6rL/il/BB82g+qkyg0eCpYNvmPtNTmENrjcI2PRoOSyQwDECM7dNMJ4vKv
         wV1Z/CaVtZ5zr2MALYbygxRxw3isq0/l3ZPOis63jXT6ubIMGbXUvF9g9C1E6SSZAjtM
         RN+MedVTTmfDqImEjw3S+VQ2q/Wt7wIvKrvhWe65HlPnWRtKLbF9mPSa/YaSmUJqGRfj
         B9h/qnuIUak6kJstHNe95Wweeq4/LvuUL8B8sQXy/+9wJZOD8iLvaHMCwMBmxMIKPVlB
         O16p12DQs10mz+OcI6zORyNYrcfjSUZkZgo0XMOEdCFDJkT3gV+JOxwE0dKtpEM67dav
         lGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=2ov929KePKsPaFPc1VrmABScxzdAPHfHq3b58XUkzC0=;
        b=GI6DBLvFgOlFQuB49heaHd97RYxRlgPKmst+84jvgYFX9FkHrP/4yoadlOfyQ0J1MT
         BPoxDXPhDAOo9YU1x8OcENIIu4xxfqdUNUrz+7hbRHg5+DjyAq5khMyY9rhO/cuHFim5
         ru2ZndhvHBWJ6ijfjGudkNiHJqpjJi09zjWfyqz62W2PvdcOrshG1qMXuzh/DN3JAUuS
         LQizKRO0WeMHoTd5PXIOM0qIrUbJT+cFBId+aGgfvF0n7bFPyT2nCPcGNfiRRGZ6EzWQ
         XnwbKjk8g5LnMf46VUIaj8c4IxWqB2+1ZS9C5YJzTST+PO6Ell/kTKaUied/+IRin9tZ
         QPag==
X-Gm-Message-State: AOAM533pnHfPxbmaUNrj64knqmPO5y746sPEsWO3rrqSuOBXtyNHLWXI
        /dHc5MKGhNvZOMPEnAGRmgw=
X-Google-Smtp-Source: ABdhPJzz3tb99CJ+2o6v8114Hz1KMNMKs+GIhTRx42aepmja8oYFKByJ2trZqPQuoSNBcVmIykBT3A==
X-Received: by 2002:a63:bf4a:: with SMTP id i10mr8135505pgo.196.1634286119812;
        Fri, 15 Oct 2021 01:21:59 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id oo9sm4771245pjb.53.2021.10.15.01.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 01:21:58 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 5/7] rt-tests: cyclictest: Move signal handler to avoid
 function declaration
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
        <20211014071247.4165329-6-punitagrawal@gmail.com>
        <4ddcdfd6-f5cf-757d-7b27-534b1d2665b8@redhat.com>
Date:   Fri, 15 Oct 2021 17:21:55 +0900
In-Reply-To: <4ddcdfd6-f5cf-757d-7b27-534b1d2665b8@redhat.com> (John Kacur's
        message of "Thu, 14 Oct 2021 14:31:13 -0400 (EDT)")
Message-ID: <87fst21yvw.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

John Kacur <jkacur@redhat.com> writes:

> On Thu, 14 Oct 2021, Punit Agrawal wrote:
>
>> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> 
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>>  src/cyclictest/cyclictest.c | 78 ++++++++++++++++++-------------------
>>  1 file changed, 37 insertions(+), 41 deletions(-)
>> 
>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
>> index 9c67a3ce3034..48a782fe167d 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -220,10 +220,6 @@ static char jsonfile[MAX_PATH];
>>  static struct thread_param **parameters;
>>  static struct thread_stat **statistics;
>>  
>> -static void print_stat(FILE *fp, struct thread_param *par, int index, int verbose, int quiet);
>> -static void rstat_print_stat(struct thread_param *par, int index, int verbose, int quiet);
>> -static void rstat_setup(void);
>> -
>>  static int latency_target_fd = -1;
>>  static int32_t latency_target_value = 0;
>>  
>> @@ -1311,43 +1307,6 @@ static int check_timer(void)
>>  	return (ts.tv_sec != 0 || ts.tv_nsec != 1);
>>  }
>>  
>> -static void sighand(int sig)
>> -{
>> -	if (sig == SIGUSR1) {
>> -		int i;
>> -		int oldquiet = quiet;
>> -
>> -		quiet = 0;
>> -		fprintf(stderr, "#---------------------------\n");
>> -		fprintf(stderr, "# cyclictest current status:\n");
>> -		for (i = 0; i < num_threads; i++)
>> -			print_stat(stderr, parameters[i], i, 0, 0);
>> -		fprintf(stderr, "#---------------------------\n");
>> -		quiet = oldquiet;
>> -		return;
>> -	} else if (sig == SIGUSR2) {
>> -		int i;
>> -		int oldquiet = quiet;
>> -
>> -		if (rstat_fd == -1) {
>> -			fprintf(stderr, "ERROR: rstat_fd not valid\n");
>> -			return;
>> -		}
>> -		rstat_ftruncate(rstat_fd, 0);
>> -		quiet = 0;
>> -		dprintf(rstat_fd, "#---------------------------\n");
>> -		dprintf(rstat_fd, "# cyclictest current status:\n");
>> -		for (i = 0; i < num_threads; i++)
>> -			rstat_print_stat(parameters[i], i, 0, 0);
>> -		dprintf(rstat_fd, "#---------------------------\n");
>> -		quiet = oldquiet;
>> -		return;
>> -	}
>> -	shutdown = 1;
>> -	if (refresh_on_max)
>> -		pthread_cond_signal(&refresh_on_max_cond);
>> -}
>> -
>>  static void print_tids(struct thread_param *par[], int nthreads)
>>  {
>>  	int i;
>> @@ -1566,6 +1525,43 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
>>  }
>>  
>>  
>> +static void sighand(int sig)
>> +{
>> +	if (sig == SIGUSR1) {
>> +		int i;
>> +		int oldquiet = quiet;
>> +
>> +		quiet = 0;
>> +		fprintf(stderr, "#---------------------------\n");
>> +		fprintf(stderr, "# cyclictest current status:\n");
>> +		for (i = 0; i < num_threads; i++)
>> +			print_stat(stderr, parameters[i], i, 0, 0);
>> +		fprintf(stderr, "#---------------------------\n");
>> +		quiet = oldquiet;
>> +		return;
>> +	} else if (sig == SIGUSR2) {
>> +		int i;
>> +		int oldquiet = quiet;
>> +
>> +		if (rstat_fd == -1) {
>> +			fprintf(stderr, "ERROR: rstat_fd not valid\n");
>> +			return;
>> +		}
>> +		rstat_ftruncate(rstat_fd, 0);
>> +		quiet = 0;
>> +		dprintf(rstat_fd, "#---------------------------\n");
>> +		dprintf(rstat_fd, "# cyclictest current status:\n");
>> +		for (i = 0; i < num_threads; i++)
>> +			rstat_print_stat(parameters[i], i, 0, 0);
>> +		dprintf(rstat_fd, "#---------------------------\n");
>> +		quiet = oldquiet;
>> +		return;
>> +	}
>> +	shutdown = 1;
>> +	if (refresh_on_max)
>> +		pthread_cond_signal(&refresh_on_max_cond);
>> +}
>> +
>>  /*
>>   * thread that creates a named fifo and hands out run stats when someone
>>   * reads from the fifo.
>> -- 
>> 2.32.0
>> 
>> 
>
> NACK: What's wrong with function declarations? They allow the freedeom to 
> put your function where you wish. This patch is unnecessary churn, sorry.

I wasn't implying there's anything wrong with a function
declaration. They seemed unnecessary and can be easily avoided. But if
there's a reason to prefer the current placement of the signal handler
(I couldn't see any obvious pattern), I'll drop the patch.

Thanks for comments on the other patches as well. I'll update the set
once you've had a chance to go through the rest.

Punit
