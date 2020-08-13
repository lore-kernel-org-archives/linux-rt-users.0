Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5A0C433E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 09:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C294F205CB
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 09:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyRok1sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHMJKb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMJKb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Aug 2020 05:10:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE03C061757
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Aug 2020 02:10:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f18so5927950wmc.0
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Aug 2020 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:user-agent:mime-version;
        bh=X82xs8KxYvqhcjj16s6NgfhxdLnV2Zt12aboTgwJfPc=;
        b=PyRok1skmbsJadF9L2MGmEzDnMfuNCu9++O5uhQqoEQI9FVUTHDwG3II46YGFipPDY
         UYYDvXNDg7za6Fn5ZLIkZe806VNd4kjtXeB7n/t7tRqi17ifxsZAiYr6SNleWyVn4gA2
         Hfcm4r3TtNGyuprlfcohzHnbUQaod1x8RCjOzGPh/C17HbHL/sEBWiytf46vIUw3LSPm
         yRS1u9kut+O04v1hRKorc+2TrIeiTRQ3dTtpVRvTeVEF6UG3MBLx6MfbjbTI//G3sVAr
         kc/jYknV/W1X8nIm2p+Xm865O4ow2U0/TzuPF0UwdzcyOo4sjgb8M0XI9uXJWTMX3dI9
         p6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:user-agent
         :mime-version;
        bh=X82xs8KxYvqhcjj16s6NgfhxdLnV2Zt12aboTgwJfPc=;
        b=eB64A+klb7xKtQDF0RqgLMgcZycrPR4WkR2gfqu6XyReqQ1Ubps8KSbVhIUOapPyE2
         inprO5PDrEDKLoaHtlVSV9LPPgp/UUELuKyDtsf0zE5pODOSSEp2b9KUisC/iVwRO9lW
         /gbEK0C9S+hLKUSzo5VvrFv0Ig0wnef/YR8EpqXj1rJAgVvre6S/bjNUn+hR8nUiiC+v
         sOUHShIRj+pvTZAlNDWt5joEYgo2beE00ZXKenJ4vzXBwa+whhkvkn4tEEJnH0KBNykf
         5SmXs6BjZ2V5IvFpcSy8yILWMYjsF3rQj8VkyoZSvr2nODf7IGutXnkJESF7QttGXrAP
         G4SA==
X-Gm-Message-State: AOAM530FjQetKutvgaLZoQd+xVk4TsZX69I0a+Yqd0wq7XVd3ftMTZe6
        SjFL6nWOs1twHKfz8ru65jU1c21p
X-Google-Smtp-Source: ABdhPJwIiZb56d8V1Lp1YluATXCY8/gZcmhVkjSBZFiE+X2VgFnN0IeRVBuCQQSpAyq2jr3AovlFww==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr3262631wme.45.1597309828885;
        Thu, 13 Aug 2020 02:10:28 -0700 (PDT)
Received: from felia ([2001:16b8:2dab:1900:6ca0:fcf0:36d4:3808])
        by smtp.gmail.com with ESMTPSA id v12sm9226724wri.47.2020.08.13.02.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 02:10:28 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Thu, 13 Aug 2020 11:10:21 +0200 (CEST)
X-X-Sender: lukas@felia
To:     linux-rt-users@vger.kernel.org, rt-admin@linuxfoundation.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Updates to the Real-time Linux wiki
Message-ID: <alpine.DEB.2.21.2008131106310.30199@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1615274203-1597309828=:30199"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1615274203-1597309828=:30199
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT

Dear all, 


after reading the recent LWN.net article on local locks, I have just 
quickly updated the Real-time Linux wiki page:

1. Adding a short blog post referring to the LWN.net article.

====== LWN.net: Local locks in the kernel ======

Marta Rybczyñska summarizes the Real-time Linux Project's work on making 
the locking APIs carry more semantic information, and hence allow the 
underlying kernel execution to be safe when being more flexible, e.g., 
allow more kinds of preemption, in the LWN.net article 
[[https://lwn.net/Articles/828477/|Local locks in the kernel]]. This 
article shows nicely the needs and challenges on reworking the kernel's 
core API "just to make Linux real-time, but done right". Initially 
motivated by the needs for real-time systems, the locking API in the 
kernel has improved in clarity for the overall kernel community, i.e., all 
kernel developers and users.

2. Adding some reference to the Linux Plumbers Real-Time MC on the events 
section.


So, just some minor things to keep the page up to recent events.

If there are any objections, let me know or simply edit or revert my 
changes.


Best regards,

Lukas
--8323329-1615274203-1597309828=:30199--
