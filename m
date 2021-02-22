Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED3AC433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 22:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9750764E4A
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 22:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhBVWIo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 17:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhBVWIm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 17:08:42 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B49C061786
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 14:08:01 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id w1so3666130qto.2
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LObQm/tajGpZ0uD+lMdz556MAs0TERYOE3GzoGWbHJo=;
        b=ZjkLhTgCRl215DSMTiuZisPsrzmyyUpQc4z1u0O4NsUI870sVHJPbZEeONuGl2E88x
         iD+iQqMuCa2weHFLVgDF+4g6Dd96MMWjMB3LaiTjQSGnN+gsgjKaNb1T1+conbP8lE4y
         OK0dRekKMOrmUYo5onK1lCCKKeFHNgovoC7YBLBGA7dJ9jWVEpNhsL8yv+M7FAp/CJZt
         Q1qKYBrMmaFL9IbJSOPIrDM4kK+K0ztNTyHsDlA3cWYV+KUa8S493F2FEfsX/uZkyctw
         zUAJgKmOjb58bs/W5+5eUJ0Dh1g45pMBeyJc3EzR/C1aYanw7IZ7pwVgqWWTf7uEVcfy
         JRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LObQm/tajGpZ0uD+lMdz556MAs0TERYOE3GzoGWbHJo=;
        b=ArGqo52Rq+y0xd+tZgXWe+3DxSLBeIgwJo9CHbDh8EEduhH75s4682Cv40kajd8KGh
         FsU3ftlRHbs886LU6YzxUIBh2AC4LmZyou7GGmQOFN5p7ySCeEZHsJ3yzIldhujKZcWe
         EnhgNtihKwo83QSHB7HGEo1rDhed6sDaWGjMzxmRmaNXeGkFpTf/vCmIXk68yr+jq8EE
         yRDmgWuM5AMasMUVu/QvClrUJOwI308LcFynMAk/z6RrhMJfqVQRyr7IXgdu6Fx1FfT/
         8NycyDXHun679As1NqZNfFkVLwjjH9RxX7XNTyElZ30n++fQ6A1/hOzn2Olw9A14dMae
         caHw==
X-Gm-Message-State: AOAM530gPpItLQUtowLBKpWOtCTOwnuWobmzcMDd72FON6H5alKavgpa
        6VZTjdsmcsURJNPp0kF0m9eD5v8oqxWabbH5
X-Google-Smtp-Source: ABdhPJyiLIQ7GT9PxfGJDqOx0v7J9Cc8Lr4JR8PJfQNTfCrJ3voviiYl7NHLOFlY1p4L4psrRzLoTw==
X-Received: by 2002:ac8:4e53:: with SMTP id e19mr22536170qtw.77.1614031681068;
        Mon, 22 Feb 2021 14:08:01 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id o5sm13278352qkh.59.2021.02.22.14.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 14:08:00 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Christian Eggers <ceggers@arri.de>
Cc:     Daniel Wagner <wagi@monom.org>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rt-tests: remove rt_numa_bitmask_count in rt_numa.h
Date:   Mon, 22 Feb 2021 17:07:50 -0500
Message-Id: <20210222220750.12911-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210222220750.12911-1-jkacur@redhat.com>
References: <20210222220750.12911-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove rt_numa_bitmask_count as it is unused.
The code uses numa_bitmask_weight() from numa instead

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/rt_numa.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 4cbd979c21e8..03f060e144ce 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -83,16 +83,4 @@ static inline void rt_bitmask_free(struct bitmask *mask)
 	numa_bitmask_free(mask);
 }
 
-/** Returns number of bits set in mask. */
-static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
-{
-	unsigned int num_bits = 0, i;
-	for (i = 0; i < mask->size; i++) {
-		if (rt_numa_bitmask_isbitset(mask, i))
-			num_bits++;
-	}
-	/* Could stash this instead of recomputing every time. */
-	return num_bits;
-}
-
 #endif	/* _RT_NUMA_H */
-- 
2.26.2

