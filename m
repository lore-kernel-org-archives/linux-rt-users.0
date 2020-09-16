Return-Path: <SRS0=TxdF=CZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437BAC433E2
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Sep 2020 18:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A68206B5
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Sep 2020 18:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t0muO0TA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YpG409Yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgIPSiC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgIPS3N (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Sep 2020 14:29:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B3FC00867E;
        Wed, 16 Sep 2020 06:48:44 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:48:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600264122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0/VZg6wbWAvukFWWQ0elkbfFN5Dw6CkfsHF1d+jr2R8=;
        b=t0muO0TACNMhOXxHgjIvsMKzaUknk0Al3nS1cqUlikYW7QKLWGtYSzr23MgCDzRGYyBrB0
        Extf/f2GbyEqEX6DZ8zYC5XL8/nQb+JLmUIThRSbL3lZuXDARla82U7hjJRVUyVVwaziX9
        sVVH5c4V1F0L6LSOkuZJU4o/lriQv3Ckj1gfCxnwl/O7sLC+14aEp9vPWaHOaF/Zoqeulw
        PL8N3SAn61RxjLn3FaQuWcIV2+G8vDW5LXtibH2696wHY+02n3lUWTLWQ4t1q1K/57+or5
        U5Z308J5VCOhJ79fTBZuDnzRUikjOHAm5PcRRpTvYgl5BlMeuc5Vf7SkGDApFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600264122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0/VZg6wbWAvukFWWQ0elkbfFN5Dw6CkfsHF1d+jr2R8=;
        b=YpG409YdI/4Y5u0Iidig6cPwSnngsC+oBFfhw0ktYjYRVPlnWGfYZg1ELo1a36qVtw5bR3
        gGpkNAEq95b7PSDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9-rc5-rt7
Message-ID: <20200916134841.gykarzgc4xowiv5w@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9-rc5-rt7 patch set. 

Changes since v5.9-rc5-rt6:

  - Modem Host Interface (MHI) bus failed to compile. Patch by Clark
    Williams.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.9-rc5-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9-rc5-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9-rc5-rt7

The RT patch against v5.9-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9-rc5-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9-rc5-rt7.tar.xz

Sebastian

diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index c4a940d989121..2b4ed30d47294 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -9,10 +9,9 @@
 #include <linux/device.h>
 #include <linux/dma-direction.h>
 #include <linux/mutex.h>
-#include <linux/rwlock_types.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
-#include <linux/spinlock_types.h>
+#include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
