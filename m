Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7419CC433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6151861212
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhKKUpW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhKKUpV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:21 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06C8C061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:31 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id bq14so7082423qkb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNsiKwaE7yyqpuQNBRiErLvDPCuk2jinPy0Sq9+YoDs=;
        b=DOfTwtYiK4EtAc6ylGQ3JYwWYbuttItZ5EqW2sJYW14HBoTxMG6TVl+84Mm9nTcXWo
         GxkZBnwET6R59yqxTlv01d8wXyT9tttXONI6NUAcIR1EB28/OuXEncBoWF+H/y1PgOh5
         l8d7O1CaUBv7H8bHZEtg+//A5q7tqfTT1+iTkUBRF2LRYOj5X9DnrWM0Ufcd6MMvHCEI
         vf0BZdO2B0avfo/3HYdO5QY0x0s0qs1l111l65m4R+WQXjz7d/5QT14FZ9+8qi5822Mb
         +KAWj9LDU1mjuGyLqRhS7NEwnml8ziFvTHdQUDtkqOpu89NrFbXO2GmTXmWqOVYmdBBB
         FHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FNsiKwaE7yyqpuQNBRiErLvDPCuk2jinPy0Sq9+YoDs=;
        b=aApyUpLn7+QS8WTnkYfImfIPVV0v53CIRlj7ZOSWCQVFozETnFMCIUUHS9ocus8fCL
         nnDQB/aR3P21E/hCGWjs9WfF+mjewlTv5Z7NVKGhuEZ0ZxYKkl+sC47OW5MkkHjK1TsS
         5COPxpFDNHK6BJcqK1Juunv7+KYZKtQutG8WrOR36QM6hPQnGyoydjRz6UYXjxyNdzO3
         uBKgcYehfoLEFyODPSPu0bZ1OiQTxvgLCPf0pmOyA6E1paSETy8x6KQbsCtHgih8ixuL
         wScxW6ets713t5/aCm3wNbEYwFVkymggwtSZ8Fzbe2EaSt5Rbzs/tnmV3JubPT/D3TPy
         TPIg==
X-Gm-Message-State: AOAM532Xuq6YzuIsMlvVXtOxkCQJKjUit8aj5G5xu3Z4DljIK/9CdfAO
        HREM/M4u2FkZGfiUt1AiY4qeTNuKxFA=
X-Google-Smtp-Source: ABdhPJxDh+cqN2iStW6W2VLiq2st7tZbPHOWVZvyZc0VX23tBdW4L1rWn1ZORUg7oQosDavF4CfZFw==
X-Received: by 2002:a05:620a:46ac:: with SMTP id bq44mr8622558qkb.414.1636663350706;
        Thu, 11 Nov 2021 12:42:30 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:30 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 06/17] rt-tests: get_cyclictest_snapshot: print_warning should be a classmethod
Date:   Thu, 11 Nov 2021 15:41:56 -0500
Message-Id: <20211111204207.10167-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Make print_warning a class method since it only references a class
variable and doesn't require self

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/get_cyclictest_snapshot.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/get_cyclictest_snapshot.py b/src/cyclictest/get_cyclictest_snapshot.py
index aed9681e4cc5..aedc72001fb2 100755
--- a/src/cyclictest/get_cyclictest_snapshot.py
+++ b/src/cyclictest/get_cyclictest_snapshot.py
@@ -21,10 +21,11 @@ class Snapshot:
 
     warned = False
 
-    def print_warning():
+    @classmethod
+    def print_warning(cls):
         """ print a warning one time only even if called multiple times """
-        if not Snapshot.warned:
-            Snapshot.warned = True
+        if not cls.warned:
+            cls.warned = True
             print("No cyclictest instance found")
 
     def __init__(self):
-- 
2.31.1

