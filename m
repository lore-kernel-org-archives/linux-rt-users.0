Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2902CC636CC
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Feb 2023 21:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjBCVQC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjBCVPy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2023 16:15:54 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B719A701A
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Feb 2023 13:15:39 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id m26so7017429qtp.9
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Feb 2023 13:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up87JT+Oy5cK09OPgZIVT8p4/CiyWa4g1UtMA+kE6c4=;
        b=kuDCVHy/9FY8KusrhAw1MqMTfhlaCPOvU/Uw+2Xj5Yy7N6/s8fHmIwlaNT9T2GtCx+
         HbJKacQKKMaM7XcqhQNk65bhsw3YJHxwIsA9UrFaf5M4fZZi1Jgaa/SYdqP3w4/pER5U
         2yJNyH2YihLtOZdlo38dRlG5x2vwSN+0cg/uPX5lsj7pC5CZTr4bSeOJY+leFNnJIcqS
         7hS/svLAhyThBC1mEkRu4yhOf4LKHta8Gqmj/N60F/slD1yRC1Z/1QSXXd1XlZQ48Wrx
         aT7Wcsc5V1Z8EspTMiEO0wFGvRYt0TsAoXJMVStA1Qj88K9CpiDEcL9lR0awEYddxCZH
         5okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=up87JT+Oy5cK09OPgZIVT8p4/CiyWa4g1UtMA+kE6c4=;
        b=BFE6gczQt4ZQLjZlqjGltRJnIGNHbB363xaCSXOFCVAHzFstDhZI9K7c90mN+kz01j
         RARU7EFp6ro9+YDTe0T5UuHApWKsive8XJLLDvmYKymonhE/hWnu1O8ZgZkqIGnk5/bA
         B/TSR2SyiCx5kLynO339qG2makInslOPCEuPJbzDrngeBkqoXWQAhYxSeG/6+oWFN3sC
         WU24vNIgDMsEjM2PN44z6d6xRApTfq2PgApfxSMUfW7NBam+0csC4QYpcOVM6KhHMAgi
         WgWuhRK70yRBMZ694TRnDfT8Lhvof5k2R4ghWU9gb0DXUni4Vt1M3sGv+qz2TFbtz2Up
         1zMw==
X-Gm-Message-State: AO0yUKXre+sBhWGF8QVWQFNwQtgFKNuaJ4RDiW3APlxAYtAd/bxHEw2r
        obC/2J2OhQNSx5+3a4OA58aRFC8o/nY=
X-Google-Smtp-Source: AK7set/SMlUwb/9VgmkkG4sV+isjiKs0fe+0qnENSLmpePPb7/v23Dr8TvN+jkF+XhftN/2jWHjBUw==
X-Received: by 2002:a05:622a:2ca:b0:3b9:b1a1:73ec with SMTP id a10-20020a05622a02ca00b003b9b1a173ecmr22307637qtx.23.1675458937693;
        Fri, 03 Feb 2023 13:15:37 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id br15-20020a05620a460f00b00706bc44fda8sm2531004qkb.79.2023.02.03.13.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:15:36 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/8] rteval: rtevalXMLRPC.py: Convert regular strings to f-strings
Date:   Fri,  3 Feb 2023 16:15:22 -0500
Message-Id: <20230203211527.71181-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203211527.71181-1-jkacur@redhat.com>
References: <20230203211527.71181-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Convert regular strings to f-strings in rtevalXMLRPC.py

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/rtevalXMLRPC.py | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/rteval/rtevalXMLRPC.py b/rteval/rtevalXMLRPC.py
index f24e21a8ed2f..6dce12ad78bb 100644
--- a/rteval/rtevalXMLRPC.py
+++ b/rteval/rtevalXMLRPC.py
@@ -33,7 +33,7 @@ from .Log import Log
 class rtevalXMLRPC:
     def __init__(self, host, logger, mailer=None):
         self.__host = host
-        self.__url = "http://%s/rteval/API1/" % self.__host
+        self.__url = f"http://{self.__host}/rteval/API1/"
         self.__logger = logger
         self.__mailer = mailer
         self.__client = rtevalclient.rtevalclient(self.__url)
@@ -41,7 +41,7 @@ class rtevalXMLRPC:
 
     def Ping(self):
         res = None
-        self.__logger.log(Log.DEBUG, "Checking if XML-RPC server '%s' is reachable" % self.__host)
+        self.__logger.log(Log.DEBUG, f"Checking if XML-RPC server '{self.__host}' is reachable")
         attempt = 0
         ping_success = False
         warning_sent = False
@@ -52,10 +52,10 @@ class rtevalXMLRPC:
                 ping_success = True
             except xmlrpc.client.ProtocolError:
                 # Server do not support Hello(), but is reachable
-                self.__logger.log(Log.INFO, "Got XML-RPC connection with %s but it did not support Hello()" % self.__host)
+                self.__logger.log(Log.INFO, f"Got XML-RPC connection with {self.__host} but it did not support Hello()")
                 res = None
             except socket.error as err:
-                self.__logger.log(Log.INFO, "Could not establish XML-RPC contact with %s\n%s" % (self.__host, str(err)))
+                self.__logger.log(Log.INFO, f"Could not establish XML-RPC contact with {self.__host}\n{str(err)}")
 
                 # Do attempts handling
                 attempt += 1
@@ -63,17 +63,16 @@ class rtevalXMLRPC:
                     break # To avoid sleeping before we abort
 
                 if (self.__mailer is not None) and (not warning_sent):
-                    self.__mailer.SendMessage("[RTEVAL:WARNING] Failed to ping XML-RPC server", "Server %s did not respond." % self.__host)
+                    self.__mailer.SendMessage("[RTEVAL:WARNING] Failed to ping XML-RPC server", f"Server {self.__host} did not respond.")
                     warning_sent = True
 
-                print("Failed pinging XML-RPC server.  Doing another attempt(%i) " % attempt)
+                print(f"Failed pinging XML-RPC server.  Doing another attempt({attempt}) ")
                 time.sleep(attempt) #*15) # Incremental sleep - sleep attempts*15 seconds
                 ping_success = False
 
         if res:
-            self.__logger.log(Log.INFO, "Verified XML-RPC connection with %s (XML-RPC API version: %i)" % (res["server"], res["APIversion"]))
-            self.__logger.log(Log.DEBUG, "Recieved greeting: %s" % res["greeting"])
-
+            self.__logger.log(Log.INFO, f'Verified XML-RPC connection with {res["server"]} (XML-RPC API version: {res["APIversion"]})')
+            self.__logger.log(Log.DEBUG, f"Recieved greeting: {res['greeting']}")
         return ping_success
 
 
@@ -85,9 +84,9 @@ class rtevalXMLRPC:
         warning_sent = False
         while attempt < 6:
             try:
-                print("Submitting report to %s" % self.__url)
+                print(f"Submitting report to {self.__url}")
                 rterid = self.__client.SendReport(xmlreport)
-                print("Report registered with submission id %i" % rterid)
+                print(f"Report registered with submission id {rterid}")
                 attempt = 10
                 exitcode = 0 # Success
             except socket.error:
@@ -96,12 +95,10 @@ class rtevalXMLRPC:
                     break # To avoid sleeping before we abort
 
                 if (self.__mailer is not None) and (not warning_sent):
-                    self.__mailer.SendMessage("[RTEVAL:WARNING] Failed to submit report to XML-RPC server",
-                                              "Server %s did not respond.  Not giving up yet."
-                                              % self.__host)
+                    self.__mailer.SendMessage("[RTEVAL:WARNING] Failed to submit report to XML-RPC server", f"Server {self.__host} did not respond.  Not giving up yet.")
                     warning_sent = True
 
-                print("Failed sending report.  Doing another attempt(%i) " % attempt)
+                print(f"Failed sending report. Making another attempt({attempt}) ")
                 time.sleep(attempt) #*5*60) # Incremental sleep - sleep attempts*5 minutes
 
             except Exception as err:
@@ -111,12 +108,9 @@ class rtevalXMLRPC:
         if self.__mailer is not None:
             # Send final result messages
             if exitcode == 2:
-                self.__mailer.SendMessage("[RTEVAL:FAILURE] Failed to submit report to XML-RPC server",
-                                          "Server %s did not respond at all after %i attempts."
-                                          % (self.__host, attempt - 1))
+                self.__mailer.SendMessage("[RTEVAL:FAILURE] Failed to submit report to XML-RPC server", f"Server {self.__host} did not respond at all after {attempt - 1} attempts.")
             elif (exitcode == 0) and warning_sent:
                 self.__mailer.SendMessage("[RTEVAL:SUCCESS] XML-RPC server available again",
-                                          "Succeeded to submit the report to %s"
-                                          % self.__host)
+                                          f"Succeeded to submit the report to {self.__host}")
 
         return exitcode
-- 
2.39.0

