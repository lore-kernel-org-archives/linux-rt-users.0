Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF967C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF0C61264
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhKKUp3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbhKKUp2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:28 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F82EC061767
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:39 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l8so6521617qtk.6
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=unGu6xaxu8AQzixDAbgLFoh/lvTXRIPm49EvTRo8yIQ=;
        b=X0R3e8dmdGdOVuidk6pYbvWzDDe6M+bAx1cEJknuWfmvuf91J0jYZb7MLdOmFarjiv
         vvyPrFI5to17iEFWR+fNFgWZhEWqwgdl6OvIazRalFLG8Z47auPBg4RH5e9nYPVRTNax
         Bj/prN7KTAdbPKFv1mWxyJxLhlL3WatcetdErlrDOOqd/VNBrfgmsUM11AXDMrRKAONZ
         E8Bu9YF5zAOA+jQYqUARXpCh+GIOE396HYau0jhK7HZnBcZNis6UrQY2gHVItNz9GdA5
         lwczWHQ8LLUeCNPhR3po42+T37ZpIMdQnph/yP3bOxMb+hb771KpxsPjUuEiFUXEz7Wc
         J+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=unGu6xaxu8AQzixDAbgLFoh/lvTXRIPm49EvTRo8yIQ=;
        b=YCd7JkF3qda2ZbpYI56XNYgFQcBlPjAthWpr968iYOhPmoBbeFZMvqR15pqvFnr1HE
         1Unvvdl71P2z0e46sRlXFVbqtUD9B4UNXuViai+QhNkFm7JUczFE7Ncx7NJaHo3JENQw
         wch2ZRM30fsKmqvv5rtXCpMMwNIVHsc/KW53nck6vo+4xdCuiGF/9vFrF++xaSUmBXb6
         le3rT8IF+g8UQjOc3QAwpxlSHPrdpzYbvvN7o0Fat24KwwRTYA6xiNPlX7dq6dCAQzhn
         Ugr+akk+Fb0gEP9FRlzsvZPNF2tnYo5jpulm05GfhwMeD8Ub3hhmjShSLBKPlqR3WJ5J
         nczA==
X-Gm-Message-State: AOAM532VwqUaJzZhIHkjltzS72e3+r+jsQeU+58SZC57RACBfHWW2HfG
        /WIPW8Ju5AmVCxwHlINyT4UUW5xUfBA=
X-Google-Smtp-Source: ABdhPJwBjdwkNxlDpCHvTzhoHO4ucaWEOSsAacn/CpYbDAPsFgBwCEdWI5lkdJfNRuD5tJG3TNImsw==
X-Received: by 2002:a05:622a:589:: with SMTP id c9mr10195703qtb.313.1636663358253;
        Thu, 11 Nov 2021 12:42:38 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:37 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 15/17] rt-tests: cyclictest: Drop unused defines
Date:   Thu, 11 Nov 2021 15:42:05 -0500
Message-Id: <20211111204207.10167-15-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

KVARS, KVARNAMELEN and KVALUELEN defines are not used in
cyclictest. Drop them.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index e4d43481de97..5758f88a24d0 100644
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
2.31.1

