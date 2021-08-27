Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A6C4320E
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B4E60FD8
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhH0WDz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhH0WDy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:54 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD30C0613D9
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:04 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t190so8787047qke.7
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkogbI0Z2C57eS5RdDpTbURRW0wvNNVHW3PiAAgqDsA=;
        b=R+9tKQFnJQb1i+mWt2CVMGo8Q5OZ9DiIkjaxJAho0kmYwQffsV+DKLSWNOrdruNErW
         YUhb8vvWCTskfPEfUfT8q1Jqd9nTdfScc9ZB7U5hUf65Av6E63bjf+xxL8CBvR525a27
         KDNXnzT5yoLYARyWTnJ/3oBbSFxHI0Bvh3a7ctn0yVgdi+V8TXYjO1xGet6PEOXg6c9U
         FaxZR7v1QcV6UaSC+K1BIgHi8BBIlVI1K9x/w23FvlCi6dATRsk1nq0xn+ufhYrxxPK4
         Ij7wz2xp78eistgRD9LWDxH5atBAgv4uRdPubljAL6VRi0x+26DTqAh1fll8FRezLQTC
         jEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xkogbI0Z2C57eS5RdDpTbURRW0wvNNVHW3PiAAgqDsA=;
        b=QnceyoV2g67JjLLYE9sXHVVAhsjvkXXI8AYTUc5F5It9yoL0SqqchZtorodOXhdUFn
         /e4JWJHRJQKPH6218HpPrMxTopeUymf52Iv2kxiWmfxO3yzNuERjgEJEF8AMu1v108bu
         ub/RwGLCnwFSCZ+gL9roLQb0u3ct7Zmc0o8hDOMwQDSyAs09RUIEE3SSXFQibyVifM2C
         zWTKDU7AZI4pUMdFLrlSdc6ny+vwhB4+8sJwd8a9C02nKi49I7SCDHfEVGMPpaYJvudy
         RXAfKxMRykjkHPsoViKVdqGb8/ppcJp7R5IZnNUqkM4DOH8bppp33kk1BKNMva+663ut
         h18A==
X-Gm-Message-State: AOAM533fCyNF/FgsBBUodH8P5zPT/mYS+jfMHRb5u+bvWYHPghjqP/3W
        RTdA1O9ROJq4tL8RN41JtTBr8ZUhD5aT5Q==
X-Google-Smtp-Source: ABdhPJwgWxMGITjYhDdSeVdV+x4n4PtsCYs/il4UGes+akvY839otHYrrnB6++OASAbjElZusYAEDg==
X-Received: by 2002:a05:620a:1aa6:: with SMTP id bl38mr11380562qkb.36.1630101783950;
        Fri, 27 Aug 2021 15:03:03 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id t64sm5659209qkd.71.2021.08.27.15.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 15:03:03 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/8] rt-tests: pi_stress: Don't call free on alloca
Date:   Fri, 27 Aug 2021 18:02:40 -0400
Message-Id: <20210827220244.24210-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827220244.24210-1-jkacur@redhat.com>
References: <20210827220244.24210-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

strdupa uses alloca to allocate the buffer
free should not be used on space allocated with alloca,
so remove these.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 53c6af15afac..3888198f395b 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1259,10 +1259,8 @@ int process_sched_line(const char *arg)
 		k = strsep(&buf, del);
 	}
 
-	if (!id) {
-		free(buf);
+	if (!id)
 		return FAILURE;
-	}
 
 	/* We do not validate the options, instead we pass all garbage
 	 * to the kernel and see what's happening */
@@ -1280,7 +1278,6 @@ int process_sched_line(const char *arg)
 		retval = FAILURE;
 	}
 
-	free(buf);
 	return retval;
 }
 
-- 
2.31.1

