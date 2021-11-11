Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137FCC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BFE6120D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhKKUpS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhKKUpS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:18 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13F4C061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:28 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z9so6489795qtj.9
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjiL7SuI/grP29vHh7MKCCeptCljIVYsQ+EpHkyl8zk=;
        b=mIDBqQQJGwqZQflByjr1SvLGuDByvae9o77S9JNu6ooMxynzWgC556mRLxBtx5fr2h
         MB4d1QnnURKrft2EFE27kQuNdCRHlfzLQ9L4f0+za1vH8dCbhRuZPlDr40/QPN7ouA8C
         3hSpN2x6fT1fKj+30maT4Q4B7QkPJQsfruq1zEsVUSViFO+T4W2WUMXdO19DiXx6Pv6E
         XF+BcCNIR6uAup2xaDuMWaxAisV4hhlWxwhrSkXdd9rc2EJ2IcnHc+wHrMk/5nafRIl3
         AVebjePUAktRWFNDcIuNl11Nf4mCG3nlAW4s957YAVHJNwPbLH/wM4DJrTbYfa4WNujY
         sAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kjiL7SuI/grP29vHh7MKCCeptCljIVYsQ+EpHkyl8zk=;
        b=1o4JPxnbpm9jkaY0YvIRFt4tyc2TfQlpmp3pqzPlYAL2TZsTcsWrV+DJYFcult+Y/6
         0Q145r2iNzd8y1INbH2Wwy5OEslrka3Hs3lf4Hv7yE7mmD3wBy41HchuB767KYh0HO24
         4FbRTEjXL/6uutSJbfkEa5etR8HbCHyzguQjYRLnXJ4lJBG8849IGFJUd3cHQoalj53R
         wQT3T3WbbRkV8Pmm8YDGmcayVg9cahu5U0PvST+a09EXBkDoKUwiVQa/uLGKdvAGa9cP
         9NHWgbDAKfWDwAvYojDDw55tl8Xgipozzy/a7Z4nBbp7pi2mJnetHrZg6pduAK+FyXQw
         Fceg==
X-Gm-Message-State: AOAM531V8sJzgR03U2UwvOnLJSp//pSP33StfAZ1PagYoshmGnV0m71M
        yCO1AIPkXTPN8MSH/48m5ha8cABaG44=
X-Google-Smtp-Source: ABdhPJw2AN9EkvZAc/SOEUgWfwctWz/Tr/qN+y7jRgsQgBU5eefMLOQIHHdu8xkSRjMgec+XqpMhbA==
X-Received: by 2002:a05:622a:246:: with SMTP id c6mr10837635qtx.305.1636663347515;
        Thu, 11 Nov 2021 12:42:27 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:27 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 02/17] rt-tests:hwlatdetect.py: Remove multiple statements on one line
Date:   Thu, 11 Nov 2021 15:41:52 -0500
Message-Id: <20211111204207.10167-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove multiple statements on one line

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index ac87036d4c08..66e132b8c2a5 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -19,10 +19,12 @@ quiet = False
 watch = False
 
 def debug(str):
-    if debugging: print(str)
+    if debugging:
+        print(str)
 
 def info(str):
-    if not quiet: print(str)
+    if not quiet:
+        print(str)
 
 #
 # Class used to manage mounting and umounting the debugfs
@@ -358,7 +360,8 @@ class Tracer(Detector):
                 val = self.get_sample()
                 while val:
                     self.samples.append(val)
-                    if watch: val.display()
+                    if watch:
+                        val.display()
                     val = self.get_sample()
                 time.sleep(0.1)
         except KeyboardInterrupt as e:
@@ -425,7 +428,8 @@ class Hwlat(Detector):
                 while val:
                     val = val.strip()
                     self.samples.append(val)
-                    if watch: print(val)
+                    if watch:
+                        print(val)
                     val = self.get_sample()
                 time.sleep(0.1)
         except KeyboardInterrupt as e:
-- 
2.31.1

