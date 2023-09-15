Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6779EEAA42
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Sep 2023 02:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjIOCci (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 22:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjIOCch (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Sep 2023 22:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D4D526B8
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Sep 2023 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694745110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FwmUy8m/v/WHKSgubxWP3esXuZO2lifquLriUNNJdKs=;
        b=YrquACuGeGBGZ1lwuHCEMrp3Fvi02hRSG6P35DxyTSkS1ySJhG/cfQMsFoS6qZ4V2PZUjG
        e5lHqB5HV7E7/RxGFum0jtszHUhCjCWxrr/wyMQj9NhX35lVKj/kRJ0Emxe+pfJ/z62bMV
        f9blk7SrUK82Ne0dwQwfxK9e1AEaLIs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-z6GpbGCWPeKP91qc2wh2fg-1; Thu, 14 Sep 2023 22:31:43 -0400
X-MC-Unique: z6GpbGCWPeKP91qc2wh2fg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBE78857A9C;
        Fri, 15 Sep 2023 02:31:42 +0000 (UTC)
Received: from localhost (unknown [10.22.17.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 894E328AC;
        Fri, 15 Sep 2023 02:31:42 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Wang Yong <wang.yong12@zte.com.cn>,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 2/2] Linux 5.10.194-rt95-rc1
Date:   Thu, 14 Sep 2023 23:31:35 -0300
Message-ID: <20230915023135.201399-3-lgoncalv@redhat.com>
In-Reply-To: <20230915023135.201399-1-lgoncalv@redhat.com>
References: <20230915023135.201399-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v5.10.194-rt95-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 8d02a9bac500..fe529ae51f64 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt94
+-rt95-rc1
-- 
2.41.0

