Return-Path: <SRS0=hjoW=WL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24B6C3A589
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 13:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C594B2086C
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 13:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej8kfEN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfHONxL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:53:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50802 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbfHONxL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Aug 2019 09:53:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so1356448wml.0
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Aug 2019 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ciOumPGaIphc2+BpzfnYtc5tQpkNO61EBfO7UIgm228=;
        b=ej8kfEN7EvHlTE2bGBooLRrJayo7tNSVKfSrlao1zaIbxqjcWyKJyxuJfPONqD8qFy
         IoSbO+jR53WE9llkzkHZ/6/jUdrgHCpnF16FMYydOzpgyGaKh1faiMXowXQSDx7QsUUX
         iBniERRQ5qTKMtxrqmIw7QN6m1ZtQvOY3/IE9Lh85gDqQ9Q9pjW0pxORaMJhpJML9pMV
         PGw2FzMTwrdQoj0aiydexfFU2LziG7ON2LmBYlCc+LRWUC+dRTVTWRRHPoKKO6fbUhnk
         2J+a0TCf5t03Hp8MnU6fRBs2pLcxhLrIZTLEcEEHNVKnhg1PgA+9c4gmTeU5LRdBmjBn
         fGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ciOumPGaIphc2+BpzfnYtc5tQpkNO61EBfO7UIgm228=;
        b=eYYtYTT2hO4XksimcurmVw9GinRF+cSqnO01tByks8uVt8fe5AJqrrW94XRHTxKo60
         rDLEL8wgXN/tlw6TJbbwzO8wBmkI6wgS2yfj7B5C5YPzclzBstLP7czgj5rN19UtAsRv
         pHVTWkWzAljzvZ2zbBwE2FKptJz6BxIDiF8Sxa3HWfqEiHUFlJqkpaUQKT6mMfMH8eRi
         hkyR7fqu68Q3PforiER8Y3iKSdZub6q8PGRLBxHsR0unBwAm62vSxs3rqG/Xg7YhiSUW
         8yMQkAQg3vFSjnbm5LJkYyf9BJY4nn2ShPnTPN48OMhCtHfh1W8GL319Fd6Bg1nPdAOW
         jMGA==
X-Gm-Message-State: APjAAAVmbxjt3IQSQsSui3Li9rROoOL2sBcn3QKOvxjoYKknYa8a9C8/
        QiRaIZ/sT3q9yBCDCY/b4QOKPnzy6tFuxVkhfuk=
X-Google-Smtp-Source: APXvYqxB5j0GQUu8O/wGu1TE9D6CoFzZjbq070sc+weO6mfetNKskVp9fUeA9auCi08kUpPrxelU7+oOugGbu8LKoRE=
X-Received: by 2002:a7b:c929:: with SMTP id h9mr3069890wml.1.1565877189097;
 Thu, 15 Aug 2019 06:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
 <20190813095306.xqgq3uusdpj7dhy7@linutronix.de> <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
 <20190814112656.z3de2rgbqzpaquz5@linutronix.de> <CAD56B7ezpaONhXCddu6RTE33-iXG7+J=xf417xu_uT-YKPV6RQ@mail.gmail.com>
 <20190815082955.olo3phbqj6disk3q@linutronix.de> <87a7ca4nh6.fsf@linutronix.de>
 <20190815134248.abwbufgwh4zybj4g@linutronix.de>
In-Reply-To: <20190815134248.abwbufgwh4zybj4g@linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Thu, 15 Aug 2019 09:52:56 -0400
Message-ID: <CAD56B7eFQfvq6cWnT6um4M2Y7LAr5tz0=PvpeWM=QfwAU6pFyA@mail.gmail.com>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> > Emergency messages are not involved here. You can see at 84239098us tha=
t
> Right, we don't have that. Let me boot my arm64, print something and
> check how it goes=E2=80=A6
Thanks! Nothing too crazy is happening with printk in my setup. Mostly
I just see systemd messages like this:
[55458.630872] systemd-journald[1072]: Sent WATCHDOG=3D1 notification.
[55578.632076] systemd-journald[1072]: Sent WATCHDOG=3D1 notification.

-Paul
