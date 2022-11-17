Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0BAC433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Nov 2022 06:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiKQGzR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 01:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKQGzP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Nov 2022 01:55:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9615B588
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Nov 2022 22:55:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s5so1161804edc.12
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Nov 2022 22:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVFu2qgoNWO7PTRZcOmS8TSIcuRdq8GfQBjjqkclLWQ=;
        b=aE0i3P4VVzJDDVmMy0qHubVw3OXFy21B/OIVG/hof7di3lcu5SzWPDcX2sLFKOp5iY
         sEPC7QHrKtofLB2PCPDJJWN7ET7vBV7nwW3HxnBT0JZuAr4zgCHgNkNLwh0oGGc+JLlm
         AUpOwpgP6TCri6+Zeo5Zj/swUZugrgg8enQjeg8BMN2I1AnOby5wytISmvilB45sh/IL
         BsJVZ2zX+4K9fufPnRhDwRaHf9HU7u+j1lfPyy/mMguLO8rs0x7jbp7m7LeLRkBkHpW/
         MAvieHRQNOsEOJvGTVJjl3wDv7hIX+fWqcg7fURKS7bXJSHYpzQCr2DIFCXwO4wO8Kdl
         E+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LVFu2qgoNWO7PTRZcOmS8TSIcuRdq8GfQBjjqkclLWQ=;
        b=lL45EGe48sF2hsILYxIDqMarsUwBRdKaV3KlsMSCnos16lCNTKILDtGmO8ep4JQB3v
         DkPzBEMK+oDmuaXaxo+bQCCEOdAsn+1jo9HMs7DPiMfw7mskduzmnvS8/XwkwmKESVV5
         bA2BpyezsoKtIZXGXfuBmVZIYjEAcz9P7Pf1nUv5lvkLbDhYnLM5cGdnhdEyAXQC5NhY
         C8Pi+TYYuqK6LOQ1WWmu+FIAy2uzTLfwgE/Nuvns7QCxjerMBiNTQ1PUmndsxlHbzrZ+
         BU8qXOW1GV551W8HxA5lw1VKUuJ16fYK/Ub7S6UhrpQ8fNqVF797WaMptPWjBhAgYfzN
         ejbQ==
X-Gm-Message-State: ANoB5pnCOwKnycjjZxQ+EqWcXbyD3M/ngt2Qz6NS+JRs33coU0myqzpm
        Uqqpdh4HvSyxXkB8ebe1geN5HzEMrUs=
X-Google-Smtp-Source: AA0mqf4hUD1hj/HE4eL89bmDq8ZdjCIzEGUV6ovp+dimdFFzHZ/aloQuSk8EoYbaBf4uTiiXakPEwA==
X-Received: by 2002:aa7:c60b:0:b0:462:750b:bced with SMTP id h11-20020aa7c60b000000b00462750bbcedmr927033edq.313.1668668112243;
        Wed, 16 Nov 2022 22:55:12 -0800 (PST)
Received: from [192.168.1.6] ([5.28.144.164])
        by smtp.googlemail.com with ESMTPSA id kw9-20020a170907770900b00781dbdb292asm7649655ejc.155.2022.11.16.22.55.10
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 22:55:11 -0800 (PST)
Message-ID: <be1a23f2-f8c1-17f0-db77-a32469fa56fa@gmail.com>
Date:   Thu, 17 Nov 2022 08:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
From:   yosi yarchi <yosi.yarchi@gmail.com>
Subject: high prioritized threaded interrupt is delayed due to low priority
 softirq job
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  Hi

  my platform is:
    SAM9X35 (8 CAN mailboxes),
    Linux mscb 5.4.41-linux4sam-2020.04-rt24 #1 PREEMPT_RT Wed Nov 9 
06:12:28 UTC 2022 armv5tejl GNU/Linux
    CAN threaded interrupt (irq/30-can0-346) is configured to be highest 
priority on
      system, and it is scheduled very quickly after CAN irq_handler expires
      (irq_handler_entry: irq=30 name=can0), doing its job (at91_irq).

  my problem is that from time to time I get CAN RX overflow. problem 
analysis is as the following (see trace below):
    after CAN threaded interrupt completes its job (at91_irq_r), 
scheduler force it to
      run some other low priority softirq jobs (softirq_entry: vec=1 
[action=TIMER],
      softirq_entry: vec=3 [action=NET_RX]). during the processing of 
those jobs, new HW
      CAN irq_handler expires (irq_handler_entry: irq=30 name=can0), but 
scheduler
      schedule the at91_irq job at the end of job queue, which is too 
late, and I get CAN
      rx overflow.

  I've tried some solutions, no one worked out of the box:
    1. disable all relevant irqs (timer, network) at CAN irq_handler 
(irq_handler_entry:
      irq=30 name=can0), and enable them at the end of CAN threaded 
interrupt job
      processing (at91_irq_r)
    2. configure CAN job (at91_irq) to run inside the CAN irq_handler 
(irq_handler_entry:
      irq=30 name=can0) by adding IRQF_NO_THREAD flag to request_irq.

  is there built-in solution for this problem at linux-rt?
  if not, what could be good 'hacked' solutions for the problem?

  with best regards
  Yosi Yarchi

  kernel trace:
  -------------

         <idle>-0     [000] d..h1..  6020.481859: irq_handler_entry: 
irq=30 name=can0
         <idle>-0     [000] d..h1..  6020.481875: irq_handler_exit: 
irq=30 ret=handled
    irq/30-can0-346   [000] d......  6020.481972: at91_irq: 
(at91_irq+0x0/0xab0)
    irq/30-can0-346   [000] d...1..  6020.482090: at91_irq_r: 
(irq_forced_thread_fn+0x3c/0x8c <- at91_irq)
         <idle>-0     [000] d..h1..  6020.482330: irq_handler_entry: 
irq=30 name=can0
         <idle>-0     [000] d..h1..  6020.482347: irq_handler_exit: 
irq=30 ret=handled
    irq/30-can0-346   [000] d......  6020.482438: at91_irq: 
(at91_irq+0x0/0xab0)
    irq/30-can0-346   [000] d...1..  6020.482553: at91_irq_r: 
(irq_forced_thread_fn+0x3c/0x8c <- at91_irq)
         <idle>-0     [000] d..h1..  6020.482812: irq_handler_entry: 
irq=30 name=can0
         <idle>-0     [000] d..h1..  6020.482829: irq_handler_exit: 
irq=30 ret=handled
    irq/30-can0-346   [000] d......  6020.482923: at91_irq: 
(at91_irq+0x0/0xab0)
    irq/30-can0-346   [000] d...1..  6020.483040: at91_irq_r: 
(irq_forced_thread_fn+0x3c/0x8c <- at91_irq)
         <idle>-0     [000] d..h1..  6020.483290: irq_handler_entry: 
irq=30 name=can0
         <idle>-0     [000] d..h1..  6020.483308: irq_handler_exit: 
irq=30 ret=handled
    irq/30-can0-346   [000] d......  6020.483400: at91_irq: 
(at91_irq+0x0/0xab0)
    irq/30-can0-346   [000] d...1..  6020.483514: at91_irq_r: 
(irq_forced_thread_fn+0x3c/0x8c <- at91_irq)
         <idle>-0     [000] d..h1..  6020.483781: irq_handler_entry: 
irq=30 name=can0
         <idle>-0     [000] d..h1..  6020.483799: irq_handler_exit: 
irq=30 ret=handled
    irq/30-can0-346   [000] d..h...  6020.483891: irq_handler_entry: 
irq=16 name=tc_clkevt
    irq/30-can0-346   [000] d..h...  6020.483956: softirq_raise: vec=1 
[action=TIMER]
    irq/30-can0-346   [000] d..h...  6020.484006: irq_handler_exit: 
irq=16 ret=handled
    irq/30-can0-346   [000] d......  6020.484048: at91_irq: 
(at91_irq+0x0/0xab0)
    irq/30-can0-346   [000] d...1..  6020.484169: at91_irq_r: 
(irq_forced_thread_fn+0x3c/0x8c <- at91_irq)
    irq/30-can0-346   [000] .......  6020.484207: softirq_entry: vec=1 
[action=TIMER]
    irq/30-can0-346   [000] d..h1..  6020.484254: irq_handler_entry: 
irq=30 name=can0
    irq/30-can0-346   [000] d..h1..  6020.484267: irq_handler_exit: 
irq=30 ret=handled
    irq/30-can0-346   [000] d......  6020.484493: softirq_raise: vec=3 
[action=NET_RX]
    irq/30-can0-346   [000] .......  6020.485282: softirq_exit: vec=1 
[action=TIMER]
    irq/30-can0-346   [000] .......  6020.485306: softirq_entry: vec=3 
[action=NET_RX]
    irq/30-can0-346   [000] d..h...  6020.485607: irq_handler_entry: 
irq=16 name=tc_clkevt
    irq/30-can0-346   [000] d..h...  6020.485673: irq_handler_entry: 
irq=17 name=at91_rtc
    irq/30-can0-346   [000] d..h...  6020.485685: irq_handler_exit: 
irq=17 ret=handled
    irq/30-can0-346   [000] d..h...  6020.485706: irq_handler_entry: 
irq=17 name=atmel_usart_serial.0.auto
    irq/30-can0-346   [000] d..h...  6020.485713: irq_handler_exit: 
irq=17 ret=handled
    irq/30-can0-346   [000] d..h...  6020.485754: irq_handler_exit: 
irq=16 ret=handled
    irq/30-can0-346   [000] d..h...  6020.486008: irq_handler_entry: 
irq=29 name=eth0
    irq/30-can0-346   [000] d..h...  6020.486027: irq_handler_exit: 
irq=29 ret=handled
    irq/30-can0-346   [000] .......  6020.486571: softirq_exit: vec=3 
[action=NET_RX]
    irq/30-can0-346   [000] d......  6020.486626: at91_irq: 
(at91_irq+0x0/0xab0)
    irq/30-can0-346   [000] d......  6020.486788: at91_rx_overflow_err: 
(at91_irq+0x200/0xab0)

