Return-Path: <SRS0=d+Jj=VP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F7DC7618F
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Jul 2019 20:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB599208C0
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Jul 2019 20:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3CBXJLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391344AbfGRUrB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Jul 2019 16:47:01 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:38310 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRUrA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Jul 2019 16:47:00 -0400
Received: by mail-qt1-f179.google.com with SMTP id n11so28706011qtl.5
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2019 13:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RWNfk0uNVFlbLLqt/HDWQ6WsSnHcM974iZpVBl0z9B0=;
        b=l3CBXJLRhsSmu9coDFTk5veD6Sxxax3NMth5dNSppiBSMNr3qjSxexKu29fItZXL1F
         PaaQ6zIThCM49eL/293zzaHd1d+w7MU3iEo9R0bZTE55j6tQ18QxBOdgEXyy+rLcaqYl
         dWjneE1GtYepmGhJH2GcilKQyQmyii6FzGe4vbChEiMuFeX0KjmDmK6ruZnEM7wqNY+g
         Uwwx1OG/IuJ3nmkwW8te5R81C6ryoBc7BCj58l8dl8sdMndMABsUlCk18abb8YyEUg6w
         45TLpAFt1NRV010seJBDEeRrfYybl6L0U6mBUHklTLYJMZpFI62+DCpfvDkXswG5KwXq
         f/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=RWNfk0uNVFlbLLqt/HDWQ6WsSnHcM974iZpVBl0z9B0=;
        b=ajGCk3YD9TIEhLVBfCQ7eXTmvRq9gjAcRM+s5scSAg1mbAdthqCAVYZPz8a3Vp+jX8
         WMm7D6D+7TsiXmurjh4njrjbv/lwyA97Ehs4dLS3rmbgCpLxlW1C6UaryMlKAZNXCcyh
         RLZLl2Ww31qu65pgLwDuZ/rt2eXJ0GbpiX0+7jnGgAErZpvKFR2AGePkRlNDRxIt4fAG
         B89N9geT4eUDNSN6x+nGLUyteFgOA55uXro1f7rplYuei3Tmy45gpLfBbpCeFIMi2BHM
         T6mbO2OVUorAgNbmyNnJhQbf8ec+XjVWVB923pG7w7l088o/mHr96ELpKS0IFXQJm5X5
         TttQ==
X-Gm-Message-State: APjAAAVxzI/GuiPF26Q2GKkyNrYaembMJgOowB6l3BYs7JJhtZITosOC
        u8oDEXXC3cLaXROeFuH1ehE3Nc3T
X-Google-Smtp-Source: APXvYqyaRiKdbw3CKVGlUeoPqNOll/Y6LNQPKMl++nGPXRM/FFRB0gX5OUW/CoWpetSkUBLZVGLs6Q==
X-Received: by 2002:ac8:877:: with SMTP id x52mr33828698qth.328.1563482819590;
        Thu, 18 Jul 2019 13:46:59 -0700 (PDT)
Received: from lclaudio.dyndns.org ([191.177.181.235])
        by smtp.gmail.com with ESMTPSA id h4sm13050419qkk.39.2019.07.18.13.46.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 13:46:58 -0700 (PDT)
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 9F0553C154C; Thu, 18 Jul 2019 17:46:55 -0300 (-03)
Date:   Thu, 18 Jul 2019 17:46:55 -0300
To:     Clark Williams <williams@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>
Subject: v5.2-rt1: kernel: BUG: assuming atomic context at
 net/core/ptp_classifier.c:106 current
Message-ID: <20190718204655.GA4097@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

Sounds like ptp_classify_raw() should be reached with IRQs disabled to
safely call BPF_PROG_RUN(). I am just unsure where, down the road, the
proper context should have been set.

08:46:58 darkmatter kernel: BUG: assuming atomic context at net/core/ptp_classifier.c:106
Jul 17 08:46:58 darkmatter kernel: in_atomic(): 0, irqs_disabled(): 0, pid: 1129, name: irq/35-enp4s0
Jul 17 08:46:58 darkmatter kernel: CPU: 1 PID: 1129 Comm: irq/35-enp4s0 Not tainted 5.2.0-rt1 #1
Jul 17 08:46:58 darkmatter kernel: Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
Jul 17 08:46:58 darkmatter kernel: Call Trace:
Jul 17 08:46:58 darkmatter kernel: dump_stack+0x67/0x90
Jul 17 08:46:58 darkmatter kernel: __cant_sleep.cold+0x68/0x74
Jul 17 08:46:58 darkmatter kernel: ptp_classify_raw+0x1f/0xa0
Jul 17 08:46:58 darkmatter kernel: skb_defer_rx_timestamp+0x5a/0xb0
Jul 17 08:46:58 darkmatter kernel: netif_receive_skb_internal+0x34/0xe0
Jul 17 08:46:58 darkmatter kernel: napi_gro_receive+0x66/0x1c0
Jul 17 08:46:58 darkmatter kernel: rtl8169_poll+0x216/0x610 [r8169]
Jul 17 08:46:58 darkmatter kernel: net_rx_action+0x208/0x490
Jul 17 08:46:58 darkmatter kernel: ? __switch_to_asm+0x40/0x70
Jul 17 08:46:58 darkmatter kernel: ? __switch_to_asm+0x40/0x70
Jul 17 08:46:58 darkmatter kernel: ? __switch_to_asm+0x34/0x70
Jul 17 08:46:58 darkmatter kernel: ? __switch_to_asm+0x40/0x70
Jul 17 08:46:58 darkmatter kernel: ? __switch_to_asm+0x34/0x70
Jul 17 08:46:58 darkmatter kernel: ? __switch_to_asm+0x40/0x70
Jul 17 08:46:58 darkmatter kernel: ? sched_clock+0x5/0x10
Jul 17 08:46:58 darkmatter kernel: ? sched_clock_cpu+0x15/0x100
Jul 17 08:46:58 darkmatter kernel: __do_softirq+0x140/0x3c9
Jul 17 08:46:58 darkmatter kernel: ? irq_finalize_oneshot.part.0+0xd0/0xd0
Jul 17 08:46:58 darkmatter kernel: ? irq_thread+0x95/0x1d0
Jul 17 08:46:58 darkmatter kernel: __local_bh_enable_ip+0x13d/0x160
Jul 17 08:46:58 darkmatter kernel: irq_forced_thread_fn+0x70/0x80
Jul 17 08:46:58 darkmatter kernel: irq_thread+0xf6/0x1d0
Jul 17 08:46:58 darkmatter kernel: ? preempt_count_add+0x88/0xc0
Jul 17 08:46:58 darkmatter kernel: ? wake_threads_waitq+0x30/0x30
Jul 17 08:46:58 darkmatter kernel: kthread+0x103/0x140
Jul 17 08:46:58 darkmatter kernel: ? irq_thread_check_affinity+0x80/0x80
Jul 17 08:46:58 darkmatter kernel: ? kthread_park+0x90/0x90
Jul 17 08:46:58 darkmatter kernel: ret_from_fork+0x3a/0x50
Jul 17 08:46:58 darkmatter kernel: bpfilter: Loaded bpfilter_umh pid 1160
Jul 17 08:46:58 darkmatter kernel: bpfilter: read fail -13

Luis

