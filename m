Return-Path: <SRS0=CR0g=CU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E78C43461
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Sep 2020 03:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9C02078D
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Sep 2020 03:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyxKsp/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgIKDuB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKDt7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Sep 2020 23:49:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5FCC061573
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Sep 2020 20:49:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j11so11930332ejk.0
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Sep 2020 20:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:user-agent:mime-version;
        bh=lA6zRtvfaZCLCf5RoNJ3cId/FbUH/OqS8FP3+2LkMx4=;
        b=UyxKsp/GpuLkQJXNldjj333A79vf+6vru8N9AAXuKXC/9jZ1Zyf5oeM/qaB7Qa+wnK
         wrDpzzNryI/hF8FfL+9eJPFxz1Lk+HhABCZ6wOgTnQGw7MthH7bmPgfA3pLRw7qkUE9r
         4vF5frhhHbHn6EJtWXR/OeDaNiMfHK/+98SD4FLF1uRkzxVNLTcONrXZxbaaPzC9nvii
         8gpZd5L+ppuxWLXcddzCgFRDoggbvz2NiweZe/FNc653PLLkbg8V6Ssr5ag8AnOO/IEt
         ZS3R4+WEHe4LoS88WVCmPyvrZ3poZUffKNkmw1p9Xz2/MizNtJauOoPWxEGbb4udt9tL
         o5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:user-agent
         :mime-version;
        bh=lA6zRtvfaZCLCf5RoNJ3cId/FbUH/OqS8FP3+2LkMx4=;
        b=YgeUeAWs/yA7TDb3zVfSz1m1lcNlCTsVOBrN6juURcLpJT29sufaftuF/ITnnL3UVx
         RbBfohgVVg9wGulYFaoqqC7mQdbCyXOZZS22W8YeCR+dHWcMS5Sx6kqe1WBp/MKWJf/0
         shBCbdaz+CWxMYI68Xbb9M+5kWrCQTj1cq/ZNyqpdOUL4Df54L/SsrSqrg205c7kslIy
         MvUJaS0l94XjHBF+MlfDQm7ets2NFNpKLtfuDh+yVSSDZmEzJgT/kZ/f1N/3sjAVxG1P
         hOEJmwmZdj3LY4oEu9Q5aXUVE8J4H+/dCoJ7Bi4w4/UsLKcjmyEAB/m/Z+979+B9U2PC
         dZyw==
X-Gm-Message-State: AOAM530UvikDdt6QiSVJ9pqWhHGVZbvdlyrcCmMIC0yIx2EaqfC5KsEU
        EUosOK/oKYpBai9vZYenaahYNe8IfUYDqQ==
X-Google-Smtp-Source: ABdhPJz/K8e+2FceLUM68j12NGPruKpsQVHi5QBJbBkB3fNhnaRztUAbMZnsG9RCs24CyLx1glVwXg==
X-Received: by 2002:a17:907:20d9:: with SMTP id qq25mr152346ejb.382.1599796196643;
        Thu, 10 Sep 2020 20:49:56 -0700 (PDT)
Received: from felia ([2001:16b8:2dfa:1900:6474:716e:a7ba:8d93])
        by smtp.gmail.com with ESMTPSA id la17sm647405ejb.62.2020.09.10.20.49.55
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 20:49:56 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 11 Sep 2020 05:49:49 +0200 (CEST)
X-X-Sender: lukas@felia
To:     linux-rt-users@vger.kernel.org
Subject: Update to real-time linux wiki
Message-ID: <alpine.DEB.2.21.2009110547240.11224@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear all,

just a quick update, I added a reference to the recent LWN.net article on 
the real-time future in the Real-time Linux wiki:

  https://wiki.linuxfoundation.org/realtime/rtl/blog#lwnnetpreparing_for_the_realtime_future


Best regards,

Lukas
