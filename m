Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713FDC433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298A964E76
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 15:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBVPa6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhBVPaW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 10:30:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C64C06174A
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 07:29:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id r17so3684494ejy.13
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 07:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EYsJCyp8gbYZIFUcOYM4LiKSDgp66Kyz/uHtVoFPgw=;
        b=l/Z9BaS4koR2NvUbG6Y9Cql/8dJmXzLyHzSTK1Slfv4JCXdB84vquaQtWmCCeizDl2
         c5HHYIjWhusNVeK9B6BORWPPoUFwUZveR1zzTd/mqnd6PFDEDFaqOlv4Oqu7Ie1dmh17
         v0TrWmyMm6OZtOWoqSBmCly0T14C9JxnOK8Wq/dr+GnMhFQiyld89gJkmQaMl80tM9i5
         zpfGE8jqHX0mL6zbzcr5RYrJZHz/bz/Iy7+zn937Zs2uSZZ71+sEaKghsr234TJICCKv
         ig6/tFfP+i1wyw2efVXpyZ4fDMDCH4PoXJoVo8n2LrSK5COfLCMRvEzCDiMpRFSdpUM5
         XQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EYsJCyp8gbYZIFUcOYM4LiKSDgp66Kyz/uHtVoFPgw=;
        b=p/mlP+5AdqoT76rP3JlYjJ7oSkGOBeon15Ydyfi7meZDBY8ZPFUbb3V5walnpvgR0I
         2eKE8trQ994qIYaPIY/sHEVo6NuCe621Qt84unYTWSiHEkWc6ZMBE43m20S4EwjwGcMu
         5mveUgLT/77LxFQO4/3Nw3aHiCWwJDgMwdx4byzOdi5C39Oq2khr42NwPY2oRWC8n6u9
         iDVS2szBJXRfscqdb6CFh/oYoAqDrQ2oZOh6KmppT6hTtDc77OI7p+pxlRz8iQDMQb9Y
         DXSXSGO5egXaEEj+wAUyhzf95IGPXiGbAIZKriO8wkXWnP6UMk3n70wLegx6Tbpw5h4j
         shtQ==
X-Gm-Message-State: AOAM532A0PsZI0cs34kOb0N6H+Zz7jQWknQ6oLE0LVRmrTINckdSdE+7
        v3eW4MW0blGCydp7R2r5I8E=
X-Google-Smtp-Source: ABdhPJzgk6d8YLjC57L0BGeZGioP4xowZ1tscHWI1tcD85FmM9x9sPdffoTHmpVIv159KKTSBmcc5w==
X-Received: by 2002:a17:906:28cc:: with SMTP id p12mr21969293ejd.426.1614007778415;
        Mon, 22 Feb 2021 07:29:38 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c04-5000-dab0-26a8-91ef-23f9.c23.pool.telefonica.de. [2a01:c23:6c04:5000:dab0:26a8:91ef:23f9])
        by smtp.gmail.com with ESMTPSA id bw22sm10657116ejb.78.2021.02.22.07.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:29:37 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: rt-tests: cyclictest: Add option to specify main pid affinity
Date:   Mon, 22 Feb 2021 16:28:30 +0100
Message-Id: <20210222152833.8758-1-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.29.2
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


