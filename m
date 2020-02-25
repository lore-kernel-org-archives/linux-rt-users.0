Return-Path: <SRS0=1QYP=4N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA911C35E01
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Feb 2020 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD4F2072D
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Feb 2020 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKMiu+Mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgBYP7Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:59:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35147 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgBYP7Z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Feb 2020 10:59:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so12525079otd.2
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Feb 2020 07:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=N6mOYH9x+NuBRrqX9uUHbBPBZNk0t/K8YZLGj82Hcxs=;
        b=uKMiu+MpV5Pc70qwQNF0VCygwaqV+0Go3x3wOL2vE7OeJCNYVVXCfv6q92m7gJXZKa
         FPW3i1jQGFh8XLLyxg1PBzB0f5OG39JHvwcK+ZE7Ivf2yeQDRYGl5wcSaC6jWrTR1FyN
         GvqArdhS7I8TsNx7zXjQ3aQH7qnM81A0grz/Wsaz2ZyMo6qEyr7by7Nf3q7W7zT3+6fM
         cKHJdq6dy0skoSm0CTA+2yv8DbboScdFVfYqAP8HR13irhNO+ga6YfnS5hdnCxJzkNAT
         nUQLygBZ81K7YZqmaXZwWr9iPsrDY4md1qJ/fPx6wEE/uh2AgdcyT60DjmwLz2hfKwsy
         RMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=N6mOYH9x+NuBRrqX9uUHbBPBZNk0t/K8YZLGj82Hcxs=;
        b=VmHGEDBWfUKcOooMGPLAWUkQCvAvrRpPoBoIkMUh/Pxlj2DPN3PdFkVSLrlZlNg8ef
         H1njf/e7k62Ef0fXw5abGIFgRKTzbVTHLdyXjA5UKRJfrWtZOJ4rLGqBDeeojq1cqCHq
         xRNiLwLKzrUXnDpJbsRS9SbaY/yCbmzqC9a63oGfdru2la2U35zw/YlyMRhDdA5wZ8K5
         PJOXs7waqCZPoM1pqvVL63vBSM15sxiIgS/Hw2FuHYlyrIwPY35omEgBX48P4f5KlIp7
         Wqis2VyWzTGm34FsJcJv78/gykNd5NfN1ZYqUOBYIQk5OfinbygDhdlVfE8wbQCm0Zoo
         dLfQ==
X-Gm-Message-State: APjAAAWL1L22tYtm9+p4r/GBENG8PY4fdg5UKx40aCwtqKqZtPf/QQu2
        6yguAbzvzjTgkIlCb7XJxMmBe8bLzNnopFXQg46XVA==
X-Google-Smtp-Source: APXvYqzPXTA4CCmtVUICsjT5UuupaujRhS5or5MQ2CMej9HtP1FgIAH6XH5ogQUBWQm7h8A9W28sr0NMrPbXw8r3dwQ=
X-Received: by 2002:a05:6830:1198:: with SMTP id u24mr44009030otq.215.1582646362522;
 Tue, 25 Feb 2020 07:59:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:9489:0:0:0:0:0 with HTTP; Tue, 25 Feb 2020 07:59:21
 -0800 (PST)
In-Reply-To: <CAPm8-H4ub6MCgnVeMzZ4Lx9kfS76uDCtQrYKM_iq=vQZRh401A@mail.gmail.com>
References: <CAPm8-H4ub6MCgnVeMzZ4Lx9kfS76uDCtQrYKM_iq=vQZRh401A@mail.gmail.com>
From:   Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date:   Tue, 25 Feb 2020 17:59:21 +0200
Message-ID: <CAPm8-H4xHe7Vff=6kHgVonOD4UPh7B3ZxDpp9s7WdXzsEgiFPQ@mail.gmail.com>
Subject: Re: Unexpected high latency on bbb
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2/20/20, Laurentiu-Cristian Duca <laurentiu.duca@gmail.com> wrote:
> Hello,
>
>   I have made a rt-test on kernel preempt-rt 5.4.5
> and got unexpected high latencies (5ms max).
> Maybe I am doing something wrong ... please help
> The same test got 120us max latency on EVL project
> (on 3 hour test with one million samples)
> and only the synchronization is different on preempt_rt
> (referring to rt_gpio module described below).
>
> scenario between beaglebone black computer and fpga board
> ====
> fpga generates an interrupt and counts latency until ack
> bbb receives and ack interrupt via rt_gpio module
> fpga sends latency counter value via SPI to bbb
> bbb prints on the screen
> result: 5ms max latency.
>
> rt_gpio.c module
> ====
> ...
> static struct swait_queue_head head_swait;
>
> static irqreturn_t rt_interrupt_handler(int irq, void *data)
> {
> 	n_interrupts++;
>
> 	/* use swait.h model to signal interrupt arrived */
> 	interrupt_done = 1;
> 	smp_mb();
>  	if (swait_active(&head_swait))
> 		swake_up_one(&head_swait);
>
> 	return IRQ_HANDLED;
> }
>
> static ssize_t rt_gpio_read(struct file *f, char __user *buf, size_t
> 	len, loff_t *off)
> {
> 	int ret;
> 	DECLARE_SWAITQUEUE(swait);
>
> 	/* wait for interrupt using swait.h model */
> 	for (;;) {
> 		prepare_to_swait_exclusive(&head_swait, &swait, TASK_INTERRUPTIBLE);
>  		/* smp_mb() from set_current_state() */
>  		if (interrupt_done)
>  			break;
>  		schedule();
>  	}
> 	finish_swait(&head_swait, &swait);
> 	interrupt_done = 0;
> 	smp_mb();
> 	
> 	gpiod_get_raw_value(gpiod_in)
> 	copy_to_user(...);
> }
>
> static ssize_t rt_gpio_write(struct file *f, const char __user *buf,
> 	size_t len, loff_t *off)
> {
>     copy_from_user(...);
> 	gpiod_set_raw_value(gpiod_out, user_value);
> }
>
> static int __init rt_gpio_init(void) /* Constructor */
> {
> 	...
> 	request_irq(irq_line, rt_interrupt_handler,
> 		IRQ_TYPE_EDGE_RISING | IRQF_NO_THREAD, "rt_gpio interrupt\n", (void
> *)1));
>
> 	init_swait_queue_head(&head_swait);
> 	
> }
>
> static void __exit rt_gpio_exit(void)
> {
> 	free_irq(irq_line, (void*)1);
> 	gpio_free(gpio_in_id);
> 	gpio_free(gpio_out_id);
> 	...
> }
>
>
> userspace
> ====
>     printf("Setup this thread as a real time thread\n");
>   	if((ret = mlockall(MCL_FUTURE|MCL_CURRENT)) < 0) {
>        	printf("mlockall failed: %s\n", strerror(ret));
>        	return -1;
>    	}
>     sp.sched_priority = 98;
>     if((ret = pthread_setschedparam(pthread_self(), SCHED_FIFO, &sp)) != 0)
> {
>         printf("Failed to set lat thread to real-time priority: %s\n",
> strerror(ret));
> 		return -1;
>     }

the mistake was corrected by calling:
	sched_setscheduler(getpid(), SCHED_FIFO, &sp);


>     ...
>     use rt_gpio module to receive interrupt and ack.
>
>
>
> Thank you,
> L-C
>
