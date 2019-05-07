Return-Path: <SRS0=qtLW=TH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3FDC004C9
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 May 2019 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518902087F
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 May 2019 15:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pv6nA2gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfEGPgV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 May 2019 11:36:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38726 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfEGPgV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 May 2019 11:36:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so2859205wru.5
        for <linux-rt-users@vger.kernel.org>; Tue, 07 May 2019 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8Y8+0f/XI5bSoWQ/UWSsP0ueKGIEHvDN+vqIVaLs7k=;
        b=pv6nA2gb7Iv9xiO0IosVcAhDOHw9WK2Z0D/eAdGaDWGYrQmvrwv9su4mcpLwsnVOYJ
         tdAIgbWmtzGlhQh3G0HH0zNCQXC+xF1ReF89Eky2uOfYc4ot2xe0JnvjsC7aZqyoqx0Z
         mnBvs7XSW8tri4NqlGa4BD4dN2dkegoem19OPUXi8c//aR7bgaZgimcgo1DppesqZras
         G6x1FYsVf38fLRwO8asva38e542Xatue0sqcTiVBtHWy0+/sdIYHom41tOOCRG48496S
         c7cXkgb3TasBGjqP9ipJzY33AJ6+TCZRFn/mWGnMbHSod74EVdVs2kwSoarhQte3ymAg
         bSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=f8Y8+0f/XI5bSoWQ/UWSsP0ueKGIEHvDN+vqIVaLs7k=;
        b=c2EDWwSsB4m4FO7mfgD9AG4o1pchbpQuIBxEXbE30ubWQrjSQDlHUl6AO3cMRBazXU
         MDfjKVbrDkARZHbrgXYFvuEELCdewqLnVJ2AGm9n1+M65zA+6/9iuRps9yFgFORjHKZn
         OxSItpvSgN2yLRi7mbBRRpJNseB44Lwh+wvlorSvmxxpLobIL64CGZtAjAy5SzyFwNHr
         tnSW5C2ChQ0SYjicnir/ESSp5ZaSxabMK++QQp4UyVAaAoY2RbZJ95oi128sm22T1Zg6
         /CowXh8JEBflA6tTK/dAM1Pi0/1iktWtegeDHYYzBf8+RNALmUkBW0nCW0DysTu/G1/c
         xbtg==
X-Gm-Message-State: APjAAAUFwmYRjMWZ8d3UzDjUkUwQVaYq/tIAMItZeIiaO9LRIyqAF2hq
        BMuonVqIqwYF8e2i6lmDj4xSEIOj
X-Google-Smtp-Source: APXvYqzfKxlBfkxRi5SRj4w8HjeNFlF2fOjMjaikUu3sMKzSSZkm7ro6L/b5VjIbageb3GVvOmWtIA==
X-Received: by 2002:adf:ef43:: with SMTP id c3mr24688027wrp.141.1557243378517;
        Tue, 07 May 2019 08:36:18 -0700 (PDT)
Received: from planxty.redhat.com ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id l19sm19753463wrg.29.2019.05.07.08.36.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 08:36:17 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] queuelat: Install queuelat helper scripts from the rt-tests Makefile
Date:   Tue,  7 May 2019 17:35:59 +0200
Message-Id: <20190507153559.16109-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507153559.16109-1-jkacur@redhat.com>
References: <20190507153559.16109-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Install queuelat helper scripts from the rt-tests Makefile

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 16cd2f9bdd03..ea80923918f7 100644
--- a/Makefile
+++ b/Makefile
@@ -180,6 +180,8 @@ install: all install_hwlatdetect
 	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man4"
 	mkdir -p "$(DESTDIR)$(srcdir)" "$(DESTDIR)$(mandir)/man8"
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
+	install src/queuelat/get_cpuinfo_mhz.sh "$(DESTDIR)$(bindir)"
+	install src/queuelat/determine_maximum_mpps.sh "${DESTDIR}${bindir}"
 	gzip -c src/cyclictest/cyclictest.8 >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
 	gzip -c src/pi_tests/pi_stress.8 >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
 	gzip -c src/ptsematest/ptsematest.8 >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
-- 
2.20.1

