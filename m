Return-Path: <SRS0=1QYP=4N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C2C4BA04
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Feb 2020 23:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986602072D
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Feb 2020 23:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbnm1bGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgBYXmj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:42:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47025 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBYXmi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Feb 2020 18:42:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so397237pfp.13
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Feb 2020 15:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qTj45sA6m6qjSHvmrkPn9syAMGmwAM/fZ5Y1KhSYL2E=;
        b=cbnm1bGeww1oQBZKZMvozvGTXKNgyunvKR7JbID8mIxv7MUdwyO3sLZMG7MCjPcPuY
         OrwYKYoSwDtVa9u7eix3BXOFdSc8eX3uW/fCYx3RWbQt3WS0z0m4I1yDMsZbiLsEkmGD
         XzCFIjmtMxpDs/o5K6o9C5DmP0gbd14BKvQaYBYQxzTJs4poWwskq6+GXfbn2bqt80tN
         Ly70En5zSYziKPXufpHk4vHbFLY4qJ9hra3xhKF7iJk43INApEiWBNUeDA9CrGseUoCc
         pqOmlp6G3m1FOWDBpwslvxoGGPQ3/V/cQlsbt8Rs2SbhH/f++EnWPWJKn3Dtjzo80Lt7
         ylpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qTj45sA6m6qjSHvmrkPn9syAMGmwAM/fZ5Y1KhSYL2E=;
        b=m5E7Z2dS1LZdeFUi4PIaF/xaS4w7MmvShW0kpNqjk+46F83+xkfH6MAdFI0OqeVy/I
         6/6Wo44uNU9WHlz3ODvkiPOsncd1trDSP+liAJI/uiW3Q6jg6zHpHx+vqC5QYGpszZeA
         obDZfSRBOzEi2rvnwJhc1MB7cRVGJlt0qW2wV3fwZKdFWtjWX5reFD4iGu05kIiFnfZJ
         pmu25rPXS4SjwXqk7E0O5pezqSEFc9HB6BBBRt8TTn+e7jYeZwoTqJ2HA1mqTUDH9JdM
         Z6guf42hcb+ipPaD9TFGcn7yDqU4MOTCjL5O5zhpRJujCL8/tGZOgnKd84aqSk+trO1+
         hYvQ==
X-Gm-Message-State: APjAAAUtgbHYWtnnW9sW7/j3ZN9fkkvsbFwDI5DEZqrxphRdV+bN/PTM
        CSoh8VLQT/PpNbx8uKsIsZSqyiyG
X-Google-Smtp-Source: APXvYqwanqXYQYPlwglJjsHBRxr2RrThOBFh3nzq4abJf3VyKt+O/w6jR7vr7YeV1t1uByPYYoUr7Q==
X-Received: by 2002:a63:e011:: with SMTP id e17mr938865pgh.49.1582674157706;
        Tue, 25 Feb 2020 15:42:37 -0800 (PST)
Received: from workhorse.localdomain (99-14-97-149.lightspeed.frokca.sbcglobal.net. [99.14.97.149])
        by smtp.gmail.com with ESMTPSA id o36sm119408pgl.24.2020.02.25.15.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 15:42:37 -0800 (PST)
Received: by workhorse.localdomain (Postfix, from userid 1000)
        id 878E72A05A0; Tue, 25 Feb 2020 15:42:35 -0800 (PST)
From:   "Jeremy A. Puhlman" <jpuhlman@mvista.com>
To:     williams@redhat.com, jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org,
        Jeremy Puhlman <jpuhlman@mvista.com>
Subject: [rt-tests][PATCH] rt-tests: make manpages builds reproducible
Date:   Tue, 25 Feb 2020 15:42:30 -0800
Message-Id: <20200225234230.17232-1-jpuhlman@mvista.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Jeremy Puhlman <jpuhlman@mvista.com>

Add -n to gzip call to make the build output
of the manpages reproducible.

Signed-off-by: Jeremy A. Puhlman <jpuhlman@mvista.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8747971..1b37ba7 100644
--- a/Makefile
+++ b/Makefile
@@ -181,7 +181,7 @@ ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
 %.8.gz: %.8
-	gzip -c $< > $@
+	gzip -nc $< > $@
 
 %.8.bz2: %.8
 	bzip2 -c $< > $@
-- 
2.20.1

