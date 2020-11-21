Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8EBC388F9
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Nov 2020 05:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B236722226
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Nov 2020 05:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUkSSpIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKUFTk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 21 Nov 2020 00:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgKUFTj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Nov 2020 00:19:39 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D600C0613CF
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2020 21:19:39 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id t8so12157464iov.8
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2020 21:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KReC2PsFJh3Yusuz+sa+JHCTB6+Va/CWFxyhZtFcJIs=;
        b=LUkSSpIeZhQumQ9DUUjzMfD0Jgawids5jPxuEP7tcuwSOj3n6P7uvB1c9UOsR8bHS2
         MgKfo+uwRT0k+ZpEmrnLodaN6P0oAs+wgz6Y2IoCXZAlyAf0HxGfqFYodsJMj9QPgY30
         LnP38K2e5imGwMZLhURar/8LhkQ+1GjYgcCW92T1zwdHJwJ8bEqY/YAjKd9mj3elYdQe
         SP2qh16NLYrwHYPrUqG/dhJ+tu5vvRexHMxX4J37Z46i2VdN3Jvt0FxForRy9wRiwQmq
         u5TQ/++YBlZMuoFN1ZB8M3h2crAcWrT1Fh2rnh+oW4oLTbLHCwX2J0K8xiP426EgavEm
         Wc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KReC2PsFJh3Yusuz+sa+JHCTB6+Va/CWFxyhZtFcJIs=;
        b=X2ADO/s5rIQw5ZdXSEJHEZbTHQ4E3yXPvuze8hUW9iiIIoxJ+ESqZolLW3aFExcL2x
         cPT3xH2Dd4cblv7wFhgPujpdWh1zmF8YWiu0vKwVd9xPYv4Do7pNErA0lcIFKmdBoLgs
         sR1o0pLPpezl7yz+rD/IkQjPm1BNVP2yrq+zCQSDSNsfjvZV8SOPp5dtZ2MBfqRm7LFd
         Kj7WmSQ5H5evGcNU8x52tm+8SOgJ/FF+4pKsujr2Z1/U6Vfd04S+oRpnclGkhUu/EVlG
         62jMsvc+ugPQY3xPfFlgzLZwYLbmMxk66BFZID9SC82rovnMQSpYQHQgs8J0wlNNiPTn
         hqxg==
X-Gm-Message-State: AOAM533kvCVM0FY6exVai0WuhYRyxkZqigB6G3a9jUjn+LSYDcgKJg8u
        xmMimhOeHYvD0xOadIOWeNVvVJgmjOQsow==
X-Google-Smtp-Source: ABdhPJyU6gppEe6nrhqy8ZiDZ8vvI3lM1mNW04VajH2xxv2i/e0Xz3zyoUnlJIMOI/ELwBiA2aI5vw==
X-Received: by 2002:a02:70ce:: with SMTP id f197mr22542718jac.120.1605935978210;
        Fri, 20 Nov 2020 21:19:38 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id z6sm2874298ilm.69.2020.11.20.21.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 21:19:37 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Don't compress man pages by default
Date:   Sat, 21 Nov 2020 00:19:25 -0500
Message-Id: <20201121051925.24507-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This patch changes the default behavior of the Makefile to install
man pages without compression. This allows distribution build systems to
use the kind of compression they wish to use without the Makefile
getting in the way.

It is still possible to compress the man pages using the Makefile, for
example

make MAN_COMPRESSION=gzip

or

make MAN_OMPRESSION=bzip2

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a410cb24cf34..3b38d21afb3a 100644
--- a/Makefile
+++ b/Makefile
@@ -59,10 +59,9 @@ MANPAGES = src/cyclictest/cyclictest.8 \
 
 ifdef PYLIB
 	MANPAGES += src/cyclictest/get_cyclictest_snapshot.8 \
-	MANPAGES += src/hwlatdetect/hwlatdetect.8
+	src/hwlatdetect/hwlatdetect.8
 endif
 
-MAN_COMPRESSION ?= gzip
 ifeq ($(MAN_COMPRESSION),gzip)
 	MANPAGES := $(MANPAGES:.8=.8.gz)
 else ifeq ($(MAN_COMPRESSION),bzip2)
-- 
2.26.2

