Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63F1C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Nov 2022 19:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiKKTxq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiKKTxn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2022 14:53:43 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D6A1AD84
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:42 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h21so3267962qtu.2
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+hX2NAHggjCz0cUHEdgD/rldk9/dQ+FtNXtmxsK8nE=;
        b=BWxPK8xno9WbXuo1YDoGmq30d0LtI2SOzsLy7BrHBzCz9O9AqI3PNtWGNJbn4+yInE
         Ykc9DfHg5TyxQL3HtgiSSkWMFjLZN8MQvkwnzKITpS8M9YNoPDIDNZqKRhhAzcxWG4Da
         m8o5aMKHkZcnd0WNOsjms93Gfkx8fW9ipzE+t0TnfOzUNOqdUsCNY1r5mXsyuSxYnLwU
         Yn9FunbRugYY8JMDyJgFFvAMNqTA+36UQ7DaVn2LkWiMaptgEQrgycVR5qdYOJY4BoHu
         xy6NXnIflZxvml73UL0fsIuNX/KXGuVOz3QLVpvBzV598Iz3xQ222o5tvFLwO4G6Lx58
         alJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n+hX2NAHggjCz0cUHEdgD/rldk9/dQ+FtNXtmxsK8nE=;
        b=xvhVU2eLeFeFrjg1+EJrVDZAAimPDl2FCL7z/IG1H3s73X9W1PW0pzLh4Es9H9+3wa
         5tTWYocyDcNnUvrqXHC37LJCL4IJ1UGuWAMkuBeU2ZdiLHuNDAjIrDlZBKfACndTbu3Y
         HN3Qd8Epzgh66cdavDiXogoUTNy8OcIXHTFTGgv2vTwLguXvZYAjXu1I2wD6RaVwnXDG
         OWewh5mlZ/OalHavzilvJMG616BmkCrsPb62WjXguOV+oQSU3xQ3U3ajiy4Ms/MMuC6s
         0tCJq4W2dY3qQEZMCcoS7Y7M+zsMmIHRoWSIrwss7IEcsdzj1hqoXaBLsaPog/QHxLi9
         v8zg==
X-Gm-Message-State: ANoB5pn8dd33vGhir8Gil1OzH2qF/0UkLeZrKG0d8M3QtRHKWdM/uYBQ
        5lyxZnr3vx7sgrqdkODCVVtS4Qo0Ov8=
X-Google-Smtp-Source: AA0mqf4ckHzM7h11UQc4UdSAsjI/QaON2DhllX8s9KmG7w9bgKE0G3q8DsInIFsWoGb3UTnjE3t8EA==
X-Received: by 2002:ac8:682:0:b0:3a5:451d:2ca6 with SMTP id f2-20020ac80682000000b003a5451d2ca6mr2896103qth.88.1668196421115;
        Fri, 11 Nov 2022 11:53:41 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id i17-20020ac85c11000000b00397e97baa96sm1794332qti.0.2022.11.11.11.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:53:40 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/8] rt-tests: rt_numa.h: Remove unused paramter max_cpus
Date:   Fri, 11 Nov 2022 14:53:20 -0500
Message-Id: <20221111195323.27402-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111195323.27402-1-jkacur@redhat.com>
References: <20221111195323.27402-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove unused parameter max_cpus.
Note it doesn't appear that this function is currently being called

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/rt_numa.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 03f060e144ce..59f63ae27e10 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -72,8 +72,7 @@ static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
 	return numa_bitmask_isbitset(mask,i);
 }
 
-static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
-	int max_cpus)
+static inline struct bitmask* rt_numa_parse_cpustring(const char* s)
 {
 	return numa_parse_cpustring_all(s);
 }
-- 
2.38.1

