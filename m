Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F31CC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Mar 2021 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0489561A2A
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Mar 2021 21:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCZVUl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 26 Mar 2021 17:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229933AbhCZVUP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 Mar 2021 17:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616793614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=mrVQo9srzsM96kqBT98BwwTsIevF8ZDTRT8P9kqAt0A=;
        b=G9eTjicD6PLY/SnbCacN/TfH2tWqsQaEq5Vsx5DodVrHDMUF7UVTS9KCsAzwSKQclDb1Uf
        JHxVQ4G1Pr/KA1fXF8Fz6DfXVRM+9rNzzzVWHOfGpYzIyWTW2ZX4zmtWku1HxvWLQoBDPD
        jfQ8KHREXDNg2z+bW7k0J3FIrzoDocM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-sx88x-I8MbSbR2qHPNKa1Q-1; Fri, 26 Mar 2021 17:20:12 -0400
X-MC-Unique: sx88x-I8MbSbR2qHPNKa1Q-1
Received: by mail-io1-f70.google.com with SMTP id w8so7174686iox.13
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Mar 2021 14:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=mrVQo9srzsM96kqBT98BwwTsIevF8ZDTRT8P9kqAt0A=;
        b=EHHV46CA6HTAxsMgetdYcVF0wyEQArhX2MCQYxAlOGMUkG98Z09LS9rm81LNLeZIpt
         D6+QHI/wyiendglyga7DzXmdBjRL1dcuyJZehKU9z039gcJg2Y5jZhe2uFjItqfzn4lF
         YaL6zeCqiANpaw3O4cGUYof4bKpvv8slwlgDEoDKscCSdGBNkJschbONaqRbM9RoEP72
         ClJfT3crNTksObUBHwCM2Qwkck0zutoRZB6sWybvanNtm8AYoSkQm+dT42O4UXbAcJyZ
         ovxZCJSm2sPmx86Oz0yur8QajTPxGqA4aHJoc8rGwhFm8av9eflbDrWW5hxW594Icqcb
         bh0g==
X-Gm-Message-State: AOAM531PF0YDeAt6f27sKPbDTf3T+2j163FH7jVLzO4hW9F7/M8ov+hu
        ene5gz/oDpKmx8Nw1V5WtP2u53VtobJeahRtRYLml716eGygee2ygv40Ktx2q69CSHzxSgCnuAt
        uighnAi5FjhELjkZnXo6sDh4urjw=
X-Received: by 2002:a92:c748:: with SMTP id y8mr10263117ilp.37.1616793611774;
        Fri, 26 Mar 2021 14:20:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh0auR89PT3pe3sPldKiA2hObE6Q9SRgzWnNthkGztWq39sDwCpcLYDaxsOGg2kTTvzevcdQ==
X-Received: by 2002:a92:c748:: with SMTP id y8mr10263112ilp.37.1616793611604;
        Fri, 26 Mar 2021 14:20:11 -0700 (PDT)
Received: from halaneylaptop ([136.33.227.6])
        by smtp.gmail.com with ESMTPSA id x3sm534298ilg.2.2021.03.26.14.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 14:20:11 -0700 (PDT)
Date:   Fri, 26 Mar 2021 16:20:09 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [RT v5.12-rc3-rt3] __call_rcu with KASAN causes invalid sleeping
 function call
Message-ID: <20210326212009.dvmga3e7axms3atk@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I booted the RT kernel (v5.12-rc3-rt3) with KASAN enabled for the first
time today and noticed this:

[    2.670635] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:951
[    2.670638] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 19, name: pgdatinit0
[    2.670649] 8 locks held by pgdatinit0/19:
[    2.670651]  #0: ffffffffb6e0a1e0 (tasklist_lock){+.+.}-{0:0}, at: release_task+0x110/0x480
[    2.670666]  #1: ffffffffb7364d80 (rcu_read_lock){....}-{1:2}, at: rt_write_lock+0x292/0x3a0
[    2.670683]  #2: ffff888100364860 (&sighand->siglock){+.+.}-{0:0}, at: __exit_signal+0x11d/0x1180
[    2.670690]  #3: ffffffffb7364d80 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xb0
[    2.670696]  #4: ffff888100395e10 (&(&sig->stats_lock)->lock){+.+.}-{0:0}, at: __exit_signal+0x276/0x1180
[    2.670701]  #5: ffffffffb7364d80 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xb0
[    2.670707]  #6: ffff888100395d38 (&____s->seqcount#3){+.+.}-{0:0}, at: release_task+0x1d6/0x480
[    2.670713]  #7: ffffffffb77516c0 (depot_lock){+.+.}-{2:2}, at: stack_depot_save+0x1b9/0x440
[    2.670736] irq event stamp: 31790
[    2.670738] hardirqs last  enabled at (31789): [<ffffffffb5a58cbd>] _raw_spin_unlock_irqrestore+0x2d/0xe0
[    2.670741] hardirqs last disabled at (31790): [<ffffffffb3dc5d86>] __call_rcu+0x436/0x880
[    2.670746] softirqs last  enabled at (0): [<ffffffffb3be1737>] copy_process+0x1357/0x4f90
[    2.670751] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    2.670763] CPU: 0 PID: 19 Comm: pgdatinit0 Not tainted 5.12.0-rc3-rt3 #1
[    2.670766] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[    2.670768] Call Trace:
[    2.670790]  ? unwind_next_frame+0x11e/0x1ce0
[    2.670800]  dump_stack+0x93/0xc2
[    2.670826]  ___might_sleep.cold+0x1b2/0x1f1
[    2.670838]  rt_spin_lock+0x3b/0xb0
[    2.670838]  ? stack_depot_save+0x1b9/0x440
[    2.670838]  stack_depot_save+0x1b9/0x440
[    2.670838]  kasan_save_stack+0x32/0x40
[    2.670838]  ? kasan_save_stack+0x1b/0x40
[    2.670838]  ? kasan_record_aux_stack+0xa5/0xb0
[    2.670838]  ? __call_rcu+0x117/0x880
[    2.670838]  ? __exit_signal+0xafb/0x1180
[    2.670838]  ? release_task+0x1d6/0x480
[    2.670838]  ? exit_notify+0x303/0x750
[    2.670838]  ? do_exit+0x678/0xcf0
[    2.670838]  ? kthread+0x364/0x4f0
[    2.670838]  ? ret_from_fork+0x22/0x30
[    2.670838]  ? mark_held_locks+0xa5/0xe0
[    2.670838]  ? lockdep_hardirqs_on_prepare.part.0+0x18a/0x370
[    2.670838]  ? _raw_spin_unlock_irqrestore+0x2d/0xe0
[    2.670838]  ? lockdep_hardirqs_on+0x77/0x100
[    2.670838]  ? _raw_spin_unlock_irqrestore+0x38/0xe0
[    2.670838]  ? debug_object_active_state+0x273/0x370
[    2.670838]  ? debug_object_activate+0x380/0x460
[    2.670838]  ? alloc_object+0x960/0x960
[    2.670838]  ? lockdep_hardirqs_on+0x77/0x100
[    2.670838]  ? _raw_spin_unlock_irqrestore+0x38/0xe0
[    2.670838]  ? __call_rcu+0x436/0x880
[    2.670838]  ? lockdep_hardirqs_off+0x90/0xd0
[    2.670838]  kasan_record_aux_stack+0xa5/0xb0
[    2.670838]  __call_rcu+0x117/0x880
[    2.670838]  ? put_pid+0x10/0x10
[    2.670838]  ? rt_spin_unlock+0x31/0x80
[    2.670838]  ? rcu_implicit_dynticks_qs+0xab0/0xab0
[    2.670838]  ? free_pid+0x19c/0x260
[    2.670838]  __exit_signal+0xafb/0x1180
[    2.670838]  ? trace_sched_process_exit+0x1b0/0x1b0
[    2.670838]  ? rcu_is_watching+0xf1/0x160
[    2.670838]  ? rt_write_lock+0x306/0x3a0
[    2.670838]  ? release_task+0x23/0x480
[    2.670838]  release_task+0x1d6/0x480
[    2.670838]  exit_notify+0x303/0x750
[    2.670838]  ? cgroup_exit+0x306/0x830
[    2.670838]  ? forget_original_parent+0xb80/0xb80
[    2.670838]  ? perf_event_exit_task+0x1b3/0x2d0
[    2.670838]  ? rcu_read_lock_sched_held+0x3f/0x70
[    2.670838]  do_exit+0x678/0xcf0
[    2.670838]  ? exit_mm+0x5b0/0x5b0
[    2.670838]  ? __kthread_parkme+0xc9/0x280
[    2.670838]  ? setup_nr_node_ids+0x2a/0x2a
[    2.670838]  kthread+0x364/0x4f0
[    2.670838]  ? __kthread_parkme+0x280/0x280
[    2.670838]  ret_from_fork+0x22/0x30

Please let me know if you want any more info.

Thanks,
Andrew

