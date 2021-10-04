Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E5C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Oct 2021 12:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B430E61373
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Oct 2021 12:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhJDMqb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 08:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhJDMqa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Oct 2021 08:46:30 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100D2C061745
        for <linux-rt-users@vger.kernel.org>; Mon,  4 Oct 2021 05:44:42 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q125so16205898qkd.12
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Oct 2021 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mj+VcQtk5Bi7WZo7O2RzcIulntbl6dEWF7nOGbe9wF4=;
        b=i9MndIswtRpqRpWV0OAp8fJXUZsCI658QipSNIXkcRbh7YlI+U7lplr7gz7GcepJtz
         3u9PtoYDxax4tASsKAmbVri7JvVFSqhSGBdmRsBlbg2nXA51jQaw63BsJqyUUsCBn1Jv
         uLG8OeB/j09sT1GNZ3pnyZu1Lag0mFNIu1ichsVfZvM0xmyRvZN7JIghF4rMhvbmuiny
         dZxobPfeLeyvadBJVwtoscxqcsSVhaDpkiY4a2VGx89mbkfgfNLkQMSHB4dyFVk1D4h7
         N4INf+WMotA6b1CeuQ/c9S98A74ap4fBz/b9GJOZa8Wzns4RqJwebV+TIxA7rt1jCcHZ
         tSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mj+VcQtk5Bi7WZo7O2RzcIulntbl6dEWF7nOGbe9wF4=;
        b=tyzfjJEqw48HzPFSJY6Lk1n1QdPTkvRhzAQuQ6/A5ShnyxdJ01Y2fg+DNe89QIAKhv
         jHXK8Q+a0pryuJ9HCQv7xxo64vVDv290NoIK6ElCbML1xiDJ1x0vhh4vzTWSuyE4Ee9e
         ksYYph6o0yzdOAdHEu3c+P3fR3cVKEDqeWQgqXo/rn9H5z8/dhy/swcxzJsLtuACea8f
         cLZASaxPX5oYXwcwKCBapg6YZvzx6ZECWvO+pVPI2qmpBZxfANqG596q8lX5OjgOq1SQ
         Y4nhXgzVV+b174+DD9E2/JFwbobD9Mosm3r1Vl4DM+x4PfS11YluGsy1IqKWMv7tfGNG
         Hpjw==
X-Gm-Message-State: AOAM533BkvpQ1pbZAI8A/ZnNgGTuXNPiU9g5H5yGzbH94Xq2ZBjjp0EI
        YqPZvWhqo14armxxjpwU3t9/PeQFYeg=
X-Google-Smtp-Source: ABdhPJz8p7irbhdkpHRgSV+wM3GmJpuOxtuH413NiLBkJkhrttv1pDgqBz6F4RwuOVG2FWJ4kE+Vrg==
X-Received: by 2002:a37:a413:: with SMTP id n19mr9763485qke.461.1633351481083;
        Mon, 04 Oct 2021 05:44:41 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id d82sm7587440qke.55.2021.10.04.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 05:44:40 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Punit Agrawal <punitagrawal@gmail.com>
Subject: [PATCH] rt-tests: cyclictest: Remove unused 'C' and 'E' options
Date:   Mon,  4 Oct 2021 08:44:22 -0400
Message-Id: <20211004124422.5006-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Removing the unused short options 'C' and 'E'.

Suggested-by: Punit Agrawal <punitagrawal@gmail.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index cbdc6c11ffe3..2187d98de725 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1071,7 +1071,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case 'c':
 		case OPT_CLOCK:
 			clocksel = atoi(optarg); break;
-		case 'C':
 		case OPT_DEFAULT_SYSTEM:
 			power_management = 1; break;
 		case 'd':
@@ -1080,7 +1079,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case 'D':
 		case OPT_DURATION:
 			duration = parse_time_string(optarg); break;
-		case 'E':
 		case 'F':
 		case OPT_FIFO:
 			use_fifo = 1;
-- 
2.31.1

