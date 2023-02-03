Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B1C05027
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Feb 2023 21:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjBCVQF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjBCVP6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2023 16:15:58 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1278C3E094
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Feb 2023 13:15:42 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id jf11so3658062qvb.4
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Feb 2023 13:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbm3UeRZlKObssufKU07+Am1x9iSVkxm/kD5oFGhp0Q=;
        b=ks+Fbxkm7/lGj8HgblM/c6Qn1KbxAgOiwNrDlyEwkYg/5W/Do6ABNAC2UWWi5fB5CA
         JqeO545BDCETgP4GvHQf7yG3hbx/DkRZSzCv1sFZWx+8r8K+TfYbirPZwUowRLHmAjqs
         2qGR5nmL8mnfqga4rUjRLZWZmIy6ApDy0Iikicq5chDhyaUSOd2bvQaQakXljtjPvfXt
         iFr3vWt+dod+xTFY8iMPQwCeyHpSXjAUWTtL5iY2FBF+WcR3J8Dh1UVdhiRd6o9bOyVh
         XvXQXSYqCU0e0vvG0iFaHBmZWblEMgdPA6QK7mTGfBYjf/XeyzAaqXrUXZO9yCVHIjFF
         Li3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sbm3UeRZlKObssufKU07+Am1x9iSVkxm/kD5oFGhp0Q=;
        b=xlR05oTs+XSsfBFsnNQNjpLtjNjCUS1YrfiC8yLiT/r8WYzmc2RctMNigX1UVyOKZE
         s380r7Yab0JxfBNirS+CyTDVxgTdBK66wCvrEIR79jnm9oXvl25cD2Y7XyrYc4TVLK//
         h57vh8zUspBcq2VAHUETGbi1mvqxIaeuRrO+HKSNDbO3Tgx0Imzv7Q/qlDy0oF7vTPy/
         GSl8Totsvoabz0cA+qENOqwiB/gTmU+3hWsRPtGIjGM5f06NL0AqG30JjE4LU1ZOpy9F
         y7biibvZdlbOpFrIYqtboytZxtypM4ybYAbJAv4qXM/ZhRsgdZAYqUz3geZLWJqZ7dx6
         BeWQ==
X-Gm-Message-State: AO0yUKVieGVt6ROqpd0zJzsY4z8tGPLxiy0CWSjk2WsfgkEd/3JmtAHq
        5ZUSihQritj2KoS7izwsrnTUUKwJ61w=
X-Google-Smtp-Source: AK7set999o3u7+ykTooqWVHa6bLXSTzWp7tzqwEUog55AEOBxP21btLrEdlvL+ow4F+RLlPiToYAKw==
X-Received: by 2002:a05:6214:12d0:b0:537:695e:9f13 with SMTP id s16-20020a05621412d000b00537695e9f13mr16853342qvv.34.1675458940553;
        Fri, 03 Feb 2023 13:15:40 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id br15-20020a05620a460f00b00706bc44fda8sm2531004qkb.79.2023.02.03.13.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:15:39 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/8] rteval: xmlout.py: Convert to f-strings where possible
Date:   Fri,  3 Feb 2023 16:15:24 -0500
Message-Id: <20230203211527.71181-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203211527.71181-1-jkacur@redhat.com>
References: <20230203211527.71181-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Convert xmlout.py to f-strings where possible

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/xmlout.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rteval/xmlout.py b/rteval/xmlout.py
index a955fb11c77a..b549cc87a2cc 100644
--- a/rteval/xmlout.py
+++ b/rteval/xmlout.py
@@ -67,7 +67,7 @@ class XMLOut:
 
     def __del__(self):
         if self.level > 0:
-            raise RuntimeError("XMLOut: open blocks at __del__ (last opened '%s')" % self.currtag.name)
+            raise RuntimeError(f"XMLOut: open blocks at __del__ (last opened '{self.currtag.name}')")
         if self.xmldoc is not None:
             self.xmldoc.freeDoc()
 
@@ -131,7 +131,7 @@ class XMLOut:
                     self.__parseToXML(n, v)
                     node.addChild(n)
         else:
-            raise TypeError("unhandled type (%s) for value '%s'" % (type(data), str(data)))
+            raise TypeError(f"unhandled type ({str(type(data))}) for value '{str(data)}'")
 
     def close(self):
         if self.status == 0:
@@ -139,7 +139,7 @@ class XMLOut:
         if self.status == 3:
             raise RuntimeError("XMLOut: XML document already closed")
         if self.level > 0:
-            raise RuntimeError("XMLOut: open blocks at close() (last opened '%s')" % self.currtag.name)
+            raise RuntimeError(f"XMLOut: open blocks at close() (last opened '{self.currtag.name}')")
 
         if self.status == 1: # Only set the root node in the doc on created reports (NewReport called)
             self.xmldoc.setRootElement(self.xmlroot)
@@ -172,7 +172,7 @@ class XMLOut:
         root = self.xmldoc.children
         if root.name != self.roottag:
             self.status = 3
-            raise RuntimeError("XMLOut: Loaded report is not a valid %s XML file" % self.roottag)
+            raise RuntimeError(f"XMLOut: Loaded report is not a valid {self.roottag} XML file")
 
         if validate_version is True:
             ver = root.hasProp('version')
@@ -183,7 +183,7 @@ class XMLOut:
 
             if ver.getContent() != self.version:
                 self.status = 3
-                raise RuntimeError("XMLOut: Loaded report is not of version %s" % self.version)
+                raise RuntimeError(f"XMLOut: Loaded report is not of version {self.version}")
 
         self.status = 2 # Confirm that we have loaded a report from file
 
-- 
2.39.0

