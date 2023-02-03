Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D5FC05027
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Feb 2023 21:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjBCVQB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjBCVPs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2023 16:15:48 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C6A702A
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Feb 2023 13:15:37 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id m12so7046219qth.4
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Feb 2023 13:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=274VLyemMF45k4do6pGazU4MeQ8NbrpshgUgH5GAyPo=;
        b=lN+Qt5s0IK6iwSkwNP/jrUiHFz8y8LXKI3vPAV7ebtQjFCZSGlW//ZkxDWRm8Fhg3y
         8yj3xjfCAAOTd9q9Ji5teHyhHi0L2KypqogcJEaemPBmGwaU3fJVyDOZbOZq9R2CP4Qm
         hQ6MJZKQPU/6Y24Bp2VwYOsBxff5BLUL67UvrNqRoBxFPxTnHX6GeZYo1FRvgcclJUTH
         V703mp6r726sAX6X1DH/npYy0ZLsrab163HGZH24GloORNC1c6q4tB8eSf63R9R+QVvn
         iEsbt5Qbv9Lyg5uh6s0A/hpnN2Mg3xEd0FZktzyKRFQr4oxUHPAfxWzjX7JZXzZiv436
         1BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=274VLyemMF45k4do6pGazU4MeQ8NbrpshgUgH5GAyPo=;
        b=z1yfGtSQ8t7IHfuFqNy6BJJO39mGGYlAMyjoWEh/52poF0+fs3zETcSlbQBFkSLIrn
         85Ur2eBRpTo/lb5SwhPdOnvonA6UiXWXPc7Xbf9k1xFOPAIbg1HPi1pRLfevRYBOg9T1
         sZT2M+Jum/1BVRGF01mgORSlxIFqCBlrdbqHzdF8jHh+B9fE8i0JkKMtR/4n9aAJRba6
         OrjWj5NlAgG+ivtverwiFSP3i57CUfbQu898OOZhd1muPSYP1L0QelILSlDEeH/wFROh
         SCnaQmSJw+16DOMjyN5ekiHbBXoSTZ80wmc7Jy840/CQ9CHeoQSG35ypCWxkmE4ds52q
         e+pw==
X-Gm-Message-State: AO0yUKU7dooYa0TAaHTQKZxPhL/ppyQChKxj9pvKzDayOqz2/i3gU5Uf
        o6ZPuxYVwvU0WkaGQUaFp/4kGAslRSU=
X-Google-Smtp-Source: AK7set/xa42Srjukq/ByJlIBhnHZ6iCEV4A8YbW1ZYVdTWUhxL5+YL5KYkn1pOQMoqaobeB1lm736w==
X-Received: by 2002:a05:622a:15d1:b0:3ad:202f:8797 with SMTP id d17-20020a05622a15d100b003ad202f8797mr22573969qty.9.1675458936313;
        Fri, 03 Feb 2023 13:15:36 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id br15-20020a05620a460f00b00706bc44fda8sm2531004qkb.79.2023.02.03.13.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:15:35 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/8] rteval: rtevalReport.py: Convert regular strings to f-strings
Date:   Fri,  3 Feb 2023 16:15:21 -0500
Message-Id: <20230203211527.71181-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203211527.71181-1-jkacur@redhat.com>
References: <20230203211527.71181-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Convert regular strings to f-strings in rtevalReport.py

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/rtevalReport.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rteval/rtevalReport.py b/rteval/rtevalReport.py
index fdfaed560cfa..af3e6c9a703b 100644
--- a/rteval/rtevalReport.py
+++ b/rteval/rtevalReport.py
@@ -100,11 +100,11 @@ class rtevalReport:
 
     def _show_report(self, xmlfile, xsltfile):
         '''summarize a previously generated xml file'''
-        print("Loading %s for summarizing" % xmlfile)
+        print(f"Loading {xmlfile} for summarizing")
 
         xsltfullpath = os.path.join(self.__installdir, xsltfile)
         if not os.path.exists(xsltfullpath):
-            raise RuntimeError("can't find XSL template (%s)!" % xsltfullpath)
+            raise RuntimeError(f"can't find XSL template ({xsltfullpath})!")
 
         xmlreport = xmlout.XMLOut('rteval', self.__version)
         xmlreport.LoadReport(xmlfile)
@@ -131,7 +131,7 @@ class rtevalReport:
 
     def _tar_results(self):
         if not os.path.isdir(self.__reportdir):
-            raise RuntimeError("no such directory: %s" % self.__reportdir)
+            raise RuntimeError(f"no such directory: {self.__reportdir}")
 
         dirname = os.path.dirname(self.__reportdir)
         rptdir = os.path.basename(self.__reportdir)
-- 
2.39.0

