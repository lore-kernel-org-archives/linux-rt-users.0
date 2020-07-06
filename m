Return-Path: <SRS0=ADFb=AR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F92C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACBC206B6
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXOzrGW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgGFURk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFURj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jul 2020 16:17:39 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFCBC061755
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jul 2020 13:17:39 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u12so30016800qth.12
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jul 2020 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UApLotKODZfZLt+vWcpyJlxdyK9dxCCJ5XqFGIiJ4mw=;
        b=ZXOzrGW7J06AyArNHIoBP2QnhE9fRdsNrI/mokNriOIHyi7F+78KI+WsaGU6Bqub9S
         bswnGHt5cE57nIDQbQWDXWh6GzK7vpwHWqpjE3+NeCuOzAXvAvltyB1ikKdmGCtqXlQr
         dqSuZ6NsL55i6ENIpZSo5nsBbUEVR4Ozv1JMxfWIK0rVB1tXBm6nEKxOWOUU9y1K2C4c
         MtUDDp+QWjqWLIR0TD8LkPXTnd796GplwOcxhqlDtLdAxB1SKl+lJnxGk5kRrum2+tD4
         URi48H8M2PC2+Io411EizZhagaJKYnqVN/u3vP2w7C0hOyCdBta7gbbDv876YP11SA1Z
         caPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UApLotKODZfZLt+vWcpyJlxdyK9dxCCJ5XqFGIiJ4mw=;
        b=S2ntLczVe0u4+vl6hQUgBOIgDKDmeSYPKn+szUIAUOLvvW5n1tYQnjmQ2jTSQcuNp1
         xkPFGPxp1gtJfE7n3phxrKjYF3uvdvlBaeee2rOmd0wsJhZ5fOIEOGp7ozFe3KORh8YT
         YaH0rMPQ8o316+8STeEfk/nsy+09dxOb2SaUHjMUKsxJVb/4tBTcQuE67yqr7EATHiDb
         imU8LiUFJGxXiI5OtamSGUO5DmwY4HwFsTqfULQjOd0xExo3k3zXLtTL1LPMNsrgLPwc
         DvbSP4YYAet1zm7aH5EeplCvccJA47Oyb/zw5bdPkV0wQcMWLTMJz/KchyAk0bgZoU+j
         KkeA==
X-Gm-Message-State: AOAM5315p+3XNcDR9ZUNSXZ+FCCvtvkwD4TL38JTE5biAnoy/hhRFn7Y
        bLDYI0awXPJpZ7BGq6dIW6jZnFZqX4s=
X-Google-Smtp-Source: ABdhPJz2SxkOB9BMHA7FgFsarXlkJNIRvbeYXuoygbMEASwhSl4cOeUTZBO+yhC9ssHQ9uMt6KPEKQ==
X-Received: by 2002:ac8:7ca1:: with SMTP id z1mr47941799qtv.334.1594066658633;
        Mon, 06 Jul 2020 13:17:38 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id 73sm21551692qkk.38.2020.07.06.13.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:17:38 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/7] rt-tests: Add some files like get_cyclictest_snapshot to .gitignore
Date:   Mon,  6 Jul 2020 16:17:21 -0400
Message-Id: <20200706201722.13400-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200706201722.13400-1-jkacur@redhat.com>
References: <20200706201722.13400-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add some files like get_cyclictest_snapshot and .xz files etc

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitignore b/.gitignore
index f7574ef94900..bc01575141bb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,6 +6,10 @@
 *.d
 *.patch
 *.a
+*.gz
+*.bz2
+*.xz
+*.asc
 tmp
 patches
 ChangeLog
@@ -34,8 +38,10 @@ SRPMS
 /deadline_test
 /queuelat
 /ssdd
+/get_cyclictest_snapshot
 
 rt-tests.spec
 tags
 TAGS
 cscope.*
+src/cyclictest/__pycache__/
-- 
2.21.3

