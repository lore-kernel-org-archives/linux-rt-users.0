Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00842C433F5
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 Oct 2021 15:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8DF60F8F
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 Oct 2021 15:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhJPPFU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 16 Oct 2021 11:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhJPPFS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 16 Oct 2021 11:05:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F3C061570
        for <linux-rt-users@vger.kernel.org>; Sat, 16 Oct 2021 08:03:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g2so4686069wme.4
        for <linux-rt-users@vger.kernel.org>; Sat, 16 Oct 2021 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ogf920N2mhNwTYchyl7jfXuQCZlefhHheWTjP87vtY8=;
        b=F4Yg2QokuCshYVrM4NRYnGok8FFNuFRDAEPRJOvW29EY5NzuDuPgzMlesOELk3F892
         cQuqqJmAaiEQ5SEbaAZrMpTlWsxmCd7KGhDKPZyzF7/6DZrzFlm2Bg0WLAzzyNnr8AIl
         A2wpTmx6JLjKgmbKwewINfEnKr/WgnmuGEtHld7CfCfgyh3KPcWfXlcDN5wLIOJLmM/2
         6w9Qdy5q3dmBZH1R/kt6KuOkAJcQJUYezhRAcYcDAYKHDB+bz6NU6S0SNM04umlnbhje
         3OxsHGh8Qnh22B61ND35ocJgWaCmAkh+MIs//Rp3dhjIKg4MjrV3dx5Owg5SlFGWfmwD
         nmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ogf920N2mhNwTYchyl7jfXuQCZlefhHheWTjP87vtY8=;
        b=RjL5TRxP/TQF0UTBoX3zXfAzR3dgEPqwjJcYxVAcEe2t0lu8ztWvXdmVtdDRSB14Uj
         mD9oaU9uKzoXBGPwC9x5VXqPrvi5ocCWKuzLvD0wrWBhHqV9icRwB6Ym6mSR9DdE2Ev8
         49sYb7A4fKi16jrk2uChc5VUH86m3OnO46IuXC3elaJyFwAhONLTwxSx7ZIp0kyOx5Fs
         0QWFn2cUfyjQbIzb9hs+KUrxD61OGG4UPOfNMFIT8GseRRYLTNaJJn6rb8rDMIJTjYYl
         OIu2Fl3snmWP8sSMRcCZJkfYuYrkhiA6TNeasj18+st0GljFAVb/GDfn2wiYX7CaTOsy
         1ZqA==
X-Gm-Message-State: AOAM533yRGdaFok7W2tWDl6Oi1FEUod3KlY7wID0qp6xJO8VNY9N8Qkm
        5nweBu89b6JdrIJ1xJRlKTmNvYQblieSRIhSk5R9/UKMKjo=
X-Google-Smtp-Source: ABdhPJya0U6ZKGCm49OrDQNsoGf+2qoWh9iJBmKSCGN3EP5DL5DYcr8iKMBnAoNSZHSO9npSet0yxT5KsPB7p4HPXCk=
X-Received: by 2002:a05:600c:2041:: with SMTP id p1mr19293936wmg.145.1634396587980;
 Sat, 16 Oct 2021 08:03:07 -0700 (PDT)
MIME-Version: 1.0
From:   Joseph Salisbury <josephtsalisbury@gmail.com>
Date:   Sat, 16 Oct 2021 11:03:03 -0400
Message-ID: <CAGHUO11bZYViip313Kid+yRyvF9pRU6ktuaqJB7XO=VFcHu_xQ@mail.gmail.com>
Subject: Question About Patch Set Tracking
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

I am studying the preempt_rt patch set, and hope to contribute once I
learn more.

I have a question regarding the series file, which appears to document
the patches.  Each section in the series file appears to have a title.
Is there a decoder ring or something similar to understand what the
section titles mean?  For example, '# Applied upstream' is pretty
obvious, and can be confirmed by looking at the mainline tree.
However, I see sections such as '# Posted an applied', '#Posted', '#
Post', etc.  How can one understand the meaning of these titles?

The best way to learn may be to write some documentation about the
patch set.  I will search the wiki for some hints on activities in
that regard.

Thanks,

Joe
