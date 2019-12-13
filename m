Return-Path: <SRS0=kQBB=2D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F16C43603
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B002465A
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 09:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="OLnTDxqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfLMJTU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:19:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35887 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMJTU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Dec 2019 04:19:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so1431307lfe.3
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Dec 2019 01:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pGSD3gEjCG5lGw2yJOMoeU/fUrecjnPHPGNLWvh4sxs=;
        b=OLnTDxqo9rh27oZJgF2NL/U6/gMYF7hOoaTzCss/thLDES4m/GzDsSJLevfkurUDWn
         OnhuV2m7IIsuRMSKwlKXSu/yMQtz4jMUlGituOf13wgl7fns12TZLSb5dD/GpoqLOM+j
         4wdMZPFETrLHITygnskr891N9sEaWcKWvlasItNWJTsJckXxU/ZHFLY7CxlvuVTEZ4bq
         ifoxp8rfcYGoqqCjo9uM1ZHRYiY4lsqvkCLj1TfBDbRcrezaVgbzi20aSMPXn45e4i/k
         w6TN9BACFXlY854wN/mVyM5+sgB4c4/yTVAWezIBoxc68ZKRJV3cS38yhseKAIKwocT5
         Kl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pGSD3gEjCG5lGw2yJOMoeU/fUrecjnPHPGNLWvh4sxs=;
        b=KFc4UOldc/EZG7X4aRVIl+lpKB4DzWSWh/jMkIH9J3Y5bicMCHM8ala/oQ3YohV6Nr
         yU54jIoG0FyQFLt/W6Cx9hDdBMs+tjWfyZqTxd0JltBrSUAX5ytkEw0wYy6Rco2/arhX
         WkSN179NYb1yOqec4bkSX7hFb3WwLmEGZ7qKC3cW7/mG5AMlmIGUMX3n3P57xhXh3PEM
         E5xP1MYlM/oR3Gb5/KvTlddQ4TfoudKGGf9qwjWeph592jAmRTrJiAIUp5t9EHEU3lh5
         YMCK9ZKUj44BxaW9Glp9OXy41MN0i73xXVCW6t6FlRNtbsOeLyLLaIwhG/SEWePkU9HD
         pwsQ==
X-Gm-Message-State: APjAAAVJPJss60grB4ARTpNuaV5F717+17KgUfL8WeqcDKf6hK8z3NfO
        Bo/R1iGhfnemiI6n1cQnBXRr1apaDIyfRA==
X-Google-Smtp-Source: APXvYqytZW+EDkHow2KaQOekkeP4h+2RwCm3TL+OQzdSiqulV1n69A3qYANinkE/Qe0tm309I+o5lg==
X-Received: by 2002:a19:7015:: with SMTP id h21mr8044786lfc.68.1576228757479;
        Fri, 13 Dec 2019 01:19:17 -0800 (PST)
Received: from localhost.localdomain ([109.204.235.119])
        by smtp.googlemail.com with ESMTPSA id 207sm5065587ljj.72.2019.12.13.01.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 01:19:16 -0800 (PST)
From:   John Mathew <john.mathew@unikie.com>
To:     linux-rt-users@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, John Mathew <john.mathew@unikie.com>
Subject: [PATCH] Remove redundant wait for completion
Date:   Fri, 13 Dec 2019 11:18:43 +0200
Message-Id: <20191213091843.8365-1-john.mathew@unikie.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJz2qXnPquUZSeO9SWSmvLKcdhnT96KnD66F-oatdnotYkxS+A () mail ! gmail ! com>
References: <CAJz2qXnPquUZSeO9SWSmvLKcdhnT96KnD66F-oatdnotYkxS+A () mail ! gmail ! com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Wait and completion was bieng done to
uninitialized member variable of casted
pointer. cryptomgr_probe completes all
the waits when it completes itself. This
causes the number of wakes to exceed the
limit of 2.

This prevents swake_up_all_locked warnings.

Signed-off-by: John Mathew <john.mathew@unikie.com>
---
 crypto/api.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/crypto/api.c b/crypto/api.c
index d8ba54142620..b89c44c11c54 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -153,12 +153,9 @@ static struct crypto_alg *crypto_larval_add(const char *name, u32 type,
 
 void crypto_larval_kill(struct crypto_alg *alg)
 {
-	struct crypto_larval *larval = (void *)alg;
-
 	down_write(&crypto_alg_sem);
 	list_del(&alg->cra_list);
 	up_write(&crypto_alg_sem);
-	complete_all(&larval->completion);
 	crypto_alg_put(alg);
 }
 EXPORT_SYMBOL_GPL(crypto_larval_kill);
@@ -166,17 +163,9 @@ EXPORT_SYMBOL_GPL(crypto_larval_kill);
 static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
 {
 	struct crypto_larval *larval = (void *)alg;
-	long timeout;
-
-	timeout = wait_for_completion_killable_timeout(
-		&larval->completion, 60 * HZ);
 
 	alg = larval->adult;
-	if (timeout < 0)
-		alg = ERR_PTR(-EINTR);
-	else if (!timeout)
-		alg = ERR_PTR(-ETIMEDOUT);
-	else if (!alg)
+	if (!alg)
 		alg = ERR_PTR(-ENOENT);
 	else if (crypto_is_test_larval(larval) &&
 		 !(alg->cra_flags & CRYPTO_ALG_TESTED))
-- 
2.17.1

