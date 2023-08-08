Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530B7C001DB
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 20:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjHHUtD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjHHUsw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 16:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA015B9C
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691512893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRku+2jKgZ+nUwxuWVi5s637lJh7o+hs6ix8fet0MDQ=;
        b=CBGmq+6aOlLZRI+Dl5GCGs90EPVLGVCXJF7aEwiuzE+t/cim6jAMO2UUxnHR1oKuf7HV05
        YIvgNSUiS1I1pRZyOaz5SwC3urgLHngbieFhU5CpF4JFHYC8KxXhv5St7L/pKdn7Uzm2E0
        Rqe3WBxHvc0/GUTATsppMBF6KMIPwzs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-JCkPqZ3INvCzZoyKWwQFBQ-1; Tue, 08 Aug 2023 12:35:25 -0400
X-MC-Unique: JCkPqZ3INvCzZoyKWwQFBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 559461C29AF3;
        Tue,  8 Aug 2023 16:35:25 +0000 (UTC)
Received: from localhost (unknown [10.22.32.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BE9E568FF;
        Tue,  8 Aug 2023 16:35:24 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 3/3] Linux 4.14.320-rt152-rc1
Date:   Tue,  8 Aug 2023 13:35:20 -0300
Message-ID: <20230808163520.305842-4-lgoncalv@redhat.com>
In-Reply-To: <20230808163520.305842-1-lgoncalv@redhat.com>
References: <20230808163520.305842-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v4.14.320-rt152-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 7c59c4689f8b..95561e32e8aa 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt151
+-rt152-rc1
-- 
2.41.0

