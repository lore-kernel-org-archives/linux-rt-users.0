Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F641C4332F
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Nov 2022 19:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiKFTSH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 6 Nov 2022 14:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKFTSG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 6 Nov 2022 14:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B640BC1F
        for <linux-rt-users@vger.kernel.org>; Sun,  6 Nov 2022 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667762182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ad8ic842jdlKd3UTcmMeSqjwms+lNuCPnoKaEgTLcVA=;
        b=S74XAiySAV37WjMLZ9DMUSPgK3ZIBT/tlM8fnnLIYg+rW+qCswO8IesCJn3LGHVJQKCLLg
        e3GE/FIu8N4jn01P20arsSjROzU9se4gaNeHAlZRotfhADWq0PZrH+2lpMzGAwdMcnfvxC
        r/NE3+ZUnAgiCWbfKQhCp09OF6eh+V0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-iThobMoqMcyLEwm-EN-0hw-1; Sun, 06 Nov 2022 14:16:21 -0500
X-MC-Unique: iThobMoqMcyLEwm-EN-0hw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3D9A380453C;
        Sun,  6 Nov 2022 19:16:20 +0000 (UTC)
Received: from localhost (unknown [10.22.32.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A3ED17582;
        Sun,  6 Nov 2022 19:16:20 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 4/4] Linux 4.14.298-rt141-rc1
Date:   Sun,  6 Nov 2022 16:16:12 -0300
Message-Id: <20221106191612.21730-5-lgoncalv@redhat.com>
In-Reply-To: <20221106191612.21730-1-lgoncalv@redhat.com>
References: <20221106191612.21730-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v4.14.298-rt141-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index e27678f73d17..564532c76548 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt140
+-rt141-rc1
-- 
2.38.1

