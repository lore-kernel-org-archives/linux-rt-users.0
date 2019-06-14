Return-Path: <SRS0=fTCY=UN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FABC31E4B
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 11:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5422082C
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 11:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKqFK6F7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfFNLiC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:38:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55687 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFNLiC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Jun 2019 07:38:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so1986631wmj.5
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Jun 2019 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUKvygbVIHClD6MQR3x+66PLbfPf+vyv0iAum0KgvoI=;
        b=CKqFK6F7O3Wpa62j9WvO5HBKDM0idqEWGFhyvSnaR4kOOGm6li6PaHXya50IH9hcpD
         ulwFv5Lj342IkWfYyp7ZAgyvUPsLCu7muD10Nhdf4y4AvvrZSWmd+PCLLj2N+TTlNiHH
         wXqr0Q9ODEmwb7gzZhIkeJzeq0vjbOmWDEHPuGHgMItkDjRa6Clalhlf1IvdLWvSOl7V
         36Q6lgPiujnzKhsLuiM5C/qosPVPfodJUxIJFfnYdp0KMIlrjiG0N7k+/dA0+yi2mCRI
         bE3kq5LnUGMIthz3vPhsGIFyNSH+7KXF8Qu3YnelLleJzZVFx2P2k3CLpTVHHs60Iaiw
         hdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GUKvygbVIHClD6MQR3x+66PLbfPf+vyv0iAum0KgvoI=;
        b=XgVRpyQmumoGpqeo6MIut0mEN3xDBDSMSFDOPfQO/iMpeowJwxRZtP3qHJVMFuoEhN
         x7hfCzLj5IpTrZ9g0nLZReRvEi7B4Ww0se+6OS10Ag3hDjvh9rnrAIpcaKZ0WbD1PauY
         eeLt52ZDvMjDu4xPAj7uOQOMF6cjXfAj8C3RXbPvaG5lp8N2msqVGxPEghm2z06F+fPt
         ooL1aZMgN7gk/W4inocyBULmIYk/4MoCAfT1jSUXu/i92ZR4pA571Zo7+T6TD1v2H65/
         phHT514zwi4gT+HWZTyjrP+UFME4L+++PTb8NFczFDzUcOCrtQj/7mkX6BRp6TuMJa7A
         RIzw==
X-Gm-Message-State: APjAAAXgV/esUL6y+91h1juupfRMrTldemlftyuCJNMBGTcdfo74SKVm
        PIJcP+b5jvzOPqYfjAxisa8=
X-Google-Smtp-Source: APXvYqw2YffxFQyClu35cnG6P0rVAQe9mg2DL+fqxq/y+DePWOzv9sTGRgsDUspZ2B1qVrzjGOFB/A==
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr7923606wmj.41.1560512280393;
        Fri, 14 Jun 2019 04:38:00 -0700 (PDT)
Received: from planxty.home (ip4d14ff42.dynamic.kabel-deutschland.de. [77.20.255.66])
        by smtp.gmail.com with ESMTPSA id u11sm1841376wrn.1.2019.06.14.04.37.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 04:37:59 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/1] rt-tests: ssdd: Add Licence information to ssdd
Date:   Fri, 14 Jun 2019 13:37:47 +0200
Message-Id: <20190614113747.11565-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614113747.11565-1-jkacur@redhat.com>
References: <20190614113747.11565-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add License Information to ssdd

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ssdd/ssdd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 4e293586526e..2c3a779be9f1 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -15,6 +15,13 @@
  *
  * The tracer waits on each PTRACE_SINGLESTEP with a waitpid(2)
  * and checks that waitpid's return values for correctness.
+ *
+ * This program was originally written by
+ * Joe Korty <joe.korty@concurrent-rt.com>
+ * This program is free software; you can redistribute it and / or modify
+ * it under the terms of the GNU General Public License Version 2
+ * of the licence, or (at your option) any later version
+ * see COPYING for more information
  */
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.20.1

