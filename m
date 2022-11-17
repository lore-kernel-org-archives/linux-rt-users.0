Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675DDC433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Nov 2022 07:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiKQHOW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 02:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239129AbiKQHOR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Nov 2022 02:14:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6496EB5E
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Nov 2022 23:14:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y16so2092477wrt.12
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Nov 2022 23:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDXXGtu2rOwfWZu83oiXYsGzX6Wsi39Jr44lJekKaTw=;
        b=X0NSaL119m0W8uXSpSl6Sv0jocVjM2TUj8ER/mkhk6sxmadnXyACGZcCTuRCJuQhRf
         QXiCcLTU7jqZ3566J7KTw8OyNpOs+SpGmHkDYSDo9/okpdUEY55ejHIYEcav/X29gtgC
         tgNlv8e1+tDq07VV+4sbay9uyuiGB2c0d1/Q5nd3I4KrCuc3J2/4AbFdCUSNwJQEg0+M
         tj7Iij/Cdq/bNFJTPgzJsH/Pi75bttkk5v4n/tKzWUorP946dv0ydYzvHXBqLrKFWr5S
         d4TmNCMLpGCWS9X4ROYr8UlyvjUA0utoY9Ej4l8naNFHPsa/lcnFoWXimjBm8/9LUwDM
         YeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDXXGtu2rOwfWZu83oiXYsGzX6Wsi39Jr44lJekKaTw=;
        b=RXO25KoWbYtFCa5jmFoaTw9i/SLe7Uhmcuz70X7rHT8oMeDBOdcA20wCMpHX0owC1h
         4mrGVhX1pewyNxcMBceZiAdSnMSrhyU2dAjrQKGUj4O5dGONz0HCVPRugV9nJt4/T89d
         txhmwWw6vjwO0KVD4j6igsRzjgMueRBSx9ADc3tSKrxnbRtJKAL9/PnXpyWRlZTTcCvQ
         dQJ63x5U8iL0gnThOxDNliQyBh6EMJyndLe7LrHb1YY66WWuVC/AE4tB3bTmC5USpqp3
         bIGMtoALRKejX4mcMR3Hv9NEWLFHA7FVPBg3GGRRbVHX4v9LPtIMMQY4SMH43uC1iku4
         7fuA==
X-Gm-Message-State: ANoB5pmUuDUfBvFcUN71BnsQRLciZV8ohZNSjiq1eC6tv2Tow+KzfIf5
        swLsw/lhQxg1NCmrxgtCR2OE0hDgSI4=
X-Google-Smtp-Source: AA0mqf6IBk+ZLHMnww8l2carFvAVw2cIHxBuqo5KZQo/LZ0ghZb2QsqoL375Sdr/b4Ro5gTlUUUMJw==
X-Received: by 2002:a05:6000:105:b0:236:64e6:8c04 with SMTP id o5-20020a056000010500b0023664e68c04mr556161wrx.579.1668669254727;
        Wed, 16 Nov 2022 23:14:14 -0800 (PST)
Received: from [192.168.1.6] ([5.28.144.164])
        by smtp.googlemail.com with ESMTPSA id n17-20020a05600c465100b003cf483ee8e0sm4104622wmo.24.2022.11.16.23.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 23:14:14 -0800 (PST)
Message-ID: <656ed13b-df87-ac56-ea39-7222dcb80bf6@gmail.com>
Date:   Thu, 17 Nov 2022 09:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     yosi.yarchi@gmail.com
Cc:     linux-rt-users@vger.kernel.org
References: <be1a23f2-f8c1-17f0-db77-a32469fa56fa@gmail.com>
Subject: Re: high prioritized threaded interrupt is delayed due to low
 priority softirq job
Content-Language: en-US
From:   yosi yarchi <yosi.yarchi@gmail.com>
In-Reply-To: <be1a23f2-f8c1-17f0-db77-a32469fa56fa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi


I hope this mail will be more readable (prev mail lines had been cut):



my platform is:

1. SAM9X35 (8 CAN mailboxes),

2. Linux mscb 5.4.41-linux4sam-2020.04-rt24 #1 PREEMPT_RT Wed Nov 9 
06:12:28 UTC 2022 armv5tejl GNU/Linux

3. CAN threaded interrupt (irq/30-can0-346) is configured to be highest 
priority on system, and it is scheduled very quickly after CAN 
irq_handler expires (irq_handler_entry: irq=30 name=can0), doing its job 
(at91_irq).


my problem is that from time to time I get CAN RX overflow. problem 
analysis is as the following (see trace below): after CAN threaded 
interrupt completes its job (at91_irq_r), scheduler force it to run some 
other low priority softirq jobs (softirq_entry: vec=1 [action=TIMER], 
softirq_entry: vec=3 [action=NET_RX]). during the processing of those 
jobs, new HW CAN irq_handler expires (irq_handler_entry: irq=30 
name=can0), but scheduler schedule the at91_irq job at the end of job 
queue, which is too late, and I get CAN rx overflow.


I've tried some solutions, no one worked out of the box:

1. disable all relevant irqs (timer, network) at CAN irq_handler 
(irq_handler_entry: irq=30 name=can0), and enable them at the end of CAN 
threaded interrupt job processing (at91_irq_r)

2. configure CAN job (at91_irq) to run inside the CAN irq_handler 
(irq_handler_entry: irq=30 name=can0) by adding IRQF_NO_THREAD flag to 
request_irq.


is there built-in solution for this problem at linux-rt?
if not, what could be good 'hacked' solutions for the problem?

with best regards
Yosi Yarchi


kernel trace:
-------------

      <idle>-0   d..h1 1859: irq_handler_entry: irq=30 name=can0
      <idle>-0   d..h1 1875: irq_handler_exit: irq=30 ret=handled
irq/30-can0-346 d.... 1972: at91_irq: (at91_irq+0x0/0xab0)
irq/30-can0-346 d...1 2090: at91_irq_r: (irq_forced_thread_fn+0x3c/0
      <idle>-0   d..h1 2330: irq_handler_entry: irq=30 name=can0
      <idle>-0   d..h1 2347: irq_handler_exit: irq=30 ret=handled
irq/30-can0-346 d.... 2438: at91_irq: (at91_irq+0x0/0xab0)
irq/30-can0-346 d...1 2553: at91_irq_r: (irq_forced_thread_fn+0x3c/0
      <idle>-0   d..h1 2812: irq_handler_entry: irq=30 name=can0
      <idle>-0   d..h1 2829: irq_handler_exit: irq=30 ret=handled
irq/30-can0-346 d.... 2923: at91_irq: (at91_irq+0x0/0xab0)
irq/30-can0-346 d...1 3040: at91_irq_r: (irq_forced_thread_fn+0x3c/0
      <idle>-0   d..h1 3290: irq_handler_entry: irq=30 name=can0
      <idle>-0   d..h1 3308: irq_handler_exit: irq=30 ret=handled
irq/30-can0-346 d.... 3400: at91_irq: (at91_irq+0x0/0xab0)
irq/30-can0-346 d...1 3514: at91_irq_r: (irq_forced_thread_fn+0x3c/0
      <idle>-0   d..h1 3781: irq_handler_entry: irq=30 name=can0
      <idle>-0   d..h1 3799: irq_handler_exit: irq=30 ret=handled
irq/30-can0-346 d..h. 3891: irq_handler_entry: irq=16 name=tc_clkevt
irq/30-can0-346 d..h. 3956: softirq_raise: vec=1 [action=TIMER]
irq/30-can0-346 d..h. 4006: irq_handler_exit: irq=16 ret=handled
irq/30-can0-346 d.... 4048: at91_irq: (at91_irq+0x0/0xab0)
irq/30-can0-346 d...1 4169: at91_irq_r: (irq_forced_thread_fn+0x3c/0
irq/30-can0-346 ..... 4207: softirq_entry: vec=1 [action=TIMER]
irq/30-can0-346 d..h1 4254: irq_handler_entry: irq=30 name=can0
irq/30-can0-346 d..h1 4267: irq_handler_exit: irq=30 ret=handled
irq/30-can0-346 d.... 4493: softirq_raise: vec=3 [action=NET_RX]
irq/30-can0-346 ..... 5282: softirq_exit: vec=1 [action=TIMER]
irq/30-can0-346 ..... 5306: softirq_entry: vec=3 [action=NET_RX]
irq/30-can0-346 d..h. 5607: irq_handler_entry: irq=16 name=tc_clkevt
irq/30-can0-346 d..h. 5673: irq_handler_entry: irq=17 name=at91_rtc
irq/30-can0-346 d..h. 5685: irq_handler_exit: irq=17 ret=handled
irq/30-can0-346 d..h. 5706: irq_handler_entry: irq=17 name=atmel_usa
irq/30-can0-346 d..h. 5713: irq_handler_exit: irq=17 ret=handled
irq/30-can0-346 d..h. 5754: irq_handler_exit: irq=16 ret=handled
irq/30-can0-346 d..h. 6008: irq_handler_entry: irq=29 name=eth0
irq/30-can0-346 d..h. 6027: irq_handler_exit: irq=29 ret=handled
irq/30-can0-346 ..... 6571: softirq_exit: vec=3 [action=NET_RX]
irq/30-can0-346 d.... 6626: at91_irq: (at91_irq+0x0/0xab0)
irq/30-can0-346 d.... 6788: at91_rx_overflow_err: (at91_irq+0x200/0x

