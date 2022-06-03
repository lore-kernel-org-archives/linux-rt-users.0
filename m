Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473EDC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Jun 2022 16:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343685AbiFCQMo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343661AbiFCQMj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Jun 2022 12:12:39 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0F251326
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Jun 2022 09:12:37 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id br33so4596536qkb.0
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Jun 2022 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iV1XT8cWEw4sm8BATQpBK4G1tXOnjegU46o+Tq7zcs0=;
        b=jib+asndWmOousLD2Hxscc5IJl7XZ8GYEbRaMNLynP5qWIat145eBrWNatuzdtkxVj
         t6LLZ7cDOPJb826cLTeq7CsjMADbbqISG1GSFoaZ747Js9yjvOZNOJfTmzeWD1Y2hrLJ
         yPleNHMfFCs4LHv0m3W5wif3OLRif8jHCaTckl3IY4oRpXqW5pvD5cQXcFZKHfpbFIHQ
         VG+7UVMi9ZPD+kt4E7qrchTk8tMqIIQCPPaY6KasKM2X2viO2W6q5gLYMMt0B12SEl/T
         pE9hbpj0aI4U2hDuVajadm7jA/39m5QtgAWoF04xJCdGej323r5vPYT/FMgSGRMZsBKG
         RnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iV1XT8cWEw4sm8BATQpBK4G1tXOnjegU46o+Tq7zcs0=;
        b=JTH2mEfi8NHCdv+1A0GC/7knYlTNqBkRZ2FxDpFtfwKip+PxlGbmjrwfjFwqGfqNJ8
         bZcLhYs9Bg6naYtfY2jeO/4mNy2Ocx9iXc8tUMVuMp4qH8JcYM1yo3TLyeFvCbtj8nYz
         9aRY5zHOmzD5o1URJloxvNcPiYvI2pehT5NGKbJR8W81oy0iVbnJBKojjZ8vWpWV8sRP
         D1aYEMfyXv7XBPSKVOQDk/Z0yRIWxHQ9AXVe6vM+Tn/TaNZvhadKwymyiET5gMthJPSn
         gNYY37XM0GsLz+LUHCtWmni6sEzzlunlQodjdXjObZg3HHw4oQCNAUr5I1cB7sOgrWS9
         95IA==
X-Gm-Message-State: AOAM530xhrDj33A8GQ4SSx9HrtDc1O6nqvucHip5iZQDcnot3+XcHlcN
        Cmfyc1pS87DzmHKrbdeox0+4yngnqnI=
X-Google-Smtp-Source: ABdhPJzNNHMh4ZZ8McTnF92qhS9m3swryucttx1kh02CPo08hPH0RFtqbyzHx7T5V0wZwHfo2PKBLg==
X-Received: by 2002:a05:620a:1a0e:b0:6a5:dac2:d0ec with SMTP id bk14-20020a05620a1a0e00b006a5dac2d0ecmr6939234qkb.667.1654272756467;
        Fri, 03 Jun 2022 09:12:36 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id n12-20020a05622a11cc00b003022cdcd28bsm5234973qtk.2.2022.06.03.09.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 09:12:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/7] rteval: cyclictest.py: Use "with" with resource allocation
Date:   Fri,  3 Jun 2022 12:12:21 -0400
Message-Id: <20220603161224.10947-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603161224.10947-1-jkacur@redhat.com>
References: <20220603161224.10947-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Use "with" with open
- Add a module docstring

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 8fdd5341794a..4c8d510c4a34 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -24,6 +24,7 @@
 #   including keys needed to generate an equivalently functional executable
 #   are deemed to be part of the source code.
 #
+""" cyclictest.py - object to manage a cyclictest executable instance """
 
 import os
 import subprocess
@@ -254,14 +255,13 @@ class Cyclictest(rtevalModulePrototype):
     @staticmethod
     def __get_debugfs_mount():
         ret = None
-        mounts = open('/proc/mounts')
-        for l in mounts:
-            field = l.split()
-            if field[2] == "debugfs":
-                ret = field[1]
-                break
-        mounts.close()
-        return ret
+        with open('/proc/mounts') as mounts:
+            for l in mounts:
+                field = l.split()
+                if field[2] == "debugfs":
+                    ret = field[1]
+                    break
+            return ret
 
 
     def _WorkloadSetup(self):
-- 
2.36.1

