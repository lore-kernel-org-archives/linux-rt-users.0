Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED7C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 08:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFA860FE6
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 08:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbhIMIka (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238026AbhIMIk3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 04:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631522354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IXzduvzlMfg1+gOh7MT+1zBGqA5W6AByivTY8QlAWY=;
        b=BKxRbOQF9BtJ7JGW854D8xPVdD/ucUlISSEAC/TXa8wJO2HdVsYGh2USzCgMb0rXjnmffK
        WA/eG3+8SlTVV/6hI2KyxMKuMYxZ8wKP2E3i7nXlis+6C/Bf+btPyMOnBXi1sqZy1y5Igl
        2KKhl0x5it3GGiucQNxNS5lNrT/3cpY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-yBu45fE6PausKzqjdv748g-1; Mon, 13 Sep 2021 04:39:12 -0400
X-MC-Unique: yBu45fE6PausKzqjdv748g-1
Received: by mail-wm1-f69.google.com with SMTP id w25-20020a1cf6190000b0290252505ddd56so4605462wmc.3
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 01:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IXzduvzlMfg1+gOh7MT+1zBGqA5W6AByivTY8QlAWY=;
        b=ZSKg4CeTOkxnxdqGYrkjj3ZPcsRaCXb7vqEjbg0mplAbbN5TFBYJkR1x+mrwFBwcig
         yfgnYZd0CarDsD4vrVNpamNG9kC4aJYzoDCPbIjcU1aqU8uorJCPpIEVk0KcTv1Ldgao
         wrshuGalYzR0QSoFw3y0oVox2ToiNlkJ2upr3j91omXEsiObUL7lH4tACqKDsiy505o0
         Ar03VyRRcHrZCOmCielU2Fhsr8jnA51/EzPuOG4HRfsuJnPYnb9hgmImdbdP3WyrwEck
         KKd6V58aEZzikxNl1Jb8ct3S0AhtUUvH4b3hxR2Db+SqLth5gcLnmrFkAeXLQVBMw14B
         R4oQ==
X-Gm-Message-State: AOAM533ERvXJua2TU7Ud/b1nPCWiGOgQ1HBkJpir1D4S8pZfXr9/i3JP
        IbOgakYErJ/1utaHqTIn9M0YiwppUl7mxqxgE3FEszaaI3mL5cz654Gs6oaTKPbn1JzpLmUNP7R
        sdPxUml/ExHRfYWZzJXR6kvrVHddGdGCsWkPmRsEvt63aHQAYXklPi5u6bOUP6ddAXGpK7NUnow
        SU6MQ=
X-Received: by 2002:a7b:c4cd:: with SMTP id g13mr9895028wmk.91.1631522351277;
        Mon, 13 Sep 2021 01:39:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqvA28pY2d6QIe1fYQaF2wUS0gG3oLL/qZjhU7uDBiQLo3CthYgXLFutu2E8RozLaqSuXNbQ==
X-Received: by 2002:a7b:c4cd:: with SMTP id g13mr9894999wmk.91.1631522351023;
        Mon, 13 Sep 2021 01:39:11 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1f0d:6700:7eb9:ffb3:3868:81d7])
        by smtp.gmail.com with ESMTPSA id u8sm6640688wmq.45.2021.09.13.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 01:39:10 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH v2 2/3] oslat: Add aarch64 support
Date:   Mon, 13 Sep 2021 10:39:07 +0200
Message-Id: <20210913083908.48408-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913083908.48408-1-nsaenzju@redhat.com>
References: <20210913083908.48408-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The callbacks are based on Linux's implementation:
 - CNTVCT_EL0 provides direct access to the system virtual timer[1].
 - 'yield' serves as a CPU hint with similar semantics as x86's
   'pause'[2].

In contrast with the kernel's implementation, there isn't a need for
isb() after reading CNTVCT_EL0,  this is only needed in-kernel as the
register read has to be ordered with a subsequent locking operation.

[1] See Linux's '__arch_get_hw_counter()' in arch/arm64/include/asm/vdso/gettimeofday.h
[2] See Linux's 1baa82f4803 ("arm64: Implement cpu_relax as yield").
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
--

Changes since v1:
 - Code cleanup
 - Add compiler barriers

 src/oslat/oslat.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 33cccd3..c90ec1a 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -71,6 +71,19 @@ static inline void frc(uint64_t *pval)
 {
 	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
 }
+# elif defined(__aarch64__)
+#  define relax()          __asm__ __volatile("yield" : : : "memory")
+
+static inline void frc(uint64_t *pval)
+{
+	/*
+	 * This isb() is required to prevent that the counter value
+	 * is speculated.
+	 */
+	__asm__ __volatile__("isb" : : : "memory");
+	__asm__ __volatile__("mrs %0, cntvct_el0" : "=r" (*pval) :: "memory");
+
+}
 # else
 #  define relax()          do { } while (0)
 #  define frc(x)
-- 
2.31.1

