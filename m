Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B98EB64DC
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 19:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjF1Two (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbjF1Twk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 15:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687981910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zzzjOJ1AUxeWP9V+iQphjyJX1hA7U6SpJDWFf2qUtk=;
        b=OX0Ec+Sw/3ZMjja0PdbrK+li/kjY2Ov8XVLhfKNVkRvLv69uGsdSako+rvn1umSUQKBl83
        YEPvA/bCgf3dH0cGIS9H7H7Z5pgxB9UEJ1mWRqUnJd58cjh5Zjq3UAhu6/RaOBDM+bCnYo
        /hkKRBXu54OSJOup8np0hTpFi+OUy1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-Z_uovMJTMR6rt32FWEWmTA-1; Wed, 28 Jun 2023 15:51:48 -0400
X-MC-Unique: Z_uovMJTMR6rt32FWEWmTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1DDC8DBAE3
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 19:51:47 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD7BDF41C9;
        Wed, 28 Jun 2023 19:51:47 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 1/3] rteval: added code to download default kernel version if no version is specified
Date:   Wed, 28 Jun 2023 15:51:43 -0400
Message-Id: <20230628195145.636652-2-ashelat@redhat.com>
In-Reply-To: <20230628195145.636652-1-ashelat@redhat.com>
References: <20230628195145.636652-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Previously, the usuage was "./rteval-cmd -S [KERNEL_VERSION]", and
rteval-cmd would throw an error if no kernel version was provided.
Now, rteval-cmd will download the default kernel version, as specified
in rteval/modules/loads/kcompile.py.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rteval-cmd b/rteval-cmd
index f715fec1e21c..ae94bd98cc11 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -166,7 +166,7 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("-V", "--version", dest="rteval___version",
                       action='store_true', default=False,
                       help='print rteval version and exit')
-    parser.add_argument("-S", "--source-download", dest="rteval___srcdownload",
+    parser.add_argument("-S", "--source-download", nargs="*", dest="rteval___srcdownload",
                         type=str, default=None, metavar="KERNEL_VERSION",
                         help='download a source kernel from kernel.org and exit')
 
@@ -191,8 +191,16 @@ def parse_options(cfg, parser, cmdargs):
             ind = cmdargs.index('--raw-histogram')
         cmd_args = cmdargs[ind+1:]
         cmdargs = cmdargs[:ind+1]
+
     cmd_opts = parser.parse_args(args=cmdargs)
 
+    # if no kernel version was provided for --source-download, set version to default
+    if (sys.argv.count('-S')+sys.argv.count('--source-download')) > 0:
+        if cmd_opts.rteval___srcdownload == []:
+            cmd_opts.rteval___srcdownload = ModuleParameters()["source"]["default"].replace(".tar.xz", "")
+        else:
+            cmd_opts.rteval___srcdownload = cmd_opts.rteval___srcdownload[0]
+
     if cmd_opts.rteval___version:
         print(f"rteval version {RTEVAL_VERSION}")
         sys.exit(0)
-- 
2.39.3

