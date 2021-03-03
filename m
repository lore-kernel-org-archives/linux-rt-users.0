Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD49C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810896146D
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355270AbhCDAV5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbhCDAAv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Mar 2021 19:00:51 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01920C061764
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Mar 2021 15:16:28 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 2so9939768qtw.1
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2021 15:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=7hRHHSqBkqLWAq4AKM94iwmbXdYoXlDXX9ItKCiMkG4=;
        b=PaMEKwrrXVvajPTFJ314qU8KjOtU92dMCUp3ChmDGhnvlbVticCGZoPj34Ijd6qcha
         j6I9WgOlizX40BUh3fMVi2SBlCl5u1H6Eghzs9Nb1VTrjdtzmAxHc7d3DNsSjLronP03
         xkFIhFufoUDg0+vrNlJ5BXxPXNMedCrTHp0b+Rf7bw+vmZunalHASzodjFfWB7AXwBCE
         vnbrcVCoMgijo9ubrC3VbbTBcaiH125w/j6dv+CB4oaKgW3vd84G1C0yBQH6qVIHBLCB
         Yb/l0d/PKgjlz+6XXNrFKpxQNCe6rmSY8z5deKJYJdCmxz8UeDm9G82TRLmCSXEEL07b
         AzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=7hRHHSqBkqLWAq4AKM94iwmbXdYoXlDXX9ItKCiMkG4=;
        b=NgWaxO8BLcrvxCmdfbvODXN7gG8ARGssGVspU3PhjErlmTTn94FdDacvN06K7VymbP
         Qt20VtLMNtbQ0JGV7QrxmaioPw5N6/VnIZWPwgi9S48z0VB7Jh5XHvTqy+l7KGmOk9dp
         392JxN8djYfn/EkVnpTvtihEQRmpH5pM6cy/iD7FYXA6T0uYMxAK7UakHoarW+KoILr+
         qdZcFyO69C+L6y7Kss+e4xGf2YiGdjM6DVgeHi3K3zrpOaZPBJKyCZlL3Sm/nL4nwC3Y
         +xlmOFYXYCC6skhjIJDSFyCdUvU8h0zI5Wj+hVhRzkcE08GR4VaecE9bCmGuXuhQdENd
         +iXQ==
X-Gm-Message-State: AOAM531amowVvDYEQxzNjLAjwYLfag6ltvX9hGyQiyZw1fj5RieJUVBF
        gGR8ahYHk+PFDjxnzipKi+b54vnQ0DcrD5XW
X-Google-Smtp-Source: ABdhPJz19QRjRO3PHIOZ5zEaYbHy82tiewgTCMENh5vHdwTMv3prMTglgtNMjENGVW/yjB1/LsDNig==
X-Received: by 2002:ac8:6f55:: with SMTP id n21mr1648690qtv.381.1614813387256;
        Wed, 03 Mar 2021 15:16:27 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id z5sm2505304qkz.2.2021.03.03.15.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 15:16:26 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 3 Mar 2021 18:16:18 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Christian Eggers <ceggers@arri.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] all: Fix printf format errors
In-Reply-To: <20210303072608.stni24hteabncdjw@linutronix.de>
Message-ID: <20bcaff3-a669-c627-867d-27fbd9c4f32@redhat.com>
References: <20210226073802.9406-1-ceggers@arri.de> <ef6ce578-18c2-562a-222-c83d449ccd3@redhat.com> <20210303072608.stni24hteabncdjw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 3 Mar 2021, Sebastian Andrzej Siewior wrote:

> On 2021-03-02 14:58:22 [-0500], John Kacur wrote:
> > Are you seeing a compile time warning on some systems?
> 
> My wild guess would be 32bit systems.

haha, mine too, but is it too much to ask for some better
descriptions in the patches than, "fix printf format errors"?

> 
> > John
> 
> Sebastian
> 
> 
