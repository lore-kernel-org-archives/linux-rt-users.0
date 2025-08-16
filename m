Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4718145B27;
	Sat, 16 Aug 2025 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755307782; cv=none; b=mqg1GtueCYTh7V0NzKqTilHudfw3Z/borY6d/HWlh86AubRy46HZA2Iq4a8wqB512Km5bS3tb30mGNm2u/GQAJYMVRQX0mGRYLRnpQkSoUPqPZv6wqAmMTiTVwf9zUNYFCCxhThwXr+GisGTagsrP3bFGKGTXtPvuUJraCyNR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755307782; c=relaxed/simple;
	bh=scO7dyKId+xq+IHzBnywj7wsgQcDnXoAY5orQSiz/3k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=aVizUvCCP1n1o7CAY8JniLpRQitacCyj5Jly6oeqAaCSgwOVvG+yVQcBIHkWW/9ACeO2v4zr60+G0l5Ai8TSvA2PytrgX7MKNu5r18pkMmTbeutgS80oh/+S/ILmVReUZKs6pC4q++631PW4h8t4CJ+e48xVScYf9eRg9CGlNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b471751142aso336574a12.2;
        Fri, 15 Aug 2025 18:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755307780; x=1755912580;
        h=content-transfer-encoding:cc:organization:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oqekOMrZY1HNJtHJWKvi0Gbrfw5E4k7HTzoGUspwd4=;
        b=Ykc4JTxBydozabFZVc4fqW95CI3Us6Xc2Akc4uhjI1zSa5hQR+cQg1OZ5wPmWVqQii
         Fi+0+2qrEGj5HehmGwrADH7O0z9LyELqToSOCus1Uu69E9XyMAVXvd7njQmjZMB/kOgF
         xj6TGWJfYiOn57b8+lR6EhzgEykhwFIUANx0oCwL8ddk4AnwJ+nkatbgNXrO2xTIR+gL
         Tlaxs/lthB9ltOQGyDVtbYkcpD9ZpiCREpnErMq4ff8zZvjkF4azkvLZdOAWNcThm15A
         559K7Fp3I2NEb8s0kZImuVLGQilN9hL4PW6VPs5zQ1rHWis/nXvQQz4XfTWD+SQwRFg/
         Sw1g==
X-Forwarded-Encrypted: i=1; AJvYcCUc2ZM4BrxrVmTuhYoVWLnOIPbXM0yb2Vk7EObbMIErY7/zBVF8umGNGvrRXeP83NGgtU3A5ZdffAS1Qj/SwCk=@vger.kernel.org, AJvYcCXNGOy7gWLQC9WZsPm0OgYJEXG4Wq543TmbudWsyqLGl2ZyxIwW7F+GF02X7NlQF2SJbYOaRA7sz+wv+VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwpCYqDnXD08DWWLHRw4UJigZa+JVPQKNaEeyprAseWqTj7CEP
	94Icgauu2WmSOg1h7QszNU5IjDI1XKp5qg8ff1mjF2XP2PFJ1cMg+6PDQ/Wg+w==
X-Gm-Gg: ASbGncvQU68ZtD0NstSbasOsOtXrmC8Gy6U3Mlb2guWtdqPcHXTlha23QAf+MtVxVm7
	/4+T77Da/MW8EVRKxzbs3q7UePlCElhuDTezWR7W3WoymJExMINicPleSbdX5p8hYyfcC4zu6jz
	BMXtCGEVC+7J2jYwEknvrTynOzT6DasqzvDwMrT39NEbGylqb27qNGsihZ8O3sSdZpesceK2bBV
	5ujvxOPOFkkH5GNej+VOQretJ4d03X0ZMJSuRYMsU9Uytw7wu9U5p0Oql6yO5+i7LQuFNb1mg79
	rACZQQW/G566L+9VkWNATnqLxGwi1dU4ZmyqkBxIJY1Sqj61ais8rjSEeOhdwRqvpb/X/iRPToN
	mEUYezyTb+3f/wPYppXlUrJKj4CCDnlWb
X-Google-Smtp-Source: AGHT+IHl0HYOUZcAr3uP0eeVttzrMa1aZ4G3wmFZIvRYzvTPDe+Babco6sOsG+fiXLHV3UEl2WL1kg==
X-Received: by 2002:a17:902:c40a:b0:240:764e:afab with SMTP id d9443c01a7336-2446d8c5734mr31020405ad.6.1755307779548;
        Fri, 15 Aug 2025 18:29:39 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9dc1asm24077355ad.32.2025.08.15.18.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 18:29:39 -0700 (PDT)
Message-ID: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
Date: Sat, 16 Aug 2025 10:29:34 +0900
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
 stern@rowland.harvard.edu
From: Yunseong Kim <ysk@kzalloc.com>
Subject: [BUG] usbip: vhci: Sleeping function called from invalid context in
 vhci_urb_enqueue on PREEMPT_RT
Organization: kzalloc
Cc: Andrey Konovalov <andreyknvl@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

While testing a PREEMPT_RT enabled kernel (based on v6.17.0-rc1),
I encountered a "BUG: sleeping function called from invalid context"
error originating from the USB/IP VHCI driver.

On PREEMPT_RT configurations, standard spin_lock() calls are replaced by
rt_spin_lock(). Since rt_spin_lock() may sleep when contended, it must not
be called from an atomic context (e.g., with interrupts disabled).

The issue occurs within the vhci_urb_enqueue function This function
explicitly disables local interrupts using local_irq_disable() immediately
before calling usb_hcd_giveback_urb(), adhering to HCD requirements.

This error reported after this work:
Link: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-linus&id=9528d32873b38281ae105f2f5799e79ae9d086c2

  kworker (hub_event)
      |
      v
  vhci_urb_enqueue() [drivers/usb/usbip/vhci_hcd.c]
      |
      |---> spin_unlock_irqrestore(&vhci->lock, flags);
      |     (Context: IRQs Enabled, Process Context)
      |---> local_irq_disable();
      |
      |     *** STATE CHANGE: IRQs Disabled (Atomic Context) ***
      |
      +-----> usb_hcd_giveback_urb() [drivers/usb/core/hcd.c]
              |
              v
              __usb_hcd_giveback_urb()
              |
              v
              mon_complete() [drivers/usb/mon/mon_main.c]
              |
              |---> spin_lock()  <--- Attempts to acquire lock
                    |
                    | [On PREEMPT_RT]
                    v
                    rt_spin_lock() [kernel/locking/spinlock_rt.c]
                    |
                    v
                    [May Sleep if contended]
                    |
      X <----------- BUG: Sleeping in atomic context (IRQs are disabled!)

      |
      |---> local_irq_enable();
            (Context: IRQs Enabled)

Stack trace excerpt:

 BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
 in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 11063, name: kworker/0:5
 preempt_count: 0, expected: 0
 RCU nest depth: 0, expected: 0
 CPU: 0 UID: 0 PID: 11063 Comm: kworker/0:5 Not tainted 6.17.0-rc1-00001-g1149a5db27c8-dirty #55 PREEMPT_RT 
 Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
 Workqueue: usb_hub_wq hub_event
 Call trace:
  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
  __dump_stack+0x30/0x40 lib/dump_stack.c:94
  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
  dump_stack+0x1c/0x3c lib/dump_stack.c:129
  __might_resched+0x2e4/0x52c kernel/sched/core.c:8957
  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
  spin_lock include/linux/spinlock_rt.h:44 [inline]
  mon_bus_complete drivers/usb/mon/mon_main.c:134 [inline]
  mon_complete+0x5c/0x1fc drivers/usb/mon/mon_main.c:147
  usbmon_urb_complete include/linux/usb/hcd.h:738 [inline]
  __usb_hcd_giveback_urb+0x1e4/0x59c drivers/usb/core/hcd.c:1647
  usb_hcd_giveback_urb+0x100/0x364 drivers/usb/core/hcd.c:1745
  vhci_urb_enqueue+0x86c/0xc08 drivers/usb/usbip/vhci_hcd.c:818
  usb_hcd_submit_urb+0x2ec/0x1790 drivers/usb/core/hcd.c:1546
  usb_submit_urb+0xd3c/0x13ec drivers/usb/core/urb.c:581
  usb_start_wait_urb+0xf0/0x3c8 drivers/usb/core/message.c:59
  usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
  usb_control_msg+0x1d0/0x350 drivers/usb/core/message.c:154
  hub_set_address drivers/usb/core/hub.c:4769 [inline]
  hub_port_init+0xbac/0x2094 drivers/usb/core/hub.c:5074
  hub_port_connect drivers/usb/core/hub.c:5495 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
  port_event drivers/usb/core/hub.c:5870 [inline]
  hub_event+0x1de4/0x3c44 drivers/usb/core/hub.c:5952
  process_one_work kernel/workqueue.c:3236 [inline]
  process_scheduled_works+0x68c/0x1118 kernel/workqueue.c:3319
  worker_thread+0x834/0xc1c kernel/workqueue.c:3400
  kthread+0x5f4/0x754 kernel/kthread.c:463
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

It occurs after going through the code below:

 static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flags)
 {
 
 	...
 
 no_need_unlink:
 	spin_unlock_irqrestore(&vhci->lock, flags);
 	if (!ret) {
 		/* usb_hcd_giveback_urb() should be called with
 		 * irqs disabled
 		 */
 		local_irq_disable(); // <--- Entering atomic context (IRQs disabled)
 		usb_hcd_giveback_urb(hcd, urb, urb->status);
 		local_irq_enable();
 	}
 	return ret;
 }

 static void mon_bus_complete(struct mon_bus *mbus, struct urb *urb, int status)
 {
 	...
 	spin_lock_irqsave(&mbus->lock, flags);
 	...
 }

When called with interrupts disabled, usb_hcd_giveback_urb() eventually
leads to mon_complete() in the USB monitoring, if usbmon is enabled,
via __usb_hcd_giveback_urb().

mon_complete() attempts to acquire a lock via spin_lock(), observed in the
trace within the inlined mon_bus_complete.

Because vhci_urb_enqueue has already disabled interrupts, calling the
potentially sleepable rt_spin_lock() within this atomic context is invalid
and triggers the kernel BUG.

I request a review and correction of this locking mechanism to ensure
stability on PREEMPT_RT configurations.  Kernel config, full logs, and
reproduction steps can be provided on request.


Thanks,

Best Regards,
Yunseong Kim

