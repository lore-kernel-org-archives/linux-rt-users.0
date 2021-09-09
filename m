Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4412C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 08:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09B861131
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 08:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhIIIHX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 04:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhIIIHW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 04:07:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E047C06175F
        for <linux-rt-users@vger.kernel.org>; Thu,  9 Sep 2021 01:06:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t1so1003329pgv.3
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 01:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7c08qs+2AX6zILi5EffU/lnHnTTWxl9SWg5hOGtXIQ=;
        b=FTYk6ZV+supT3cY1PjKUdt1ABYZF9z9MkjcFkILNC0pvDH6gbMrjMok2XWoe2Wtp3x
         bRNWhnzpt2BWlJrfikDEH9lPGRRJ8Ljrw6JAZz4ay9C8yNBPsZwIQI8lxoizonxfiY7C
         NdXtiKvqREk5Vam6Dj3AiFT0R7ACT0fsKvL/eahDDga7A8UzFRJPGa82tryt5dq0TSiU
         iNXF0AfGPsQW6No0bDJFcGPBPy+Ko/1gGQk/McfM7LqVhvHd/82pc8OdB+S7mOaidwdZ
         rxG/ecSh7iAGnQRo+WiJ3pDdDFDlpv0//qBeKN6eQG8CsEV1S/PfyPW2IcT6/jJt1R80
         3iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7c08qs+2AX6zILi5EffU/lnHnTTWxl9SWg5hOGtXIQ=;
        b=5lOhy09cZfFF3Sl+yikb3elFbMNtnLHUvVYothUpc8YxtYqf9s8tSy/djKHm7nSz0E
         dL7s5HAKGC6EcNDKRTbQCyeihU6yGF/XA92wGMuRXSLIjF5KHRNypB/nTB0hvPvSYlvO
         FqISXi86wO3eH4jBpkmsDPDakZ8GVYUNHVZpLt9IMSsROY78GqRDqA3Bq5FvAbKW39VX
         2PgapKiroiPpxovTMrcBUppnVOSH8R4wZHaACC3/2hdwH1KqjoQQOvFokC1RTtXn0wOi
         A0dBtXdurHQuyeOtfW1dJbQJASGfBWYcTuNgaHyYcG/Ai5FQNv2K80tFHwN8yoB18S2M
         ErWQ==
X-Gm-Message-State: AOAM532mO1EBx6vkyRHKL9YXSROFzz0fYS6ElwZJ1C47IAd3qffBOmAz
        oYmCuHi+hTHrTVfGSpG493c=
X-Google-Smtp-Source: ABdhPJz2OeESZU3JHyWeC69Li8GpsDb2GYFRazA2J8Qewcf4f3TDLqxLF3Z9pm7hYJDNZ5dOP3dBXw==
X-Received: by 2002:a05:6a00:a94:b029:384:1dc6:7012 with SMTP id b20-20020a056a000a94b02903841dc67012mr1936144pfl.53.1631174773015;
        Thu, 09 Sep 2021 01:06:13 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id u123sm1327813pfb.123.2021.09.09.01.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 01:06:12 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: [PATCH 2/2] rteval: services.py: Fix incorrect detection of container environment
Date:   Thu,  9 Sep 2021 17:05:47 +0900
Message-Id: <20210909080547.1331581-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210909080547.1331581-1-punitagrawal@gmail.com>
References: <20210909080547.1331581-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

rteval mistakenly detects that it is running inside a container even
though it is running directly on the host. On further investigation
this was found to be due to change in behaviour around byte strings
and strings when going from python2 to python3.

In python3 byte strings are not equivalent to strings, i.e., b'' == ''
is False. The string comparison functions in services.py are still
relying on the old behaviour in python2 where they were equivalent.

Update the byte string processing by converting them to string.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/sysinfo/services.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rteval/sysinfo/services.py b/rteval/sysinfo/services.py
index 06ff5ae9cd0c..94857aea6be4 100644
--- a/rteval/sysinfo/services.py
+++ b/rteval/sysinfo/services.py
@@ -83,8 +83,8 @@ class SystemServices:
         self.__log(Log.DEBUG, "cmd: %s" % cmd)
         c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
         for p in c.stdout:
-            # p are lines like "servicename.service status"
-            v = p.strip().split()
+            # p are lines like b'servicename.service status'
+            v = p.decode().strip().split()
             ret_services[v[0].split('.')[0]] = v[1]
         return ret_services
 
@@ -92,7 +92,7 @@ class SystemServices:
     def services_get(self):
         cmd = [getcmdpath('ps'), '-ocomm=', '1']
         c = subprocess.Popen(cmd, stdout=subprocess.PIPE)
-        self.__init = c.stdout.read().strip()
+        self.__init = c.stdout.read().decode().strip()
         if self.__init == 'systemd':
             self.__log(Log.DEBUG, "Using systemd to get services status")
             return self.__get_services_systemd()
-- 
2.32.0

