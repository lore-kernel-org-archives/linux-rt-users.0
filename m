Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC260C7EE23
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 May 2023 18:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjE3ShF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 30 May 2023 14:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjE3ShD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 30 May 2023 14:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA4DC9
        for <linux-rt-users@vger.kernel.org>; Tue, 30 May 2023 11:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685471778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=w3RuU5CFEki4KqYkPIj4/cg7BW2SGBZCClcTU7vo+l0=;
        b=YyoyhuyHEQQu4v/FExwEvcrlZm8Fkrpb9WSfNkP9ICVaLGRm0gMORjFzEiOBBEJpudl+N4
        vhXXLOHA0AnGm2alrIo28zq4TiBgWC6Eh7XaN/1+tbshPzJ/+QJf54J/ZWdH0pG45xMNOS
        XnzUudew19Io3ewtMl6XnpMknDZIEg8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-M2k1xtkSO3mT3QURR4_Kcw-1; Tue, 30 May 2023 14:36:09 -0400
X-MC-Unique: M2k1xtkSO3mT3QURR4_Kcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 053BE38294A5
        for <linux-rt-users@vger.kernel.org>; Tue, 30 May 2023 18:36:09 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8DE4140E955;
        Tue, 30 May 2023 18:36:08 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id EA20F40195512; Tue, 30 May 2023 14:02:54 -0300 (-03)
Date:   Tue, 30 May 2023 14:02:54 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Nini Gu <ngu@redhat.com>,
        Jun Wang <jwang@redhat.com>
Subject: [PATCH] cyclictest: remove inclusion of unnecessary headers
Message-ID: <ZHYsPobROUdwnEC/@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


The following three headers seem to be unnecessary,
and do not exist on FreeBSD.

Remove their inclusion.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 82759d1..7b0f80f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -22,11 +22,8 @@
 #include <time.h>
 #include <errno.h>
 #include <limits.h>
-#include <linux/unistd.h>
 
-#include <sys/prctl.h>
 #include <sys/stat.h>
-#include <sys/sysinfo.h>
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/resource.h>

