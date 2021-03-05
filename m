Return-Path: <SRS0=Pnk0=ID=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8608CC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 15:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F166508D
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 15:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhCEPwT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhCEPvr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 10:51:47 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E08C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Mar 2021 07:51:47 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id l132so2381815qke.7
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Mar 2021 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=CDvc+mJFnqZheBhm1ocwZ6kKKsB94cmhBvm+GqJIuss=;
        b=kqKfwkZb+LcK2H4qZdgCImM6w7uFAW0gFAerptABAMzeELQpM/nTTVwWqEOTZfAJzj
         1U8W5a4jKyt+vLz1X334qLKpbVTYUkeqRWZao9slZc2eKBUMdtbxx69CF2KxqzAXhiui
         zycsUwWxvWvL4CP2/cMBiXYiJYuHGZJUFyXvHlNfcHp/yQ/nYko3yK3fT/2XL79eYvD9
         UxOv76agvmmQftKngAO1aYo5U+QFW/J14Ib1aR9BLG/d5TtyjqbaOdiBB/B7PhBn//F0
         aEalAMVyPggXQOwekArF1GTpqA0BA1Lyvz9RrzeCJ0JI8l11U4SDC2ZDyuzgux3NEBuz
         H63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=CDvc+mJFnqZheBhm1ocwZ6kKKsB94cmhBvm+GqJIuss=;
        b=HND8L33g0CdDTMXmZKm098BpFNFBfi2gdzGRxRprUyJS7Z9aMZtHvVmLAqZFxqQt8s
         o7uQJGWCV/tPEFqc4N66JQEUi2jqv/Bp6bYN30psYF52lu6Ct4cBp2GYx8CIkQTeThUE
         HocUUcGB8fMc70RqdGNI1mVMz9BtRxFIlY3J3S5+LfppHcALiuV70texhJqA2D0oDCWb
         ygYdVKAna0qJ3DpeA/afxkFNmiw3drUl7MK7auyl8XgcqSxfnRUDyixX9YKXcYKwP92s
         u8j87gVQc1+XGtTnrCrpBpHigLbzWEiFHOVpXYAdOgIg+BgvMxcHpqT/cy5/Hh7HQFNd
         bl2g==
X-Gm-Message-State: AOAM531m6IN/JGYgpGkL/DBL0ClxlU7VYkktkTK9SCUqMno4ar3jnIxv
        3nqcaPAEeBfZcFwFl9RM4cw=
X-Google-Smtp-Source: ABdhPJy99ZqjIQclrHvvUWxCYlHRcJ+onq7hkB8W3BKspCzEfCgMUeINTVb2PpLNZdq5amHWfrE9xw==
X-Received: by 2002:a37:424e:: with SMTP id p75mr9550624qka.341.1614959506167;
        Fri, 05 Mar 2021 07:51:46 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id z7sm1984464qkf.136.2021.03.05.07.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:51:45 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 5 Mar 2021 10:51:45 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 00/14] JSON cleanups and more tests updated
In-Reply-To: <a9461cb8-95ba-e603-beae-586b16a1f4d1@suse.de>
Message-ID: <71dcd39a-7361-852f-c711-d5f62dd12d77@redhat.com>
References: <20210305073500.17926-1-dwagner@suse.de> <20210305074138.lobxlbt7sirtj7lb@beryllium.lan> <bc668ca5-2f1b-fc36-4aa6-36917d0b6a@redhat.com> <a9461cb8-95ba-e603-beae-586b16a1f4d1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 5 Mar 2021, Daniel Wagner wrote:

> On 05.03.21 16:29, John Kacur wrote:
> > How about --json ?
> > Description, "Optionally output final results to FILENAME in JSON format"
> 
> Ah, that reminds me why I opted for output initially. We had the discussion to
> support different output formats. But if we just stick with JSON, --json is
> way better.
> 
> What about finishing this series first and then I send the output -> json
> cleanup?
> 
> 

Fair enough.

John
