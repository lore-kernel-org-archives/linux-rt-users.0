Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89949C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 17:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728BB60FED
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 17:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhINR5J (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhINR5I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 13:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631642150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D6a8PYdbTXkGPHIasH6KGmZeNd+m54TqiTxzNp7lUEA=;
        b=XF/7bEpB3IgYCcuRb4x+Wbla9Hg67B5XLOeHjbDMLh7np/FQ2tp7maU5vYcQ6ykN8E+w8v
        v9tVkEArT7Q9Prg+xVHsf6FdIQFcuKu2U+g5q+5zfGFxU953AtbmrizGXeIa5jBcZPdROU
        w1U5bjLhRTd2jWdidzEzbh90a8Cqtto=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-NZVM6bBKMzyE6XNvFV9rQA-1; Tue, 14 Sep 2021 13:55:49 -0400
X-MC-Unique: NZVM6bBKMzyE6XNvFV9rQA-1
Received: by mail-wr1-f71.google.com with SMTP id g1-20020a5d64e1000000b0015e0b21ef04so2360394wri.17
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 10:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6a8PYdbTXkGPHIasH6KGmZeNd+m54TqiTxzNp7lUEA=;
        b=CADLXg6gdUv7t40sq01eWGl/NArhMjRjhfSWT/uLDAtRP9488pYtjEsXILfABZLcXI
         YVC1zEVcWzzutBGq6FPSunLezBVsLEYTofqkmAxN/ptYVhDaGPbWxX/OCefJTOqOVJXU
         GvPpZ/8Z2gtD5Hs/AKLuN563UfQwaWfiSoQOrpo94arqglHvFXsO7UmHxsRZ9hhtn1aa
         nnsZPKTX7YmKtP8QOrI3q5xplw5ekeKm+pUQ9uOka4Yo33ZcnbPOb+j3yoR7Tn3FGy0K
         TqLmXJtaRmFz2DE0I2yQWMvUwNn8WH+/a2jTRuHQBZRCtZn2Xy6WMFLDpHRmsS3Fj585
         7A/g==
X-Gm-Message-State: AOAM530Cy0KtRpJb6OXcpTZDAA7nX0ZOkSqn1n0tfjjBn59bhnrZZtRu
        OryfW8JpRh6G/wlc2qfpYVbiG1bkP6TuR44qQ++jQSbWKztG3olgOg9uSolZoW+bLGtBASoSVHm
        pq2wXHpBzk2hMI1P02ljED6jXWABoqAc+mnPlLmgfcIK4S2iraAs4k3KNnd6lhj/J/viWwAIpyR
        +tCFI=
X-Received: by 2002:a7b:c341:: with SMTP id l1mr391360wmj.111.1631642148269;
        Tue, 14 Sep 2021 10:55:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsZEu0QtxMHakDf2KaKH7PC4Tm7YWUfpHf1+xmDf/O/x7+h6vrXbOoSHZfpuQqeTxAzUwtsQ==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr391341wmj.111.1631642147965;
        Tue, 14 Sep 2021 10:55:47 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id j17sm10919698wrh.67.2021.09.14.10.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:55:47 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com,
        Punit Agrawal <punitagrawal@gmail.com>
Subject: [PATCH] oslat: Avoid out-of-order memory accesses to precede counter read
Date:   Tue, 14 Sep 2021 19:55:42 +0200
Message-Id: <20210914175542.338429-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

In arm64 it's possible for the processor to access memory appearing in
program order after the read of the counter before the counter has been
read. This would skew the counter value to a later point than intended.

Fix this my adding an isb() following the counter read instruction.

Suggested-by: Punit Agrawal <punitagrawal@gmail.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 src/oslat/oslat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 5fce223..50ddc81 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -92,6 +92,13 @@ static inline void frc(uint64_t *pval)
 	 */
 	__asm__ __volatile__("isb" : : : "memory");
 	__asm__ __volatile__("mrs %0, cntvct_el0" : "=r" (*pval) :: "memory");
+	/*
+	 * This isb() is required to prevent the processor from accessing
+	 * memory appearing in program order after the read of the counter
+	 * before the counter has been read. Which would skew the counter value
+	 * to a later point than intended.
+	 */
+	__asm__ __volatile__("isb" : : : "memory");
 
 }
 # else
-- 
2.31.1

