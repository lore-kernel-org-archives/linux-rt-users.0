Return-Path: <SRS0=2Bnr=75=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A80FC433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 06:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790EE2074D
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 06:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mba+hDnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgFPG6H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:58:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20177 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726479AbgFPG6H (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jun 2020 02:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592290685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cj7egm433zDx7p0Bf3v5g4Pn5xUDLLu2s6YW2IvP0Nc=;
        b=Mba+hDnDMs+3rQ5DLVyGZDOm3PfW+byqsmDBpmnZTDuVqFrE9vDP296eHnk4AepbF+kIKu
        gPd/Qp5NXcvIPN6hfEOD+4OPVBkF+nFSobVj/yGNIOMBjxpoCDaljE8GzZThU3fff1tTr2
        ieQJhCTqOHELEK6jQUcSDU85ZQToMiE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-J_k0fVdQO_ewcJQkevZq3w-1; Tue, 16 Jun 2020 02:58:03 -0400
X-MC-Unique: J_k0fVdQO_ewcJQkevZq3w-1
Received: by mail-wm1-f71.google.com with SMTP id v24so846317wmh.3
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Jun 2020 23:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cj7egm433zDx7p0Bf3v5g4Pn5xUDLLu2s6YW2IvP0Nc=;
        b=Tyw6GNv2+0vNapKqeJcg0pY805Y1to/37An8PvW4Oz0w9ydQP+6Magy0r7D6HY8TMZ
         GhQbIRr/0GYKTyFrF/XSaCKNKUqps2W/lvo+kqt4oEdph616JzbSbXoRm0zezccUO2+S
         KVDT7tH+EzJJP35DZM9VtS7+GfNTNoaP9ojpbUEVwkBzwPkbenJuRqG2SmHsHRpL+d1y
         nGe1KJZb+B0WcFbxixyp4rFyWgijEBTfMBEWduudoQPFHqa1+cEmPXEH5o+90JPJgNsW
         xeYt52ER5FrLemWhp56j1UNnAeS6Lhdve2c6CajnmiNldmE+YiMKi5tiFKXKdmEbg36t
         3lMg==
X-Gm-Message-State: AOAM533tlCPJUWvjsu8vFIHEbvjqrTFWJBnIap4ZxT7tvkzyUyTGG8kz
        OVeOPKqXtWjsqBUCdSaUjxcRCt9/aUo5Qke898Me7pH3L+VcHFwNf2ARxqa1DI/oA3kMXGWULIi
        jJwjQ3PCQn2wbKNAtSNIrYor+2yM=
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr1566959wmb.3.1592290681167;
        Mon, 15 Jun 2020 23:58:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRUntKCyQbRTz8MSt1OzwEg6dE6VJryUp1MF5aPpZ6v1DVXaaL0ZbLFbPyhXkAR+MpNQfU0Q==
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr1566942wmb.3.1592290680842;
        Mon, 15 Jun 2020 23:58:00 -0700 (PDT)
Received: from localhost.localdomain ([151.29.176.125])
        by smtp.gmail.com with ESMTPSA id 30sm28927623wrd.47.2020.06.15.23.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:58:00 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:57:57 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200616065757.GA446382@localhost.localdomain>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
 <20200520162400.GA8800@lenoir>
 <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
 <20200520184710.GO10078@localhost.localdomain>
 <20200521004443.GB15455@lenoir>
 <20200521170020.GQ10078@localhost.localdomain>
 <20200615210743.GA21371@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615210743.GA21371@lenoir>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 15/06/20 23:07, Frederic Weisbecker wrote:
> On Thu, May 21, 2020 at 07:00:20PM +0200, Juri Lelli wrote:

[...]

> >   sysjitter-2377  [004]   100.438495: sched_switch:         sysjitter:2377 [120] R ==> ksoftirqd/4:31 [120]
> > ksoftirqd/4-31    [004]   100.438497: softirq_entry:        vec=1 [action=TIMER]
> > ksoftirqd/4-31    [004]   100.438499: timer_cancel:         timer=0xffffffffa55a9d20
> > ksoftirqd/4-31    [004]   100.438501: timer_expire_entry:   timer=0xffffffffa55a9d20 function=clocksource_watchdog now=4294759824 baseclk=4294759824
> > ksoftirqd/4-31    [004]   100.438504: timer_start:          timer=0xffffffffa55a9d20 function=clocksource_watchdog expires=4294760322 [timeout=498] cpu=5 idx=113 flags=D|P|I

[...]

> > ksoftirqd/4-31    [004]   100.438509: hrtimer_cancel:       hrtimer=0xffff92e9df91fd20
> > ksoftirqd/4-31    [004]   100.438511: hrtimer_expire_entry: hrtimer=0xffff92e9df91fd20 now=92630515022 function=tick_sched_timer/0x0
> > ksoftirqd/4-31    [004]   100.438515: kernel_stack:         <stack trace>
> > => __ftrace_trace_stack (ffffffffa37da921)
> > => __raise_softirq_irqoff (ffffffffa36daf50)
> > => raise_softirq (ffffffffa36db0fe)
> > => rcu_sched_clock_irq (ffffffffa375af4a)
> > => update_process_times (ffffffffa3768fa4)
> > => tick_sched_handle (ffffffffa377aaa2)
> > => tick_sched_timer (ffffffffa377ad53)
> > => __hrtimer_run_queues (ffffffffa3769cf0)
> > => hrtimer_interrupt (ffffffffa376a58a)
> > => smp_apic_timer_interrupt (ffffffffa40028f8)
> > => apic_timer_interrupt (ffffffffa4001b7f)
> > => filter_pred_32 (ffffffffa37f3357)
> > => filter_match_preds (ffffffffa37f3510)
> > => trace_event_buffer_commit (ffffffffa37dc7eb)
> > => trace_event_raw_event_softirq (ffffffffa36dab77)
> > => __do_softirq (ffffffffa420025a)
> > => run_ksoftirqd (ffffffffa36dadc6)
> > => smpboot_thread_fn (ffffffffa36ffdb8)
> > => kthread (ffffffffa36f9fb7)
> > => ret_from_fork (ffffffffa4000215)
> > ksoftirqd/4-31    [004]   100.438516: softirq_raise:        vec=9 [action=RCU]
> > ksoftirqd/4-31    [004]   100.438520: kernel_stack:         <stack trace>
> > => __ftrace_trace_stack (ffffffffa37da921)
> > => __raise_softirq_irqoff (ffffffffa36daf50)
> > => raise_softirq (ffffffffa36db0fe)
> > => trigger_load_balance (ffffffffa371cb9c)
> > => update_process_times (ffffffffa3768fc7)
> > => tick_sched_handle (ffffffffa377aaa2)
> > => tick_sched_timer (ffffffffa377ad53)
> > => __hrtimer_run_queues (ffffffffa3769cf0)
> > => hrtimer_interrupt (ffffffffa376a58a)
> > => smp_apic_timer_interrupt (ffffffffa40028f8)
> > => apic_timer_interrupt (ffffffffa4001b7f)
> > => filter_pred_32 (ffffffffa37f3357)
> > => filter_match_preds (ffffffffa37f3510)
> > => trace_event_buffer_commit (ffffffffa37dc7eb)
> > => trace_event_raw_event_softirq (ffffffffa36dab77)
> > => __do_softirq (ffffffffa420025a)
> > => run_ksoftirqd (ffffffffa36dadc6)
> > => smpboot_thread_fn (ffffffffa36ffdb8)
> > => kthread (ffffffffa36f9fb7)
> > => ret_from_fork (ffffffffa4000215)
> > ksoftirqd/4-31    [004]   100.438520: softirq_raise:        vec=7 [action=SCHED]
> > ksoftirqd/4-31    [004]   100.438521: hrtimer_expire_exit:  hrtimer=0xffff92e9df91fd20
> > ksoftirqd/4-31    [004]   100.438523: hrtimer_start:        hrtimer=0xffff92e9df91fd20 function=tick_sched_timer/0x0 expires=92631512937 softexpires=92631512937
> > ksoftirqd/4-31    [004]   100.438525: local_timer_exit:     vector=236
> > ksoftirqd/4-31    [004]   100.438527: tick_stop:            success=0 dependency=SCHED

[...]

> > ksoftirqd/4-31    [004]   100.438530: softirq_exit:         vec=1 [action=TIMER]
> 
> Was there a corresponding softirq_enter? With timers expiring inside?

The one up above, at 100.438497.

[...]

> > 
> > Does this make sense and help in any way? Suggestions for debugging this
> > further? :-)
> 
> Let's see if I can reproduce it first. If not I'll need to bother you further :)

Sure. Let me know if you find anything.

Best,

Juri

