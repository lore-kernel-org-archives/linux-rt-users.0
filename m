Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE09C001DC
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jul 2023 07:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjGMHzu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjGMHzl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jul 2023 03:55:41 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080DF2713;
        Thu, 13 Jul 2023 00:55:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EECF8DE5A3;
        Thu, 13 Jul 2023 09:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1689234435; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=JVx/wMmu2mafrXhkeZJ9fNSWsicdmXECOnuVK0+2598=;
        b=mMD8MnrVy0aqEPXhB+UqtB2KUM+5tY3yiV0+J2y/kcWGucg2ZY/HrT3sbAzp2e4WLd4l0+
        PsyPRLWao0s28B1zeUebjKUtASMp1e/9zZA64wOvgXme5nxSYeZn6IM072RqpPMjxEdNNs
        jK9+kyQ/06ezMcil7dPnby4gTYCJfmHy57Qw2X6eqWM+Hur42M5YwuUangwAoTw7DT5vSy
        Zw7hVTuaObx4eWvyNOuHIopp4Dm/XdxPx1GA0K5+29k9lcElLPMnrI2n6zm60Pe7XAeFPL
        Y9oope3OxIOScSPOxbYWfTyl8XvEjgxeNj/FXZ0b/t5FlgRr++Q0r7GUDs7Kxw==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/1] Linux 4.19.288-rt126
Date:   Thu, 13 Jul 2023 09:47:07 +0200
Message-ID: <20230713074707.1188-2-wagi@monom.org>
In-Reply-To: <20230713074707.1188-1-wagi@monom.org>
References: <20230713074707.1188-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v4.19.288-rt126-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 9d0cfbcac7f4..a44fd6cdf249 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt125
+-rt126
-- 
2.41.0

