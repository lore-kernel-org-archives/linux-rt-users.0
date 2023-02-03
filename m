Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D8FC61DA4
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Feb 2023 21:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjBCVQO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjBCVP7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2023 16:15:59 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D67A8793
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Feb 2023 13:15:45 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id k18so3648793qvm.7
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Feb 2023 13:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLU+RcBrQWKqw2VXU2hRmXDAh0kROsoTCVz/TKP7/Ww=;
        b=ZNmxHHrfsOhOf5XTROyGVPKwoIhXAAw76vZA8igRdurfWQDVxcDg+9nCUZV1KJcz7b
         Zl1Lv2EMHoEHZULKAgkjeoyB7TwimyG9gwNqiM4NzDWLWKrrk2hm//HLBYjmAKsj/C37
         oB00LKVsYSv9dyXF+r/VPD5p39s/8VvblkZ8h+PB8Mthyzadw9kk9R6gwOmLoy606jdx
         IwbncTZERI/v8kgVcy2PCUFECN4IyykLoVF9EbK4HIBtVIrShNUvqjIiwLfMbkdosVGo
         ab+RU5Z81L9ZI/q2pUI8nZlkhuEB/F1wD5In/ME4jVa9rsSgIESQrGrX3q7ukv/eZFsi
         tTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLU+RcBrQWKqw2VXU2hRmXDAh0kROsoTCVz/TKP7/Ww=;
        b=nZipHtzaf2PGepMYvrjAEFwOFFvd2liLKyq04yfi/9herFFDMt60A/4QAR56lGhhwX
         1Bh8JYr9N531SmBJUSuB68JOjOiWrTRopILQonp0h25gCbQ5SH6hIvHsR6oqoTa674+y
         lqQtjRNxtX8HDm6oOESAANm9A1Ovha1zR64140cO6HtaqMSUQgknaaYXEMlUyCELTOI0
         fKuQPGZSiOtMOVJ8mLNC9f/+kmv6oW5/6L5RecyFYRXWu0gP7mQUnlJs7o24goqS2x1i
         evVB8bkd1tc4aoIxO3ihMQ40o9Pxnlufrba7d2/E3hNxD797dQ5saan6afE55c+/ofWv
         52lA==
X-Gm-Message-State: AO0yUKXvsJnNvupOqEf5nspZe1UQWwUY2zEfrTrBU1gRukXgGOHuzbGo
        TNDIX2cKg6jHAAbx82ujLdszaXpYmSM=
X-Google-Smtp-Source: AK7set+m+17H0OCI8cUUnT8rH37eiOU5TmSmyvzMXV/IE/Vi/bd4Pee7io3mzyHjH86Ffk5dKdHr4w==
X-Received: by 2002:a0c:b38a:0:b0:534:c933:4d5b with SMTP id t10-20020a0cb38a000000b00534c9334d5bmr17319792qve.46.1675458943637;
        Fri, 03 Feb 2023 13:15:43 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id br15-20020a05620a460f00b00706bc44fda8sm2531004qkb.79.2023.02.03.13.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:15:42 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 7/8] rteval: Catch failures in python-dmidecode
Date:   Fri,  3 Feb 2023 16:15:26 -0500
Message-Id: <20230203211527.71181-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203211527.71181-1-jkacur@redhat.com>
References: <20230203211527.71181-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

python-dmidecode can generate incorrect xml,
namely Attribute unit redefined

Although useful, the dmidecode is not critical to rteval reporting.

Therefore catch this, and first see if we can at least query the bios.
If that works report the bios instead of all, and if that
doesn't work, just continue without the dmidecode report.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/dmi.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/rteval/sysinfo/dmi.py b/rteval/sysinfo/dmi.py
index 83f347623b58..89a7faae06b1 100644
--- a/rteval/sysinfo/dmi.py
+++ b/rteval/sysinfo/dmi.py
@@ -79,6 +79,7 @@ class DMIinfo:
 
     def __init__(self, logger=None):
         self.__version = '0.6'
+        self._log = logger
 
         if not dmidecode_avail:
             logger.log(Log.DEBUG, "DMI info unavailable, ignoring DMI tables")
@@ -115,7 +116,18 @@ class DMIinfo:
             rep_n.newProp("not_available", "1")
         else:
             self.__dmixml.SetResultType(dmidecode.DMIXML_DOC)
-            dmiqry = xmlout.convert_libxml2_to_lxml_doc(self.__dmixml.QuerySection('all'))
+            try:
+                dmiqry = xmlout.convert_libxml2_to_lxml_doc(self.__dmixml.QuerySection('all'))
+            except Exception as ex1:
+                self._log.log(Log.DEBUG, f'** EXCEPTION {str(ex1)}, will query BIOS only')
+                try:
+                    # If we can't query 'all', at least query 'bios'
+                    dmiqry = xmlout.convert_libxml2_to_lxml_doc(self.__dmixml.QuerySection('bios'))
+                except Exception as ex2:
+                    rep_n.addContent("No DMI tables available")
+                    rep_n.newProp("not_available", "1")
+                    self._log.log(Log.DEBUG, f'** EXCEPTION {str(ex2)}, dmi info will not be reported')
+                    return rep_n
             resdoc = self.__xsltparser(dmiqry)
             dmi_n = xmlout.convert_lxml_to_libxml2_nodes(resdoc.getroot())
             rep_n.addChild(dmi_n)
-- 
2.39.0

