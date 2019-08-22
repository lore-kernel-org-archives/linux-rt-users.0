Return-Path: <SRS0=VkLV=WS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A76FC3A59D
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 06:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BAE21848
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 06:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDy9uR9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfHVGtX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:49:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34468 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfHVGtX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 02:49:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so3278215pfp.1
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Aug 2019 23:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PiJi4PsZsLceTZnzBl9VutT3uJzum8sw1zR8yy177xU=;
        b=IDy9uR9QF8Ip53Nn8K1fboYsNqljFNdOtNP2v/+zrFNIUYAbTtxBAQmOdL61JQSpHW
         pLoaPqDn2LroGhrN0hb99a8fI788vq90VuFNI07NPk8NwJXeGP21P8CI7QkuaLSZ2JUF
         jme29Y3xvvG7qssHHVzxa9ILhT2HYGbvgfuhYgoshlU2oGFh5oUZNcF4/3yjM+5Su+8a
         nDEpE/OTq1o8tK84x/+fVibML9FFK4IdCEaMY8AnySJdZJyDXXZnTi8RuemG98f7lzof
         ALukN7zyoOZyDKEwY8KIMy4LzhUj+ROFnHrmO8cc3YL7kl7jcPsDpPEGbQpIVewNnzXR
         3wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PiJi4PsZsLceTZnzBl9VutT3uJzum8sw1zR8yy177xU=;
        b=jLWaHx7uGd1c98mkzsmbfm1w1D62A++yo6InXwbiFKP+KAZgB4VpZCeRwwD5yfJm4s
         EWrmOh5xuuI0cVZbVorOS/tuXoqKbYq55NgIbA6mqCXB771ZyiiCrpbqdy2Ee7CoPI4h
         nRRHV8Ed0a+kzOaUj/V+f/Rrv6oU3OizHsiiyA4CvW0sKZY+dWrryp/JRlzt3OgHXttL
         vQwhgnAM0fu9z1NyhL/1VZ0oTFK+1nbQ99BJ+kdu1Vd9QdAw8dzneuZVEYGD1ZJKjhQy
         VcGwWxeaKM3QiX4gNcJzSiQ/04OH0yn4j0vR6lZZcQDtmyeFKfz5c5mip8zsWDAX3dKU
         pFPA==
X-Gm-Message-State: APjAAAVpuADmNZF+DiFM+EaSNiX93Zf9N6gm9CdEZzSTMYSZI0eAkKht
        GbahIOGAkFaF3pRVSz6+PV4=
X-Google-Smtp-Source: APXvYqyxLhWKUp2t6h9qjU6tvzUgQgbvidCVvZWZAthrNC5YXTfamfAcrEGC/mLNjcrOtM7uY3SOlw==
X-Received: by 2002:a17:90a:bb89:: with SMTP id v9mr3954559pjr.88.1566456563051;
        Wed, 21 Aug 2019 23:49:23 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:53::2:ea40])
        by smtp.gmail.com with ESMTPSA id u7sm25927995pfm.96.2019.08.21.23.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 23:49:22 -0700 (PDT)
From:   Afzal Mohammed <afzal.mohd.ma@gmail.com>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH 1/2] rt-tests: Allow cross compilation
Date:   Thu, 22 Aug 2019 12:19:18 +0530
Message-Id: <eb3b222b7741d16bf45735f59015c40fcbb31ba2.1566455869.git.afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

$ make CROSS_COMPILE=<my-toolchain-prefix>

currently does not cause source to be built using the intended
toolchain, instead will use the host toolchain.

CC & AR are not updated with CROSS_COMPILE value since they are
predefined make variables (with default cc & ar respectively) combined
with the fact that CC & AR variables are updated in the makefile only if
not already defined due to the usage of '?='.

Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 51b8dea..b573408 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 1.5
-CC?=$(CROSS_COMPILE)gcc
-AR?=$(CROSS_COMPILE)ar
+CC = $(CROSS_COMPILE)gcc
+AR = $(CROSS_COMPILE)ar
 
 OBJDIR = bld
 
-- 
2.23.0

