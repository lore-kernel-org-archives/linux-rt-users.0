Return-Path: <SRS0=0hJj=WQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE61C3A5A0
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 00:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C01206DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 00:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwf1VA32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfHTAda (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:33:30 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46934 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfHTAd3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 20:33:29 -0400
Received: by mail-yb1-f196.google.com with SMTP id x10so1253097ybs.13;
        Mon, 19 Aug 2019 17:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyMT0jwhb6wCowCFW/o5BpgRu7EcFHVU+3LZ1Fjgnh8=;
        b=Bwf1VA32s3fDTHNmDZ0aPk7evhArYfMfbe6KbqijJ60jU6wBmb+ee6hqfQHNY8FqOb
         3nxlWu1cW4m4juHjPuG9B/HrhdgbpZlw2lXk5ChuR9+F4X/scMZTdC+kQrjv5lB6jWFN
         5Ppl1Wyxldz15g3MEAfqGm2zOCQ8SxwVba19XyWWwFlv/j3BCkLvTd7a8X+I8bJAhSF9
         EGFX/Yu/vjJ74CwYn2BddqgK+FHwQTuyERpSsc7vGdvX4w9+/LIagx1V4T0AEWBeoBFL
         SDwwEB2gXZqCdeQrxSNW3qB9iFSpLujlQT9mgsSHLQOJv8XmV5GKY5ZH59owdKQRAr8P
         BTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyMT0jwhb6wCowCFW/o5BpgRu7EcFHVU+3LZ1Fjgnh8=;
        b=mYjnQbh9lgcyAR1hgbRseUD9sPBaITHnxdbso3ebhk8Bi2qLLAsydS3Y4r990FuBN7
         6+1gqn4RDCH4z8IavTQFcbQWKdWc9bpVxiskHt6tBuMXeld19UQMR0/1kzJD4mSGx2M8
         h0HTmZa+pxNBbkrRiuvZ+I6V3QT+aVIvC9Tn2VXTl6oPk6aNeGB23c2VEMrJBLd/9OKq
         yN6Js2bQkfga8ozkGU/WsebmT7SIkQ4M4b65w68aUUYM6M3RitbvWdxLc4eas4FplQIF
         SuisS6SfKQETLs3ZXRM0hE017QZ5tUm/Tfxkay/OwnB2aMbzgyhaEebK4pKmdnBNGLqm
         4W7Q==
X-Gm-Message-State: APjAAAUig0JPcCL7LdA9YUD4ChUCDCvcpmlTx6w0jx9mYzpOPwzpxMoD
        3/RlHgtLocOlw0F8zdDYOFRWufqy
X-Google-Smtp-Source: APXvYqwnaxtymrerCMBld5Oye1d4dxh8rK4hOdZ4Xp4kvbZJx+IKlJkWD69gJi482FIJ6o8oIhr82g==
X-Received: by 2002:a25:aca:: with SMTP id 193mr16921407ybk.521.1566261208611;
        Mon, 19 Aug 2019 17:33:28 -0700 (PDT)
Received: from theseus.lan ([2604:2d80:b386:1f00::780])
        by smtp.gmail.com with ESMTPSA id 193sm3658853ywh.89.2019.08.19.17.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 17:33:28 -0700 (PDT)
From:   Clark Williams <clark.williams@gmail.com>
To:     bigeasy@linutronix.com
Cc:     tglx@linutronix.com, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PREEMPT_RT PATCH 0/3] i915 fixups for lockdep/lockdebugging
Date:   Mon, 19 Aug 2019 19:33:16 -0500
Message-Id: <20190820003319.24135-1-clark.williams@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Clark Williams <williams@redhat.com>

The i915 driver was throwing splats on my home test box running
v5.2-rt3 when I turned on lockdep and lock debugging configs. This was 
mainly due to the non-side effects of the spin*_irq*() macros which do
nothing to IRQs on PREEMPT_RT. Converting the various irq_lock spinlocks
and the uncore lock to be raw_spinlock_t fixes this, although I'm not
sure of the performance implications for latency spikes. 

Testing was done on an Intel NUC with the following graphics:

00:02.0 VGA compatible controller: Intel Corporation Iris Plus Graphics 650 (rev 06)

Testing on other variants of i915 would be appreciated.

Clark Williams (3):
  i915: do not call lockdep_assert_irqs_disabled() on PREEMPT_RT
  i915: convert all irq_locks spinlocks to raw spinlocks
  i915: convert uncore lock to raw spinlock

 drivers/gpu/drm/i915/i915_debugfs.c        |   8 +-
 drivers/gpu/drm/i915/i915_drv.c            |   6 +-
 drivers/gpu/drm/i915/i915_drv.h            |   2 +-
 drivers/gpu/drm/i915/i915_gem.c            |   4 +-
 drivers/gpu/drm/i915/i915_irq.c            | 154 ++++++++++-----------
 drivers/gpu/drm/i915/i915_pmu.c            |   4 +-
 drivers/gpu/drm/i915/intel_breadcrumbs.c   |  51 +++----
 drivers/gpu/drm/i915/intel_display.c       |  20 +--
 drivers/gpu/drm/i915/intel_engine_cs.c     |   4 +-
 drivers/gpu/drm/i915/intel_engine_types.h  |   2 +-
 drivers/gpu/drm/i915/intel_fifo_underrun.c |  16 +--
 drivers/gpu/drm/i915/intel_guc.c           |   6 +-
 drivers/gpu/drm/i915/intel_guc.h           |  10 +-
 drivers/gpu/drm/i915/intel_hotplug.c       |  36 ++---
 drivers/gpu/drm/i915/intel_pm.c            |   8 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c    |   8 +-
 drivers/gpu/drm/i915/intel_sprite.c        |  32 ++---
 drivers/gpu/drm/i915/intel_tv.c            |   8 +-
 drivers/gpu/drm/i915/intel_uncore.c        |  52 +++----
 drivers/gpu/drm/i915/intel_uncore.h        |   2 +-
 drivers/gpu/drm/i915/intel_workarounds.c   |   4 +-
 21 files changed, 220 insertions(+), 217 deletions(-)

-- 
2.21.0

