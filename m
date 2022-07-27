Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90784C19F28
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jul 2022 01:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbiG0BNS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 21:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbiG0BNP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 21:13:15 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28DC31DCF
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 18:13:14 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y10so412045ili.3
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 18:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rl78N3ClWjJNgaS5NlvkbfLUJDh/pw5bhKWTh0JtoCg=;
        b=lYzEqMCq+MIiFVjRPnQAIbc8s2clRHpco+V4dQzz8cNLRQZt/5m4Y2VfkaOdpf16/A
         1MQIfagNMi38EBLs0kiwgRuA9a+XlMdZyPPtfa7mpR6aaSOhtpYewxaUvpaULAmYng7Z
         5LM39R9GRln9RuhCjaauO0bS6IALjYagbqSg5Lp51IX8kG8hLCko3V1ZT9KO1ml74N8l
         3D18xrXqiVZvdKG8U4hGOEvGfA4uZ2fSJjgzvXZFaNoQ1f3+JOw3m/SZhaVEMJYxh3PU
         qD9chDfC7mUiG4S/NdUw6g/LPtuP8JEjzVmM4XGDJiT308hFbd1cni1W3xvSi2tkarhL
         dB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rl78N3ClWjJNgaS5NlvkbfLUJDh/pw5bhKWTh0JtoCg=;
        b=cGDrWBlJw2VJRPkDJanyTvs+WQODtHTVMnsUjucBstyU6QfKhGngS7R4yiNILKPVrY
         7WPCunCPEBFrG07/KYQCioB5I8NBBLAg7wpFnBMcrpjdu42QZ3M1ErxSfkiKAbyW1hPW
         c++GVqjd+KABokEPaAKuoCLRgvT3WHSojm5vA2YOhl59ugjau96w2AwtChLPsUbsEbsB
         2wz/GVpzO94c1tGbxVF5TGOjnCIO3sVm9eTvYKDIZOhb9ZYUOBaMVQfb+8l3nzOsYd2i
         wSc4u3Yb5EGxdaqBa5Q3Q2XL3r5Oszc9vLgHd3JtAEEeVBG8Wjvpak5iyyvYqHl0m0Xj
         7bxg==
X-Gm-Message-State: AJIora8hN4SXF6KRbHdUbfLsSzMeOaxih5Bq0hj7P2bvy3AL9jzhCXMC
        lgqKUyDPHDyE08S7aclZa1kM+ZH8aes=
X-Google-Smtp-Source: AGRyM1v1twnIdRfUCjrVu7lkQow+R2RGf4GCZkITXrUON8+oWSyTzVERx5ygVmcsKUcSRfGP+DG1tg==
X-Received: by 2002:a92:d8ce:0:b0:2dd:119c:c69e with SMTP id l14-20020a92d8ce000000b002dd119cc69emr7854322ilo.16.1658884393971;
        Tue, 26 Jul 2022 18:13:13 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id cs11-20020a056638470b00b0033ed273345bsm7317405jab.96.2022.07.26.18.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 18:13:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: cyclictest: Reset cpulist from newly calculated cpus
Date:   Tue, 26 Jul 2022 21:12:02 -0400
Message-Id: <20220727011202.158917-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727011202.158917-1-jkacur@redhat.com>
References: <20220727011202.158917-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

After we recalculate self.__cpus to only include online cpus, we also
need to reset the self.__cpulist which is the collapsed form of the list
that we pass as parameters to cyclictest, otherwise we can potentially
pass an offline cpu as a parameter cyclictest which will then fail

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 9e7f4ba25eab..e235b83b49f7 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -36,7 +36,7 @@ import libxml2
 from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
 from rteval.misc import cpuinfo
-from rteval.systopology import CpuList, SysTopology
+from rteval.systopology import CpuList, SysTopology, collapse_cpulist
 
 expand_cpulist = CpuList.expand_cpulist
 
@@ -220,6 +220,8 @@ class Cyclictest(rtevalModulePrototype):
             self.__cpus = expand_cpulist(self.__cpulist)
             # Only include online cpus
             self.__cpus = CpuList(self.__cpus).cpulist
+            # Reset cpulist from the newly calculated self.__cpus
+            self.__cpulist = collapse_cpulist(self.__cpus)
             self.__cpus = [str(c) for c in self.__cpus]
             self.__sparse = True
         else:
-- 
2.37.1

