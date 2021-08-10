Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88719C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 07:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4A960F38
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 07:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhHJHoD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhHJHoD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 03:44:03 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE7EC0613D3
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Aug 2021 00:43:41 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e186so2948258ybf.5
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Aug 2021 00:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KcP8IsjH6noOl+ao9BmOG5ewULfkMEWLm/kXyas+RDc=;
        b=PIuibGfI8PdAqjFRX/OYSsDJg/MeiE1bucl/D1+zyG2k7/FZF5d0Fs7iCLp//NJ7QC
         yBYgBxaxhjz9tvwv3zr48AShTugYt78zI8Hw1BtfFP+CDIHGdHPO4mJkdF4YZ1QbVcmM
         SGWh2MOyMieRAhlQ6FvOkEQ0nt1iBqN5iDzL8gu6jls3rm1DM77mxsh5FXHG68RZFgzp
         VVki5oqfLpGdTWH+IxCZccV6szbk8vsxPVkgtFv8OUw5fxayvX9+F/aWOUMwDqY+k5z3
         xpAp+yhMQzIC6zaZw5ZidIVaTD9Et1Q9Ji7BQMPDFD9paL4ToFaXDaOpi9EZlBSSh1n3
         95Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcP8IsjH6noOl+ao9BmOG5ewULfkMEWLm/kXyas+RDc=;
        b=YYpTfvcf6XH5ZldUvt/yHNZR9V78ZhuvlztcFkheCGL7YBczm/zAeomIONpO7Vs+BM
         Mk0sbOUc4LTNh+5A2RY5ITYHhlhcPpDs06tFNkFriwhAA5Mv8ewVsExnn5UadZK9fIES
         3vi9loQhI7899A9dE6KNhifxhdi5+133v3NulumxEGyGXiKPGFKxiqr8gu0uA4yDzi98
         /eKQA/921yefupDrRfQj69PtL4OxCfxAmxVCmKJoV/YD1+6uKW9/+h76/0ObJxNbDZK5
         TaDLaNzrpJqUIY9TNch45e/QxAR6MlM8G46QW7WyHQDDfAV5z/flk6VZTR0124Ak735r
         iEWw==
X-Gm-Message-State: AOAM531hg2o0CzS8jADHwvbdIb9Fehm47zeysoFM44bqASZFmOxeiICj
        pIhG4puYC4Q1G7e9kLlPO7zGP6zjRmgo9POX0Xk=
X-Google-Smtp-Source: ABdhPJz+cU7oHFdtfc+GIxNEXrmBVzoVcLKBbH7vNyKtJgX/bmN95nRoXUR4VcSiPU941zDND0Q4k0dbNqfyxwGoBu8=
X-Received: by 2002:a05:6902:509:: with SMTP id x9mr38883563ybs.267.1628581420755;
 Tue, 10 Aug 2021 00:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAFzL-7sj+Y79UC-CnB+6qDRe7EgPnjb0be63CwEJOfkdCvJYVw@mail.gmail.com>
 <002901d78da6$129f8250$37de86f0$@gmail.com> <CAFhCfDZybPqmWK2=HSTDOBT-hswkqEPUUbs428x8TBsKbLybKg@mail.gmail.com>
In-Reply-To: <CAFhCfDZybPqmWK2=HSTDOBT-hswkqEPUUbs428x8TBsKbLybKg@mail.gmail.com>
From:   Jack Winch <sunt.un.morcov@gmail.com>
Date:   Tue, 10 Aug 2021 08:43:29 +0100
Message-ID: <CAFhCfDZ0GuUaSyx8j8LnruL=zdVO69N5-qkZw0tLErWfRaP_wg@mail.gmail.com>
Subject: Re: hyperthreading and RT latency
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
Cc:     Alison Chaiken <achaiken@aurora.tech>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Also, apologies for top posting, folks.  I thought my email client was
configured differently.  Won't happen again.

Jack
