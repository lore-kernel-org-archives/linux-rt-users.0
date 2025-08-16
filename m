Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B713EA8D;
	Sat, 16 Aug 2025 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755311902; cv=none; b=gZffOHcESH1v+iLDAunYSPcY6SS5+0KvKzJ5GrAKhUkLmXfGLnGTp3VG06PZIwVdhzzIMdU1lvMHDQwZzkPoFcZygw0OmIBUQU8//MHikCEIuAloywW8PUzjd7+M073vj9B70jjUv+nlD86Hb0w2t+0yqPIAjBi70ELSFw0Hlw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755311902; c=relaxed/simple;
	bh=I1SSCfXKHJm5JlVGrebwtb326YyL9MQr/FIgmseAKnk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Wylm3JjWXaIqdr77yBs1qSumJmrW+tjuKj46ZlNIfhCEq+CAqlbBpF878H8QJ9Nwh+leqmAYsdCEWkh+mYx17Pq41ITiNoZzULYUO4j2ULs4Kv4Zyi8ePTsIc0TmLDGRWG4M7+F9+eHu8997c2zHqJhdC7SHxNgzb9/QcQX+v0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b471751142aso344894a12.2;
        Fri, 15 Aug 2025 19:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755311900; x=1755916700;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtYxl+rrETdJtMyZa8ApEqZEanvH/+Xy7WfUj5F8zoc=;
        b=BI7lzh7QtA6Hra+hGil7YJ17q5oTIFtPXhPhfI7qpeHZgb2V+PEbYkdO/R6HA5HrNX
         1f/g/Ka9kIb88N9xi0XER8oV2xy1JUnsj04GoVp2m57GPMAgmeTnX3mhX+iVOCXs+6Zh
         fNMUcQGSK8X58q5J7e01SzuRaTdwNQhuolglG/k7kWUv+awEaqEzE47AjTY//Pp7ChYC
         w+v2Cm8/8X084roZyF4jwk2/OOCNg8EALIpF5MVBeDNXZGw/sugWBKGZvD8L2Ip0Bezx
         4NoOXD0iu8vdV06Ctr37bgg44Kud7JxjTNFA9zrll7Jo5H5CwKOj43dtFI53N/GuiUwk
         vj3w==
X-Forwarded-Encrypted: i=1; AJvYcCVnkaTbCPV6jMn9ldNXLmvPUQAGfSXZbrWDo5K1EaVhtsHgeVegTyyxLwPKoeqBlPI6gfETTKM7LSr0ILI=@vger.kernel.org, AJvYcCVrThgh7g0cpWhyi+HJ77gutZcdpPhdgLpvTNesXsLQgSV0JLXTz4/CyNjISZhcaUlg5coz7Gm3ClbAsdRKFkQ=@vger.kernel.org, AJvYcCWJUm6GEMNHi2uUDYF9xb5MmaJTrMWdFi9gGqM9v91pHQOMdy6Axk8P2azGui0zrWgvdB6uQ7FmPUfQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuzm/VTf4iJdeUno3dP5J7CXH4AOg3TvZmth+Jk/MZrWVgA5GL
	FxpkBtXlJmtEZob1UkPFhhuy3BDuTdv8uxAVk4NqteX8b8SgKpluMeBkrUilAQ==
X-Gm-Gg: ASbGnctFr9L93OyTqEJamFD7sVIQuuYMY2622BghcCGbz6PrghEoBsoT7ZXIzhdJ0Ek
	Y1QmZxp5PW/VLbZizBlcStC+evs9n+oVp77ffsGpGtyb0nL29yLl10qKTuFzag4rHXqnNEgzxNE
	5b+CdKrRLapjZspQRD+MIWCjWHz76GWjLhvSYduCwPQS8GqQgk0rlDM1vM3qSzP0FNLEHRl7DLi
	7K72xE5WDTrWKwqQe/quqXpA/nqtE2gsKRv3fxieBCniUuEMoDw/ANmn6PLIWj7A7LVWIGH+nT0
	dX3IlG1mzScLT4tvGh/QsvID+Fele6LlpUT8r4edbw3xvQOLwJk/3b+XqxU19NeHxrFOeUYZhBC
	1UCfMeuEmNrqn7qhhjvg/BUKZJkEBmp2y
X-Google-Smtp-Source: AGHT+IHzCz7VyRWLMvefhL0mlUPzZ6+vJ+DogXCfUzXPUObVZRUSTVsB5cxDnu4dREpr5dZuhI+baA==
X-Received: by 2002:a17:903:1a70:b0:240:11be:4dbe with SMTP id d9443c01a7336-2446d95b26cmr27393595ad.8.1755311900471;
        Fri, 15 Aug 2025 19:38:20 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d577f31sm24692425ad.152.2025.08.15.19.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 19:38:20 -0700 (PDT)
Message-ID: <5b337389-73b9-4ee4-a83e-7e82bf5af87a@kzalloc.com>
Date: Sat, 16 Aug 2025 11:38:14 +0900
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
 linux-usb@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Nam Cao <namcao@linutronix.de>, Marcello Sylvester Bauer <sylv@sylv.io>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Al Viro <viro@zeniv.linux.org.uk>, andreyknvl@gmail.com,
 Austin Kim <austindh.kim@gmail.com>, linux-rt-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
From: Yunseong Kim <ysk@kzalloc.com>
Subject: [BUG] usb: gadget: dummy_hcd: Sleeping function called from invalid
 context in dummy_dequeue on PREEMPT_RT
Organization: kzalloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

While testing a PREEMPT_RT enabled kernel (based on v6.17.0-rc1),
I encountered a "BUG: sleeping function called from invalid context" error
originating from the dummy_dequeue function in the dummy USB driver.

The call flow (triggered via ioctl):

  Userspace (syz.0.2514 via ioctl)
      |
      v
  raw_ioctl() -> usb_ep_dequeue()
      |
      v
  dummy_dequeue() [drivers/usb/gadget/udc/dummy_hcd.c]
      |
      |     (Context: Process Context, IRQs Enabled)
      |
      |---> local_irq_save(flags);
      |
      |     *** STATE CHANGE: IRQs Disabled (Atomic Context) ***
      |
      |---> spin_lock(&dum->lock);  <--- Trace location (dummy_hcd.c:769)
            |
            | [On PREEMPT_RT]
            v
            rt_spin_lock() [kernel/locking/spinlock_rt.c]
            |
            v
            [May Sleep if contended]
            |
      X <--- BUG: Sleeping in atomic context!

      |
      |---> spin_unlock(&dum->lock);
      |
      |     (Note: IRQs are still disabled here)
      |
      |---> usb_gadget_giveback_request();
      |
      v
      local_irq_restore(flags);
      (Context: IRQs Enabled)

Stack trace excerpt:

 BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
 in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 27291, name: syz.0.2514
 preempt_count: 0, expected: 0
 RCU nest depth: 0, expected: 0
 CPU: 1 UID: 0 PID: 27291 Comm: syz.0.2514 Kdump: loaded Not tainted 6.17.0-rc1-00001-g1149a5db27c8-dirty #55 PREEMPT_RT 
 Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
 Call trace:
  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
  __dump_stack+0x30/0x40 lib/dump_stack.c:94
  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
  dump_stack+0x1c/0x3c lib/dump_stack.c:129
  __might_resched+0x2e4/0x52c kernel/sched/core.c:8957
  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
  spin_lock include/linux/spinlock_rt.h:44 [inline]
  dummy_dequeue+0x9c/0x3b8 drivers/usb/gadget/udc/dummy_hcd.c:769
  usb_ep_dequeue+0x70/0x21c drivers/usb/gadget/udc/core.c:330
  raw_process_ep0_io+0x2e8/0x704 drivers/usb/gadget/legacy/raw_gadget.c:738
  raw_ioctl_ep0_write drivers/usb/gadget/legacy/raw_gadget.c:766 [inline]
  raw_ioctl+0x1b44/0x3288 drivers/usb/gadget/legacy/raw_gadget.c:1312
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:598 [inline]
  __se_sys_ioctl fs/ioctl.c:584 [inline]
  __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:584
  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
  el0_svc+0x40/0x140 arch/arm64/kernel/entry-common.c:879
  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
  el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:596

On PREEMPT_RT configurations, spin_lock() is replaced by rt_spin_lock(),
which may sleep when contended. Therefore, it is forbidden to call
spin_lock() while interrupts are hard-disabled (atomic context).

The issue occurs in dummy_dequeue because it explicitly disables interrupts
using local_irq_save() before attempting to acquire dum->lock via
spin_lock().

static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
{
    // ... (snip) ...
    ep = usb_ep_to_dummy_ep(_ep);
    dum = ep_to_dummy(ep);

    if (!dum->driver)
        return -ESHUTDOWN;

    local_irq_save(flags);       // <--- 1. IRQs Disabled (Enters Atomic Context)
    spin_lock(&dum->lock);       // <--- 2. Calls rt_spin_lock (May sleep) -> BUG
    list_for_each_entry(iter, &ep->queue, queue) {
        // ... (critical section) ...
        break;
    }
    spin_unlock(&dum->lock);

    if (retval == 0) {
        // ... (snip) ...
        // Note: Called while IRQs are still disabled.
        usb_gadget_giveback_request(_ep, _req);
    }
    local_irq_restore(flags);    // <--- 3. IRQs restored
    return retval;
}

The pattern of manually disabling IRQs and then taking a spinlock
local_irq_save() + spin_lock() is unsafe on PREEMPT_RT, the current code
structure keeps IRQs disabled even after spin_unlock(&dum->lock) while
calling usb_gadget_giveback_request(). This extended atomic context can
also be problematic if the completion handler attempts to acquire another
sleepable lock.

I request a review and correction of this locking mechanism to ensure
stability on PREEMPT_RT configurations.  Kernel config, full logs, and
reproduction steps can be provided on request.

Thanks,

Best Regards,
Yunseong Kim
