Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58701C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3995D6113A
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 14:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348312AbhIIO1N (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345119AbhIIO1K (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 10:27:10 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69AEC0005F6
        for <linux-rt-users@vger.kernel.org>; Thu,  9 Sep 2021 06:03:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c19so1288633qte.7
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rfIgA3fd6KWq2QlzbV65DgJpIjqfTAm77OMGuCCqW58=;
        b=kgKBtvTdbcXCS37izPwYVOwKaYIGmXvygBPdvNAQWQkNa2HHRM4mAlWiYwGvVWIb7C
         XfOvQiZsMsoKQ5ixDojLNrejNysZARHIbtVrnIfdRfZCEvvD0C7KQGria25FVo5fy2/I
         L24z/27lQZif3weqWWySzkcGF3wh87iU2eKbVypeyFCqlqvLLdrURp4iK+0BO3cWOAOb
         ogxPeDGAqaeEVUd+p1PTiJoYppyWi/owX84/b2O97Ar2dOwP7Vzu7D0uhqSpAcjezzSL
         3vYjCfvTn1EmzrxeM49FPKfiwHOUSXiQVqo1P+SXjnf9KG+cVGPmeOUh9IHbTWwURMby
         BSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=rfIgA3fd6KWq2QlzbV65DgJpIjqfTAm77OMGuCCqW58=;
        b=0rcEtcAhANoEBrBLAEI/S4QqU65E2N8MCIHIdSR1WD2B1n3PX/w+u0fUD+6DFRR4vj
         N3EyWDC8GZqp8WHMixDDLwJuYsZ01lno3sfSRIQeGJeiyZzYb/6QFjyZb6ntzFMrARMd
         ohPszwrvNZv/SfjOifR0dbmGCsxYVRSGH/mtZI1uDktkLRFbZ+C9OsqZ4IIq2L3pV0IG
         Co1TvMySvUGWgrJk9o/nH17pdB7xycn9ve0BDrfFOqoT6FmvMQfVoc65ErhAFAB5B2oC
         CKsriasO1CoY+KBuxeObocCxfYwRVx4QZEf1DaINMp5EjqYtRXbQkKzmV26q5S6ZK3DC
         pZRQ==
X-Gm-Message-State: AOAM531r8GSjWP5puSjz9wtrKoeTsHI84ZRmBNKYsy+ndSPVfOjyMQIN
        ZqCNc/8Csz4l0sdB6OKk+FfwfBjjp6o=
X-Google-Smtp-Source: ABdhPJzarJowDnl0amV4trNIqx2GAes6CCPftROfKnmxAA4sIMBj0HMvu1vZ6AvWxIzJAR8mPKSeKQ==
X-Received: by 2002:ac8:5c08:: with SMTP id i8mr2611475qti.314.1631192605907;
        Thu, 09 Sep 2021 06:03:25 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id c4sm1284097qkf.122.2021.09.09.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:03:25 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Cc:     John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] rteval: Only process warnings if dmidecode_loaded is True
Date:   Thu,  9 Sep 2021 09:03:12 -0400
Message-Id: <20210909130314.6109-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If python-dmidecode is not available, then you can't test hasattr
or you will get a NameError. Simply return instead.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/dmi.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rteval/sysinfo/dmi.py b/rteval/sysinfo/dmi.py
index bd397360096a..80cf3c723b36 100644
--- a/rteval/sysinfo/dmi.py
+++ b/rteval/sysinfo/dmi.py
@@ -42,6 +42,9 @@ except ModuleNotFoundError:
 def ProcessWarnings():
     """ Process Warnings from dmidecode """
 
+    if not dmidecode_loaded:
+        return
+
     if not hasattr(dmidecode, 'get_warnings'):
         return
 
-- 
2.31.1

