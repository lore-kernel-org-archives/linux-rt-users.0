Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136B2C43334
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Jun 2022 16:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343666AbiFCQMn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343659AbiFCQMj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Jun 2022 12:12:39 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3B24591
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Jun 2022 09:12:36 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c12so5896889qvr.3
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Jun 2022 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BbwmfuLS0mUDZI+i5hLQoLgqGPHyuFWXNcwgrI4nD8Y=;
        b=NRdRBlMlllJ3ExCbmrdBJWd+lNpAJ7HkeHzaU6NoRcsWYjLJ1LTz3NyZdsHO7/eeb9
         FNPBXgXR78dWB0eT2SDbGiS2E1vX7hCRiBLERQREA225gr9DoJrY9TvK2wJK4CyIhdso
         Rx/f8YxfJFKcKrFGq1Kmz9cJ2V/l6zxmCeywP+yVX7Va90ScBbiOJV07yI+JI4PHqLYt
         7qeeorYBYHpmr0t/vOxAVtTOHKrw3YlQpH6breGkpP9vuxJK4Fm2YRpZYWvusE4ASjrz
         ZJEw6zclfAJVrSqum0tfRcxc8YZBEQupNMibDueXVPTa+zxHGKnmpYQuzjAi6ljlfpcl
         iCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BbwmfuLS0mUDZI+i5hLQoLgqGPHyuFWXNcwgrI4nD8Y=;
        b=j5Defn8Ks6N8QiEK0EfDMhjzSetsLg5eqLzr1A2MWl91+pEZtOoZAeUW8mHNJNCfib
         eyqWcITu4iMTbmKOWcKYriIUXaH2J1AmIzBb/iQKMEo21aCg7Ov2x+siCpzUuOznf+0g
         jNsMmcRQNu9G/Q+ycA8c9LHL1VUeyAulTi9b6gWLArR72mJiUZDrR4A9d4DL5HaCMEwQ
         NMafOlCH+evCXrQTSCQZ1kvjId4F2tN5Dap4Taj5m15P72ke0VKC3uang2/aiPHpnkvR
         mdoHUQX51zhwp1ljw1cGGFRXBj+e2K7LynClDKyAQH2vCRl+RGOW2yo2kpV8s+yyvMS6
         404g==
X-Gm-Message-State: AOAM531K9Y+Lg6s0j4/jkjGa4TiKrpdJxOo1QvTH09d0ZqjBMeBqnRIG
        ejLp87SVcvh1+Eoe/M83ISqhxX+QERA=
X-Google-Smtp-Source: ABdhPJzJwdQwnDFyNozJew+8gI6mbDgvf5ZqJG5C+VaTyFDujOs8cjKN/Xqm1hhLa9sjSbbz6OtZeg==
X-Received: by 2002:ad4:5cab:0:b0:464:643b:1099 with SMTP id q11-20020ad45cab000000b00464643b1099mr14209184qvh.95.1654272755467;
        Fri, 03 Jun 2022 09:12:35 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id n12-20020a05622a11cc00b003022cdcd28bsm5234973qtk.2.2022.06.03.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 09:12:35 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/7] rteval: stressng.py: Remove unnecessary list
Date:   Fri,  3 Jun 2022 12:12:20 -0400
Message-Id: <20220603161224.10947-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603161224.10947-1-jkacur@redhat.com>
References: <20220603161224.10947-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove unnecessary word list around cpus.items()

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/stressng.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index d084814142fb..d0772ce77662 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -69,7 +69,7 @@ class Stressng(CommandLineLoad):
                 cpus[n] = [c for c in cpus[n] if str(c) in expand_cpulist(self.cpulist)]
 
         # remove nodes with no cpus available for running
-        for node, cpu in list(cpus.items()):
+        for node, cpu in cpus.items():
             if not cpu:
                 nodes.remove(node)
                 self._log(Log.DEBUG, "node %s has no available cpus, removing" % node)
-- 
2.36.1

