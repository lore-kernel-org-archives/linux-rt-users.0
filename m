Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D5C636D4
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Feb 2023 22:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBOWUi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOWUh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Feb 2023 17:20:37 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160E6305C1
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Feb 2023 14:20:37 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id k14so150201ilo.9
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Feb 2023 14:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GvU3woDZfy7bL3b6keToxNTmXhBe1SHBv5aqEUk63Dc=;
        b=IqHIJG56kxsTbH67dVBNhFBSdZpD1O/bF9EWZX9TKSrfqochcVt+6h4iEKU7BaywKN
         sJc+sthuyGPBlabgM48MMWS76cVbnO2SQJePMuaJutKyYdXCub21CLGlOxINlUNWLPqX
         Upx5Crx2BvMwlpSq4+nWEXBRVjwddSEbNTXCM1ZNv6Qba+diLK/tPnMm3pldw3/cdD5Y
         93sqisgX6x8LRDNPcG/11ESiPWUHImhl1M5evQZnySUR15FllEWoS4F4MHONullMebav
         QfsU30E2loz4atqJYuliQlA7hLWoHhzpGVBsj4chskiPIGBMnJ1kgfWoOHiD891Dnk2Z
         MrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvU3woDZfy7bL3b6keToxNTmXhBe1SHBv5aqEUk63Dc=;
        b=h47krAGwpu0Rf1mrncjSu3gYM/anUK6ZhjWkzOI47DDl94zw3VRPhcjeE7/JXa/ReG
         v0rjvvdxkTzMA77WAfrvxwX1YJYqB7jCX1Sk4WyusN2Q0wNUFGUywOB57ZDVcqwq4sD2
         YQCGDycDH+f7uajSxZKtUnd1SVqp3FuoXdlrAXSUYwCXnOLCWAzngWlRu6GgP0WNW75p
         ti0PDBgMONviCS13LDxMXwooXvv0f5sCV/xganAde73X8NwApyKedvvlC89Dk5bJArFE
         IKzsgCOuKkHPeQJQmWck8Fy6ppLC2FXKBnnsVMQ852hwSHyVL2dzFr081c3je5/lWatM
         dOLA==
X-Gm-Message-State: AO0yUKUsM+H+XlfNok2YMpqYOP89TVD5TGm7AO7AWGDvv6udhH+9VY3O
        WFUF7rJ0EPbaOHa4t8tl1Jox/yDe0js=
X-Google-Smtp-Source: AK7set8Bsge0yUE0merFlSUD5rAC0TG9HAhFgC1wT/hHZP2QRdqYSILRgmg+v9YS/pFwHjDP4zaIzA==
X-Received: by 2002:a92:c241:0:b0:315:7ecc:5fd8 with SMTP id k1-20020a92c241000000b003157ecc5fd8mr418444ilo.28.1676499635884;
        Wed, 15 Feb 2023 14:20:35 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id k4-20020a92c244000000b003157c7c43d1sm291927ilo.7.2023.02.15.14.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:20:35 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 1/1] rt-tests: Makefile: Use sysconfig instead of distutils for PYLIB
Date:   Wed, 15 Feb 2023 17:20:11 -0500
Message-Id: <20230215222011.23329-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use sysconfig instead of distutils for PYLIB
Version 2 takes into consideration that different versions of python
produce different results.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile     |  2 +-
 get_pylib.py | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100755 get_pylib.py

diff --git a/Makefile b/Makefile
index 4df61ece123b..32a9f41198a4 100644
--- a/Makefile
+++ b/Makefile
@@ -34,7 +34,7 @@ CFLAGS ?= -Wall -Wno-nonnull -Wextra
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=
 
-PYLIB  ?= $(shell python3 -c 'import distutils.sysconfig;  print (distutils.sysconfig.get_python_lib())')
+PYLIB ?= $(shell python3 -m get_pylib)
 
 # Check for errors, such as python3 not available
 ifeq (${PYLIB},)
diff --git a/get_pylib.py b/get_pylib.py
new file mode 100755
index 000000000000..56253d589fe4
--- /dev/null
+++ b/get_pylib.py
@@ -0,0 +1,16 @@
+#!/usr/bin/python3
+
+# This file is used during the make process
+
+import sysconfig
+
+# Older versions of python don't have this scheme
+# but produce the answer we expect with 'posix_prefix'
+# Newer versions of python insert 'local' in the path unless we use rpm_prefix
+SCHEME = 'rpm_prefix'
+
+if not SCHEME in sysconfig.get_scheme_names():
+    SCHEME = 'posix_prefix'
+
+PYLIB = sysconfig.get_path('purelib', SCHEME)
+print(PYLIB)
-- 
2.39.1

