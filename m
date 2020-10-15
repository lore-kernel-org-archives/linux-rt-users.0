Return-Path: <SRS0=ZzBC=DW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200EFC433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Oct 2020 06:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D0F22249
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Oct 2020 06:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvSDZGUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgJOGu7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Oct 2020 02:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOGu7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Oct 2020 02:50:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC5C061755
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2020 23:50:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c21so2028710ljj.0
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2020 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAU3uKrZa2J7LXMAHGt9ACecWN3CdSOMqn4FFeqT/5o=;
        b=yvSDZGUdPRphEdRi50d0XCG/2yEBmk4yTmxaiSt2OAs//h8RNEBD4W3ym7NPfCmwMA
         9fYmckkbvwBMtVq4VqSQQx9UsbjeRAEhHrqHHoQtEFoTPDyUmzPvp8fWyp5F6FRTAv5n
         Vhz5XVD0DDFVGBbQZo568hfKkOlsPu2VxXsRDVPCYaaLjwzO7svJUUJMzKpJBDeREx9C
         Efct+HvWSJmzQCj3Umz489KTTMyWx4wD+6qyqMXW7gtPt9mrnSv7Y1W213V4HBoY+FzQ
         znY2BAPF12C/rvgRfX4mNqbqh99aL+WpvV/iG+4NSI3Ode4unyKgPXmdnOCvgDn+plyJ
         plvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAU3uKrZa2J7LXMAHGt9ACecWN3CdSOMqn4FFeqT/5o=;
        b=H1O3lEFFT4jukDhqsW/WEVtHWosdMM9QjZtU08QHJZfAdOGGfkM5DFtF8yNEfE0saJ
         Xqs63aYPNOxAkYzR6/vZxnYXNCwlNtsFfkzWbFETZ8Q2RnIcfKAisxn4OO9vwRymUKwu
         7lXBPzJhXAESv1Iygf03wIMDcKD5Tv6AtW5BxoRfJ0nqKPdTO88yrbIGfZA0/TasF/4+
         kl21Y4/WfLTq8YUa6Kd7mUEg7nYuNUCwKhsJuMFc3/utDuHzldhP8FSZttzQmgfquHDC
         7721UG2RYncXBUrzqZxrPfbnr1VkMCvakX4We403qy8tBhQ1vgBYblBJoyaAPxSpWjrW
         Zyfg==
X-Gm-Message-State: AOAM5306n1s2JoFGbRAT4YV7cOFsdrBFVvAJY2qECuqKJ6FV4/tNgw2j
        jJIy8AkRM80Tj320o6MBROgU6jzDuj8LSk+J
X-Google-Smtp-Source: ABdhPJyhSrCe34JjOEc5jkKQufT9oxSdw56AEosUBVdGmVVoaa6QJHLtww1GYmJRbZSzwa/rUWnhNg==
X-Received: by 2002:a05:651c:11c5:: with SMTP id z5mr729893ljo.48.1602744657039;
        Wed, 14 Oct 2020 23:50:57 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id v4sm682993lfn.6.2020.10.14.23.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 23:50:56 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     williams@redhat.com, davids@redhat.com
Cc:     linux-rt-users@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [RTEVAL PATCH] rteval: misc.py: cpuinfo: set default value for 'model name'
Date:   Thu, 15 Oct 2020 08:50:54 +0200
Message-Id: <20201015065054.645567-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Set a default value to 'unknown CPU' for 'model name'. If 'cat
/proc/cpuinfo' don't provide a 'model name' there will be a default set.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 rteval/misc.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rteval/misc.py b/rteval/misc.py
index 0dd361ff19fd..d99b3c20ecda 100644
--- a/rteval/misc.py
+++ b/rteval/misc.py
@@ -75,6 +75,8 @@ def cpuinfo():
         if key == 'processor':
             core = val
             info[core] = {}
+            # default model name if there isn't any in /proc/cpuinfo
+            info[core]["model name"] = "unknown CPU"
             continue
         info[core][key] = val
     return info
-- 
2.28.0

