Return-Path: <SRS0=hjoW=WL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8676FC3A589
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540AA20644
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 15:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAYau75+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfHOPbU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:31:20 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36206 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfHOPbU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Aug 2019 11:31:20 -0400
Received: by mail-wr1-f48.google.com with SMTP id r3so2592997wrt.3
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Aug 2019 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wirHDOg9EOMFe3qTsPFAv3c99OnqdRgUxRzLGwmcTds=;
        b=UAYau75+1amRT6Dx169ZahFAyij7C4S5S8O3Dim39fs+yUHUXbFJ9wcMgqTP5zTUyr
         k2oo4G9hj2Mi05B9q7QIVS+M/NwTPJkaywMDO/0ZwJbTfHuQTl/7XuVUIixC0P/OVlSL
         Ia6h1Xa9xeSr0Wjh5PcD3WYp1DX77JGWfoIvXKd8LkQt3w3xpt70iHkH7KmfHSAlMaXF
         dNjvxoeGYvStiMUFMki1PuGG9kgEE78SrVht61nXjLpJItdsvmHb99WTj53Oe/40H0Gd
         YXiSmigwLxvwAKS4a8MBCzaoibB7+yX5js1uMSSkQHxxSiXGQ2pKLGVjSors0hKTuEXA
         3uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wirHDOg9EOMFe3qTsPFAv3c99OnqdRgUxRzLGwmcTds=;
        b=PKMDz5mpixzVtMSCWgOtPI4fcM99o/ODT8mVil/G6uJRngX5mSfr9L60Cxzxyrx8hJ
         iXAbCURgMsVzjrhv6GE6kkUmddgc6F9WRICQGO9AMjHZeC8L6Y1tdAXiE7bFAs2DzpXS
         8bnzTnRp62eTdsZY8MoJlbH6Xbt0yby9mWQvn8BbiVCvTf0VECL6ZrEVfsJ49PRaleWz
         GOJKc54WQzRSeSaOHRX2eB0Oi2eB7wH3aXouqBk+wHBIeB/ncI6kdwVaaI8S7i8lfRh8
         RXyoZxTtG3cMYHlcA5FnM6EoqNNvVgrSVrAc0JKegMs6g8BOcnVNZIEka1vRS/f7ddwz
         RUdQ==
X-Gm-Message-State: APjAAAWDvJYhO0E0AetY5ST1CESqFUytyvkNt6iPDP9LxGslC8dTLAUC
        VBaNtAT1IXFCadXRWKe3Ljj3wYaPWbokk3ASaDg=
X-Google-Smtp-Source: APXvYqw48VfFsUWN6lkz3IkMOmmse+JwQOOiyGlf+T+ieJGMzP/97odVlaooqDw+wuy1cLdyARiBv9BEMV8qsqAaiLI=
X-Received: by 2002:a5d:5701:: with SMTP id a1mr6117212wrv.95.1565883078184;
 Thu, 15 Aug 2019 08:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
 <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
 <20190814112656.z3de2rgbqzpaquz5@linutronix.de> <CAD56B7ezpaONhXCddu6RTE33-iXG7+J=xf417xu_uT-YKPV6RQ@mail.gmail.com>
 <20190815082955.olo3phbqj6disk3q@linutronix.de> <87a7ca4nh6.fsf@linutronix.de>
 <20190815134248.abwbufgwh4zybj4g@linutronix.de> <CAD56B7eFQfvq6cWnT6um4M2Y7LAr5tz0=PvpeWM=QfwAU6pFyA@mail.gmail.com>
 <20190815141923.yu6obojglb2hjsia@linutronix.de> <CAD56B7d-nCs9am2Dh6LkawjL66V6Hmvw6XuCrzrfqU86csrFoQ@mail.gmail.com>
 <20190815151515.p2tch5qz653h2unm@linutronix.de>
In-Reply-To: <20190815151515.p2tch5qz653h2unm@linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Thu, 15 Aug 2019 11:31:05 -0400
Message-ID: <CAD56B7fO4iFbp8agFyhT4Vogz_y8kRVH9bLB9yeo9-5xw5-Tig@mail.gmail.com>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> That was the previous patch I've sent you.
Ah, I see now I messed up manually applying the first one. I'll retest
that then then apply this and test.

-Paul
