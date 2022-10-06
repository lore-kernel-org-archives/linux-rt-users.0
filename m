Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFE6C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Oct 2022 20:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiJFUMd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiJFUMb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2022 16:12:31 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D25AC704E
        for <linux-rt-users@vger.kernel.org>; Thu,  6 Oct 2022 13:12:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id h6so1755058qkl.11
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Oct 2022 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DjydNZiVsxlynN6JjPPEjWX2U+/k/nS38H8OcmmaEkg=;
        b=P8ZuUUx//WEhPDc/+6XZUdBskwH9UCB9ool+249YedLRxBXOUQz10sS1tJ5i6fACsj
         aFbOWw89FUGuzuWXghMF12qqypy7fT6E/V+jjpMEx4SJTXHEph4u5X/5y+QGrmIcCJ3U
         D8FYMfnLwuHNvdXj3HN28k4IdQzxS+n9rf9mukbnnoA1zIEOgEnSF2mqCWAz/W/Anmi4
         03QiZPLFMEVeHAptR9zwIDfr+MI31nPwqUFNragM/bSSY7CJLmAKqsMky/s0srDil0nr
         7Dag/t237tXd2nTHyK0Uw/LVBE9s7gRba7ew1br2C4LFL9N+DIhMhWusm25WM8HYOULh
         D5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjydNZiVsxlynN6JjPPEjWX2U+/k/nS38H8OcmmaEkg=;
        b=AgDyCjcZveYjxn2lSCK15DuQrKDoy66RzMPZFKMPlp0A41RQ/rcXAg+jzExhntRyKH
         tEPs8jWpSMw2j74z90uMDwb9id2sTvdQcClSk76FiuWxqPaczk9G+AdGBjLDLKqhWrBu
         6YfhfnfRAJF01Vi+450rx4IgcBClNvlhxG51Ktn7unMD64MNWq6EE9xjoOyLxXN8+Xwj
         s85DUJho7SGE4d6hx0m7pREnfOp5rRyQCVQ4CSB7/lT/iWy1EUnZQPvrCswK8xYgxyNZ
         dUsDPgVC3PVNdofObFYGpmp8RJa7AuzqUk3ouB69WHnPQh35ZWm2TnnMPYCTUMfGT9TQ
         rFjA==
X-Gm-Message-State: ACrzQf1IqfZNSIQGCTYnIE/IsScYv33w+R7jD8idr8He+SGTTaa2CvXw
        8YC9rD3oQ9/y2Ex5mxY0MT5eY3TgvjI=
X-Google-Smtp-Source: AMsMyM5bZhzGz1O34tnFdw6PxYEPrnp6RwqIYI/eaREx/JL6kXxG49PP6vzDZ0aMx4d9hF0W860deA==
X-Received: by 2002:a05:620a:1029:b0:6e7:b1f0:fae9 with SMTP id a9-20020a05620a102900b006e7b1f0fae9mr937929qkk.564.1665087148790;
        Thu, 06 Oct 2022 13:12:28 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-11-174-88-121-224.dsl.bell.ca. [174.88.121.224])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006bc192d277csm57665qko.10.2022.10.06.13.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:12:28 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Remove arbitrary num of threads limits
Date:   Thu,  6 Oct 2022 16:11:55 -0400
Message-Id: <20221006201155.14736-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove the arbitrary limit to the number of threads in pmqtest,
ptsematest, sigwaittest and svsematest.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pmqtest/pmqtest.c         | 2 +-
 src/ptsematest/ptsematest.c   | 2 +-
 src/sigwaittest/sigwaittest.c | 2 +-
 src/svsematest/svsematest.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 6ad0a92ffb5c..9e142787d8b4 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -393,7 +393,7 @@ static void process_options(int argc, char *argv[])
 		}
 	}
 
-	if (num_threads < 0 || num_threads > 255)
+	if (num_threads < 0)
 		error = 1;
 
 	if (priority < 0 || priority > 99)
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index e000c3017081..a9d6c69b6449 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -299,7 +299,7 @@ static void process_options(int argc, char *argv[])
 		}
 	}
 
-	if (num_threads < 0 || num_threads > 255)
+	if (num_threads < 0)
 		error = 1;
 
 	if (priority < 0 || priority > 99)
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index d0d79df940de..728176a0b385 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -369,7 +369,7 @@ static void process_options(int argc, char *argv[])
 		if (duration < 0)
 			error = 1;
 
-		if (num_threads < 1 || num_threads > 255)
+		if (num_threads < 1)
 			error = 1;
 
 		if (priority < 0 || priority > 99)
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 22ea7bcb7374..243b13738b19 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -398,7 +398,7 @@ static void process_options(int argc, char *argv[])
 		if (duration < 0)
 			error = 0;
 
-		if (num_threads < 1 || num_threads > 255)
+		if (num_threads < 1)
 			error = 1;
 
 		if (priority < 0 || priority > 99)
-- 
2.37.3

