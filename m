Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D01C61DA4
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Feb 2023 19:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjBBTah (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjBBTag (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Feb 2023 14:30:36 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C63872648
        for <linux-rt-users@vger.kernel.org>; Thu,  2 Feb 2023 11:30:34 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h24so3177674qtr.0
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Feb 2023 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0iP6afBDN4T/ht7ZpW8qumj6sOGS6b7+CnVoVLfEcjQ=;
        b=gsFbldKu1IswV86j8PaD/PsnRNEROAy366vlam3+oKroz7jUTgfmhh0LRQyAcBbL64
         p/Je25MtvjVwwTm1JFN1TUhXKSGfQkNvBF6uPux/W/Gp1+fYtifc5lV9dpCgoNswCBOC
         w/fWb15Ti2cNBtwPePFd6008YUOc7MmhQiHH0xT6UqKNlV4eNtzcfd4iqVl1eLDXpk5H
         KmW6kACYoLrtgZRn5gRsNo46VKOijSYtkhPAxHID9GYRgRFfcihkQCpmQ3ojMjpO3AaQ
         k6GE6cXI/527DqvhTWVDz+saZlofJvHhCNjIW7cabn15sVgFUARjsqx6u49Iyg8n4L/Z
         qj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iP6afBDN4T/ht7ZpW8qumj6sOGS6b7+CnVoVLfEcjQ=;
        b=7gDNH8PPO1fmsH+i64GY3oaJrj5ujhzFmMo/o8OF15Dh2/UCqSD948VUiEi87SYMen
         F+3ukkqAy+RlrLYQYNfUWcrL6JwrfjvU/PGnLtIOQz3nlqGEmGZB78tUb68jKoFG65O5
         Yhu+iVdf/IyaRYEtLQ44hHX1NSkrKvVhgyppwwlmEHw+1xxHvNIfx7pP4teOIZ7ihqy6
         M7Y9xaucga9/07SJYJWeexJLM4JX4+0e/WUWFatzHvFHW6Sh4JNmoIp8RGZCuHN6lcXq
         ZXWyA7f7Yk+TpSEUY4VWTvFuQ4u5o+9qgiOhlpPKgscIsw9PGh2vKTLmyqtQ367qO977
         8NkA==
X-Gm-Message-State: AO0yUKWmzqUq3gOy5coLIVftKtP4aqftk16/ScQQCkpqIFe4ugiw92ZV
        wfFlbv82BTH0Q0TkU1V4yspz5uIeYRQ=
X-Google-Smtp-Source: AK7set/zIQSvnnPg8HGRKdy7XJd0/s9CQphk/lZhD0hsRZ2qz/AIRC5xTOxLuXher0bOvEFvws69yA==
X-Received: by 2002:ac8:5dcd:0:b0:3b8:5057:3776 with SMTP id e13-20020ac85dcd000000b003b850573776mr13886767qtx.13.1675366232697;
        Thu, 02 Feb 2023 11:30:32 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b003b63b8df24asm147337qtb.36.2023.02.02.11.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:30:32 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Catch failures in python-dmidecode
Date:   Thu,  2 Feb 2023 14:29:57 -0500
Message-Id: <20230202192957.57022-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

python-dmidecode can generate incorrect xml,
namely Attribute unit redefined

Although useful, the dmidecode is not critical to rteval reporting.

Therefore catch this, and first see if we can at least query the bios.
If that works report the bios instead off all, and if that
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

