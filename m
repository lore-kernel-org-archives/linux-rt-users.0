Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AF3C05027
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Feb 2023 21:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjBCVQI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjBCVP7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2023 16:15:59 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527838EAA
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Feb 2023 13:15:43 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id g8so7001743qtq.13
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Feb 2023 13:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHJRzDobW7a1YAjs6ATWZwHOSKCBI3eNm4mlLC/FZok=;
        b=ErJfU91yCZqkSK3osju4y7ww3FW/Ypqc9x4pMjtuif601v0jMz7VCO0I0vkC3ZPskG
         7XQ9eBCQ1YixAw60xHdYrlZ1UL40E5C5NAiyw8pJ8yw0bxo+EPQIXOdggwHCzcZue+/x
         ybH1IY2IHP7TFufmv6uc/6iPIJGPduo681U2OxdC4z5NbIPHyQ7eKbM/cB1Nk3ZQuN5l
         fhV2wsg+4D+qzdao6Fu5GT2GtxjJCDAwy/ohOc+Yeh/Tz/Ro+y3XL9RlrxJIrv7/+ZuU
         fFjMDeUHRGu1A8GfUzvbQtMNEbiGIl2b5U/UUqhhbG9uO7lNrQ89QMC6K3GGg1P+5nZm
         h31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHJRzDobW7a1YAjs6ATWZwHOSKCBI3eNm4mlLC/FZok=;
        b=jutQRyaeELLfJD2fWQkANEeVTD/+Gdw/2DI0t47ZJVMNkQZLKTSpO+SBc3VKZd/3qs
         aQjTjBR4y125Dn9ulVTptyrwC5YKB1a0Nh86nE6ZzP70e6llVOzlUMkz4/EKpuRo28pt
         wilkCVjrt8tsnWSmdxpL7y8Jghrmd+9c2Mpn3s41L74ci4Gh4HvaMzwBr8XURY3sxcB6
         P/1vqdh1jc1vTPCBBtjpBOMZQ3kKO11y4x19fKVmOfAKQeoXg9h4J3OkM2zfrtgyDg8m
         UcNdl/vfndZsbBNp24KaxrfVwOLOB4l9p88+DwqE1UP39cxJuqQ869DKFUdqmlctQ/sz
         2NrQ==
X-Gm-Message-State: AO0yUKX94b9wATp06B83FYfpVE/6N1TWQRPTDIq5db53bbUSTLMUIGDy
        VVIh+dH8pYV1XK4bv0WlNxXNsuWx0PU=
X-Google-Smtp-Source: AK7set8zOzGOJwAvQVITB0tLKWrbOG3rY72TIdl+H0pAXye1GEWbqQCljB676wrUEf5jCRJwVMnalg==
X-Received: by 2002:ac8:41d4:0:b0:3b9:bc8c:c1fc with SMTP id o20-20020ac841d4000000b003b9bc8cc1fcmr9002955qtm.7.1675458942122;
        Fri, 03 Feb 2023 13:15:42 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id br15-20020a05620a460f00b00706bc44fda8sm2531004qkb.79.2023.02.03.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:15:41 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/8] rteval: Log.py: Convert to f-strings
Date:   Fri,  3 Feb 2023 16:15:25 -0500
Message-Id: <20230203211527.71181-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203211527.71181-1-jkacur@redhat.com>
References: <20230203211527.71181-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Convert Log.py to f-strings

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/Log.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/rteval/Log.py b/rteval/Log.py
index 63ca3b8681f8..8d08ab3e210a 100644
--- a/rteval/Log.py
+++ b/rteval/Log.py
@@ -60,10 +60,7 @@ class Log:
 
     def log(self, logtype, msg):
         if (logtype & self.__logverb) or logtype == self.ALWAYS:
-            self.__logfile.write("%s%s\n" %
-                                 (self.__logtype_str(logtype),
-                                  msg)
-                                 )
+            self.__logfile.write(f"{self.__logtype_str(logtype)}{msg}\n")
 
 
 
@@ -80,8 +77,8 @@ def unit_test(rootdir):
     def run_log_test(l):
         for lt in range(min(logtypes), max(logtypes)*2):
             test = ", ".join([logtypes_s[logtypes.index(i)] for i in [p for p in takewhile(lambda x: x <= lt, (2**i for i in count())) if p & lt]])
-            print("Testing verbosity flags set to: (%i) %s" % (lt, test))
-            msg = "Log entry when verbosity is set to %i [%s]" % (lt, test)
+            print(f"Testing verbosity flags set to: ({lt}) {test}")
+            msg = f"Log entry when verbosity is set to {lt} [{test}]"
             l.SetLogVerbosity(lt)
             test_log(l, msg)
             print("-"*20)
-- 
2.39.0

