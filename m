Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC99C4332F
	for <linux-rt-users@archiver.kernel.org>; Sun, 27 Nov 2022 05:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiK0FK2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 27 Nov 2022 00:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiK0FK1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 27 Nov 2022 00:10:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC0710FED
        for <linux-rt-users@vger.kernel.org>; Sat, 26 Nov 2022 21:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669525812; bh=OXKIdAHCClvjhunrUaiiwnTTfVfWOIbhFhvfye64kRE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=lDOe+MUEmSA8HIQJO91VmL/WrWMy9jmFjB6rOOnCAjzdKjoRY6l2pKN6zZcuyR8f2
         Cat22kks/SB6VeJPMoWEAqaYzP6e2ZXmwTVDUfGWVrytafr3xyMS2croQZ2uvOHRSq
         kQYVX1QfHxbUsZTk1WNbxLrQLHnweux0uYSWH/j5oL+3gTHOfDD8iqOyKtGt5kXKPN
         Pqj6oiULhtnITvuDUXf13wEekKz0i2foW5ewLdpZsVksDm9oDm9HBLXwldLvEuiYpU
         cSIUBVmWwaD4kT1+cXocti3kokSnw27QMbipcELmmxEKjwfoChcDTFUQqzZdGgjgZq
         SE3YKLk+P+5FQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.241]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1pQYhU0ROe-00RZV3; Sun, 27
 Nov 2022 06:10:12 +0100
Message-ID: <1806ff76592576c6e6dba91f09ce661b7c75a9a9.camel@gmx.de>
Subject: v6.1-rt4 rpi4 boot time atomic_sleep splat
From:   Mike Galbraith <efault@gmx.de>
To:     linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sun, 27 Nov 2022 06:10:11 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:k7X488KccnxeQZNmQHgfYBVNoICA5RBvs46rsvLkrIxrzBacBMF
 mWrIyDLkf+0k86ncm2x4Oe/W4bJUTzSx8TXdjQxdEX3B4Hs0sE2gGtek6z4h/+297a9Pg71
 Ua+W2PVXav3UgyuHVootLJ3ft0l1ebc0D5uJLCFe9JIJBaYkcn8HebEYebab7tX18uyeGDm
 aaQTevq9WsQncD42A3mmw==
UI-OutboundReport: notjunk:1;M01:P0:OQGmE1AVHtA=;xtRw6v8nbPETwTowS/Lmmgc+MOE
 achI91CruDw3vnOT6h4RFZIhs328N6LoIoyf9oULqMNOPUPcdSWKlMP5smZsSjlC3mq3pkAtz
 miSJVrkkbXkFsuehGrFyfGEWoBHKizHc3NLXWPvBvZObjyM8Oo4ip7u3f5gqx/bJ+wlDvVk1H
 4UpUjtgjewDnHDdPfJ6JWgYwAIs0xqJa4hMZ4YOZ+Pkrfh8BPNqLzY6YbCmXsxtUF9qCaGz2c
 Ih2oplFeA/hLhiBMe0FwFb2JgLKyAGUi6RFxH93vwUhxh3ytDEHS9MK2yZMtokiMzgZbQ/ylM
 bCC0JJyTFOdj5KEWu3WegVgo3elFGk44h6nVi4EsW1pl7SRDm6mx5K/cIza+VeGcrSmo5Ogog
 EhyEOVe/ROYQfeuNVQx1jA5TdhPVfJMMfqWd5BNDECPk0RA3wiISGPqedyoJmHeQWwADbu01W
 ow53zIGCrWF4DWmnnI0uUvdhmHDGdqMTea8oQie0v+C8E6+Rxk8Q57KXDaIJZvJ50l4xBToKY
 BcNQLnEzWJvZ2LFjgkTol1/nUpALn3tMb3Czx9n5p+cTYaq/Ad/MGsK0LVGu5he1rHByESZSk
 GESYnA4AtFCR3rKk6RP7++3OVU12c19BQe/3RTheRlAk1WGa787OtP9WHJrUPoJdoNRUHBat4
 M6Rr/jDEhvDYHEaPexH5m1WMkp62nfuUCE+alrDMaQgBkRy/CIauIoV5g8LX2iv4CUpY7e1sI
 i6bjCIzg0Rr0SNGLNk6LdRShFRJV1/fHHdYlKMR0HKWQlmjxCt4EvFS6jbuCWv+kIKxKVne+m
 vhbvqDXxNCB9PVm8TyirMkr0pRn9QqXUOgbEubfYLhDnLJuvV6REi3H9CcTNgghNSmRYjsQiX
 8n8tP0F3pZKitevwB05UzyUXe9gxqYfu015mzUnuKlMiArXavYaUFW8OuJJU2rDXg5/gle+HL
 zCyxVg==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sole splat seen during brief master usability test drive.

(older rpi kernel is still way better idea, but it's improving.. boots,
runs and hdmi audio started working)

[    0.007076] smp: Bringing up secondary CPUs ...
[    0.008304] Detected PIPT I-cache on CPU1
[    0.008377] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[    0.008384] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
[    0.008391] preempt_count: 1, expected: 0
[    0.008396] RCU nest depth: 1, expected: 1
[    0.008400] Preemption disabled at:
[    0.008403] [<ffffffd3244ca8e0>] migrate_enable+0x40/0x170
[    0.008425] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.0.g0b1dcc2-rt4 #25
[    0.008437] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
[    0.008442] Call trace:
[    0.008445]  dump_backtrace.part.0+0xe8/0xf4
[    0.008455]  show_stack+0x20/0x50
[    0.008463]  dump_stack_lvl+0x64/0x80
[    0.008477]  dump_stack+0x18/0x34
[    0.008488]  __might_resched+0x15c/0x1c0
[    0.008502]  rt_spin_lock+0x38/0xd0
[    0.008514]  rmqueue_bulk+0x68/0x850
[    0.008529]  get_page_from_freelist+0xbe4/0xfa0
[    0.008542]  __alloc_pages+0x14c/0xf70
[    0.008554]  new_slab+0x2f0/0x374
[    0.008569]  ___slab_alloc+0x5f0/0xbcc
[    0.008584]  __kmem_cache_alloc_node+0xd0/0x380
[    0.008591]  __kmalloc+0x6c/0x1c0
[    0.008603]  detect_cache_attributes+0x448/0x564
[    0.008620]  update_siblings_masks+0x30/0x304
[    0.008631]  store_cpu_topology+0x48/0x60
[    0.008640]  secondary_start_kernel+0xc8/0x144
[    0.008656]  __secondary_switched+0xb0/0xb4
[    0.008752] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
[    0.010180] Detected PIPT I-cache on CPU2
[    0.010300] CPU2: Booted secondary processor 0x0000000002 [0x410fd083]
[    0.011522] Detected PIPT I-cache on CPU3
[    0.011649] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
[    0.011768] smp: Brought up 1 node, 4 CPUs

