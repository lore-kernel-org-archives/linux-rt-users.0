Return-Path: <SRS0=LpNT=RY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC31FC43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Mar 2019 21:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F58921917
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Mar 2019 21:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfCUV1d (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:27:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47043 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfCUV1d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Mar 2019 17:27:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id o1so119686wrs.13
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Mar 2019 14:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Rqm7ac/x/Lallc3QWbJp9N4x7jU0ErblacsYj2QBmhI=;
        b=EE51QOuvy14DqNjQXycGET2f/XdE7/I9HPAo4AsBuE4Z9s77CsZnGTMuwRjI7+GE8H
         keDU/iW9WoXRHM7hmuiHZS2kZ0zfQ8kNEkjqLD73gmX2kGAFIRTA4sn9wklCCy9ZqfXX
         8F45lc//cyL7bwMXshPmIPrD0ukJMMXiZGGO5ijXLValeJRK9lKUGWdke2ZAK5JYLgOg
         rs+W23npml3Y23FYOp2c/VRl5sOawWMfRfFOIK43Q6F4EOOeTJrtnrgGc8hwF1OiTJB7
         GrnQvmUusxskNoBHZlnmllHjylq9Hvxt8PZdlQKVyOGlTcQgllVQdmiH/GeYjkpb+Wjj
         PKuQ==
X-Gm-Message-State: APjAAAWYIkQhfvggaFAs+afuoiPzLnGl+HbFP2d/5CTkgbkLojIj85Lj
        /ADqBr44hGNziwQYybPHAixq/A==
X-Google-Smtp-Source: APXvYqwiWg6Iohg5BJo5XEifNmfI7HEZWCT9HVcJ/VU7ZChAbCcY8XWR89jPnl1QoBc5sXOkBUhsQQ==
X-Received: by 2002:a5d:63c4:: with SMTP id c4mr3862294wrw.307.1553203651906;
        Thu, 21 Mar 2019 14:27:31 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host42-239-dynamic.117-80-r.retail.telecomitalia.it. [80.117.239.42])
        by smtp.gmail.com with ESMTPSA id w10sm7539967wrn.32.2019.03.21.14.27.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 14:27:31 -0700 (PDT)
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        =?UTF-8?Q?R=c3=b4mulo_Silva_de_Oliveira?= 
        <romulo.deoliveira@ufsc.br>, LKML <linux-kernel@vger.kernel.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: BUG-RT: scheduling while in atomic in the watchdog's hrtimer
Message-ID: <d2eb047a-6c07-e176-aa2a-68a425efd0ae@redhat.com>
Date:   Thu, 21 Mar 2019 22:27:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

In the 4.19/5.0-rt configured !SMP, the following chain of events can
take place:

------------------------------ %< -------------------------------------
smp_apic_timer_interrupt(){
	hrtimer_interrupt() {
		__hrtimer_run_queues() {
			watchdog_timer_fn() {
				stop_one_cpu_nowait() {
					#ifdef !CONFIG_SMP
						schedule_work() {
							queue_work() {
								queue_work_on() {
								/* phew, long, ah!?.... */	
									local_lock_irqsave() {
										__local_lock_irqsave() {
											__local_lock_irq() {
												spin_lock_irqsave() {
													rt_spin_lock()...
														/* from here on you already know...*/
														/* a lot of } */
------------------------------ >% -------------------------------------

And this can cause a scheduling while in atomic.

Tracking down, the commit that introduced the stop_one_cpu_nowait()->
queue_work_on() to the path was:

------------------------------ %< -------------------------------------
commit 9cf57731b63e37ed995b46690adc604891a9a28f
Author: Peter Zijlstra 
Date:   Thu Jun 7 10:52:03 2018 +0200

    watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work
    
    Oleg suggested to replace the "watchdog/%u" threads with
    cpu_stop_work. That removes one thread per CPU while at the same time
    fixes softlockup vs SCHED_DEADLINE.
    
    But more importantly, it does away with the single
    smpboot_update_cpumask_percpu_thread() user, which allows
    cleanups/shrinkage of the smpboot interface.
    
    Suggested-by: Oleg Nesterov 
    Signed-off-by: Peter Zijlstra (Intel) 
    Cc: Linus Torvalds 
    Cc: Peter Zijlstra 
    Cc: Thomas Gleixner 
    Cc: linux-kernel@vger.kernel.org
    Signed-off-by: Ingo Molnar 
------------------------------ >% -------------------------------------

Later modified by:

------------------------------ %< -------------------------------------
commit be45bf5395e0886a93fc816bbe41a008ec2e42e2
Author: Peter Zijlstra 
Date:   Fri Jul 13 12:42:08 2018 +0200

    watchdog/softlockup: Fix cpu_stop_queue_work() double-queue bug
    
    When scheduling is delayed for longer than the softlockup interrupt
    period it is possible to double-queue the cpu_stop_work, causing list
    corruption.
    
    Cure this by adding a completion to track the cpu_stop_work's
    progress.
    
    Reported-by: kernel test robot 
    Tested-by: Rong Chen 
    Signed-off-by: Peter Zijlstra (Intel) 
    Cc: Linus Torvalds 
    Cc: Peter Zijlstra 
    Cc: Thomas Gleixner 
    Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
    Link: http://lkml.kernel.org/r/20180713104208.GW2494@hirez.programming.kicks-ass.net
    Signed-off-by: Ingo Molnar 
------------------------------ >% -------------------------------------

I hit it while trying the automata model against the 4.19-rt/5.0-rt 
kernels.

You can find more about it here:
http://bristot.me/another-bug-found-with-the-model/

Thanks
-- Daniel
