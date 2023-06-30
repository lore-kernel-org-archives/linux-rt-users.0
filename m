Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4203EB64D7
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 17:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjF3RLn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF3RLl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 13:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD473A90
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688145047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/odKMpF2yHlr+aJ7kqK7ViiiDccHr4o2c2/fP3KuFA=;
        b=HhzFSlRUhavc7v9GU5FfWvYlIOliDHrbrizji7oXMGmFuBG8bNkWU9OISf1eGOr10q+HeM
        7vAkJh4bnRlgn6ClsZRfNzXqorgRd6cd48KhayWKpUuHCvPytfAPQCUyp8Imt306ODyZun
        4FXrNxtTyUZAJcRQKCWxP7QeRqejdmg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-q9gl3n-KO-Wk1r4p_lDK-w-1; Fri, 30 Jun 2023 13:10:45 -0400
X-MC-Unique: q9gl3n-KO-Wk1r4p_lDK-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 776B2882389
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 17:10:45 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.32.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 516DB40C2063;
        Fri, 30 Jun 2023 17:10:45 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v3 2/2] Edited code from previous commit to exclude try-except block
Date:   Fri, 30 Jun 2023 13:10:19 -0400
Message-Id: <20230630171017.1072241-2-ashelat@redhat.com>
In-Reply-To: <20230630171017.1072241-1-ashelat@redhat.com>
References: <20230630171017.1072241-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Edited code, from previous commit that allowed -S to download kernel
versions of the form x.y, to exclude try-except block.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index d019da41d8d3..44921dfe0764 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -291,11 +291,7 @@ if __name__ == '__main__':
                 kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", rtevcfg.srcdownload).group(0)
                 url = "https://git.kernel.org/torvalds/t/"
             else:
-                try:
-                    kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", rtevcfg.srcdownload).group(0)
-                except AttributeError:
-                    # if kernel version specified is of the form x.x and not x.x.x
-                    kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}", rtevcfg.srcdownload).group(0)
+                kernel_prefix = re.search(r"(\d{1,2}\.\d{1,3}\.\d{1,3})|(\d{1,2}\.\d{1,3})", rtevcfg.srcdownload).group(0)
                 major_version = re.search(r"\d{1,2}", kernel_prefix).group(0)
                 url = "https://kernel.org/pub/linux/kernel/v" + major_version + ".x/"
 
-- 
2.39.3

