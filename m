Return-Path: <SRS0=xoO4=RO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D3FC4360F
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8915206BA
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MioMBZMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfCKN0K (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:26:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46855 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfCKN0C (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Mar 2019 09:26:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id i16so5060488wrs.13
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Mar 2019 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttBzvcnkPiqA+e/T720HDsTZusAdMluXvhk+g6mHzmo=;
        b=MioMBZMPXi+JpVJ8CQ+YeNzkxXaHNyhpOmCgfSS6fO9NtMjTDPd6A9m3D6OB4xsP9v
         tEjAMNhPzdsK/Sf0jugnvpiknI/qT9ffa3tz1szu9o/P55y0+lASMQrKgKn0NxqVMQBu
         YgCKvfsWLo+actt2sx1cwK1+r8dAOQZNxark5OcP2w3zqFrq5rWxXrvHun8WWYJfqH7g
         R9YY4I24Zz6pSl0yJcc25eLfa2xsOOUR7Cn5/CVoBbV4LKbcOL6IpnB4H9DeIBnziTBN
         mVOxCN9chjdMuqo4YzKm1+w3yERRbal86o3nELEHsL0ZoKZsWWw2urLBaiTd98U6txAp
         M6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ttBzvcnkPiqA+e/T720HDsTZusAdMluXvhk+g6mHzmo=;
        b=mIzHIvkObShm4TNAFsvD5etG0iRmrpANkis1MpjNkJyCpmjZ2/riuCtIP8+PczZyRX
         mHlPLkUfamRbq+5TJWbSfNRyc36rVps4Ir4GjrzTULH7mfE7f3I8KkqwUlbyIaOg1jLV
         NVck5JRWQBcJFmsxPAE/hy7Mw08RUNohO0hJupWA9oa3GKvolztyJJrSj5zn1srMbnxt
         L/fE7NYSgXvmxiblOpp5JVqjpZFDsx4e5PXmN9zEuYa8yY2EI2y6yGhN60I51hDKSC7j
         r6aVSycIy44yHOAv+kDaC1sh09ZkEsH7YL8R9iZX9wB0wn010fmdAQ26mYfy5VCuoQcR
         LyBw==
X-Gm-Message-State: APjAAAVNMyUcYpFrmxBYOo3LQnLEmVmxaXtYMUEwtcZHizdqRIIJmD9m
        TfgA6Nurqgo3YbaQptIJrmDOcTrw
X-Google-Smtp-Source: APXvYqzNQWWCGqfY7pJAytQTWGb6hfSQ5zjNp8im1EodXP4AA+06zEyofTT75ZletwPu4FJX0ZTh8g==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr19635755wrx.134.1552310760235;
        Mon, 11 Mar 2019 06:26:00 -0700 (PDT)
Received: from planxty.redhat.com ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id g202sm21776222wme.26.2019.03.11.06.25.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 06:25:59 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] cyclictest: Fix compiler warning about srncpy output truncated
Date:   Mon, 11 Mar 2019 14:25:48 +0100
Message-Id: <20190311132549.7219-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Clark Williams <williams@redhat.com>

Fix compiler warning about strncpy output truncated before terminating
nul copying as many bytes from a string as its length

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
Extracted from a patch from Clark
---
 src/cyclictest/cyclictest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 68b3836405c1..1bd63fd93dce 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1257,7 +1257,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case 'F':
 		case OPT_FIFO:
 			use_fifo = 1;
-			strncpy(fifopath, optarg, strlen(optarg));
+			strncpy(fifopath, optarg, strnlen(optarg, MAX_PATH-1));
 			break;
 		case 'H':
 		case OPT_HISTOFALL:
@@ -1267,7 +1267,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			histogram = atoi(optarg); break;
 		case OPT_HISTFILE:
 			use_histfile = 1;
-			strncpy(histfile, optarg, strlen(optarg));
+			strncpy(histfile, optarg, strnlen(optarg, MAX_PATH-1));
 			break;
 		case 'i':
 		case OPT_INTERVAL:
-- 
2.20.1

