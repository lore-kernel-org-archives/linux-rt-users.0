Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A8CC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Apr 2022 08:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiDSI0J (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Apr 2022 04:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349902AbiDSI0F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Apr 2022 04:26:05 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E43388C
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 01:23:20 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2eafabbc80aso163548467b3.11
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=As2LB6A/X9otvN49tXwK3LHjZM2tY6V874odJ13zkdc=;
        b=nUU8cHs0VUgBWlyJWMYmQfPfcAaoktJ1HEUS4kZs30Pj+j0DniHXOJllSbLS4HtybT
         lwJPgD3geVcT+HFyaGDgoPbKulz5DHBZYbDZQpOp1aYTnKeZoddYGl0Nf+qM1JM9ekfW
         fv+wh9NLUnXuG5QvNXRhRIdz1nd+66p+igBQBPomnNhy/vIRTnnVkEtipl2R1MwGEUJv
         VNPHyUVYdYgZMOUbXsCdjDlxo4Id9Ghov+0kyuCP98rINZmBIchE41JjY5WtYfHKtpXw
         r+rXRfNZboAB0BOjOD5ACZcJhQdnJCgnkkVszBauVKg52hZ0ZsAhnCHaxbA2iuUmnW+o
         KDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=As2LB6A/X9otvN49tXwK3LHjZM2tY6V874odJ13zkdc=;
        b=TUFWcQ3T0icvohS/zwJQFrPDnyWN905CTxePC4d+XcW1n+oYV/tqPc5fKAZhACkN5O
         xBDsU5cLF+FKoD6kjSxwjtxWqVZ0r63heaJGPgu5/ghrcf+pk6k0YS+i/rvhQg7r8Zx/
         XGSwtjPfG8mNM0u15aY3bpmdzB9tO9SzxmAWdGFXIkKbtqmdtXXCnlxXVxdYqK4tB5p3
         RJArwUujpQo7VAYHXuIWyLswEm+GhvTXVYngU5zBHczh6yuq8oW1oVZmfLhJxj4wgkbq
         WYx/WPDALNYZgWnSdLqmVkwbWio/5ETe28/W8WVie+zmv0z7tlBd7w5cHyPWhCuYXOcA
         ehcA==
X-Gm-Message-State: AOAM531TX1Y3PQfJbkHREY5iSG9iKFV440Rq6Y1d93rB3Lggn/NYtn/j
        3hM121PBNka/d5bzyxAs3XZW8unMlquA8EtauJ3i8bhu/6M=
X-Google-Smtp-Source: ABdhPJyLkalY91m+RIn57eLQrF1HlrVlv8ISM/3azDFrM+/qQFnyRRYnwl0PLtr60sbW3/vGSbGXs65mnLPtGDpHDJQ=
X-Received: by 2002:a0d:c583:0:b0:2e6:b1e7:a6b with SMTP id
 h125-20020a0dc583000000b002e6b1e70a6bmr14173614ywd.424.1650356599326; Tue, 19
 Apr 2022 01:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <5c1e1916-6966-f54c-6af5-ad06ac945718@monom.org>
In-Reply-To: <5c1e1916-6966-f54c-6af5-ad06ac945718@monom.org>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 19 Apr 2022 10:23:07 +0200
Message-ID: <CAFLxGvzxBSaqFAMUzBVfAwWdHgARxZP5MaeQXUpWUPV6ypETvA@mail.gmail.com>
Subject: Re: [ANNOUNCE] High altitude realtime workshop 2022 edition
To:     Daniel Wagner <wagi@monom.org>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Apr 19, 2022 at 9:59 AM Daniel Wagner via Xenomai
<xenomai@xenomai.org> wrote:
> What: High altitude realtime workshop 2022 edition
> When: 2020-06-05 to 2020.06.07

Whoops, old date.
10. June to 12. June 2022 it is.
