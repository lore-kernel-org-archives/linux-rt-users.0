Return-Path: <SRS0=oqvG=4I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD13C11D05
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 14:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E992068F
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 14:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phOhnh4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgBTOml (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:42:41 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36285 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgBTOmk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Feb 2020 09:42:40 -0500
Received: by mail-ot1-f46.google.com with SMTP id j20so3866799otq.3
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Feb 2020 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RjyU3eivO2H8H+d7BRyyK+QzaCchThcl7JyXxF84l/g=;
        b=phOhnh4Zh3Xmtm/h+9kIlDmdL0Leyi4Pj36iPbaapItpCxrVYmR9znt+Ah+2kUAwnP
         3JBS+iw6ryIiaMVrQB388Fx5DdiYWpf4E+x765FCRIWQmMW+fYaxW7hA4tHeFDBWn7gO
         tjfAM1LBh95+KvkwhtcE6NO4/i2uGwdxqYGxgMy06KTChF67sA3dXIFTe2tI9QB7AUp5
         NN+j7hkz/LGVcbkSztV3X5oyOlG4a9Gxa9fp3Tybpn4dhkIU1DB9e1m40n+lqlK90GGM
         5iPlhOGA9lwme8n0rul1aj35gT2XnYpt8EsHAIu8En6l5C+SgqzQimzYEk92rj9bMPbr
         w4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RjyU3eivO2H8H+d7BRyyK+QzaCchThcl7JyXxF84l/g=;
        b=fNfNqK7xZkRdNf2wYkUAWKtjgZCVJcPv5vd1nDK/XhwXwXaDEDJRzIt8f+O3DcHerj
         9bJLZsl9QaKTRdeiGnESai6h/oJLO1t8Oq3VMnrkuhq1LvJUmeYNHY9IY55wxa5DyxlB
         B8hE45wxaL4sLYk3gaxxgexMJhPBgMMOth7cSe6MKHrUwHu9Kq+KDlZbhJkjWDzFOrl6
         xtTMTkJn8qf/GgeS9gCQnrI2vTVJeW6qBurRV8IFz4iIs0yHs8VE44Cm0DI3ADayrI/V
         S6+IiJnCZ+CAbzQS2Q3+bZsnYUdA0PPslRriARG+aVfYdIOSMOmi7urlK0Y9DaEI4trj
         RgFw==
X-Gm-Message-State: APjAAAX7lQD0S1CGeOWoGGDDpIqSDD/uRH54SBWx9jsKwrSxuEwFnMtE
        8/Ynr/AG1Ai+Pk+ishz2iwQveQ5by/KZxi9lwSF1eA==
X-Google-Smtp-Source: APXvYqzKOdyYqomMGZ26Twpc4x2jMwfnuHbmIUqMkwc/08OT9q6cTzCAxRgwMQfIVcTT75X+jCcSd0XKVinbM59+lp8=
X-Received: by 2002:a9d:7489:: with SMTP id t9mr23165840otk.255.1582209758028;
 Thu, 20 Feb 2020 06:42:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:9489:0:0:0:0:0 with HTTP; Thu, 20 Feb 2020 06:42:36
 -0800 (PST)
From:   Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date:   Thu, 20 Feb 2020 16:42:36 +0200
Message-ID: <CAPm8-H4ub6MCgnVeMzZ4Lx9kfS76uDCtQrYKM_iq=vQZRh401A@mail.gmail.com>
Subject: Unexpected high latency on bbb
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

  I have made a rt-test on kernel preempt-rt 5.4.5
and got unexpected high latencies (5ms max).
Maybe I am doing something wrong ... please help
The same test got 120us max latency on EVL project
(on 3 hour test with one million samples)
and only the synchronization is different on preempt_rt
(referring to rt_gpio module described below).

scenario between beaglebone black computer and fpga board
====
fpga generates an interrupt and counts latency until ack
bbb receives and ack interrupt via rt_gpio module
fpga sends latency counter value via SPI to bbb
bbb prints on the screen
result: 5ms max latency.

rt_gpio.c module
====
...
static struct swait_queue_head head_swait;

static irqreturn_t rt_interrupt_handler(int irq, void *data)
{
	n_interrupts++;

	/* use swait.h model to signal interrupt arrived */
	interrupt_done = 1;
	smp_mb();
 	if (swait_active(&head_swait))
		swake_up_one(&head_swait);

	return IRQ_HANDLED;
}

static ssize_t rt_gpio_read(struct file *f, char __user *buf, size_t
	len, loff_t *off)
{
	int ret;
	DECLARE_SWAITQUEUE(swait);

	/* wait for interrupt using swait.h model */
	for (;;) {
		prepare_to_swait_exclusive(&head_swait, &swait, TASK_INTERRUPTIBLE);
 		/* smp_mb() from set_current_state() */
 		if (interrupt_done)
 			break;
 		schedule();
 	}
	finish_swait(&head_swait, &swait);
	interrupt_done = 0;
	smp_mb();
	
	gpiod_get_raw_value(gpiod_in)
	copy_to_user(...);
}

static ssize_t rt_gpio_write(struct file *f, const char __user *buf,
	size_t len, loff_t *off)
{
    copy_from_user(...);
	gpiod_set_raw_value(gpiod_out, user_value);
}

static int __init rt_gpio_init(void) /* Constructor */
{
	...
	request_irq(irq_line, rt_interrupt_handler,
		IRQ_TYPE_EDGE_RISING | IRQF_NO_THREAD, "rt_gpio interrupt\n", (void *)1));

	init_swait_queue_head(&head_swait);
	
}

static void __exit rt_gpio_exit(void)
{
	free_irq(irq_line, (void*)1);
	gpio_free(gpio_in_id);
	gpio_free(gpio_out_id);
	...
}


userspace
====
    printf("Setup this thread as a real time thread\n");
  	if((ret = mlockall(MCL_FUTURE|MCL_CURRENT)) < 0) {
       	printf("mlockall failed: %s\n", strerror(ret));
       	return -1;
   	}
    sp.sched_priority = 98;
    if((ret = pthread_setschedparam(pthread_self(), SCHED_FIFO, &sp)) != 0) {
        printf("Failed to set lat thread to real-time priority: %s\n",
strerror(ret));
		return -1;
    }
    ...
    use rt_gpio module to receive interrupt and ack.



Thank you,
L-C
