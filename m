Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363A3C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213046120D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhKKUpW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbhKKUpW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:22 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ADDC061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:32 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id bq14so7082442qkb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+gTMM0sQES9PPV3WtfUHy1YJmNmttjJxy8MV/jL95c=;
        b=Hk8BL23BOoncUBV7VKZA5JBuDaFFOEuL36abWeUoWEPaOVtu2sle2NEdQTQhLlL0fP
         sy/4jVuFbaS3Nretyg9ya7WYDudLsFgbz7cEKlEw24HwFuU4E/Xw7V6/pTEmK1FsoBQn
         fitx3+CMUW0TNbEjPy6Tbc+wogaePtXzK18T/g00ys0AkZ3SJ6wLzJItiuQKCgD3adMX
         pZmSw15XmCxyzOqP0wz+EAA0lZdPMetgwKEWK1qQL4W+dmsmzEosTsnI+hFPhYg4C03d
         azH/9ydUTPCQc4+G5Enow8NDNZQPl3I6PDy//FwnGso5FmdZdkvMUdxaBCIyXLdbBCT6
         a5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=w+gTMM0sQES9PPV3WtfUHy1YJmNmttjJxy8MV/jL95c=;
        b=KqSxDnu/ksxbSVabpZP1+snIwhVfBvhe+dxsoRPnjInc/nN/YlXScRA0oAJcef4acu
         hpIEiADbOQLLOluwmNgp1KK9Mi9d2fz523dS11xqzqESTUQ/75TgKFxpnr38RPhu5Wu5
         MfudwJbh/TqnNK1/fY6o29/JFDEMJ/kUoB/JXlNFKZ5EPnzywbBtGkD8Sf0dsspsDTEP
         n9N9QpfNYVCMlaCM7uVkJ6MmhhQZrHjJuReJ9j7c8/B73mRw201QD3GpSodsl7fgLb6J
         VgJwzOuQ/lGFo4MCowWkjyBxXt1Bstu0CGXJSH9H6h8VInWsJAte00Cf2RLY9rBNdfDs
         3hnA==
X-Gm-Message-State: AOAM530e6bu3O1kudum0Q7qgCkCgQOl7LDfI/QZqwE7wL5zLYIOCQNyv
        Omd57rz/ACAH/xJKHrXhqzW8XIEGJCw=
X-Google-Smtp-Source: ABdhPJwIQDxzIglMBxyjzO9XkzS9gV7NsNXR0knVv5O9VSbxLOG1jqdMMpNCvR8lCg0sP+5W6qteEA==
X-Received: by 2002:a05:620a:424f:: with SMTP id w15mr8681121qko.258.1636663351468;
        Thu, 11 Nov 2021 12:42:31 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:31 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 07/17] rt-tests: hwlatdetect: Remove unnessary parens after return
Date:   Thu, 11 Nov 2021 15:41:57 -0500
Message-Id: <20211111204207.10167-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove unnecessary parens after return

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 5a66280fb01c..2fabbb55b242 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -174,14 +174,14 @@ class Kmod:
             debug("not loading %s (already loaded)" % self.name)
             return True
         cmd = ['/sbin/modprobe', self.name]
-        return (subprocess.call(cmd) == 0)
+        return subprocess.call(cmd) == 0
 
     def unload(self):
         if self.preloaded or self.builtin:
             debug("Not unloading %s" % self.name)
             return True
         cmd = ['/sbin/modprobe', '-r', self.name]
-        return (subprocess.call(cmd) == 0)
+        return subprocess.call(cmd) == 0
 
 #
 # base class for detection modules
@@ -494,11 +494,11 @@ def microseconds(str):
     if str.isdigit():
         return int(str)
     elif str[-2:] == 'ms':
-        return (int(str[0:-2]) * 1000)
+        return int(str[0:-2]) * 1000
     elif str[-2:] == 'us':
         return int(str[0:-2])
     elif str[-1:] == 's':
-        return (int(str[0:-1]) * 1000 * 1000)
+        return int(str[0:-1]) * 1000 * 1000
     else:
         raise RuntimeError("invalid input for microseconds: '%s'" % str)
 
-- 
2.31.1

