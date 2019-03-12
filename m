Return-Path: <SRS0=Dbld=RP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA6AC43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 13:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A203D2075C
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 13:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB31N7Nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfCLNiE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:38:04 -0400
Received: from mail-yw1-f51.google.com ([209.85.161.51]:37879 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNiD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Mar 2019 09:38:03 -0400
Received: by mail-yw1-f51.google.com with SMTP id w66so1372348ywd.4
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Mar 2019 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1QKkfv9YJmkvJXos/3vTF+TvA86H1gHbGnjGtJKF3E=;
        b=YB31N7NzDDyehLwpWNHfB1/y0wy+OyWN1/RsAu+6Lr56NzlyZ4nU5aCEKXXwy3/MXQ
         mxfr52A71Ekl+PrniKjx+iObFznb/JZdLYH8BIzP3R16ORfsvePh5Jot86Q8TWmPveN9
         9vheX2NWkU/e0QGVefADAR8/wQUb3f+MGZ7aFgf1isL2vAZovSNC8YZnTNO2PizCvUV2
         /Ry7+xmga8Mj+RlfPH4ii3/iDvO0gdAje9Q6VvhU5dtxVuiVU9JQ0qOnLra7tF67ETs5
         GVXl9P+hg+OW/cRKxX0zHOuuI5dhNMKHc59rGRnkeCBegrnW26Sit4r5+ipqrXlSs+J/
         Z5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1QKkfv9YJmkvJXos/3vTF+TvA86H1gHbGnjGtJKF3E=;
        b=YYnoY/JhZOc6S+ZqciUWsDr2EKwF7nnjrspC323bmmemOY0y1UCq2BSihqz0QzuUKi
         nYuSo2EQr12bopD0gRgH5FE/9EpJgLSlZ5uN7HKXqQyvMzw2d/Io+JifzUXxOWPA43d4
         2z6j25Vj5BWrpMJ62rPlMn2aB6UrJLW9pgkMWBngAWfPNEweaheJUepolRngYWnWHH3z
         yKceiAoLfD9+rRw/lSQ+lw2/oCmo0s3D8Qx8xKa6IFe1+ZkBD/grVK9jhGGcaowEs00u
         PMKVwiKIWqGiKtDYBkkgZqGnyVpHKkzV9byAFTp/E9Jcv2y7UpFBiRhGE98b44DVCSlI
         E7KA==
X-Gm-Message-State: APjAAAWHJS9tIeP2mrdsduNvUZrlaMBuHm5pQjC1Aqrl3pPxeTJ5dsZZ
        vWPiim4ePABxSXKk23ceXmj405hIGRI+qJZ+TGyRgJUw
X-Google-Smtp-Source: APXvYqz96KFz9spYxYoW6ZW9mSlCfCZsk72YjsjL8w2YjhEDDFGf98yCGhObLxRA70w/TJugOFfSo98NX5lojDACekM=
X-Received: by 2002:a81:180b:: with SMTP id 11mr28257500ywy.431.1552397883111;
 Tue, 12 Mar 2019 06:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAAh1qtmTVSPfzsGsuxbu3qzAQ9U=3wBCkVFh4DDRjeOA_eqpYA@mail.gmail.com>
 <20190219172156.syot6kfy37dzvrui@linutronix.de>
In-Reply-To: <20190219172156.syot6kfy37dzvrui@linutronix.de>
From:   Yimin Deng <yimin11.deng@gmail.com>
Date:   Tue, 12 Mar 2019 21:37:51 +0800
Message-ID: <CAAh1qt=aLns60J4cP-Y0sBkMEF+0vxQbUu4xWC+9QCjzpZOV=g@mail.gmail.com>
Subject: Re: Help me: deadlock reported in pthread_mutex_lock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

Thank you for your concern!

We also doubt that there's something wrong on the atomic operation or
on cache line consistency on SMP. But it's really hard to confirm or
to debug it because it's difficult to reproduce it.

B.R.
Yimin

> On 2019-02-14 16:09:48 [+0800], Yimin Deng wrote:
> > I could not image a scenario that lead to 3 different values on the
> > same variable mutex->__data.__lock seen in 3 positions.
> > It's very difficult to reproduce this issue (About 1 ~ several months
> > for 1 reproducing). And we failed to reproduce it using small
> > application.
>
> what are the chances that the atomic operations are not so atomic?
>
> > B.R.
> > Yimin
>
> Sebastian
