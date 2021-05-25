Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256A3C2B9F8
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 May 2021 14:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054C161417
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 May 2021 14:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhEYOcb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 May 2021 10:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbhEYOc0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 May 2021 10:32:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CDEC061574
        for <linux-rt-users@vger.kernel.org>; Tue, 25 May 2021 07:30:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y7so18956556eda.2
        for <linux-rt-users@vger.kernel.org>; Tue, 25 May 2021 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:from:to:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rZjjntTCkDIVx+RmRwl8WiFi/7fs8GZW/lBVdjbOE9o=;
        b=GxhHnt1dTplddPIbtQvUPtiuiuYtU0NG0XC7fwNejtnyje8MU+3GbztyxeVOl0SZxv
         NyJoZ+Yxwu4hoE4fZhSiuCRYePDtoWwxpAHFr1av5VZOfBJJsilIGCIMswDyH+/cjEeb
         124WLqhNEf6aMRycbaxvP5PVpc4Xy/payhKn+2wi1WpJBo5sYXXrHVMPWzyhwSHUSIAl
         Yxe3FXnxhupQHCwGtQmz9K0Jk5dbqwS9tvAs+7Jo4OOXGSo5M1WwSK4mNE7oWcwpSLok
         4JFsniZsF1nmcGVnOJzl8arxYDo/yOCd2HvAInwHSOe0PK4np4gaTVWNsC1YpdlACpLX
         PWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:from:to:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZjjntTCkDIVx+RmRwl8WiFi/7fs8GZW/lBVdjbOE9o=;
        b=YqPtjxQlba4mxe/FWFrVXb2EbAY5F/hZeNNttoZARk8vi9yfaae3/1Ft5MqWaN4kP1
         TI9QvK+Yz2RUHQJC5TKBOPdZjX3Z2QrhDmE1nrG8U6zqFLEoMHUI9VW809rZBTfWZSVq
         Y9Hke9R2/zZx0oYsybkgZQFFW6i9S4qf8Fd8prdYmAiplVsGByTpi3YQHyPJ/Pd7XMoO
         YPQVFKtJQZvsSvW13z7XLDDNKOGYMheurl/0/nhjz7Ck2pTNo7MHPk+HFYiyxJx+9Pxg
         lhz02CIfX+nlPOa/MTm17y5e0Wa6tG74Cgi7YGNP0+7CPJNu1UMjcTRxZs5CMx0fm5ce
         Hg3Q==
X-Gm-Message-State: AOAM533b6X53IEIy46mBRrLrL8DTM0G6lCMDC1DMk48baGQd7CEuttYy
        bGVOKEpkZbZ0pB61ZqSdgTkGuCkpnQs=
X-Google-Smtp-Source: ABdhPJwt7jRokSv2LgoX3P/1VZj+Xd+Dv4U3pQAIQiPOXSM0Q7sgBxTd4pNaOoAZNBOgB/tA4UdhJQ==
X-Received: by 2002:aa7:d913:: with SMTP id a19mr32509466edr.173.1621953053698;
        Tue, 25 May 2021 07:30:53 -0700 (PDT)
Received: from [192.168.1.11] (46-22-16-56-dynamic-cgnat.cust.swissbackbone.net. [46.22.16.56])
        by smtp.gmail.com with ESMTPSA id y23sm10795580eds.60.2021.05.25.07.30.52
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 07:30:53 -0700 (PDT)
Subject: Re: Network latency on 5.4 and 5.10
References: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
From:   Christoph Mathys <eraserix@gmail.com>
To:     linux-rt-users@vger.kernel.org
Message-ID: <7e7394a6-cec6-e3c6-b5a8-e1cb6627a96d@gmail.com>
Date:   Tue, 25 May 2021 16:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I did some more testing on 5.10 and it seems my
network irq thread runs into some kind of PI with
the RCU thread and thus cannot run for ~200us.

Some questions:
  - Why does this PI happen?
  - Can I avoid it? How?
  - Can I avoid that the RCU runs for such a long
    time at once?

I'm playing around with NOHZ_FULL and RCU callback
offloading at the moment to see if this helps somehow.
But with only two cores my options on juggling
threads onto CPUs are somewhat limited.


           rcuc/1-20      [001] .....12 16017.277265: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=000000000c04e43c
           rcuc/1-20      [001] .....12 16017.277265: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=00000000c6b95ab2
           rcuc/1-20      [001] .....12 16017.277266: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=00000000f9863725
           rcuc/1-20      [001] d..h212 16017.277266: irq_handler_entry: irq=130 name=ecat0-rx-0
           rcuc/1-20      [001] d..h212 16017.277266: irq_handler_exit: irq=130 ret=handled
           rcuc/1-20      [001] d..h412 16017.277266: sched_waking: comm=irq/130-ecat0-r pid=25665 prio=19 target_cpu=001
           rcuc/1-20      [001] dN.h512 16017.277267: sched_wakeup: comm=irq/130-ecat0-r pid=25665 prio=19 target_cpu=001
           rcuc/1-20      [001] dN..112 16017.277267: rcu_utilization: Start context switch
           rcuc/1-20      [001] dN..112 16017.277267: rcu_utilization: End context switch
           rcuc/1-20      [001] d...212 16017.277268: sched_switch: prev_comm=rcuc/1 prev_pid=20 prev_prio=98 prev_state=R+ ==> next_comm=irq/130-ecat0-r next_pid=25665 next_prio=19
  irq/130-ecat0-r-25665   [001] d...311 16017.277269: sched_pi_setprio: comm=rcuc/1 pid=20 oldprio=98 newprio=19
  irq/130-ecat0-r-25665   [001] d...111 16017.277270: rcu_utilization: Start context switch
  irq/130-ecat0-r-25665   [001] d...111 16017.277270: rcu_utilization: End context switch
  irq/130-ecat0-r-25665   [001] d...211 16017.277270: sched_switch: prev_comm=irq/130-ecat0-r prev_pid=25665 prev_prio=19 prev_state=R+ ==> next_comm=rcuc/1 next_pid=20 next_prio=19
           rcuc/1-20      [001] .....12 16017.277271: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=000000008900a49c
<lots of similar lines>
           rcuc/1-20      [001] d...112 16017.277288: workqueue_queue_work: work struct=0000000093763c71 function=css_killed_work_fn workqueue=0000000040d70e90 req_cpu=16 cpu=1
           rcuc/1-20      [001] d...112 16017.277289: workqueue_activate_work: work struct 0000000093763c71
           rcuc/1-20      [001] d...312 16017.277289: sched_waking: comm=kworker/1:2 pid=13240 prio=120 target_cpu=001
           rcuc/1-20      [001] d...412 16017.277290: sched_wakeup: comm=kworker/1:2 pid=13240 prio=120 target_cpu=001
           rcuc/1-20      [001] .....13 16017.277290: percpu_free_percpu: base_addr=0000000026e5557e off=111288 ptr=00000000cb224c7a
           rcuc/1-20      [001] .....13 16017.277290: percpu_free_percpu: base_addr=0000000026e5557e off=111280 ptr=000000001ea01103
           rcuc/1-20      [001] .....12 16017.277290: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=00000000f7fe2da7
<lots of similar lines>
           rcuc/1-20      [001] .....12 16017.277299: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=000000004363b5fd
           rcuc/1-20      [001] d..h212 16017.277300: local_timer_entry: vector=236
           rcuc/1-20      [001] d..h312 16017.277300: softirq_raise: vec=8 [action=HRTIMER]
           rcuc/1-20      [001] d..h212 16017.277300: write_msr: 6e0, value 304f993b507a
           rcuc/1-20      [001] d..h212 16017.277300: local_timer_exit: vector=236
           rcuc/1-20      [001] .....12 16017.277301: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=00000000407b3531
<lots of similar lines>
           rcuc/1-20      [001] .....12 16017.277305: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=00000000af2cd46f
           rcuc/1-20      [001] d..h.12 16017.277305: local_timer_entry: vector=236
           rcuc/1-20      [001] d..h112 16017.277306: hrtimer_cancel: hrtimer=0000000082cde4bc
           rcuc/1-20      [001] d..h.12 16017.277306: hrtimer_expire_entry: hrtimer=0000000082cde4bc function=hrtimer_wakeup now=16017273215561
           rcuc/1-20      [001] d..h212 16017.277306: sched_waking: comm=cyclictest pid=20680 prio=19 target_cpu=001
           rcuc/1-20      [001] d..h312 16017.277306: sched_wakeup: comm=cyclictest pid=20680 prio=19 target_cpu=001
           rcuc/1-20      [001] d..h.12 16017.277307: hrtimer_expire_exit: hrtimer=0000000082cde4bc
           rcuc/1-20      [001] d..h.12 16017.277307: write_msr: 6e0, value 304f996a73c6
           rcuc/1-20      [001] d..h.12 16017.277307: local_timer_exit: vector=236
           rcuc/1-20      [001] .....12 16017.277307: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=000000008da0302a
<lots of similar lines>
           rcuc/1-20      [001] .....12 16017.277418: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=00000000994b1e7d
           rcuc/1-20      [001] .....12 16017.277418: mm_page_free: page=00000000a7e4a633 pfn=104560 order=2
           rcuc/1-20      [001] .....12 16017.277418: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=0000000054b769bf
           rcuc/1-20      [001] .....12 16017.277419: sched_process_free: comm=kill pid=14926 prio=120
           rcuc/1-20      [001] d...113 16017.277421: workqueue_queue_work: work struct=00000000d2b86e8a function=css_release_work_fn workqueue=0000000040d70e90 req_cpu=16 cpu=1
           rcuc/1-20      [001] .....13 16017.277421: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=000000000b628ae9
           rcuc/1-20      [001] d...113 16017.277422: workqueue_queue_work: work struct=00000000d6255bb4 function=css_release_work_fn workqueue=0000000040d70e90 req_cpu=16 cpu=1
           rcuc/1-20      [001] .....13 16017.277422: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=00000000d844ad24
           rcuc/1-20      [001] .....13 16017.277422: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=00000000a49f8139
           rcuc/1-20      [001] .....13 16017.277422: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=00000000f2b3224d
           rcuc/1-20      [001] .....13 16017.277422: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=00000000d2397b3c
           rcuc/1-20      [001] .....13 16017.277423: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=00000000a367555e
           rcuc/1-20      [001] .....13 16017.277423: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=000000002aaa5cac
           rcuc/1-20      [001] .....13 16017.277423: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=00000000430e91ae
           rcuc/1-20      [001] .....13 16017.277423: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=00000000f8512c96
           rcuc/1-20      [001] .....13 16017.277423: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=000000005e5ac681
           rcuc/1-20      [001] d...213 16017.277424: timer_start: timer=0000000098e46346 function=delayed_work_timer_fn expires=4310684537 [timeout=20] cpu=1 idx=58 flags=I
           rcuc/1-20      [001] .....12 16017.277425: kfree: call_site=security_task_free+0x36/0x50 ptr=00000000e928d73e
           rcuc/1-20      [001] .....12 16017.277425: kmem_cache_free: call_site=__put_task_struct+0x88/0x190 ptr=00000000d32d025d
<lots of similar lines>
           rcuc/1-20      [001] .....12 16017.277452: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=00000000097691fb
           rcuc/1-20      [001] .....12 16017.277453: sched_process_free: comm=(sd-pam) pid=14847 prio=120
           rcuc/1-20      [001] d...112 16017.277454: workqueue_queue_work: work struct=0000000077c15f97 function=free_work workqueue=00000000f605602a req_cpu=16 cpu=1
           rcuc/1-20      [001] d...112 16017.277454: workqueue_activate_work: work struct 0000000077c15f97
           rcuc/1-20      [001] .....12 16017.277454: kfree: call_site=security_task_free+0x36/0x50 ptr=000000003016d2cc
           rcuc/1-20      [001] .....12 16017.277454: kmem_cache_free: call_site=__put_task_struct+0x88/0x190 ptr=000000008d44c92c
           rcuc/1-20      [001] .....12 16017.277455: kmem_cache_free: call_site=__put_task_struct+0x101/0x190 ptr=00000000bf1f1ae9
           rcuc/1-20      [001] .....12 16017.277455: kfree: call_site=free_task+0x1b/0x60 ptr=0000000000000000
           rcuc/1-20      [001] .....12 16017.277455: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=00000000eb792cfc
           rcuc/1-20      [001] .....12 16017.277456: sched_process_free: comm=systemd pid=14846 prio=120
           rcuc/1-20      [001] d...113 16017.277457: workqueue_queue_work: work struct=00000000a65dcda5 function=css_release_work_fn workqueue=0000000040d70e90 req_cpu=16 cpu=1
           rcuc/1-20      [001] .....13 16017.277457: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=00000000a29d18ed
           rcuc/1-20      [001] d...113 16017.277457: workqueue_queue_work: work struct=0000000000e1ccca function=css_release_work_fn workqueue=0000000040d70e90 req_cpu=16 cpu=1
           rcuc/1-20      [001] .....13 16017.277457: kfree: call_site=put_css_set_locked+0x155/0x2b0 ptr=00000000cfeca6c9
<lots of similar lines>
           rcuc/1-20      [001] .....12 16017.277461: kmem_cache_free: call_site=rcu_do_batch+0x194/0x480 ptr=000000009e31b81e
           rcuc/1-20      [001] .....12 16017.277461: rcu_utilization: End RCU core
           rcuc/1-20      [001] ...s.12 16017.277462: softirq_entry: vec=8 [action=HRTIMER]
           rcuc/1-20      [001] d..s113 16017.277462: hrtimer_cancel: hrtimer=000000009862add4
           rcuc/1-20      [001] ...s.13 16017.277462: hrtimer_expire_entry: hrtimer=000000009862add4 function=hrtimer_wakeup now=16017273371650
           rcuc/1-20      [001] d..s213 16017.277462: sched_waking: comm=EtherlabDaemon pid=25770 prio=120 target_cpu=001
           rcuc/1-20      [001] d..s313 16017.277464: sched_wakeup: comm=EtherlabDaemon pid=25770 prio=120 target_cpu=001
           rcuc/1-20      [001] ...s.13 16017.277464: hrtimer_expire_exit: hrtimer=000000009862add4
           rcuc/1-20      [001] d..s113 16017.277464: write_msr: 6e0, value 304f994bc448
           rcuc/1-20      [001] ...s.12 16017.277464: softirq_exit: vec=8 [action=HRTIMER]
           rcuc/1-20      [001] dN..311 16017.277465: sched_pi_setprio: comm=rcuc/1 pid=20 oldprio=19 newprio=98
           rcuc/1-20      [001] dN..311 16017.277466: sched_waking: comm=irq/130-ecat0-r pid=25665 prio=19 target_cpu=001
           rcuc/1-20      [001] dN..411 16017.277466: sched_wakeup: comm=irq/130-ecat0-r pid=25665 prio=19 target_cpu=001
           rcuc/1-20      [001] .N..... 16017.277467: rcu_utilization: End CPU kthread@rcu_wait
           rcuc/1-20      [001] dN..1.. 16017.277467: rcu_utilization: Start context switch
           rcuc/1-20      [001] dN..1.. 16017.277467: rcu_utilization: End context switch
           rcuc/1-20      [001] d...2.. 16017.277468: sched_switch: prev_comm=rcuc/1 prev_pid=20 prev_prio=98 prev_state=R+ ==> next_comm=cyclictest next_pid=20680 next_prio=19
           rcuc/1-20      [001] d...2.. 16017.277468: tlb_flush: pages:0 reason:flush on task switch (0)
       cyclictest-20680   [001] ....1.. 16017.277469: sys_clock_nanosleep -> 0x0
       cyclictest-20680   [001] ....... 16017.277470: sys_exit: NR 230 = 0
       cyclictest-20680   [001] d...... 16017.277470: x86_fpu_regs_activated: x86/fpu: 000000001e825867 load: 1 xfeatures: 2 xcomp_bv: 8000000000000003
       cyclictest-20680   [001] d..h... 16017.277474: call_function_single_entry: vector=251
       cyclictest-20680   [001] d..h... 16017.277475: call_function_single_exit: vector=251
       cyclictest-20680   [001] d..h... 16017.277476: irq_work_entry: vector=246
       cyclictest-20680   [001] d..h2.. 16017.277479: sched_migrate_task: comm=EtherCATControl pid=25916 prio=20 orig_cpu=1 dest_cpu=0
       cyclictest-20680   [001] d..h... 16017.277480: irq_work_exit: vector=246
       cyclictest-20680   [001] ....1.. 16017.277485: sys_write(fd: 4, buf: 7f98e50e0300, count: 21)
       cyclictest-20680   [001] ....... 16017.277485: sys_enter: NR 1 (4, 7f98e50e0300, 21, 0, 0, 0)
       cyclictest-20680   [001] ....... 16017.277486: tracing_mark_write: hit latency threshold (165 > 150)
       cyclictest-20680   [001] ....1.. 16017.277487: sys_write -> 0x21
       cyclictest-20680   [001] ....... 16017.277487: sys_exit: NR 1 = 33
       cyclictest-20680   [001] ....1.. 16017.277487: sys_write(fd: 5, buf: 409a8a, count: 2)
       cyclictest-20680   [001] ....... 16017.277487: sys_enter: NR 1 (5, 409a8a, 2, 0, 0, 0)
