Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0C6C61DA3
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Feb 2023 19:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjBUT7S (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Feb 2023 14:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjBUT7I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Feb 2023 14:59:08 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C287ECF
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 11:59:07 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h19so2816492qtk.7
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18Nb3voZt40snAS0ir9baegCbM8+ROn/8qsmHrSzbU0=;
        b=g1YiyJcK5J/p+CFQ6LLO2R0eqWZlvYNDO0NHf6pKWhG9Lz5KlVeX9Y5iqDCSn6Wbjp
         P5AgqYIe1z+wwpsRIKMNbyorsdYpmgFVRmuI4uH0KfZ0d58XRQUH6/jBk7a/RG+24nue
         r0nvG+wj4xf3zU533Qo1qtH4JnhZgy+uwCm/Iy5nzbWtxrOkCHPFSAPUtfw+t0mhFEvE
         aLrtjl+lXPCSWY+0KzyFQhoHJ1xoUcH9E4qeRx/Fe3USijHZ9quGHZ3eXs7lH184CiFp
         MKRB0tn+Fk1c+RAerli4QTzwu9Wk0llI/PSGoJ834XCl+L0bzlxTj48/tnCuwfDB9Mdz
         6oMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=18Nb3voZt40snAS0ir9baegCbM8+ROn/8qsmHrSzbU0=;
        b=YbVic4axe9IDsE3+/j+jMTuS3V6JOzlDnHCK9+U9DSA68jkcHG5sbSQpJq1uAzWOCm
         ATRSne/DldxbdRLWJ+ZrOC/UEvgqkXNDwDMwiaxDFtyN7Nww8LMJDrV6CWECeZFMpMvv
         GHhR9PthJbZy8IoEnIdv8cYh3GaOpawV6wqIwAwDyQfw2UcKH32FGlklzZPx+hk2W6rQ
         WdT29Sh08tDcxqkmHG+SAt/3NQ8UxFrexkwo2qH7ZxvWwgiajTD35rdYQL2/ot0fG28v
         0DjLSWDg+693J0H315zp7WUijGPTmux2CRpw1L5K1jy8meT+qoPCmoWfp4Y4vBT3faTp
         Om9Q==
X-Gm-Message-State: AO0yUKUOQOLHKdm38qfv1ItIlkaXEV1ATt69jU1OcqYLjn/KWimErloo
        RCPuiIV86Xa2Q4i246xyGr0kGyGMtL0=
X-Google-Smtp-Source: AK7set9mlsWakFJ193+yfwWoYjK6qD8RoT+VswQv0EoGKwllnGux4Q27zJvyIxCZNjbB5svOeK+AGw==
X-Received: by 2002:a05:622a:1cd:b0:3bf:a3fc:c70a with SMTP id t13-20020a05622a01cd00b003bfa3fcc70amr5925433qtw.28.1677009545654;
        Tue, 21 Feb 2023 11:59:05 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id r21-20020a37a815000000b00742301f1bfbsm758934qke.45.2023.02.21.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:59:04 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 12/14] rteval: Use sysconfig instead of deprecated distutils
Date:   Tue, 21 Feb 2023 14:58:26 -0500
Message-Id: <20230221195828.17919-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221195828.17919-1-jkacur@redhat.com>
References: <20230221195828.17919-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use sysconfig instead of deprecated distutils to add the
rteval directory to the module search path.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/__init__.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index d8127425febe..a245ef935568 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -37,7 +37,7 @@ import sys
 import threading
 import time
 from datetime import datetime
-from distutils import sysconfig
+import sysconfig
 from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules, MeasurementProfile
 from rteval.rtevalReport import rtevalReport
@@ -99,7 +99,12 @@ class RtEval(rtevalReport):
             raise RuntimeError(f"can't find XSL template ({self.__rtevcfg.xslt_report})!")
 
         # Add rteval directory into module search path
-        sys.path.insert(0, f'{sysconfig.get_python_lib()}/rteval')
+        scheme = 'rpm_prefix'
+        if scheme not in sysconfig.get_scheme_names():
+            scheme = 'posix_prefix'
+        pypath = f"{sysconfig.get_path('platlib', scheme)}/rteval"
+        sys.path.insert(0, pypath)
+        self.__logger.log(Log.DEBUG, f"Adding {pypath} to search path")
 
         # Initialise the report module
         rtevalReport.__init__(self, self.__version,
-- 
2.39.1

