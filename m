Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2B0C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 24 Mar 2022 00:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346954AbiCXA6b (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 23 Mar 2022 20:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346951AbiCXA6a (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Mar 2022 20:58:30 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6819134F
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Mar 2022 17:57:00 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id p143so1797063vkf.5
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Mar 2022 17:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fgwdetCmWiUvv0IFLA1VvS0hWWNQXVBgGymIr6/n4wc=;
        b=ST3HKcZphWK1fFAzt4wUOgZsIcVQ7xo2V569Oq2x51Thn3t6twIOw+1q6Cm5DPoFUc
         vy3Ma1nsByhWxIUJSM1bIVv9k0N6r2OYLrjwTbmrWsaqU1ZpKCIUG9eXavM1sBFBc3tR
         OsCY8H8+fZgaTogZQJv+GabHuorNObS4DATMGi2j7A0UmuxOZXYk49eXE0MVKhFtlAdk
         9W+G313Q+UiK+FShj/ByVeF3pdQKw+jeZB/ASOyUoU4h1wsxRlC8Rqt9ong1zOv0YuNB
         R9STd35VtbZCUQTW4M5akFHs+yfcJBNA41lOtnyAL1AT0SsrtsqLW46wgE2yFHAzF5K8
         nIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fgwdetCmWiUvv0IFLA1VvS0hWWNQXVBgGymIr6/n4wc=;
        b=EQzgDps77icVvWkdKrB9wIGMdlL/MY5FlIA0r6tqKo5eULdFMxdvB8in1aB3DjOuzy
         F9PNno5Rz2Aq4R0W97CZVAJR/s0sJdqtdO47fZA+u0yi7cCbVT3KRr3mY5NSvXMJsRnf
         aZuDw9U6zKZB5meyv5nXtsMm1moS2FD7/KUB/ohkhZ0LEf/PM9ockkCKjJR0zQd3euIN
         1hksHKp26tYRiyLDmd6F3EvY8uA+BChe57FV1yctruAhkV3TVDqmfK3FuQi1FrJk1/AZ
         CrWJowWuaExSp/wwbmk79FgPMZGP4XiCpEOmgqVGosvf0IQMnSH3V0sfmwQAz8aUhLQx
         VIgw==
X-Gm-Message-State: AOAM532Nhy2uaJapW/DIct2ol5/YTE5O6b24Kn8cpK8abzSsveHs3Csa
        /2yytrAVXK+sYe3bg8OwRgviGPSrcEUJuLgShZRg4UDD6ss=
X-Google-Smtp-Source: ABdhPJwLIEilDV+9JTYyg1+Z6kU5eTtrjZIdqxSclAdgRNtQfbw1G2vlxX0QajCcLVmiN2TsQ8MedFAbDq5hKXLD68Y=
X-Received: by 2002:a05:6122:6af:b0:337:bbfe:b8b8 with SMTP id
 r15-20020a05612206af00b00337bbfeb8b8mr1561429vkq.31.1648083419269; Wed, 23
 Mar 2022 17:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+1+E3UVmbLA76t_JkZMMC6FHsmc_EOKeLztvgN6nAhTjjK5bQ@mail.gmail.com>
 <871qyse8ra.fsf@jogness.linutronix.de> <CA+1+E3WxTOMbh5OCub2wNiNWNELA2fcDL1hXgzJzr-Yc-FuoTQ@mail.gmail.com>
 <CAMLffL9hqXcco9NCH1eGdzw4uWPSxPpLaO5fZWgNqS9moKE2HQ@mail.gmail.com>
In-Reply-To: <CAMLffL9hqXcco9NCH1eGdzw4uWPSxPpLaO5fZWgNqS9moKE2HQ@mail.gmail.com>
From:   Gautam Thaker <ghthaker@gmail.com>
Date:   Wed, 23 Mar 2022 17:56:47 -0700
Message-ID: <CA+1+E3W5KAFtMJA_B9pbJa02ZZNJaNnon61-dan9AhdCOW0OEQ@mail.gmail.com>
Subject: Re: 5.15.28-rt35 #2 SMP PREEMPT_RT: Should scheduling latency be as
 large as 800 usec?
To:     Clark Williams <williams@redhat.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 23, 2022 at 3:26 PM Clark Williams <williams@redhat.com> wrote:
>
> Something that's not always obvious is that BIOS settings can affect your=
 latency numbers. Look in the rt-tests project for a script called 'hwlatde=
tect' and try running that to see if control is transferring to the BIOS vi=
a an SMI or MCE. Here's a sample run on an untuned Intel NUC:
>
> $ sudo hwlatdetect --duration=3D30s

OK, this was very useful. This has returned the following for me:

node-0> sudo hwlatdetect --duration=3D30s
hwlatdetect:  test duration 30 seconds
   detector: tracer
   parameters:
        Latency threshold: 10us
        Sample window:     1000000us
        Sample width:      500000us
     Non-sampling period:  500000us
        Output File:       None

Starting test
test finished
Max Latency: 811us
Samples recorded: 23
Samples exceeding threshold: 23
ts: 1648082981.696619376, inner:811, outer:19
ts: 1648082982.999941947, inner:545, outer:16
ts: 1648082985.249826218, inner:0, outer:426
ts: 1648082986.249810897, inner:409, outer:0
ts: 1648082987.249818630, inner:0, outer:415
ts: 1648082988.249822370, inner:417, outer:0
ts: 1648082989.249816168, inner:409, outer:0
ts: 1648082990.249820394, inner:412, outer:0
ts: 1648082991.249820365, inner:0, outer:410
ts: 1648082992.249825886, inner:0, outer:414
ts: 1648082993.249822956, inner:409, outer:0
ts: 1648082994.249822720, inner:407, outer:0
ts: 1648082995.249826191, inner:409, outer:5
ts: 1648082996.249832029, inner:413, outer:0
ts: 1648082997.249832007, inner:412, outer:0
ts: 1648082998.249842325, inner:0, outer:420
ts: 1648082999.249838335, inner:0, outer:415
ts: 1648083000.249836740, inner:412, outer:0
ts: 1648083001.249835774, inner:409, outer:0
ts: 1648083002.249832951, inner:0, outer:404
ts: 1648083003.249833781, inner:0, outer:404
ts: 1648083004.249837415, inner:0, outer:406
ts: 1648083005.249851829, inner:0, outer:418
node-0>

I see one inner value of > 800usec, and several cases where sum of
"outer" + (next) "inner" is > 800 usec.  If I can reduce this to the
55 usec you see  on your "untuned" Intel NUC (what is NUC BTW?) I
would be quite happy.

Is there a pointer to any documentation as to what I may try on the
BIOS settings?  And I am not familiar w/ "...since transitioning
between c-states is another place you can see latency spikes", any
pointers regarding that also will be appreciated.

Gautam
