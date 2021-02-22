Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEAFC433E9
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58BC664E74
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 15:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhBVPbB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhBVPaX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 10:30:23 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476EFC061786
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 07:29:40 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j9so22559604edp.1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTED1TD2aNBo1/6gng2O5bCrbs8xUiBAIl2dI2yKOXE=;
        b=qtR2raZEZw+901QTDAzeJFZz8nLjzRkwDNAdSczAP2C/yEj0oEuauQIjKu4H8C87b+
         /0L9l/niiZ+AxXE5yfFYojWuasrYZx+FYMdwTj/nOhjVjL1zFqfHMPJt3JN9UKyyNip5
         fWuZdLQ70mXJ+K2pLy/7GzX3fD5WdtQIcZM6S9MaoGtgtGFPzxMsEYhc2WH3sOrPgRw9
         XxtUxUxPtuMGaN4rvH3oP/yoB5daaZQ6qmmHc71wEjG6EQkQV8pRHRSaJepJ3tf+bNjs
         w/cjGX3w3zLaBem0bm8i4Nko3+ckux5k8maQUOjWbf2+2aw5BIEBobiFWfM+JdhDU2gw
         B0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTED1TD2aNBo1/6gng2O5bCrbs8xUiBAIl2dI2yKOXE=;
        b=STtou4Nv3i9J5YP5Mt8sQtcw1lCcWjwk/XCpbE1EHIvuZzD2tgNssrLSgQie1X8PZJ
         9lDYZmjULVObUPtGTDf5CIQGwdSNP5KM4THzU3fHFmCYUqiMcSfiFp2+ElZF3NNoQFWF
         MiFFnDOk8AwVNXWmN50xY/vtn1yjSWAV7KCamuy8Vd84A0NcDbBJGLcsCuvsj+vf6S6m
         10fMLpAAAb4m9XOWlWNbir4heL0tYxf58rIWYXt/8fxaK2Ii+PGEl7ItPtC+OkiKMRRx
         m4D3T/GMdCm2EqPihsVhBJpanqg7u9Ate3jvgpB2vuFjXG5bvgnzFbrTO4sJyXpra3DD
         OENA==
X-Gm-Message-State: AOAM533H3CdqA2ANk0h7nb2pDh3Po74skEgpIBmuo1KH4MIdhVeaIPWc
        kFTuSkczv674kIcxY2gkk3YKnHbTPbCs1A==
X-Google-Smtp-Source: ABdhPJxtSUPjqgdS/zv1OLlhQcAnciRD5T3cnZWptbiknRxRZKfKq4+6Q4jq/LQb3V99qZ49yskkNA==
X-Received: by 2002:a50:9d0b:: with SMTP id v11mr23901897ede.308.1614007779026;
        Mon, 22 Feb 2021 07:29:39 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c04-5000-dab0-26a8-91ef-23f9.c23.pool.telefonica.de. [2a01:c23:6c04:5000:dab0:26a8:91ef:23f9])
        by smtp.gmail.com with ESMTPSA id bw22sm10657116ejb.78.2021.02.22.07.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:29:38 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 0/2] rt-tests: cyclictest: Add option to specify main pid affinity
Date:   Mon, 22 Feb 2021 16:28:31 +0100
Message-Id: <20210222152833.8758-2-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210222152833.8758-1-schwenderjonathan@gmail.com>
References: <20210222152833.8758-1-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

This patch adds the option --mainaffinity to specify the affinity of
the main pid. 
This is mainly useful if you want to bind the main thread to a 
different (e.g. housekeeping ) CPU than the measurement threads.

Regards 

Jonathan

Jonathan Schwender (2):
  cyclictest: Move main pid setaffinity handling into a function
  cyclictest: Add --mainaffinity=[CPUSET] option.

 src/cyclictest/cyclictest.c | 39 ++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

-- 
2.29.2

