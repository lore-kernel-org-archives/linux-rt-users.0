Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B5C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 07:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC7A64ED6
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 07:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBVH2G (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 02:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBVH2F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 02:28:05 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D49C061574
        for <linux-rt-users@vger.kernel.org>; Sun, 21 Feb 2021 23:27:24 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id p186so11993727ybg.2
        for <linux-rt-users@vger.kernel.org>; Sun, 21 Feb 2021 23:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rVrBllwKXDPOO33V7vEvomgzdYE636jpZDmwyo3OuR0=;
        b=b9V9Q3OYykmrpG6yjaZhzv1l5fG6fOFXppnv/KxkfbObv8xDP8+RRFIVoIR10SGhV9
         xfA9EZXQNGRmDjlYRTv0pgP7xfJx4JD74KwHv80D4gCNPSk80tDeYQQwixFQ4cSBbuEL
         b+qTunQ9F8kvo/qKeRILKP24hKTt9pIDyjvb3KkJjg37diHVu7kZODxQeDEbrr3sS1E1
         3oRgS+Uh36H8kK6BW9wP7LweM9h6jByxqHoOFmwC1PzKTbcc5Fk6pTbP+oK4J6CHgxGG
         R1nH9XGVVowR9NVnOIBOizQOxTyLwOYD0thRG/xYck4B6NyuZBG4CgAFCHURYkWy9ZEc
         sQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rVrBllwKXDPOO33V7vEvomgzdYE636jpZDmwyo3OuR0=;
        b=o+T7/IUmOeS42CbkGMd9huvjUx6cuBUDuMg2V9Ok7tCYlSyvsOmCaXoHGMDssdmPhf
         Q9UepyiEloiGJqso21kfqk4or66bLuzTWK8qdkmz9DPZgj/gAK2DQ3+l0L5EcDo/Xu3v
         wGj6JMgivcP7S/8tTBLTLjBmrPi/IWBQN2RIpQGMNuLVX0NAG/5cuXXgvuSKZmJlOq+g
         2IRF0bBGknY/V4Xj+FOkXrE9ndDKo7FvqA/OuSeNId4lWegQBbr+hydrEQ3OWTI5fkd6
         4v6FSuFXqhzpH4wZU+VFLuNazvZHVD0fpijptGgXVbWNY3geokdWKh70LQrLvRNUq0QU
         WxDA==
X-Gm-Message-State: AOAM533NLSUPS8lj/aYBs4NyszZ590JQ01Zh7AKYLfJMPOhODpXPPDBg
        w4V/rZX1b6vH0v2E87vPWzcaR3QKvnsZ5i4n655XVyyZxdKqGg==
X-Google-Smtp-Source: ABdhPJy9OJM/yY0Upj0V01D+s2SaW4ELnoe+UKedjxUBYafeBglUnL72EaI6E0DrNAIcB2PLdQvAmVBzBrN7WrEzJAE=
X-Received: by 2002:a25:31c2:: with SMTP id x185mr29726528ybx.93.1613978843890;
 Sun, 21 Feb 2021 23:27:23 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?6bmP6bKy?= <kunpeng0891@gmail.com>
Date:   Mon, 22 Feb 2021 15:27:13 +0800
Message-ID: <CAJa5FiHcaG7EB3eAD17w_6GhZm0yqvD0Ev3DvJAU7meOG6C--g@mail.gmail.com>
Subject: Question about rt-patch use in arm64 kvm host and guest o
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm trying to use rt-ptach in arm64 kvm to improve real-time performance.
I couldn=E2=80=99t find useful information on the web so I think this mail
list is the most appropriate place to ask this question.

Rt-patch can use in arm64 kvm host linux and guest linux ? Where can I
find reference examples?

Thanks

Best,
Kun
