Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4B1EB64D7
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jun 2023 17:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjFWRwj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFWRwh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jun 2023 13:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D42136
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jun 2023 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687542713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XwDCEtwiX4bF1dDMCazxJ04wTvOM+n+zJE1uB8ddaOA=;
        b=K/Pqy2SGBaHPz9R9gCIq5XHCAjjOT8RGG7CJ7x0XzxaGsADUnelfVLkKmYEcJfzt9SYRTJ
        /BCnZENdhCvINhIVl0hV9EEzUE+6q/5mpoqMyk5N52YYstshJ5e6h/QNiv1QFeeNpujtxS
        OWV6E83JLi4aNjTMTvtQhVXyOPNoRxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-uq58yQDZOZuf_SEOiROvSQ-1; Fri, 23 Jun 2023 13:51:51 -0400
X-MC-Unique: uq58yQDZOZuf_SEOiROvSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60D381008133
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jun 2023 17:51:51 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.18.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CAD2C57961;
        Fri, 23 Jun 2023 17:51:51 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 3/3] rteval-cmd: added code to handle downloading kernel versions of the x.x
Date:   Fri, 23 Jun 2023 13:50:50 -0400
Message-Id: <20230623175049.492763-3-ashelat@redhat.com>
In-Reply-To: <20230623175049.492763-1-ashelat@redhat.com>
References: <20230623175049.492763-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rteval-cmd: added code to handle downloading kernel versions of the x.x

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rteval-cmd b/rteval-cmd
index 19efd1d0b296..0426f8c3bddc 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -306,7 +306,11 @@ if __name__ == '__main__':
                 kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", rtevcfg.srcdownload).group(0)
                 url = "https://git.kernel.org/torvalds/t/"
             else:
-                kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", rtevcfg.srcdownload).group(0)
+                try:
+                    kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", rtevcfg.srcdownload).group(0)
+                except AttributeError:
+                    # if kernel version specified is of the form x.x and not x.x.x
+                    kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}", rtevcfg.srcdownload).group(0)
                 major_version = re.search(r"\d{1,2}", kernel_prefix).group(0)
                 url = "https://kernel.org/pub/linux/kernel/v" + major_version + ".x/"
 
-- 
2.39.3

