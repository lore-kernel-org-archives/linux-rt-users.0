Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B614EC433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 07:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EE16192B
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 07:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhELHbu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 May 2021 03:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhELHbN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 May 2021 03:31:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB15C0613ED
        for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2021 00:29:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id bf4so25856620edb.11
        for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2021 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvAMLLHZ9k5i1OEsSJrFi8i4tVEo/LR8+oa0bocRAJY=;
        b=kAepzJJcItSDx6KEoSyp6zv7UqCofeAtJilsWr1YujfAWEOt2Fdy2B+j3K8rBsoIar
         rZ52gW57OFG0j/0FpnhKSSTLsw6pM9y5kRXu343VG3l8xwcIEixG1scW4iSuQorHZ3C4
         2f4tfQHdXGcZS6524xW59cmcmV3HWUzRaROPqEURiE26Lax8F3K7/kxedq0SLlWbDT/8
         etb9B0wAd9LwJs3WvoFC09AiOp9Boh2K4qRH62aCMUk/alXH4wlCYcMaICn8L8uDTUwH
         u6Gr6fcF4ZiMOqNvtOUOPg0EFk5/9s71R/W/LanVOzhbouHEcFFJm3IUw+jbfminjRBT
         qdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xvAMLLHZ9k5i1OEsSJrFi8i4tVEo/LR8+oa0bocRAJY=;
        b=RVWa1PIaWd1qe5SYOFmuf5NENrcVF5dxZU09qx12ch+89UjQ1TBClpbYEU5lOFyJ2I
         WGP3Qu0G5fS7GfzPYL6GuQEhrHRwf92i8thxvBEbPPcJFPzFPBE5eZMKueHux22dIBGO
         V2H1giMWFwAlP4XwZBvP2p9jPTfwW1Hy9AR036rRHwMm9Riw8YUtAcXkVkoeo7Wv+To9
         JP/+77ixlVCiNkDc1js77W7G64E6j9H1WElFDzrfERVBnHVKzbU/KHYsroWejWg//qhR
         TSfgaA0HtW8MjsfCKcKNdlNbdRqQiHyOkNv3E/Bp5aFsrFate9TngKpQivrqUzwr8S60
         /sPg==
X-Gm-Message-State: AOAM533VLBk7JItAgknUCKw7ih7WF7vwCRuSadKKea10YdG9SyugMSh0
        IxojM+P7OLOYtt/T7irFo8U=
X-Google-Smtp-Source: ABdhPJyzR4WkmlwQUm1SSvPSGwOow0dHB+cKJ7mAnE0/BbGE5+1VQBSSSpMZlnODbgkQtIUbUj4Q6A==
X-Received: by 2002:a50:c34a:: with SMTP id q10mr41613734edb.346.1620804582168;
        Wed, 12 May 2021 00:29:42 -0700 (PDT)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id q18sm16388684edd.3.2021.05.12.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:29:41 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
Received: from peko by dell.be.48ers.dk with local (Exim 4.92)
        (envelope-from <peko@dell.be.48ers.dk>)
        id 1lgjJM-0002yL-Lp; Wed, 12 May 2021 09:29:40 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     williams@redhat.com, jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org,
        Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH] Makefile: drop explicit undefine PYLIB for compatibility with make 3.81
Date:   Wed, 12 May 2021 09:29:38 +0200
Message-Id: <20210512072938.11384-1-peter@korsgaard.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

GNU make 3.81 does not like the explicit tab-indented undefine:

Makefile:41: *** commands commence before first target.  Stop.

Dropping the indentation also doesn't work:

Makefile:41: *** missing separator.  Stop.

So simply drop the undefine logic.  As explained in the GNU make manual,
undefine is not commonly needed as E.G. ifdef checks for a non-zero string:

https://www.gnu.org/software/make/manual/html_node/Undefine-Directive.html
https://www.gnu.org/software/make/manual/html_node/Conditional-Syntax.html

Fixes:
http://autobuild.buildroot.net/results/cf7c4f360f5464c700788cc8299fd086544c80e8/build-end.log

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Makefile b/Makefile
index b17ac09..ec85ac8 100644
--- a/Makefile
+++ b/Makefile
@@ -36,11 +36,6 @@ LDFLAGS ?=
 
 PYLIB  ?= $(shell python3 -c 'import distutils.sysconfig;  print (distutils.sysconfig.get_python_lib())')
 
-# Check for errors, such as python3 not available
-ifeq (${PYLIB},)
-	undefine PYLIB
-endif
-
 MANPAGES = src/cyclictest/cyclictest.8 \
 	   src/pi_tests/pi_stress.8 \
 	   src/ptsematest/ptsematest.8 \
-- 
2.20.1

