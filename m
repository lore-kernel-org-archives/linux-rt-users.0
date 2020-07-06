Return-Path: <SRS0=ADFb=AR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D3BC433DF
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96010206B6
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UampZlR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgGFURk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgGFURi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jul 2020 16:17:38 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E81C08C5DF
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jul 2020 13:17:38 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o38so30051678qtf.6
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jul 2020 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cOlXBKNatoE8C8L3loxU9qaJz977b13REqfbqBaJuus=;
        b=UampZlR/cMVCP2c4EYYyxjhcqpIBof35TIMzZrOk0YVa3aqMnXv7V64N32QfxfxwrY
         wmoI86cxi3qLRGED5+ybJyqoERD7WcOGqleloFJUzdTLs7WTCNTHzxTngqmZD0pVq8a7
         g1xgEb+ySCpMuJ3l1QBCQY39MdQn8FsrKrf4o3AXmHt2IZzCe2JwJ+7M0fiNbWgIPKfD
         9rpmCof09WRh6b/P6wBiQota35vUJJfwCQIT+KpvELvkltWIrcN0GSIvWCztAZXBnd7b
         DlHdB0IeJXyxb57+etgQ0G2BlSc3NRwRFI+vVlqrb/3yjJmMr5SeqpQ9a/tKnW0EEW4L
         9qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cOlXBKNatoE8C8L3loxU9qaJz977b13REqfbqBaJuus=;
        b=rbUrvKT7hrQimktlUFYpPKhzPhsdo9Kf8jeCU3tMcsCg2wvfURbo3Gsy2dA/kuNn8g
         cp/LaMaa1/7U5EnJC1nqRNFSbMKLM3edgVp9LyodrWkQU6Mmwi5KJMe9HPpZi6XHnES9
         zvWxYlQGwju4nvIJ6aKFArDTX38JdB2OMQ4VfG9k2q/vU0ZYbIC6XVp9FETdoje+QcZR
         WvLdZaLtS4hOH6BuLgbn8LWL0DzQy+cx/NllToId03AwBts2NXGtWgRwmlFbSCemf4n6
         XLF5ubv85N21BfBS1G23RDr9Pxa7MSgjvysoCD3IX0gLOEIcWs0/fdB7+/okPMloOLcj
         w4uQ==
X-Gm-Message-State: AOAM531pLAl4rlrpd/muDjl0bzhPrNe6Ateg9lzrPi6X2bfpf7nYXkM5
        Hb8389Oww5WaC2bnrTnm+yK9sgLKTEM=
X-Google-Smtp-Source: ABdhPJy8VOCU2LU66FREOpWGcAy8b7GZk6PQwj6pHwDIko6Tdzr9EWuCrfAvlQDNLESo25Y1ywplRg==
X-Received: by 2002:aed:2492:: with SMTP id t18mr52270946qtc.353.1594066657816;
        Mon, 06 Jul 2020 13:17:37 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id 73sm21551692qkk.38.2020.07.06.13.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:17:37 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/7] rt-tests: Tweak the cyclictest man page
Date:   Mon,  6 Jul 2020 16:17:20 -0400
Message-Id: <20200706201722.13400-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200706201722.13400-1-jkacur@redhat.com>
References: <20200706201722.13400-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Tweak the cyclictest man page with the .SY macro to make the cyclictest
command stand out apart from the options

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 00e2d2403996..44b5d0dbcc4a 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -15,7 +15,7 @@
 .SH NAME
 cyclictest \- High resolution test program
 .SH SYNOPSIS
-.B cyclictest
+.SY cyclictest
 .RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
 [\-h " histogram " ] [\-i " intv " ] [\-l " loop " ] [\-o " red " ] [\-p " prio " ] \
 [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ] [ \-S | \-U ]"
-- 
2.21.3

