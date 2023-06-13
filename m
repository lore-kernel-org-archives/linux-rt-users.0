Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D747FEB64D0
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Jun 2023 18:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjFMSJb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFMSJa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Jun 2023 14:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0171C13E
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Jun 2023 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686679729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNp5pGeqz8vwux/ABY4mJ1Tdkr7ToDk8h93RvLSz5Zg=;
        b=ftOpchhqqUoJkboPNyq6l5bKgbEPySBQ8j+5CU0Wv9G3CRGmcg3b1eBmOjeDqysjpNDi6j
        dHVMQko4Zbp6VPgJ3yywjd+NTvj50DIe6NPyQhaKJpSZlA0xWIfObQ7hVa9uLM7VHpto/Q
        MUa8jxzkQFxxC6vp3CNYWnO/Bl3mCuk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-Znvi2K72MK2NNZ5RsKKLwA-1; Tue, 13 Jun 2023 14:08:48 -0400
X-MC-Unique: Znvi2K72MK2NNZ5RsKKLwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97E50811E7F
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Jun 2023 18:08:47 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.11.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 789CD40CFD00;
        Tue, 13 Jun 2023 18:08:47 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] rteval: osinfo.py: Added code to use 'sos report' instead of sosreport.
Date:   Tue, 13 Jun 2023 14:08:30 -0400
Message-Id: <20230613180828.1235964-2-ashelat@redhat.com>
In-Reply-To: <20230613180828.1235964-1-ashelat@redhat.com>
References: <20230613180828.1235964-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

sosreport is deprecated, so if available on the system osinfo will try
to use the sos command instead.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/sysinfo/osinfo.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/rteval/sysinfo/osinfo.py b/rteval/sysinfo/osinfo.py
index 83dc78b96fdd..0c570c0e395b 100644
--- a/rteval/sysinfo/osinfo.py
+++ b/rteval/sysinfo/osinfo.py
@@ -62,12 +62,14 @@ class OSInfo:
 
 
     def run_sysreport(self, repdir):
-        if os.path.exists('/usr/sbin/sosreport'):
+        if os.path.exists('/usr/sbin/sos'):
+            exe = '/usr/sbin/sos report'
+        elif os.path.exists('/usr/sbin/sosreport'):
             exe = '/usr/sbin/sosreport'
         elif os.path.exists('/usr/sbin/sysreport'):
             exe = '/usr/sbin/sysreport'
         else:
-            raise RuntimeError("Can't find sosreport/sysreport")
+            raise RuntimeError("Can't find sos/sosreport/sysreport")
 
         self.__logger.log(Log.DEBUG, f"report tool: {exe}")
         options = ['-k', 'rpm.rpmva=off',
@@ -75,8 +77,8 @@ class OSInfo:
                    '--batch']
 
         self.__logger.log(Log.INFO, "Generating SOS report")
-        self.__logger.log(Log.INFO, f"using command {' '.join([exe]+options)}")
-        subprocess.call([exe] + options)
+        self.__logger.log(Log.INFO, f"using command {' '.join(exe.split()+options)}")
+        subprocess.call(exe.split() + options)
         for s in glob('/tmp/s?sreport-rteval-*'):
             self.__logger.log(Log.DEBUG, f"moving {s} to {repdir}")
             shutil.move(s, repdir)
-- 
2.31.1

