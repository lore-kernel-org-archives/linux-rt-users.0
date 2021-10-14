Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24535C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1030B610EA
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJNHPU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhJNHPT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 03:15:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2ACC061570
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n11so3527140plf.4
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E72XnWhDCiGeZTYcJ562uuqcBhc3ZDZIr3c1FuvOobc=;
        b=Hk8hb6gGN2bXvysAdrQkBRQf5xREGl7wc8RkwEUPV//XoeLfE1USy+au2fO7HXVVWy
         zjHVcYXUbK5J9Ysd+y4qcvweqI89kA8xFq/3UHoRiEwF0rGTmukJ8UqOMh3DO1Fn2Qrb
         4uTB0gr6eNxarMG0iolLJX69JLVUrOpPBcQlLBuP9ekuMUHf2FWwaroIgNCuN/o5Jt2/
         IJ0hsEp318l/GlmCdVkSn94Xl2KoGxYHotBvMV2ggbo+gGJR7ehand0b6GABu4A1pDLC
         9wwEEkTiP6buZPKjH/NPwe1Af1HKkmNxIM8KF9KszK1RBa6PvOmk32z2xwRfF9YaHn+S
         YTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E72XnWhDCiGeZTYcJ562uuqcBhc3ZDZIr3c1FuvOobc=;
        b=ptib7vN7+b3H9HenAtZXaWC0hMxW1XcOZx/6LqbLPdPzayiAl3gZGwcirp9yBPqaVc
         eV4WgOsdSfNC3vCe0FdcdbKZKKJjiMmrI0dw8dFvWZVS6ebhcI8YgQWyfXlzx7zoFEi9
         WY4fNDDU8ouU/c1mVzEso0LiIVD/YxKqMUsmvxPafGst7WIg8QW4uD3HhzAeDIZy2xqh
         Pny2Xgq7ucouFe+x1O6BKWEnMxywnd6qjrZdeWvGpFhsSMKgH3hIHag4Q2yAgJmDb6kW
         unz4urEhjAav6aYXJyVeM3VEQdiqzx+QMRTXNfGEK8Xv0Ab+rAfE2OlqnEdf6xnWrN1O
         tpJQ==
X-Gm-Message-State: AOAM532j32sLCejwG+jHeK3QbOYRzb6r0WVhA3p70YkLNbdo2QgTy3q0
        Bq1uzuwfOwu/Yis9Iuk6TEn9ER0QKVk=
X-Google-Smtp-Source: ABdhPJwkq1LH59uXXnQJlvRo8EOazEyQQQGTAkMxW4mCQ7CCyqAiE8AhjOLC6hl71Pd8VEgE8jpdnQ==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr4427938pjp.56.1634195595185;
        Thu, 14 Oct 2021 00:13:15 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id k127sm1528087pfd.1.2021.10.14.00.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:13:14 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: [RFC 1/7] rt-tests: cyclictest: Drop unused defines
Date:   Thu, 14 Oct 2021 16:12:41 +0900
Message-Id: <20211014071247.4165329-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211014071247.4165329-1-punitagrawal@gmail.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

KVARS, KVARNAMELEN and KVALUELEN defines are not used in
cyclictest. Drop them.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 src/cyclictest/cyclictest.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2187d98de725..0c1e6617e0e1 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -99,10 +99,6 @@ extern int clock_nanosleep(clockid_t __clock_id, int __flags,
 /* Must be power of 2 ! */
 #define VALBUF_SIZE		16384
 
-#define KVARS			32
-#define KVARNAMELEN		32
-#define KVALUELEN		32
-
 #if (defined(__i386__) || defined(__x86_64__))
 #define ARCH_HAS_SMI_COUNTER
 #endif
-- 
2.32.0

