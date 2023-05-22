Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5721C77B73
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 May 2023 20:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjEVUug (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 May 2023 16:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjEVUuf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2023 16:50:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5655793
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2023 13:50:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso124576a12.1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2023 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmn-com-au.20221208.gappssmtp.com; s=20221208; t=1684788632; x=1687380632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoPbfdhFkVcfpTXp/UIz5l0i6czkcwm1+6LL743pKeg=;
        b=B39pXWdVZ8RcGwEmb5kARu4nT5e9jJw3Q1k+1EQqBhU6LY76S+ESnHPu7gQmpbWSTF
         vHpIpUsjmZaZoH9mnaJtZojfoDB2KD62zsjOC0HPfNRnn8FsLRNTp5iyrRoKHOS3ujSg
         5waXZEzQwtFEDxLOBb4DmF/Qg4D1bMdRGcw9s5/r/7whm9KEnxhVpWmg8ZZDibSCe0qy
         DqlbA9e4m9tIPBnUfkYY7bVbiJ0kWyDq4Dq4KYOJqot46zGyNDA3uJHRJMla+e1AYtIF
         +56VpOdrrFjoBKfLe4lExEbRpANSo0SHjFBGfmzqwp46mX1UXqM4NloPDPD6t4jr7yN0
         1hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788632; x=1687380632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoPbfdhFkVcfpTXp/UIz5l0i6czkcwm1+6LL743pKeg=;
        b=Z6KHuy09Y4D3xv8htGqJnySV+f0gsYFnNynw1FWPoUVJsGh+NyH50ZIUjC96EfTffE
         ZUCBtkKw6A6UkUglpFCeEveE9FyCKl8KOpraGO54WtzWp8qAsZlOKFnVOeLKA9UyB1in
         8A/F3/8n/qY15KEeB3oQSVd1fGYlfrAqKTiM5P8rQ5mwwWrB8ZZDXuC2P+PyUzVRNC4R
         JvR9GNj3GDpbXI/e9z6WNwhafL5AqUuG61rymsv8Ynp/qTUll6MVX1SQQKe1NNBT9gOO
         uw2WYzGfV7YXs3YOV/DhQbwrdbI7+jdk4Fu05qpTZ7IhIbdlNwR1WIZzOfln7qCayRp4
         LEgg==
X-Gm-Message-State: AC+VfDxqlh/+rJZmSZrPlOl5Q+gHLrQtL+igtWFN8zEA002WUo06/lPr
        ovukVfmyZtJvrcS+g2wDOXClypxve3ZlVU76mQy+ug==
X-Google-Smtp-Source: ACHHUZ7aqD3jU72W8FrKU1+8NfQxUY0+Fa/FqiD1ffnpBJeNVejC8EoH4W+4J6kTbdh9DxsDEBTuEL/rCFiT5VGvTD4=
X-Received: by 2002:aa7:d34a:0:b0:504:9346:11d3 with SMTP id
 m10-20020aa7d34a000000b00504934611d3mr9562285edr.29.1684788631666; Mon, 22
 May 2023 13:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
 <20230428131236.9MfVxN3s@linutronix.de> <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
 <20230516105950.kSgA5y-v@linutronix.de> <CANV1gkftrZvhUhXV-mJ-mYmsue3ER33cXCNmVD1bGAc6TmTHuA@mail.gmail.com>
 <CANV1gkfsAfDt76=STFrekQA4M6sfVKyq7bujA=Tu+S6k+EGYcg@mail.gmail.com>
 <20230519083745.AB0-5kD9@linutronix.de> <CANV1gkcah59yVOMZ-s_0TMeMEgpwOaDKSWbdL3Y2Y86RQ+UsKA@mail.gmail.com>
 <20230522093208.NtKNYiYn@linutronix.de> <CANV1gkf+m1n3bLdBg3vP3pzSxiQ1Na53TSbUvLrNNqmKVZvgQQ@mail.gmail.com>
 <ZGuAJu32i1Hf3awN@tpad> <CANV1gkcuPVZz6=BrNxWBd9SqB4ydNmJOge6Tir2xG9C050oH1w@mail.gmail.com>
 <Pine.NEB.4.64.2305221323260.9144@freeby.mesanet.com>
In-Reply-To: <Pine.NEB.4.64.2305221323260.9144@freeby.mesanet.com>
From:   Rod Webster <rod@vmn.com.au>
Date:   Tue, 23 May 2023 06:50:19 +1000
Message-ID: <CANV1gkd0=Hcs7ztCkKs5GjvCEG7nA+ivr1BaopLCaRzAN4Heww@mail.gmail.com>
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al NIC
To:     Peter Wallace <pcw@mesanet.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Peter, thanks for joining the conversation.
For the benefit of  others, Peter is the manufacturer of the Mesa
network hardware we are working with. it's great to have him on board.

Rod Webster





Rod Webster

VMN=C2=AE

www.vmn.com.au

Ph: 1300 896 832

Mob: +61 435 765 611




On Tue, 23 May 2023 at 06:38, Peter Wallace <pcw@mesanet.com> wrote:
>
> On Tue, 23 May 2023, Rod Webster wrote:
>
> > Date: Tue, 23 May 2023 06:02:13 +1000
> > From: Rod Webster <rod@vmn.com.au>
> > To: Marcelo Tosatti <mtosatti@redhat.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
> >     linux-rt-users@vger.kernel.org
> > Subject: Re: Excessive network latency when using Realtek R8168/R8111 e=
t al
> >     NIC
> >
> > This stuff is hard! I just realised that rtapi_app is a red herring!
> > rtapi_app is Linuxcnc and there is nothing wrong with it. Its thread
> > is on a 1000us cycle so it seems it gets all its jobs done in 200us
> > and then sleeps for 800us which makes perfect sense!
> >
> > The issue we have is deeper than that. I think we should be looking at
> > the NIC interrupt (but don't trust the novice!).
> > The network communication is consuming more than the 800us slack from
> > time to time. When that happens, our hardware sees the timing overrun
> > and increments an internal packet error count. If too many of these
> > happen in succession, the hardware decides the RT environment can't be
> > relied on, disables further communication and returns an "error
> > finishing read" to Linuxcnc to say it's given up.
> >
> > Marcelo, we didn't resort to C. We were able to use a bash script and
> > use a linuxcnc tool called halcmd to query the hardware as shown here.
> > #!/usr/bin/bash
> > stat=3D0
> > while (($stat < 1))
> > do
> > stat=3D`halcmd getp hm2_7i96s.0.packet-error-total`
> > done
> > trace-cmd stop
> >
> > I think we need to increase the stat threshold  so we get more samples
> > in our trace before stopping it. The current trace will only have one
> > instance.
> > Thanks for letting me see the issue more clearly.
> >
> >
> > Rod Webster
> >
>
>
> I should note that at least for Intel MACs, the 6.3.1-rt13 and 6.4.0-rc2-=
rt1
> kernels seem to solve the issue. Not sure what changed but maximum read t=
ime
> is now in the 200.. 250 usec peak region (about 100 usec more than averag=
e)
> This is the peak read latency after about 3 days of videos, compiling and
> local network activity.
>
> Sadly 6.4.0-rc3-rt2 has regressed slightly in network latency on my test
> systems
>
> My test systems were all Intel CPUs with 4 cores, isolcpus=3D3 and the Et=
hernet
> IRQ pinned to CPU3
>
>
> Peter Wallace
