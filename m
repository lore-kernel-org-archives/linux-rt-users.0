Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B0AC1B087
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 15:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932FF23730
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 15:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgLGPWN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Dec 2020 10:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgLGPWN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Dec 2020 10:22:13 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040D2C0617B0
        for <linux-rt-users@vger.kernel.org>; Mon,  7 Dec 2020 07:21:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d20so18598835lfe.11
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Dec 2020 07:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODpSoEmNbq4jUl3WGrBL/gHgU8LJBlKLzw2q3hitzfk=;
        b=EeF4TpNM5822R8wksasofMeoyAGWabpPMoSiBzdU/Ydxmhe4LTINP0VR/nGQwt7dtm
         2vU6AyNCymAM+ZOq3UuxHO/kRnyq4yjfwo1yh2/VQacut+0XoV/wz9Vrp6e6u6Ccd3B2
         LUwDHXYbCqBUKbu6Nyu0g6+VXnQ9BHEs8wBtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODpSoEmNbq4jUl3WGrBL/gHgU8LJBlKLzw2q3hitzfk=;
        b=cwc3DWCwIIqzEgqLejRdmxS50NrHkuRYVVu/e3JtnbOzn/qoDR35YNt0r6zUCc2qk5
         gJtXE7uTm31v4bkUkvm97a0eTAKPNMdpo+2AmtApJTcL9Cq7LhPZVwjFuJUdnrTIrzR4
         IaDfPbT6EzvO/kKUSLdTpBQQMNtBMmNXP4uZv0gDvUEJvmuyTNmFyGRFB88a/TnhXfE9
         Ty/qvoUFH3L5tYX+e5c72l6zQJo3GKZiB5k1rkkXmRAGmXPoxojqllhwqpdLPJ27w6aX
         Z04lOXOpDVqUQm7CR2NmGQvx5wXgb7OPQilDvrUrwS3EFgl+elSJYqBe6YLYPFWFnNvt
         dtRg==
X-Gm-Message-State: AOAM530TbH3usMyupby747B/s3ubO5DOpTcolp/e5t0drYw3W1J+R+AC
        gJdkCu3VeumStZ2nLg7NyoFMoRrWRB4JpjpP3wbOHw==
X-Google-Smtp-Source: ABdhPJwHEC0oFuYU7tv2dbpbzD3yAaNJNYk53+CAspsxguKOIGKzL9HNaC3UZ29ttjNVccWUmOEKbNHVYH46OCKAx7E=
X-Received: by 2002:a19:8a46:: with SMTP id m67mr8042040lfd.515.1607354491520;
 Mon, 07 Dec 2020 07:21:31 -0800 (PST)
MIME-Version: 1.0
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de> <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
 <20201130145229.mhbkrfuvyctniaxi@linutronix.de> <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
 <20201130160327.ov32m4rapk4h432a@linutronix.de> <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
 <20201202220826.5chy56mbgvrwmg3d@linutronix.de> <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
 <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de> <20201203133934.37aotbdjnd36lrxv@linutronix.de>
 <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de> <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
 <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de> <CAM4kBBL5+xNWq6DWHY6nQjwDTj8PZKem-rGuFvimi7jekjA+Xw@mail.gmail.com>
 <3ec93680c6a27626b23e99d552aa778be7b2ecec.camel@gmx.de>
In-Reply-To: <3ec93680c6a27626b23e99d552aa778be7b2ecec.camel@gmx.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 7 Dec 2020 16:21:20 +0100
Message-ID: <CAM4kBBJ2jqBKdTPWPZEfuc17yiARMr_NwOSoHL_r0eC9n7UpUQ@mail.gmail.com>
Subject: Re: scheduling while atomic in z3fold
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Dec 7, 2020 at 1:34 PM Mike Galbraith <efault@gmx.de> wrote:
>
> On Mon, 2020-12-07 at 12:52 +0100, Vitaly Wool wrote:
> >
> > Thanks. This trace beats me because I don't quite get how this could
> > have happened.
>
> I swear there's a mythical creature loose in there somewhere ;-)
> Everything looks just peachy up to the instant it goes boom, then you
> find in the wreckage that which was most definitely NOT there just a
> few ns ago.
>
> > Hitting write_unlock at line 341 would mean that HANDLES_ORPHANED bit
> > is set but obviously it isn't.
> > Could you please comment out the ".shrink = z3fold_zpool_shrink" line
> > and retry?
>
> Unfortunately, that made zero difference.

Okay, I suggest that you submit the patch that changes read_lock() to
write_lock() in __release_z3fold_page() and I'll ack it then.
I would like to rewrite the code so that write_lock is not necessary
there but I don't want to hold you back and it isn't likely that I'll
complete this today.

Best regards,
   Vitaly
