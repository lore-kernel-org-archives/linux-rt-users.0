Return-Path: <SRS0=u1dD=AS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF1C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Jul 2020 03:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69412070C
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Jul 2020 03:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBUb0oPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGGDX7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGDX7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jul 2020 23:23:59 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE40C061755
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jul 2020 20:23:58 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e13so36936348qkg.5
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jul 2020 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4TrT8LwFtiVr+jeSh16vC97og4GDxip5tkQ+vrrDfI=;
        b=KBUb0oPo/fYoLam6rcG4pkLZTqWvNGMJL70Cwrz9YXJ2kk8P8irnR7dHVfsKiBfcsd
         +V2dMxg5tbMXVIyOkIbhDqNJd5rGxXceqJaNIUAZf/3Htk1xyJOB/RL6XgNEKlLtXBA4
         1irvO1EHZyqVnmMxoa1gW52zWgC/Y4/x3CFmiOU1OK4csWZGN25+us576Oiw3TONyHum
         Bc2843U6GrQfh/dyJz5WYRr94ZnAz1nw/s4lXC0Khr/QtFMfS0+/3Q5zEHjdKSQcdjse
         o6yGMhszjOcB6/SAvMBoIWvF1OPtHhUXO7Nk/v+RRKEZDeeK8SlXtwhTRPv6OaOdkByX
         9e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=c4TrT8LwFtiVr+jeSh16vC97og4GDxip5tkQ+vrrDfI=;
        b=YEo+d/qyKklYZuG9f+tGvhwUKMewOxdHZrn9QFVTZHtunJhQBSGu6E0BtAyZdXXb6U
         UazVMA0wSCjvaoWqdF8LwcRFCjdJlmpPnrk+JMryZcKYfsbPIwJjEcCVqQ23re0+AB//
         kZ2+E3LPaTd+gyFBw3bu72LTUBjGIClByqD6EhWWDp/Ovs6xzMIKqVjw3ezwf72lR04f
         t+Q1UngXa6fTtyB1hStsc+BleemGbfu2XJgBm/Ev0P3D0FsOpmVloKjpnrb5BGKDcgrT
         Zr+6V6kEY8hksF84Z6CDL+Cd7RYowCweZblY301/4P8GMSPFLZV8kyrTErS+9pOHkt7S
         SPgg==
X-Gm-Message-State: AOAM532mO3/sraywYzmFDhPlzeMW2GTUne2aKKkhtWQXP11SBbYGbi+f
        ytb/VS1SYsApYseWVwc933VqlbYcnqg=
X-Google-Smtp-Source: ABdhPJyAJBC/Rw5m5nRI3XcFMUgZpVeMuPbpqLskFq22AAuKLhsYb49uQHXJhaLD3byxRQ+/oAH9Kg==
X-Received: by 2002:a37:741:: with SMTP id 62mr49392374qkh.495.1594092238013;
        Mon, 06 Jul 2020 20:23:58 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id q189sm22918547qkd.57.2020.07.06.20.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 20:23:57 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Install new man page get_cyclictest_snapshot.8
Date:   Mon,  6 Jul 2020 23:23:48 -0400
Message-Id: <20200707032348.23755-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Install the new man page, get_cyclictest_snapshot.8

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 05fc5eda71fa..be7831277c88 100644
--- a/Makefile
+++ b/Makefile
@@ -47,7 +47,8 @@ MANPAGES = src/cyclictest/cyclictest.8 \
 	   src/queuelat/queuelat.8 \
 	   src/sched_deadline/deadline_test.8 \
 	   src/ssdd/ssdd.8 \
-	   src/sched_deadline/cyclicdeadline.8
+	   src/sched_deadline/cyclicdeadline.8 \
+	   src/cyclictest/get_cyclictest_snapshot.8
 
 ifdef PYLIB
 	MANPAGES += src/hwlatdetect/hwlatdetect.8
-- 
2.21.3

