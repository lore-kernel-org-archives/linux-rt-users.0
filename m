Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55839C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 15:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8A323731
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 15:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgLGPoC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Dec 2020 10:44:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:41605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgLGPoC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Dec 2020 10:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607355710;
        bh=AlTxvn4IgovRTYLaaEd3qOVX0F6tArcXWwxMwShSXPQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=elVyZNeedZKlZPbIea0DJMZRtRIja4DG6M2zXag4wc2NuLoJXDUJAYcBdyKNJ0KZA
         aiildd9yluDU4lOe54mXscFQO/o9817B5ZzEou8hO2BajSLFItF8bNJovPkjglgU8q
         NimKGtIvPUso5jikee3he2DxHz9hJvPCOGhVnu1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.4]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMfc-1kyRiM1WmS-00EPlV; Mon, 07
 Dec 2020 16:41:50 +0100
Message-ID: <9bd908b65ef15149458aa060c0daf065f9d45615.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Mon, 07 Dec 2020 16:41:48 +0100
In-Reply-To: <CAM4kBBJ2jqBKdTPWPZEfuc17yiARMr_NwOSoHL_r0eC9n7UpUQ@mail.gmail.com>
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
         <20201203133934.37aotbdjnd36lrxv@linutronix.de>
         <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de>
         <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
         <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de>
         <CAM4kBBL5+xNWq6DWHY6nQjwDTj8PZKem-rGuFvimi7jekjA+Xw@mail.gmail.com>
         <3ec93680c6a27626b23e99d552aa778be7b2ecec.camel@gmx.de>
         <CAM4kBBJ2jqBKdTPWPZEfuc17yiARMr_NwOSoHL_r0eC9n7UpUQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bdKYObo2ckNROyXGjzofEcImn2TnTbbZRmZzxNR3wrNvJH60bUS
 1P2URyN51VEyP+G4XdimGSN9SUgUvLU4gPB4Vtwce9BluZ8WtkT2kIdIqExLO4YyuEB7cRB
 VTpRrmmlVeHdb7YAU3vmoY4H8fGGSynxiASSABJC/EKlISzkmJXmFYl+xWCLsUn51mfokV6
 5BV7pWr4plA7llsZC7PmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9IfITGryrRk=:hPlnjfzHjOyEWJt64w+CKy
 ek1tO4m6iH4eL0loaassL3qPbkRnqvOnrgw80hPMeJSZ7GKkkZkwtOj88mjQr4j84FUqDeKen
 GM2KMIo9KjZynE66rUPRcmMk/M9TdjXCEFu4u/30gmmsb6RjaF9Ug1f+DLfpWRTKXQkZ31e5C
 x/xWhRR4810RWAsrENHK+u6MH1ss9IdwMm/M2XMg7j6/UPrhuPh9E+STt8NFFngs/Ap51vvhr
 aNPV45wfj81xUDR5F3st26011nrnS72Y6wfBy7SbLwPax6PWIQWEHs1kpEGKXW/QlB+tDRBzt
 vwvgJBeyWIpZ2Oju+Ahuf3YGfPoa5Mm1frDbnrO10eYvwm3cFH0xiWUy4ftlCi2kitOW+0/Ej
 SgtoEaDQ1wVgySvOcUeUk0l8S1Mnm4ZrWu7/FzLlpi2arBj5GvxonvZdzJFf1V4KNi+XR/YR4
 q23uDWdAFq9jMImPRAHXWPZ2c5Qp4Buo7SYLLG3ueoodH5qBszGipPVpWuC+sz11Q6Vn/IwZj
 jp9D0X7l4EMnEApznsOvy6YxYQuBAYtWHI1I+1ZbF7p4pyfAKQEW5vCIynGhLnU6MnGtVZgjF
 5aAuPkiyZMX9cKx5kZdnmt6OzBhzhzl++Q4PPSLqvm5OBKbHIpIJUTVOlBNiWhT+eq+EPHS6l
 b203Tw20L7s5s/Tu9qYHu6N50BNwdNODXWvAxntfohG+dO4fwvg0G/1yjeSvpdE8DcZDHZcmf
 IJjywPsKcfxkpZMWAuibzZwp0/nPis8MIoEhHZuizzX2U4FRTyJVqAQiPqbJAeADNhIHNO6a2
 Gdc50E+DMigbuUXglfVZ7a4D7VUoQNmdRCfVQvo7CnEG51h+IV+YAV335vQfMl1ULZG2BQZ4O
 gdCRFPNrKngdTCCJ5B+g==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-12-07 at 16:21 +0100, Vitaly Wool wrote:
> On Mon, Dec 7, 2020 at 1:34 PM Mike Galbraith <efault@gmx.de> wrote:
> >
>
> > Unfortunately, that made zero difference.
>
> Okay, I suggest that you submit the patch that changes read_lock() to
> write_lock() in __release_z3fold_page() and I'll ack it then.
> I would like to rewrite the code so that write_lock is not necessary
> there but I don't want to hold you back and it isn't likely that I'll
> complete this today.

Nah, I'm in no rush... especially not to sign off on "Because the
little voices in my head said this bit should look like that bit over
yonder, and testing _seems_ to indicate they're right about that" :)

	-Mike

