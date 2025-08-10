Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064BD3C38;
	Sun, 10 Aug 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838357; cv=none; b=IgHxsfelun+MvWcnQh5dtZ2dsZGV+CX3UDPMS2P+jLidRtMZ/G9Usu0D/zKtOwST3pn55Hv9+lFtUl/v/P672wUP223KwlwaqeClYx9AR4a4DUxzmg/2RRdg6HUvrU8CZDNjVstbuoOdgFm/aPidBhIhULxOmZxjpKKS5FV24Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838357; c=relaxed/simple;
	bh=VS4jroL1tgveOOP2fX+aDbX7Yqcb8U/jU7EdrCg5LKs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Uk68naSoJCoSW65EHHRxlr6MBzGs0+AplL9otrvwWe6b4GXrC6vJV0SnfAeSqr4ZYP2RION0Sa4YcRrZq6YxRvz2dtEIDW7Oh1cY3SzT1uPci1btnt4TyT3Sm570OCwT4K/MNadUtPvgKWnGq94EHDbX2X6IMMR1vvp+EpTVmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32116dd55dcso691487a91.3;
        Sun, 10 Aug 2025 08:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754838355; x=1755443155;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw75YOLprBb6oK/VjbpS7g6mJyg1To/vCc6CBoQypEk=;
        b=spFULThgG70Ljn71O8cRLaygKu/QDx+cjbFchJQ9O0WGygtcppENR4zHY9s4YO8e6b
         sDyQ3JkXKn8ZdN+4bB/VNuOaTB4P0H/juexQw13T+WtstLt+x0rJoKrIj7luFgX4hhoV
         y6c4VJh9fDvH1vtAnIBq4ujUlWBuHWIOA6OJpA7cT5ilhNAZ0idC0BlRSOxYKZJgxnS2
         qt0wxk94yiTwMA/80F/3FsuJG/JZgnR0urTzupkClErL5/YXDhuedSCJGsBEc2KK2vfW
         buQk8HoMajP6QMxgmIJkPUe/Ex2nm3gYOU7vrMTEP2ky46+fFlDeZ45HzVk/5hsJBpXO
         dZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCWov82IYesJdSdtce7k+Pte3GIKVrQPRh7Z1H0pvu5v7NGN5pFuIj87OZalhK+RwHKhNfUwot+MoUlrpX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+fHL1IyN7xpFR8x+spBwE1DK2YQ9Qeq8lQ3B/16G19PyTXfg
	uCkWEvgbpActka6QhJpfwi/4KyVgs5SiZdeox6MBQohjSM/4cwoP/ZsK1ET02w==
X-Gm-Gg: ASbGnctw24XmfNMlT5P7vqw5B2DQptxB0hl0MKoVTzsiGLogYutPXtmV0slb1DIQ0Lc
	62yDNCjx0tr3XxU6h+Sr5goFDkVrGbKJ/ASS6ylXy/Hp/9APW3lNV/LuklEoHWIdr2N+acGXxKn
	ANHChht6xt2Bm5dzpbxhz0ouVJtkR3HxaXk9g/cRRDyHeUZD5oMO5MNI0uHTgR50uhtXEQW0eU6
	LN9GyzMkbXZbeFXSZ7iyxwLAmoVhc1+DqXzpdNNTIjWXTjMz3pfhew1a68jAoQa85YpLvRMb6KR
	uLmqddyf5GIrvc4lqd8+Sg9lu5N+EDhkQRgXX7GP6SPIIDhQHMyV7/SuhcioifE1PmSPzm9mnAz
	b1W1QthzPbF1dSa79krgEv8EsOmKMgLr2
X-Google-Smtp-Source: AGHT+IHgBPLnCIqw+XYClcoWUZeYHzPL/scfxM+cVHtLK+8JGxzhvAFyi2c3ztOuz1HfBFhcp5dFjQ==
X-Received: by 2002:a17:90b:164a:b0:31f:24c2:16cb with SMTP id 98e67ed59e1d1-32199dd2640mr3574878a91.6.1754838354809;
        Sun, 10 Aug 2025 08:05:54 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bea205365sm20165704b3a.83.2025.08.10.08.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 08:05:54 -0700 (PDT)
Message-ID: <1f8dd706-0eb0-4e09-a0fe-fc48fb24005e@kzalloc.com>
Date: Mon, 11 Aug 2025 00:05:49 +0900
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-usb@vger.kernel.org
Cc: linux-rt-users@vger.kernel.org, gregkh@linuxfoundation.org,
 stern@rowland.harvard.edu, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
From: Yunseong Kim <ysk@kzalloc.com>
Subject: [BUG] usb: sleepable spinlock used in USB bh_worker softirq on
 PREEMPT_RT
Organization: kzalloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

While running a PREEMPT_RT-enabled kernel I observed a sleepable
spinlock (rt_spin_lock) being taken from a softirq context within
the USB core framework. On PREEMPT_RT, spin_lock() may sleep when
contended. This is unsafe in softirq context and can cause hangs or
deadlocks.

Below is the relevant call path, reformatted for clarity:

(1) softirq context: workqueue_softirq_action

 --> bh_worker()
     --> process_scheduled_works()
         --> process_one_work()
              --> usb_giveback_urb_bh()
                   --> __usb_hcd_giveback_urb()
                        --> hub_irq()
                             --> hub_resubmit_irq_urb()
                                 --> spin_lock()
                                         |
                                         --> rt_spin_lock()
                                             ** <-- sleepable spinlock
                                                    used in softirq
                                                    context **
Stack trace excerpt:

| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
| in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15, name: ksoftirqd/0
| preempt_count: 0, expected: 0
| RCU nest depth: 2, expected: 2
| CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.16.0-11245-gc87c2e4c1589 #35 PREEMPT_RT 
| Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
| Call trace:
|  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
|  __dump_stack+0x30/0x40 lib/dump_stack.c:94
|  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
|  dump_stack+0x1c/0x3c lib/dump_stack.c:129
|  __might_resched+0x2e4/0x52c kernel/sched/core.c:8957
|  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
|  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
|  spin_lock include/linux/spinlock_rt.h:44 [inline]
|  hub_resubmit_irq_urb+0x2c/0x168 drivers/usb/core/hub.c:687
|  hub_irq+0x2ac/0x3d0 drivers/usb/core/hub.c:814
|  __usb_hcd_giveback_urb+0x2f0/0x5e8 drivers/usb/core/hcd.c:1663
|  usb_giveback_urb_bh+0x234/0x3c4 drivers/usb/core/hcd.c:1697
|  process_one_work kernel/workqueue.c:3236 [inline]
|  process_scheduled_works+0x678/0xd18 kernel/workqueue.c:3319
|  bh_worker+0x2f0/0x59c kernel/workqueue.c:3579
|  workqueue_softirq_action+0x104/0x14c kernel/workqueue.c:3606
|  tasklet_hi_action+0x18/0x8c kernel/softirq.c:860
|  handle_softirqs+0x208/0x63c kernel/softirq.c:579
|  run_ksoftirqd+0x64/0x264 kernel/softirq.c:968
|  smpboot_thread_fn+0x4ac/0x908 kernel/smpboot.c:160
|  kthread+0x5e8/0x734 kernel/kthread.c:464
|  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844


(2) softirq context: run_ksoftirqd()

--> handle_softirqs()
    --> tasklet_action()
        --> workqueue_softirq_action()
            --> bh_worker()
                --> process_scheduled_works()
                    --> process_one_work()
                        --> usb_giveback_urb_bh()
                            --> __usb_hcd_giveback_urb()
                                --> async_completed()
                                    --> spin_lock()
                                         |
                                         --> rt_spin_lock()
                                            ** <-- BUG: sleeping function
                                                    called from invalid
                                                    context **

Stack trace excerpt:

| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
| in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15, name: ksoftirqd/0
| preempt_count: 0, expected: 0
| RCU nest depth: 2, expected: 2
| CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.16.0-10393-g3267b1c07fff-dirty #43 PREEMPT_RT 
| Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
| Call trace:
|  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
|  __dump_stack+0x30/0x40 lib/dump_stack.c:94
|  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
|  dump_stack+0x1c/0x3c lib/dump_stack.c:129
|  __might_resched+0x2e4/0x52c kernel/sched/core.c:8957
|  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
|  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
|  spin_lock include/linux/spinlock_rt.h:44 [inline]
|  async_completed+0x70/0xabc drivers/usb/core/devio.c:633
|  __usb_hcd_giveback_urb+0x2f0/0x5e8 drivers/usb/core/hcd.c:1663
|  usb_giveback_urb_bh+0x234/0x3c4 drivers/usb/core/hcd.c:1697
|  process_one_work kernel/workqueue.c:3236 [inline]
|  process_scheduled_works+0x678/0xd18 kernel/workqueue.c:3319
|  bh_worker+0x2f0/0x59c kernel/workqueue.c:3579
|  workqueue_softirq_action+0x104/0x14c kernel/workqueue.c:3606
|  tasklet_action+0x18/0x8c kernel/softirq.c:854
|  handle_softirqs+0x208/0x63c kernel/softirq.c:579
|  run_ksoftirqd+0x64/0x264 kernel/softirq.c:968
|  smpboot_thread_fn+0x4ac/0x908 kernel/smpboot.c:160
|  kthread+0x5e8/0x734 kernel/kthread.c:464
|  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

Softirq context is not allowed to sleep. PREEMPT_RT replaces spinlock
implementations with sleepable variants to improve RT performance.
This is fine in process context but unsafe in atomic contexts such as
softirq. This specific instance is in the USB core bh path, so a
framework-level fix seems appropriate.

Because USB activity frequently triggers hub interrupts and URB
givebacks "urb->complete(urb)", this issue can be hit easily on
PREEMPT_RT systems. This means that using USB devices under PREEMPT_RT
may be unstable in its current state, especially under high I/O load or
when multiple devices are active. The likelihood of encountering this
problem increases with frequent plug/unplug events, isochronous transfers,
or heavy USB traffic.

At the moment, I think the following solutions might be possible:
 1. Use raw spinlocks (raw_spin_lock_irqsave/restore) in bh paths.
 2. Move sleepable work into process context (regular workqueues).
 3. Avoid locking entirely in these atomic paths if possible.

I believe this requires a change in the USB core framework rather than
just in individual drivers.

Kernel config, full logs, and reproduction steps can be provided on
request.

This bug was uncovered during my work to fixing KCOV for PREEMPT_RT awareness.
Link: https://lore.kernel.org/all/ee26e7b2-80dd-49b1-bca2-61e460f73c2d@kzalloc.com/t/#u

Best Regards,
Yunseong Kim
