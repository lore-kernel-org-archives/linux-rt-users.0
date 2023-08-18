Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7B9C71136
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Aug 2023 08:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358446AbjHRIIn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 04:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358437AbjHRIIk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2023 04:08:40 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13FE2D5D;
        Fri, 18 Aug 2023 01:08:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 315EEE1A0F;
        Fri, 18 Aug 2023 10:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1692346116; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=LyWtB6snaCP89bsxLTQfGWH/fBUWtv9xx69GMobeI1U=;
        b=aAoxmR4ceHulyCPrnuz6Gh73ZJQJPeGqFISUeA8xQqPlRE8bBXwzbhX2d77DBXbRq+PL9Z
        Xw3t3/rbC+z1HBIKLkoQtoSEiQ/uel5IrTSyyRrdv7gV7RspYYwu5+DHR7zPpj8oKsYI8Y
        06SFE5jms3AOF0yRtJtKhqMsiA05D28FJVAhg99TkUPlCCAlnmJu4AIu2pgqYprioXodU7
        W8xmIgcyB/1CxdCbx5IQ1cdABrZFxYAec3QpykeuScOd0HEFoVUBa15uOYCptPNozik2YK
        wGocU627WagdlOIQr66d0CleHX6D/GGRGpfgNzFiwmW0QSf2dp1ZvUeXjbepLg==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/1] Linux 4.19.292-rt128
Date:   Fri, 18 Aug 2023 10:08:33 +0200
Message-ID: <20230818080833.31189-2-wagi@monom.org>
In-Reply-To: <20230818080833.31189-1-wagi@monom.org>
References: <20230818080833.31189-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v4.19.292-rt128-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index c85940d40a67..6d2a676e2033 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt127
+-rt128
-- 
2.41.0

