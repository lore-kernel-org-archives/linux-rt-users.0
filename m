Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505C9C0015E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 18:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjHISU2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHISU1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 14:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A441A3
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691605189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRGHEiT8pLwtnLA9jEjq2CMH5kXZKfnvGE31ymTiB+8=;
        b=T+q2FaOkLRYKjyEO1xjsjySkEaO2UdPQ0NY7vLnXxyb4s2eHc/qRaG5Hhtfb/AOfkSCPEn
        hMYgFUogE+io77dhjKrphi2Tnx7BqZ2KzCN5GmVIkhw7rJV8VhYDHnUuHS50S+iGLp72V6
        qnVk8hQxAOdo+SfU10gOHOzp/7v43Is=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619--JzZhW_fMhKP51DEQYqEbw-1; Wed, 09 Aug 2023 14:19:46 -0400
X-MC-Unique: -JzZhW_fMhKP51DEQYqEbw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76ce5b9f285so99588085a.1
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Aug 2023 11:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691605186; x=1692209986;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRGHEiT8pLwtnLA9jEjq2CMH5kXZKfnvGE31ymTiB+8=;
        b=A3FM8TVadfvPmIo5/lulq2JhKHerbTWmU7qX9GPh12dL7V8EuBh8ZJxLDejoG+RS/J
         I13fdvnkLD1JwpMiLBQMfVHQgndkDDCB0EucY1ZnAHWVpM8jNeusJfC/4I4Q/yErMAZp
         B0CXv1u5zfzJS9mjslprkvoxfSIYWZFBmj2CibmAQhyA6S4m5Ksns0+623NobrAUMBck
         JcA737XoYoWuZpVdQlpXEL7hTL2s5+blnoBzS1rmCrCYZXm6czzj98T7/r2SuuQYXW8R
         OWtuErYub1cRVXojtDEo4LzJ8Hqf4eZ0k7r+iiTougE1U4AuXm2/Fl8dqJM1s9EUsbql
         MBPQ==
X-Gm-Message-State: AOJu0YwTCF5NwAt2ZM+WXACoyyGjmtxyYVGY0FyGhVFVgosBA6DX7Il/
        gVAsd+hclgD06C2hl/ksQmfzolHuKqhbkkzzj8tSdV/4bak2eWsk6H5yEZFW60z8evKsXTALphc
        yDO+EEA7o69MJJ9qF96YcSSuojJp25vybBBk=
X-Received: by 2002:a05:620a:2401:b0:765:aaa8:d1c9 with SMTP id d1-20020a05620a240100b00765aaa8d1c9mr519846qkn.4.1691605186151;
        Wed, 09 Aug 2023 11:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4N3DB4iXFULL2GF6v/OlEfgSp9XuSMoTOZx4QpvXNbEIBEq/E/zzKFl/rPenlDdGsRMooeQ==
X-Received: by 2002:a05:620a:2401:b0:765:aaa8:d1c9 with SMTP id d1-20020a05620a240100b00765aaa8d1c9mr519833qkn.4.1691605185889;
        Wed, 09 Aug 2023 11:19:45 -0700 (PDT)
Received: from fionn ([184.147.140.157])
        by smtp.gmail.com with ESMTPSA id c17-20020a0cf2d1000000b0063d03e59e07sm4641308qvm.130.2023.08.09.11.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 11:19:45 -0700 (PDT)
Date:   Wed, 9 Aug 2023 14:19:26 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com,
        williams@redhat.com
Subject: Re: [PATCH v2] cyclicdeadline: removed extra pthread_barrier_wait()
 calls
In-Reply-To: <20230809144855.143778-1-ashelat@redhat.com>
Message-ID: <ae2618e7-eaa5-262f-ab2c-dcd4635df8ca@redhat.com>
References: <20230809144855.143778-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 9 Aug 2023, Anubhav Shelat wrote:

> Before this change, cyclicdeadline was giving abnormally high latencies
> and occasionally locking up on start, uncharacteristic of an RT system.
> After removing the extra calls, the latencies were more in line with
> what we expected and there were no lock-ups on run.
> 
> Test runs, courtesy of Clark Williams (aarch64 system running RT kernel):
> 
> Cmd Line: $ sudo ./cyclicdeadline -t8 -a8-15 -D 5m
> 
> The first three test runs were from the current main branch of realtime-tests:
> 
> First run
> 
> T: 0 ( 2074) I:1000 C: 300007 Min:      1 Act:   11 Avg:   10 Max:      34
> T: 1 ( 2075) I:1500 C: 200005 Min:      1 Act:   12 Avg:   10 Max:      30
> T: 2 ( 2076) I:2000 C: 150004 Min:      1 Act:   14 Avg:   11 Max:      36
> T: 3 ( 2077) I:2500 C: 120003 Min:      1 Act:   11 Avg:   10 Max:      42
> T: 4 ( 2078) I:3000 C: 100003 Min:      1 Act:   13 Avg:    6 Max:      35
> T: 5 ( 2079) I:3500 C:  85717 Min:      1 Act:    3 Avg:    8 Max:      28
> T: 6 ( 2080) I:4000 C:  75002 Min:      1 Act:   11 Avg:   10 Max:      43
> T: 7 ( 2081) I:4500 C:  66669 Min:      1 Act:   13 Avg:   10 Max:      31
> 
> Second run
> 
> T: 0 ( 2074) I:1000 C: 300007 Min:      1 Act:   11 Avg:   10 Max:      34
> T: 1 ( 2075) I:1500 C: 200005 Min:      1 Act:   12 Avg:   10 Max:      30
> T: 2 ( 2076) I:2000 C: 150004 Min:      1 Act:   14 Avg:   11 Max:      36
> T: 3 ( 2077) I:2500 C: 120003 Min:      1 Act:   11 Avg:   10 Max:      42
> T: 4 ( 2078) I:3000 C: 100003 Min:      1 Act:   13 Avg:    6 Max:      35
> T: 5 ( 2079) I:3500 C:  85717 Min:      1 Act:    3 Avg:    8 Max:      28
> T: 6 ( 2080) I:4000 C:  75002 Min:      1 Act:   11 Avg:   10 Max:      43
> T: 7 ( 2081) I:4500 C:  66669 Min:      1 Act:   13 Avg:   10 Max:      31
> 
> Third Run
> 
> T: 0 ( 2199) I:1000 C: 300007 Min:      1 Act:   12 Avg:   11 Max:      35
> T: 1 ( 2200) I:1500 C: 200005 Min:      1 Act:   13 Avg:   12 Max:      36
> T: 2 ( 2201) I:2000 C: 150004 Min:      1 Act:   14 Avg:   12 Max:      42
> T: 3 ( 2202) I:2500 C: 120003 Min:      2 Act:   16 Avg:   13 Max:      36
> T: 4 ( 2203) I:3000 C: 100003 Min:      1 Act:   10 Avg:    7 Max:      31
> T: 5 ( 2204) I:3500 C:  85717 Min:      1 Act:   11 Avg:   10 Max:      35
> T: 6 ( 2205) I:4000 C:  75002 Min:      1 Act:   11 Avg:   10 Max:      26
> T: 7 ( 2206) I:4500 C:  66669 Min:      1 Act:   17 Avg:   12 Max:      35
> 
> The second three runs were on the same system but with code that has the pthread_barrier_wait() calls fixed
> 
> First run
> 
> T: 0 ( 4131) I:1000 C: 300004 Min:      1 Act:    3 Avg:    8 Max:      38
> T: 1 ( 4132) I:1500 C: 200003 Min:      1 Act:   13 Avg:    6 Max:      32
> T: 2 ( 4133) I:2000 C: 150002 Min:      1 Act:   12 Avg:    8 Max:      31
> T: 3 ( 4134) I:2500 C: 120002 Min:      1 Act:   11 Avg:   10 Max:      32
> T: 4 ( 4135) I:3000 C: 100002 Min:      1 Act:   11 Avg:   10 Max:      30
> T: 5 ( 4136) I:3500 C:  85716 Min:      1 Act:   12 Avg:   10 Max:      35
> T: 6 ( 4137) I:4000 C:  75001 Min:      1 Act:   11 Avg:   10 Max:      33
> T: 7 ( 4138) I:4500 C:  66668 Min:      1 Act:   10 Avg:    9 Max:      28
> 
> Second run
> T: 0 ( 4353) I:1000 C: 300006 Min:      1 Act:   13 Avg:   10 Max:      34
> T: 1 ( 4354) I:1500 C: 200004 Min:      1 Act:   13 Avg:   11 Max:      28
> T: 2 ( 4355) I:2000 C: 150003 Min:      1 Act:   13 Avg:   11 Max:      32
> T: 3 ( 4356) I:2500 C: 120003 Min:      1 Act:   13 Avg:   11 Max:      38
> T: 4 ( 4357) I:3000 C: 100002 Min:      1 Act:   12 Avg:   11 Max:      29
> T: 5 ( 4358) I:3500 C:  85716 Min:      1 Act:   11 Avg:   11 Max:      31
> T: 6 ( 4359) I:4000 C:  75002 Min:      1 Act:   11 Avg:   10 Max:      32
> T: 7 ( 4360) I:4500 C:  66668 Min:      1 Act:    3 Avg:    2 Max:      19
> 
> Third run
> T: 0 ( 4426) I:1000 C: 300006 Min:      1 Act:   13 Avg:    8 Max:      43
> T: 1 ( 4427) I:1500 C: 200004 Min:      1 Act:    2 Avg:    6 Max:      25
> T: 2 ( 4428) I:2000 C: 150003 Min:      1 Act:   11 Avg:    9 Max:      30
> T: 3 ( 4429) I:2500 C: 120003 Min:      2 Act:   12 Avg:   11 Max:      31
> T: 4 ( 4430) I:3000 C: 100002 Min:      1 Act:   12 Avg:   11 Max:      33
> T: 5 ( 4431) I:3500 C:  85716 Min:      1 Act:   12 Avg:   10 Max:      31
> T: 6 ( 4432) I:4000 C:  75002 Min:      2 Act:   13 Avg:   12 Max:      36
> T: 7 ( 4433) I:4500 C:  66668 Min:      1 Act:   12 Avg:   10 Max:      30
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  src/sched_deadline/cyclicdeadline.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 48b82e7efb01..39aeeb5d0785 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -807,8 +807,6 @@ void *run_deadline(void *data)
>  		return NULL;
>  	}
>  
> -	pthread_barrier_wait(&barrier);
> -
>  	attr.sched_policy = SCHED_DEADLINE;
>  	attr.sched_runtime = sd->runtime_us * 1000;
>  	attr.sched_deadline = sd->deadline_us * 1000;
> @@ -816,8 +814,6 @@ void *run_deadline(void *data)
>  	printf("thread[%d] runtime=%lldus deadline=%lldus\n",
>  	      gettid(), sd->runtime_us, sd->deadline_us);
>  
> -	pthread_barrier_wait(&barrier);
> -
>  	ret = sched_setattr(0, &attr, 0);
>  	if (ret < 0) {
>  		err_msg_n(errno, "[%ld]", tid);
> @@ -1281,8 +1277,6 @@ int main(int argc, char **argv)
>  
>  	atexit(teardown);
>  
> -	pthread_barrier_wait(&barrier);
> -
>  	if (shutdown)
>  		fatal("failed to setup child threads at step 1\n");
>  
> @@ -1312,8 +1306,6 @@ int main(int argc, char **argv)
>  
>  	printf("main thread %d\n", gettid());
>  
> -	pthread_barrier_wait(&barrier);
> -
>  	if (shutdown)
>  		fatal("failed to setup child threads at step 2");
>  
> -- 
> 2.39.3
> 
> 
Nice
Signed-off-by: John Kacur <jkacur@redhat.com>

