Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2173CC433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Nov 2022 19:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiKKTxj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKKTxi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2022 14:53:38 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544642D7
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:37 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id w10so3978710qvr.3
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfV/K5pbb8srIg1oakB2Utgm5TSb7xbJxb2URWVUAJE=;
        b=psCbl0SL/TAppVROWehhPQTORsXop99iBSe60HNcT8uVYOcM8GLhMzgY/bJO0HTlsj
         MWryiQ+OvUn4ysxLQXs5G4V/1w6FreqCH3+Suzac4Nhm+xomOsk8IEB9lZkXWN5iIDC8
         +4kLxBdNPVGasxILPBTrpoIudcREtcUFwbebU6fyZzTzl6HrFqeH/m0UOQ7c6r/TEqZT
         dXeBBZt4cGftlwrvYjJ57LKNIMOfzX6VVTeQJoxQdw5NQDtRtD0eo5YKlHD09cgOnBbP
         uKNZ04NvWCdrIGtfUxOBaVLpVgmK/vRlpiOQwum++qI8ZzTTGIZocS1BvmoAjBkqi71W
         09Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfV/K5pbb8srIg1oakB2Utgm5TSb7xbJxb2URWVUAJE=;
        b=FpHOWTp9Go8bpo3FRAbD428xR86OExclB2x+GlU6iHm0cJm44b0lv1Wi85Rtl/bC6S
         r5bM9c3tpoLYUWwPkSKHepffagajUWm2lb2DRbKYm1DlM4/rv89t84M+VUlbYt0hT/at
         rAy6X/QVlCmUHUZBDrsj6+VpbZ+oHQ8CnhnszpRxhZbxzyOjdSkY2JAcXMpoihgQpM65
         TUSUOC61FPul8lrjNDDFg2eYiTewIMs1yeyY3r2u8l5da34lj3a7OX8sxngT+EzRp+xm
         Gi9w3Ctpbv7kgUwcLBlUf92L550hzmJceODV3/2lzhGoj52L/Mmpo7aXKH3ZScoJzoNY
         1MfA==
X-Gm-Message-State: ANoB5plwCj/TiZPTZaVh7+hZ1PNXriBFnAZHmGvR2hFTl8aQypp/vvV+
        JMuRYkfugcLIEkAhdDklOptMzbROsxI=
X-Google-Smtp-Source: AA0mqf4qd79VC4DyUdcK9CjUScQGjrw4p4Et2RU0CyRSQml28F/mdgZ19phKvBmfpLU9do6t2h4RyA==
X-Received: by 2002:a05:6214:5445:b0:4bb:d324:3b0 with SMTP id kz5-20020a056214544500b004bbd32403b0mr3405354qvb.14.1668196415658;
        Fri, 11 Nov 2022 11:53:35 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id i17-20020ac85c11000000b00397e97baa96sm1794332qti.0.2022.11.11.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:53:34 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/8] rt-tests: hackbench: Add error checking to connect and getsockname
Date:   Fri, 11 Nov 2022 14:53:17 -0500
Message-Id: <20221111195323.27402-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111195323.27402-1-jkacur@redhat.com>
References: <20221111195323.27402-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add error checking around the calls connect and getsockname

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hackbench/hackbench.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 18c928480103..8c6d83520e57 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -130,14 +130,16 @@ static int inet_socketpair(int fds[2])
 
 	if (bind(s1, &sin, len) < 0)
 		barf("bind");
-	getsockname(s1, &sin, &len);
+	if (getsockname(s1, &sin, &len) < 0)
+		barf("getsockname");
 	if (listen(s1, 10) < 0)
 		barf("listen");
 	if (ioctl(s2, FIONBIO, &ul) < 0)
 		barf("ioctl");
 	if (ioctl(s1, FIONBIO, &ul) < 0)
 		barf("ioctl");
-	connect(s2, &sin, len);
+	if (connect(s2, &sin, len) < 0)
+		barf("connect");
 	if ((fds[0] = accept(s1, &sin, &len)) < 0)
 		barf("accept");
 	ul = 0;
-- 
2.38.1

