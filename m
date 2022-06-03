Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F0C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Jun 2022 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbiFCQMh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343661AbiFCQMg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Jun 2022 12:12:36 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995033389C
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Jun 2022 09:12:34 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id j2so5869942qvp.9
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Jun 2022 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZNf63hNMi0f9CJ5Yqp7nwiFopFCL87vgTQ0RBPzS+YM=;
        b=ilbe3NQy0wCmKO5NhX+ZFExAue1gFjWXlDjpiIWaQha8Fjzn50OG4mgb0FeynC2nQm
         6x/jgulcmvxVK8VWFVsR3316vL+AlMnqBJ5mjeUdaajS4mTxqfHa5YO1O7EMX5hZEfVU
         73xXGjqXleGB48vZ3SPsttDAKrerRh3g0DR0YrDi+j4Ry09TyNtugdjua1snprXbZirZ
         yfFZWMWI2wZyjUpkX1wDovA+k37cXOIbRoVDTb06pYTGfu6n72BT/7dMguUiozEKO04Z
         ed8KwtPOsgLq5otf/GqYV3CP6UA5GIKz3+4XMDMqcQ10IIBSqu9DiXqmhc3PBTmMgyYJ
         RYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZNf63hNMi0f9CJ5Yqp7nwiFopFCL87vgTQ0RBPzS+YM=;
        b=gLCHc7Q793FVVL4DmuIiD/tplQTEEZmIf/Axyvkkc476K+tVSBW/9C6zj7Y3iKsdYk
         CBG5z8A+wcOq4u0Rm5JTQ8WmPdUh7VpXhY+FjtbVgWw0UF3wMSs6UPT0fGy8bNY6kr5T
         3VwgwsqgL3ybHUT/oV+HqegutZPhpsxFXoACHq+Z2cS7mx/GWwoXvPVcf/yT9bRhb5k1
         +Cz34L5LIFd8nBnUQ+qWokNbL9NHTYFUk9ZKV6mlOR5+keiQ7oxg8FtZVjZa3e5mUG1b
         cEwtW172i0455LNphSG1nd0RdYcSW5FjWkpBp9g3JW9/QrhR5owwms3FzPcBMUP6FEUM
         X+9w==
X-Gm-Message-State: AOAM530Zz2R4cUuLxsRloNhpr+KPXMS1GzH0/Jy5oW0u/psrGEt2TbIX
        WqW/tZNT3wsHR6d6t5pm8xEBybjXdBU=
X-Google-Smtp-Source: ABdhPJxul0s9U7ZLXkvPdd9jXT2JigsfEN29/JkzxJezIJ+C+w8Wmgm6hsL0rw9SIR7K3B24+4oMQw==
X-Received: by 2002:a05:6214:4013:b0:467:d600:76ea with SMTP id kd19-20020a056214401300b00467d60076eamr4998749qvb.70.1654272753450;
        Fri, 03 Jun 2022 09:12:33 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id n12-20020a05622a11cc00b003022cdcd28bsm5234973qtk.2.2022.06.03.09.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 09:12:33 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/7] rteval: rteval-cmd: Use "with" with open
Date:   Fri,  3 Jun 2022 12:12:18 -0400
Message-Id: <20220603161224.10947-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use "with" for resource allocating operation open

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 2c775ee52f69..4598ba514ddc 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -72,15 +72,13 @@ def summarize(repfile, xslt):
         isarchive = True
 
     # Load the XSLT template
-    xsltfp = open(xslt, "r")
-    xsltdoc = lxml.etree.parse(xsltfp)
-    xsltprs = lxml.etree.XSLT(xsltdoc)
-    xsltfp.close()
+    with open(xslt, "r") as xsltfp:
+        xsltdoc = lxml.etree.parse(xsltfp)
+        xsltprs = lxml.etree.XSLT(xsltdoc)
 
     # Load the summay.xml report - with some simple sanity checks
-    xmlfp = open(summaryfile, "r")
-    xmldoc = lxml.etree.parse(xmlfp)
-    xmlfp.close()
+    with open(summaryfile, "r") as xmlfp:
+        xmldoc = lxml.etree.parse(xmlfp)
 
     if xmldoc.docinfo.root_name != 'rteval':
         raise RuntimeError("The report doesn't seem like a rteval summary report")
-- 
2.36.1

