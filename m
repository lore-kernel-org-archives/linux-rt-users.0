Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A91C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 08:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207872333E
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 08:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgLPIhO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLPIhO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Dec 2020 03:37:14 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B59C061793
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Dec 2020 00:36:34 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id w18so9315215iot.0
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Dec 2020 00:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Fg+dJpAkPzQgfIVtbGH0Jrt0V8MOJDKOUI3BCvh84E=;
        b=RoIVG4t+9k242rFNOT8zttkm7niP4zttGQaicc/NZcY3Aet9uKwICXpFV9Nc1EO0e2
         qNXEYYDclzpfDIminPM3XMM5S1bUmGAwuP9eqUWKeaUhD7H3WEaL91YLmAQ2TcB7bVC8
         x4x255nQm839rnnxjJHFbSCqj8lnkZouMkbbvEboehkYfsRLTG2saMJS6meFnzCozvNk
         2d9pjDWaaQHnKILnPGrU76QNsqA9w9FDy9/ZrowD70n9Sd9iftyLWMRdTJD9liA6ArWb
         wuCX9jv9O2TXHvVvTxM4Kxb1XdQzUMUtZ/j7QNKdoJEGUf/711hlUaEP0uk0I9ljNN/h
         KLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Fg+dJpAkPzQgfIVtbGH0Jrt0V8MOJDKOUI3BCvh84E=;
        b=GD34Iw0Ut5V9oUgRfnd+vVOqL9yvh/PSLYIZC/5OONhnFuFMkR1e9TPLWT1t5/HcJQ
         yHxmxSz+qdAAOmwr4a3X7zxJ96GbZhyLXxFydXymSHhJx0Um0/6gcp6cSaoMxgB8oX2t
         BLuj33s8lzCu2/zTa3ICStSHRjzDDDcODTj0qdwLVB5ok8j8JURgnmAKcB/X0O79snXR
         1U/HzTFsRT1L8oB5/rsnE4VC+ud41WGRfYTFN3hf0Mpfp9QQIe9j6e2udQVL2wUzQfAi
         ft4LWly5Vev9U1EHuzSjxkoTRKtKk4ctKhBJ829LrJd4uTZtn93J+BfM+4dgorMPWzvb
         H3kQ==
X-Gm-Message-State: AOAM533vq6UZU0ztCDiYYeCmpH8IgbW8fsCBaY+SSTmWbvX6BgcBM1Hy
        e6U6PUXK6ZYsQBSV4dLWdNTS2rVdCRb5VraG0AyWgy0d9Y4=
X-Google-Smtp-Source: ABdhPJwYs+lTN7xC/tLacN3FNyB/VXiRoT1BgBtbvl8oAB5g48dzUmdSSTWa3qhkcqXou1jWDSheow5lhDSCA7xCiS0=
X-Received: by 2002:a02:969a:: with SMTP id w26mr41907655jai.96.1608107793780;
 Wed, 16 Dec 2020 00:36:33 -0800 (PST)
MIME-Version: 1.0
References: <2aa26de8-1345-7e46-3628-a97a54e677b5@numalliance.com>
In-Reply-To: <2aa26de8-1345-7e46-3628-a97a54e677b5@numalliance.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 16 Dec 2020 09:36:23 +0100
Message-ID: <CAKXUXMwihDVrw03JehiVSQADtqwXWDNV_CJT+tzudRPHxLBdyQ@mail.gmail.com>
Subject: Re: enabling rt preempt
To:     Stephane ANCELOT <sancelot@numalliance.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Dec 16, 2020 at 9:31 AM Stephane ANCELOT
<sancelot@numalliance.com> wrote:
>
> Hi,
>
> I have downloaded latest LTS kernel 5.4 .
>
> For unknown reasons, I dont understand why I can't enable full rt preempt,
>

Well, PREEMPT_RT is not available on v5.4 without the PREEMPT_RT patch set.

You can check that there is no architecture support for PREEMPT_RT on
the stable kernel. Just look at the Kconfig files defining those
config symbols.

Lukas
