Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BFDC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Mar 2021 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD7E64FCA
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Mar 2021 20:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCJUJv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Mar 2021 15:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhCJUJl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Mar 2021 15:09:41 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E58C061574
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Mar 2021 12:09:41 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u4so35709048lfs.0
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Mar 2021 12:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=jirL2BxnxO978V8IhVCLuUrNL7yXLyh2s5Y6Igo6K3Y=;
        b=O2zVRMoFvXA6YATBeJC1uZvcVpJ7kGbAB3yPSiIzsKq2lHqkOLvg7+r5KIkv8AEuoL
         cqlgQDSkGKdOlm7Z/xEh1mK/sCMrZJvtk/3kk84IafYLJqyBo25ZWimniBaQO7OdR50H
         44bFVyvnfV5rv3eFjKVM9BCFXO5C3T5k8/YKnUEvyz69NQpj/Pi225/dojVTwpo1qacc
         RiTT2wC5sU1VNE6fMiyNkz1kvTDMRyWEaYvhq8Ig/GKnbvR0qULzBo1dz1PVA3ayeiKx
         uZrvGluRswYQA69MWtpzE1OXrOw8Zx+zVgwC3eYbJD8Os6qjUyQrU0++rWlKBVakmLDJ
         SZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jirL2BxnxO978V8IhVCLuUrNL7yXLyh2s5Y6Igo6K3Y=;
        b=iIpMu0TkP9TrRNjcr0kUyLAaeuZy9b8PCLmaf+B3zvBaSCCCNccqH8IIyKBAnnKMi/
         FPDNtZ2V8iDdD5/g1MdSdwHBFJ7bIa2x6BnLuE4R/qJpGQgFIoqceVtC7a6LvhFJ8gkv
         8LuXXuu+PO9enSaJJ4ujEQOLHH6RthaEIbOuXih+xFA9MDC4mLk2lJ2S2AP6DzVGeC2N
         3PEVvVh94X8oyyXA1TzmWOcDiapkTIBGPKg2FvqGNb5Io/YU+BrKNnpAacX/wBZB96pb
         0PsWM12OaEZhzIzbeKyo6Rb0rXSJuI7jeycCQQsd0h0UdkkIMH4uuNXWYVvBXunwJlI0
         uEqA==
X-Gm-Message-State: AOAM531lSLPoyZDiWLca+6tzIlG7omxPMYL5OWAMobHTzUJmOA00Kz+m
        v7UEHD9OYKYdhDm6H/u32CCgsVpDhZhLAh0qNgNzesHsMenXJyEQ
X-Google-Smtp-Source: ABdhPJwy/XmBCeK/gpdBDFjP4j7qCws7R7rQkNlCdlk96R2JCzjiIfOo91sQGYn/wgGNSsK01SeaBYZlJYtUvrDrSN8=
X-Received: by 2002:ac2:5e21:: with SMTP id o1mr81931lfg.435.1615406979578;
 Wed, 10 Mar 2021 12:09:39 -0800 (PST)
MIME-Version: 1.0
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Wed, 10 Mar 2021 17:07:47 -0300
Message-ID: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
Subject: PREEMPT_RT benchmark
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,
I'm currently developing a time benchmark application where I want
to measure a real time thread latency. My application is based on
Cyclictest from
the rt-tests suit.
> https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/rt-tests

I programmed in such way that it would be equivalent to Cyclict test
running with the following command line:
> cyclictest -m -n -N --threads=1 --interval=10000 --priority=80 --distance=0 --loops=1000 --clock=1

At least that's what I expected, but my latencies are much bigger than
Cyclictest ones.
From cyclictest I get an average in my computer of  something between
2300 and 2500 nanoseconds.  However, in my application I'm having
something between 47000 and 55000 nanoseconds. As you can see it is
much higher!

I'm not sure of what I'm doing wrong, could you help or suggest something?

Processor Info:
> Intel(R) Core(TM) i3-9100F CPU @ 3.60GHz

System info:
> 4.4.208-rt198 #1 SMP PREEMPT RT Wed Jul 8 16:23:16 -03 2020 x86_64 x86_64 x86_64 GNU/Linux

My application code:

> #include <sys/mman.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sched.h>
> #include <stdint.h>
> #include <time.h>
> #include <pthread.h>
> #define LOOPS 1000
> #define INTERVAL 0.01 //0.01 s = 10 ms = 10000 us = 10000000 ns
> #define USE_NS 1
> #define NSEC_PER_SEC 1000000000
> #define USEC_PER_SEC 1000000
> static inline long int calcdiff_ns(struct timespec t1, struct timespec t2);
> static inline long int calcdiff_us(struct timespec t1, struct timespec t2);
> static inline void time_norm(struct timespec *ts);
>
> void* sim_Thread( void* notUsed );
> pthread_t sim_ThreadID;
> pthread_attr_t sim_AttrThread;
> struct sched_param sim_MySched;
> // Compiler flags: gcc -O0 time_eval_4.c -o time_eval_4 -Wall -lm -lpthread
> int main ()
> {
> if(mlockall(MCL_CURRENT|MCL_FUTURE) == -1)
> {
>                 printf("mlockall failed: %m\n");
>                 exit(-2);
>         }
> pthread_attr_init( &sim_AttrThread );
> sim_MySched.sched_priority = 80;
> pthread_attr_setschedpolicy( &sim_AttrThread, SCHED_FIFO );
> pthread_attr_setinheritsched( &sim_AttrThread, PTHREAD_EXPLICIT_SCHED );
> pthread_attr_setschedparam( &sim_AttrThread, &sim_MySched );
> pthread_create( &sim_ThreadID, &sim_AttrThread, sim_Thread, NULL );
> pthread_join( sim_ThreadID, NULL );
> return 0;
> }
> void* sim_Thread( void* notUsed )
> {
> struct timespec now;
> struct timespec next;
> struct timespec periodicInterval;
> unsigned long int diff;
> unsigned long int j;
> FILE *benchmark_fp;
> benchmark_fp = fopen("Benchmark_4.txt","w+");
> fprintf(benchmark_fp, "loops: %ld \n", (unsigned long int) LOOPS);
> periodicInterval.tv_sec  = (unsigned long int)( INTERVAL );
> periodicInterval.tv_nsec = ( (unsigned long int)( (unsigned long int)( INTERVAL * 1000000000 ) % 1000000000 ) );
> #if USE_NS
> fprintf(benchmark_fp, "interval: %f ns\n",(double) INTERVAL*NSEC_PER_SEC);
> #else
> fprintf(benchmark_fp, "interval: %f us\n",(double) INTERVAL*USEC_PER_SEC);
> #endif
> if( clock_gettime( CLOCK_REALTIME, &now ) != 0 ) return 0;
> next.tv_nsec = now.tv_nsec + periodicInterval.tv_nsec;
> next.tv_sec  = now.tv_sec +  periodicInterval.tv_sec;
> time_norm(&next);
>     for(j=0;j< (unsigned long int) LOOPS; j++ )
>     {
>
> // Wait for the next period to wake up...
> clock_nanosleep( CLOCK_REALTIME, TIMER_ABSTIME, &next, NULL );
> // Get the "now" time moment...
> clock_gettime( CLOCK_REALTIME, &now );
>
> #if USE_NS
>         diff=calcdiff_ns(now, next);
> #else
>     diff=calcdiff_us(now, next);
> #endif
> // Set the timer for interrupt in the next moment...
> next.tv_nsec += periodicInterval.tv_nsec;
> next.tv_sec  += periodicInterval.tv_sec;
> time_norm(&next);
> fprintf(benchmark_fp, "%ld\n", diff);
>     }
>     fclose(benchmark_fp);
> }
> static inline long int calcdiff_ns(struct timespec t1, struct timespec t2)
> {
> long int diff;
> diff = NSEC_PER_SEC * (long int)((int) t1.tv_sec - (int) t2.tv_sec);
> diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
> return diff;
> }
>
> static inline long int calcdiff_us(struct timespec t1, struct timespec t2)
> {
> long int diff;
> diff = USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec);
> diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
> return diff;
> }
> static inline void time_norm(struct timespec *ts)
> {
> while (ts->tv_nsec >= NSEC_PER_SEC) {
> ts->tv_nsec -= NSEC_PER_SEC;
> ts->tv_sec++;
> }
> }


Thanks!
Michel
