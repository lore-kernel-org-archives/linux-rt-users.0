Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC85CC7EE23
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjFAU2s (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFAU2r (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7CE195
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PwhbVf7tWp9Sx6kiVtr3dP3sLSJnDuHYn/CiwUNsw+U=;
        b=i8WIaCcABhzq4hQviCt0FQvxb668cFHqCZy5L2NO8IZssP+99dG6GPaFgVN3uYKwLNhdCZ
        3/BoD390sSai0CbeQV0kgrHjhhoba+w/nnTa5OYjD0nkKsPUsQzKfFYoPWRDwVkwTrQveN
        RGha6Nj/1662scMRWXTLkoieGEllrX4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-1CMMaTouNYKirPCd5JVZ_Q-1; Thu, 01 Jun 2023 16:28:00 -0400
X-MC-Unique: 1CMMaTouNYKirPCd5JVZ_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1973F8015D8
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:28:00 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6B24C154D9;
        Thu,  1 Jun 2023 20:27:59 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 06/10] rteval: Use f-strings in osinfo
Date:   Thu,  1 Jun 2023 16:27:32 -0400
Message-Id: <20230601202734.813515-7-ashelat@redhat.com>
In-Reply-To: <20230601202734.813515-1-ashelat@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use f-strings in osinfo.py

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/sysinfo/osinfo.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rteval/sysinfo/osinfo.py b/rteval/sysinfo/osinfo.py
index ead5e3939cfa..83dc78b96fdd 100644
--- a/rteval/sysinfo/osinfo.py
+++ b/rteval/sysinfo/osinfo.py
@@ -55,9 +55,9 @@ class OSInfo:
             shutil.copyfile(dpath, os.path.join(repdir, "dmesg"))
             return
         if os.path.exists('/usr/bin/dmesg'):
-            subprocess.call('/usr/bin/dmesg > %s' % os.path.join(repdir, "dmesg"), shell=True)
+            subprocess.call(f'/usr/bin/dmesg > {os.path.join(repdir, "dmesg")}', shell=True)
             return
-        print("dmesg file not found at %s and no dmesg exe found!" % dpath)
+        print(f"dmesg file not found at {dpath} and no dmesg exe found!")
 
 
 
@@ -69,16 +69,16 @@ class OSInfo:
         else:
             raise RuntimeError("Can't find sosreport/sysreport")
 
-        self.__logger.log(Log.DEBUG, "report tool: %s" % exe)
+        self.__logger.log(Log.DEBUG, f"report tool: {exe}")
         options = ['-k', 'rpm.rpmva=off',
                    '--name=rteval',
                    '--batch']
 
         self.__logger.log(Log.INFO, "Generating SOS report")
-        self.__logger.log(Log.INFO, "using command %s" % " ".join([exe]+options))
+        self.__logger.log(Log.INFO, f"using command {' '.join([exe]+options)}")
         subprocess.call([exe] + options)
         for s in glob('/tmp/s?sreport-rteval-*'):
-            self.__logger.log(Log.DEBUG, "moving %s to %s" % (s, repdir))
+            self.__logger.log(Log.DEBUG, f"moving {s} to {repdir}")
             shutil.move(s, repdir)
 
 
@@ -118,7 +118,7 @@ def unit_test(rootdir):
         log = Log()
         log.SetLogVerbosity(Log.DEBUG|Log.INFO)
         osi = OSInfo(logger=log)
-        print("Base OS: %s" % osi.get_base_os())
+        print(f"Base OS: {osi.get_base_os()}")
 
         print("Testing OSInfo::copy_dmesg('/tmp'): ", end=' ')
         osi.copy_dmesg('/tmp')
-- 
2.31.1

