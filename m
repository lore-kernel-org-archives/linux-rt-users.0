Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D263EB64D7
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 19:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjF1Twn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230447AbjF1Twk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 15:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687981910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNeAFbAr0yUDhqGYCz2RWk015OyiEGgCkWmpmZujbNQ=;
        b=FpznHH+G93K6hLE5DWOxru4poYlfIAza3qwMBOe6MzQNSBr6pF8hBteWcC928kH+bo/vqG
        4M30P/6JJBeTGSLUhMR+O4mtAtYvoiuZKGGdD25mMjX1frPJZYa2cXExJtdqKFTAVc1z20
        IVxeU0mOdTbcDVCKBdLfqHlQFFDfMvw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-BRrvHF_DNmehk9mjZnCNng-1; Wed, 28 Jun 2023 15:51:48 -0400
X-MC-Unique: BRrvHF_DNmehk9mjZnCNng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4793E38149AA
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 19:51:48 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29F0DF5CDF;
        Wed, 28 Jun 2023 19:51:48 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 3/3] rteval/server: edited files to use optparse instead of argparse
Date:   Wed, 28 Jun 2023 15:51:45 -0400
Message-Id: <20230628195145.636652-4-ashelat@redhat.com>
In-Reply-To: <20230628195145.636652-1-ashelat@redhat.com>
References: <20230628195145.636652-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rteval/server: edited files to use optparse instead of argparse.
Note: Since server is diabled, these changes have not been tested.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 server/remove_rtevalrun          | 16 ++++++++--------
 server/rteval_testserver.py      |  1 -
 server/testclient_sendreportfile | 10 +++++-----
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/server/remove_rtevalrun b/server/remove_rtevalrun
index cee699e27c9f..7d83f71ea644 100755
--- a/server/remove_rtevalrun
+++ b/server/remove_rtevalrun
@@ -29,7 +29,7 @@
 
 import sys
 import getpass
-from optparse import OptionParser
+from argparse import ArgumentParser
 from database import Database
 
 def do_delete(dbc, table, rterid):
@@ -45,20 +45,20 @@ def do_delete(dbc, table, rterid):
 
 
 if __name__ == '__main__':
-    parser = OptionParser(version="%prog v0.1")
+    parser = ArgumentParser(version="%prog v0.1")
 
-    parser.add_option("-H", "--host", action="store", dest="dbhost", default="localhost",
+    parser.add_argument("-H", "--host", action="store", dest="dbhost", default="localhost",
                       help="Database server to connect to (default: %default)",
                       metavar="HOST")
-    parser.add_option("-p", "--port", action="store", dest="dbport", default="5432",
+    parser.add_argument("-p", "--port", action="store", dest="dbport", default="5432",
                       help="Database server port to use (default: %default)", metavar="PORT")
-    parser.add_option("-U", "--user", action="store", dest="dbuser", default="rtevaladmin",
+    parser.add_argument("-U", "--user", action="store", dest="dbuser", default="rtevaladmin",
                       help="Database user to connect as (default: %default)", metavar="USERNAME")
-    parser.add_option("-d", "--database", action="store", dest="dbname", default="rteval",
+    parser.add_argument("-d", "--database", action="store", dest="dbname", default="rteval",
                       help="Database to use (default: %default)", metavar="DATABASE")
-    parser.add_option("-r", "--rterid", action="store", dest="rterid", default=None,
+    parser.add_argument("-r", "--rterid", action="store", dest="rterid", default=None,
                       help="rteval run id to remove from the database", metavar="INTEGER")
-    (opts, args) = parser.parse_args()
+    opts = parser.parse_args()
 
     if opts.rterid is None:
         print "%s:  Missing --rterid value" % sys.argv[0]
diff --git a/server/rteval_testserver.py b/server/rteval_testserver.py
index 6cac85bcfe52..c7f9ce954b21 100644
--- a/server/rteval_testserver.py
+++ b/server/rteval_testserver.py
@@ -30,7 +30,6 @@ import sys
 import signal
 from xmlrpc.server import SimpleXMLRPCServer
 from xmlrpc.server import SimpleXMLRPCRequestHandler
-from optparse import OptionParser
 import argparse
 
 import xmlrpc_API1
diff --git a/server/testclient_sendreportfile b/server/testclient_sendreportfile
index 08317b263f76..dc69a199122c 100755
--- a/server/testclient_sendreportfile
+++ b/server/testclient_sendreportfile
@@ -28,22 +28,22 @@
 
 import sys
 import libxml2
-from optparse import OptionParser
+from argparse import ArgumentParser
 
 sys.path.append('../rteval')
 import rtevalclient
 
 if __name__ == '__main__':
-    parser = OptionParser(version="%prog v0.1")
+    parser = ArgumentParser(version="%prog v0.1")
 
-    parser.add_option("-r", "--report", action="store", dest="report", default="summary.xml",
+    parser.add_argument("-r", "--report", action="store", dest="report", default="summary.xml",
                       help="Which XML report to send to the XML-RPC server  (default: %default)",
                       metavar="FILE")
-    parser.add_option("-X", "--xmlrpc-submit", dest="xmlrpchost", default="localhost:65432",
+    parser.add_argument("-X", "--xmlrpc-submit", dest="xmlrpchost", default="localhost:65432",
                       help="Hostname to the XML-RPC server to send the data (default: %default)",
                       metavar="HOST[:PORT]")
 
-    (opts, args) = parser.parse_args()
+    opts = parser.parse_args()
 
     d = libxml2.parseFile(opts.report)
 
-- 
2.39.3

