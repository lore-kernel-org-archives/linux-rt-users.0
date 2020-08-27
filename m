Return-Path: <SRS0=N+eC=CF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2583C433E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Aug 2020 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4E42177B
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Aug 2020 15:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbfRWaTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgH0Puj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgH0Puh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Aug 2020 11:50:37 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00537C061264;
        Thu, 27 Aug 2020 08:50:36 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id g20so1804578uap.8;
        Thu, 27 Aug 2020 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqgQFayVgaKlkaBGtNrK6F+MRvnVjmjaxJyHhjZ7vS8=;
        b=SbfRWaTYDdGMHKXhX7od1Wavmkpg1jfntwNI335+Cg5KMF1c5QjtACDPJP2t7sg3/N
         ZswDOZEqbBrGYKycI0accmJTGZ0cTWczccdaueti0evPm0PCQBkd5q7cYxCPwvs5M+GX
         +5z7Zc12lbuevG/7MSH6/eQXSUNAhssaiVBCmvq2qER2qzSvzUOoGfN58LW24SHSD8W+
         TO3Vy+w47diP733htgFi0RP88xab4Th6b6SnGQ0JATeUk5NNVYYw+PHZJ9zj0LESoAhO
         9OcubkOL/2dN6HpCZSnmvOlIWoSnARhAbQ2z2jiUEfoz5VgEr6dbiaEDnWUcyjYFYL7C
         nrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqgQFayVgaKlkaBGtNrK6F+MRvnVjmjaxJyHhjZ7vS8=;
        b=HgBqQmSuyjdBXSZGdOUitLyzOwEMuGWU4ctwVlJmJ/Nf4dDRh6Sg4m1iXJG2SlXjqR
         eGwdFVIHevIY7Aw4HT55btO/f+0KN7ox8vO3+KS2h0AEkZyzYnjhFINEZyfGMZIG674n
         Pc6xO7+XfcWWKbr5oFffkoBsuWcipnrRS/TvcLF9YAL6FM7fUxsqVBMA0VF1OT5CBjQ+
         hckdCvYebs1xDwnRCMeM23FEkwgzyrlxDQlpe/BsDM4U43/cUonbGPEtZWFBJmM9Ck7R
         DJ0sj4H4SnCm4BrZrnqwXxX6BuGVOptlU6qXWat9o3gainGY8qgYBSai590si58aBNWa
         yinw==
X-Gm-Message-State: AOAM533C/YzANiLrnzD+svojXLL3PrHczT7sYbyC4Oq8I0qXNeal/Xfj
        mcuNz2YRN2T19wcw+HL0fO97zQdt0ecWlT6qnrC6xCSuGGI=
X-Google-Smtp-Source: ABdhPJxy/uWzerN1lgAoWXWpUsfEkSeXxsPdLqIuN4nEMR8qJ6R/Qt5/Z3rmzAh1YwKglRqTOW0vbD9xVoYIGlv4pQ8=
X-Received: by 2002:ab0:3443:: with SMTP id a3mr11593386uaq.6.1598543435957;
 Thu, 27 Aug 2020 08:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
 <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan> <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
 <20200826090518.m6vblobggnfdjau5@beryllium.lan> <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
 <20200827091910.ibuyr53qprb7qmju@beryllium.lan> <20200827092743.kjl6hkaephx3a64a@linutronix.de>
 <20200827101622.xx4jzecouxrlwbii@beryllium.lan> <20200827102840.msv556nrah4h4vmq@linutronix.de>
 <20200827112705.uleixtdmx3pacr5u@beryllium.lan> <20200827124611.tsivo4xopvoenfmy@beryllium.lan>
In-Reply-To: <20200827124611.tsivo4xopvoenfmy@beryllium.lan>
From:   Daniel Vacek <neelx.g@gmail.com>
Date:   Thu, 27 Aug 2020 17:50:24 +0200
Message-ID: <CAA7rmPG1j0vD4rtv2piLF1UV9qD4mfcXVAHfA3vqGniPUAerrw@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
To:     Daniel Wagner <wagi@monom.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 27, 2020 at 2:49 PM Daniel Wagner <wagi@monom.org> wrote:
>
> > Would be interesting to see the size numbers for v5.6-rt? Hmm, I'll
> > just start the compiler. It's all scripted anyway :)
>
> v5.6-rt:
>
> -rw-r--r-- 1 wagi users 28688896 Aug 27 13:38 rpi3-image-ll-v5.6.19-rt12
> -rw-r--r-- 1 wagi users 28688896 Aug 27 13:34 rpi3-image-nohz-v5.6.19-rt12
> -rw-r--r-- 1 wagi users 29669888 Aug 27 13:32 rpi3-image-none-v5.6.19-rt12
> -rw-r--r-- 1 wagi users 33438208 Aug 27 13:30 rpi3-image-rt-v5.6.19-rt12
> -rw-r--r-- 1 wagi users 28688896 Aug 27 13:38 rpi3-image-up-v5.6.19-rt12
> -rw-r--r-- 1 wagi users 29669888 Aug 27 13:36 rpi3-image-vp-v5.6.19-rt12
>
> v5.4-rt:
>
> -rw-r--r-- 1 wagi users 27525632 Aug 27 14:40 rpi3-image-ll-v5.4.59-rt36
> -rw-r--r-- 1 wagi users 27525632 Aug 27 14:36 rpi3-image-nohz-v5.4.59-rt36
> -rw-r--r-- 1 wagi users 28506624 Aug 27 14:34 rpi3-image-none-v5.4.59-rt36
> -rw-r--r-- 1 wagi users 32360960 Aug 27 14:32 rpi3-image-rt-v5.4.59-rt36
> -rw-r--r-- 1 wagi users 27525632 Aug 27 14:40 rpi3-image-up-v5.4.59-rt36
> -rw-r--r-- 1 wagi users 28506624 Aug 27 14:38 rpi3-image-vp-v5.4.59-rt36
>
> So in previous releases the size offset was roughly around 4MB.

Maybe the threshold is 33554432, eg. 32 megs...

--nX
