Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E0EB64D9
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Jul 2023 00:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGKAwE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 20:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGKAwD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jul 2023 20:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF517AF
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jul 2023 17:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689036679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MJ/4HkLY1wW5PY2UP1gAVu3W5msABdqpAvgoaBBXxyc=;
        b=KQWh79Buz79YdATnFtNsatDi7rxHoxAhu1ZZAj6/5aEK01NBfTZ52+R5u0FOimHAGlNgrV
        rZaqcck7N+XI6LjZ7KDG9oD1JD5NA9R7cH9tHTtWjH6+GQkbYjQP54MKJmpdFf8E9c68aP
        wYqvTHnDI4MmYLcmGabgQirpcfa/Peg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-J2v8fgucM7CZL2PTtWi5wA-1; Mon, 10 Jul 2023 20:51:17 -0400
X-MC-Unique: J2v8fgucM7CZL2PTtWi5wA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76783ba6d62so552405785a.3
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jul 2023 17:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036677; x=1691628677;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ/4HkLY1wW5PY2UP1gAVu3W5msABdqpAvgoaBBXxyc=;
        b=gxZH071U58fD6lgKqwD9UueXScIxBmKhk68mLF4VVvemvDYBArDmEMKio4rU5FZN3X
         3Gl9/lX/qaMA2mbGaTYnFaq5u/Rc2ErGs/NBqg3xs8kxQ3XTc1CRmRSnH7pajPxWyWxu
         kDi6WmRX4nXEhhED+H5bpeayxcxD3oavQGxeYNeq+v7I6ZKBIVp5j8pauwM5w8bJJwBp
         txoJBGDU/38//nHEdShFLGn6QpsFkeO7PKkvhm8tUVsPww95vjsjWa3gPlnVrjZg8tZb
         YQ9SFmV2JC+sshp7MWwwC947tTQZTllKWlrAiVIWN3BlXmpzokFlxrCqqeqLL+FWfGDp
         w36Q==
X-Gm-Message-State: ABy/qLZjXUbH3WWePU8/KxOFj73S8GtaSPbKTuXD4L8LMf8/xknENcu+
        pB6hhj6XVuGHIRzsxetXxENmgAthuZOd8W1Qc/yndXGqCL/UZS8TYyn8kbp6Etp6kVGy/mgfSEZ
        udAKwYE0kb+BoNhgXnXEq43BMT+Cuq6sWUq9BbXh08WzTy2c6+hV1rRNRXHurQ/amuo5r3r332E
        I/H6AvidCUJ8k=
X-Received: by 2002:a05:620a:b57:b0:75b:23a1:8336 with SMTP id x23-20020a05620a0b5700b0075b23a18336mr12765918qkg.49.1689036676897;
        Mon, 10 Jul 2023 17:51:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHzDOfZF8oJq5yfEuCz/x8zyAuvVdgw/tvDkEQJ+UPGvrcBkgELqwP3xFYb/bgd50b1ti7Xew==
X-Received: by 2002:a05:620a:b57:b0:75b:23a1:8336 with SMTP id x23-20020a05620a0b5700b0075b23a18336mr12765896qkg.49.1689036676457;
        Mon, 10 Jul 2023 17:51:16 -0700 (PDT)
Received: from thinkpad2021 ([64.99.149.73])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a16a800b00767d6d11eb8sm420546qkj.67.2023.07.10.17.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:51:16 -0700 (PDT)
Date:   Mon, 10 Jul 2023 20:51:14 -0400
From:   "John B. Wyatt IV" <jwyatt@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jlelli@redhat.com, vschneid@redhat.com, pauld@redhat.com,
        rt-maint@redhat.com
Subject: [preempt-rt] BUG: sleeping function called from invalid context at
 drivers/gpu/drm/i915/gt/uc/intel_guc.h
Message-ID: <ZKyngsXKztAU9J3r@thinkpad2021>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello everyone, I am a new kernel developer with the Red Hat real-time team.

I am seeing two different call traces with 6.4-rt6 on my 12th Gen Intel Framework Laptop with i915 emit the same bug. Both of them occurred in the same boot. This kernel was built and tested on RHEL8. [1] occurs only once. [2] occurs ~50 times in a boot and log in to the gnome desktop.

[1]

[ 3800.598054] BUG: sleeping function called from invalid context at drivers/gpu/drm/i915/gt/uc/intel_guc.h:329
[ 3800.598060] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 207, name: kworker/4:1H
[ 3800.598063] preempt_count: 0, expected: 0
[ 3800.598065] RCU nest depth: 5, expected: 0
[ 3800.598066] 11 locks held by kworker/4:1H/207:
[ 3800.598069] #0: ffff93b400054f38 ((wq_completion)events_highpri){+.+.}-{0:0}, at: process_one_work (./include/linux/list.h:927 ./include/linux/hashtable.h:107 kernel/workqueue.c:2446) 
[ 3800.598084] #1: ffffbc7441087e70 ((work_completion)(&(&engine->heartbeat.work)->work)){+.+.}-{0:0}, at: process_one_work (./include/linux/list.h:899 ./include/linux/list.h:927 ./include/linux/hashtable.h:107 kernel/workqueue.c:2446) 
[ 3800.598093] #2: ffff93b401cfd470 (kernel_context){+.+.}-{3:3}, at: heartbeat (./include/linux/rcupdate.h:805 ./drivers/gpu/drm/i915/i915_request.h:622 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c:148) i915
[ 3800.598247] #3: ffff93bb8cc207e0 ((softirq_ctrl.lock)){+.+.}-{2:2}, at: __local_bh_disable_ip (kernel/softirq.c:157 (discriminator 19)) 
[ 3800.598258] #4: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:95) 
[ 3800.598268] #5: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip (kernel/softirq.c:157 (discriminator 15)) 
[ 3800.598276] #6: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: submit_notify (./include/linux/rcupdate.h:805 drivers/gpu/drm/i915/i915_request.c:798) i915
[ 3800.598457] #7: ffff93b5a1ccaa68 (&sched_engine->lock/2){+.+.}-{2:2}, at: guc_submit_request (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:1985 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2001) i915
[ 3800.598632] #8: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:95) 
[ 3800.598639] #9: ffff93b5a1e4f6f0 (&ce->guc_state.lock){+.+.}-{2:2}, at: add_to_context (./include/linux/list.h:134 ./include/linux/list.h:229 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3408) i915
[ 3800.598801] #10: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:95) 
[ 3800.598813] Hardware name: Framework Laptop (12th Gen Intel Core)/FRANGACP04, BIOS 03.04 07/15/2022
[ 3800.598816] Workqueue: events_highpri heartbeat [i915]
[ 3800.598935] Call Trace:
[ 3800.598937]  <TASK>
[ 3800.598940] dump_stack_lvl (lib/dump_stack.c:113) 
[ 3800.598947] __might_resched+0x1a0/0x260 
[ 3800.598956] guc_context_set_prio (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3345 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4009) i915
[ 3800.599123] ? lock_is_held_type+0xe1/0x140 
[ 3800.599133] add_to_context (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3386 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3430 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4034) i915
[ 3800.599300] __i915_request_submit (drivers/gpu/drm/i915/i915_request.c:199 drivers/gpu/drm/i915/i915_request.c:210 drivers/gpu/drm/i915/i915_request.c:691) i915
[ 3800.599460] guc_submit_request (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:1966 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2003) i915
[ 3800.599622] submit_notify (./include/linux/refcount.h:199 ./include/linux/refcount.h:250 ./include/linux/refcount.h:267 ./include/linux/kref.h:45 ./include/linux/dma-fence.h:308 ./include/linux/dma-fence.h:305 ./drivers/gpu/drm/i915/i915_request.h:402 drivers/gpu/drm/i915/i915_request.c:309 drivers/gpu/drm/i915/i915_request.c:786) i915
[ 3800.599784] __i915_sw_fence_complete (drivers/gpu/drm/i915/i915_sw_fence.c:201) i915
[ 3800.599919] __i915_request_queue (./include/linux/bottom_half.h:33 drivers/gpu/drm/i915/i915_request.c:1832) i915
[ 3800.600108] heartbeat (drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c:285) i915
[ 3800.600241] process_one_work (./arch/x86/include/asm/bitops.h:228 ./arch/x86/include/asm/bitops.h:240 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/cpumask.h:504 ./include/linux/cpumask.h:1082 ./include/trace/events/workqueue.h:82 kernel/workqueue.c:2407) 
[ 3800.600261] worker_thread (kernel/workqueue.c:2556) 
[ 3800.600269] ? __pfx_worker_thread (kernel/workqueue.c:2498) 
[ 3800.600273] kthread (kernel/kthread.c:348) 
[ 3800.600278] ? __pfx_kthread (kernel/kthread.c:332) 
[ 3800.600287] ret_from_fork (arch/x86/entry/entry_64.S:308) 
[ 3800.600312]  </TASK>

[2]

[ 3796.648741] BUG: sleeping function called from invalid context at drivers/gpu/drm/i915/gt/uc/intel_guc.h:329
[ 3796.648746] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 47819, name: gnome-shell
[ 3796.648749] preempt_count: 0, expected: 0
[ 3796.648750] RCU nest depth: 6, expected: 0
[ 3796.648752] 12 locks held by gnome-shell/47819:
[ 3796.648824] #0: ffffbc74443b3d28 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_mode_page_flip_ioctl (drivers/gpu/drm/drm_plane.c:1342) drm
[ 3796.648887] #1: ffff93b4438e5088 (crtc_ww_class_mutex){+.+.}-{3:3}, at: drm_modeset_lock (drivers/gpu/drm/drm_modeset_lock.c:317) drm
[ 3796.648944] #2: ffff93bb8bc207e0 ((softirq_ctrl.lock)){+.+.}-{2:2}, at: __local_bh_disable_ip (kernel/softirq.c:157 (discriminator 19)) 
[ 3796.648954] #3: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:95) 
[ 3796.648963] #4: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip (kernel/softirq.c:157 (discriminator 15)) 
[ 3796.648971] #5: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: fence_set_priority (drivers/gpu/drm/i915/gem/i915_gem_wait.c:105 drivers/gpu/drm/i915/gem/i915_gem_wait.c:92) i915
[ 3796.649136] #6: ffffffffc0a4fa40 (schedule_lock){+.+.}-{2:2}, at: i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:163 drivers/gpu/drm/i915/i915_scheduler.c:292) i915
[ 3796.649279] #7: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:95) 
[ 3796.649285] #8: ffff93b5a1ccaa68 (&sched_engine->lock/2){+.+.}-{2:2}, at: i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:294) i915
[ 3796.649425] #9: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:95) 
[ 3796.649431] #10: ffff93b4405762b0 (&ce->guc_state.lock){+.+.}-{2:2}, at: guc_bump_inflight_request_prio (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4019) i915
[ 3796.649572] #11: ffffffff9fe21000 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:95) 
[ 3796.649583] Hardware name: Framework Laptop (12th Gen Intel Core)/FRANGACP04, BIOS 03.04 07/15/2022
[ 3796.649584] Call Trace:
[ 3796.649586]  <TASK>
[ 3796.649589] dump_stack_lvl (lib/dump_stack.c:113) 
[ 3796.649596] __might_resched+0x1a0/0x260 
[ 3796.649603] guc_context_set_prio (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3345 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4009) i915
[ 3796.649735] ? lock_is_held_type+0xe1/0x140 
[ 3796.649743] guc_bump_inflight_request_prio (drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:3385) i915
[ 3796.649904] i915_schedule (drivers/gpu/drm/i915/i915_scheduler.c:338) i915
[ 3796.650082] ? lock_release+0x15e/0x450 
[ 3796.650101] fence_set_priority (drivers/gpu/drm/i915/gem/i915_gem_wait.c:70) i915
[ 3796.650274] i915_gem_fence_wait_priority (./include/linux/bottom_half.h:31 drivers/gpu/drm/i915/gem/i915_gem_wait.c:144 drivers/gpu/drm/i915/gem/i915_gem_wait.c:115) i915
[ 3796.650448] i915_gem_object_wait_priority (drivers/gpu/drm/i915/gem/i915_gem_wait.c:157 (discriminator 3)) i915
[ 3796.650617] intel_prepare_plane_fb (drivers/gpu/drm/i915/display/intel_atomic_plane.c:1077) i915
[ 3796.650783] ? is_module_address (./arch/x86/include/asm/preempt.h:121 kernel/module/main.c:3169) 
[ 3796.650790] ? static_obj+0x5a/0x70 
[ 3796.650802] drm_atomic_helper_prepare_planes (drivers/gpu/drm/drm_atomic_helper.c:2580 drivers/gpu/drm/drm_atomic_helper.c:2556) drm_kms_helper
[ 3796.650828] intel_atomic_commit (drivers/gpu/drm/i915/display/intel_display.c:6767 drivers/gpu/drm/i915/display/intel_display.c:7576) i915
[ 3796.650982] drm_atomic_helper_page_flip (./arch/x86/include/asm/atomic.h:190 ./include/linux/atomic/atomic-instrumented.h:177 ./include/linux/refcount.h:272 ./include/linux/refcount.h:315 ./include/linux/refcount.h:333 ./include/linux/kref.h:64 ./include/drm/drm_atomic.h:490 drivers/gpu/drm/drm_atomic_helper.c:3647) drm_kms_helper
[ 3796.651000] drm_mode_page_flip_ioctl (drivers/gpu/drm/drm_plane.c:1377) drm
[ 3796.651057] ? __pfx_drm_mode_page_flip_ioctl (drivers/gpu/drm/drm_plane.c:1213) drm
[ 3796.651094] drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:794) drm
[ 3796.651136] drm_ioctl (./include/linux/thread_info.h:277 ./include/linux/thread_info.h:313 ./include/linux/uaccess.h:190 drivers/gpu/drm/drm_ioctl.c:892) drm
[ 3796.651175] ? __pfx_drm_mode_page_flip_ioctl (drivers/gpu/drm/drm_plane.c:1213) drm
[ 3796.651210] ? lock_release+0xeb/0x450 
[ 3796.651222] __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856) 
[ 3796.651228] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 3796.651233] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[ 3796.651237] RIP: 0033:0x7fd3cc0fe7cb

