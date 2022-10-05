Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9137C433FE
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Oct 2022 16:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJEQSI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 12:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJEQR4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Oct 2022 12:17:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A012A7DF6F
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Oct 2022 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664986657;
        bh=JWu2sPHTFBfuzo6hskJmU1KJV6vbXF9719fdb8/eNkY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=M68uKa5v/9RXBQv4+gzBVd9qiHFl9Nege2K4jZzC00qsg/+w45d5EB5WMB9J8aSzD
         9+OlpobbdQvBTqVj1rJG0IK4EjqWxS0JyAYwddy0EELxqT43D0iT7i7ZYvkdysBBeV
         8zVMri1eJBiBVsnWChql5fp0Au9XiCtUMnQl39Ow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.43] ([178.208.115.148]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1pHguQ03f1-017Dzs; Wed, 05
 Oct 2022 18:17:37 +0200
Message-ID: <9a950f2b-94c2-7dad-51f2-545aa37850c2@gmx.net>
Date:   Wed, 5 Oct 2022 18:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Regression (latency spike) between 5.16.2-rt19 and 5.17.1-rt17
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
 <Yz2HQlzZ491HtOm+@linutronix.de>
 <5675da76-80ba-5708-e022-2385e3b56fad@redhat.com>
From:   Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <5675da76-80ba-5708-e022-2385e3b56fad@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TnowKR9matJqOGQJhlba8CM8WebNOm1KSF7owLk4qz48k91GtS9
 lAFyek88v9YagjWfQfrpALDMhuDdhGp517L+QeQfmsKz5qHGCCFTwvaB3OvHOIDJ7MBnk1p
 wbcw36vyp/95aLhGZwaCe849HkL3IUlsAGdYZz2PFnU3j8q9WwfZOKgFaGrysMu2mpCDpF5
 Lh7cVNDg7hLy6yfkFyJbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+oSDlcly00g=:rGWGS/pl4TrMbelrHZgHI9
 7yZDYeQecP+kQi57Op0Tq+1t2lTQr/dTMjd4tywAPp4AAXCDS3A0OcL7WzOkEKsa69CusAban
 jPxZkmCHk54OLIO/0wwcQIk8x9UF56XUwwtdmj3RdzensNuVmA2ohbFxyAYkykd/K47vGBUm/
 /kPm4XZuo9Q9Gt4fe+KG27g0eiVFsRWO+X8qLNVwajh9h+MhLQ8jybT+FgtcYVyTlGtWEDSwR
 LKE+rjTU67HYJXiLtdOTZgaUyBtbVb/LrpmBMyhySV1eFjT0OutQg4Gasfgk0KS3kDADYe2BP
 +xAPX5RC1EXyUFmQWzcJpTPlVdXFk+IciCUdXqIU05ZJQiBAjQyaAh2X8JzGzU9Em97W7/adi
 wmkMYKHd3tTZHtSIlbzaNmBfqj7D3h5m+zxALUSY3rUs4ociZIeyiOTFqcthRxhyogDRITSLj
 /oEAlTCVbsgkcwsXLZoOpzULW+o++Vpu3+gWnm4iDwn/3QAeaS+CTvNLeOSQs9YoW0gLmVg6i
 12ewEhE+k9XIdk5kHxNHg+GineX4TnExQvhXV5/2uR3StJEZUtQ+nXNfwY7hVQwjgTYULzwtH
 3cI8oCcxsVlsE9aSstYQHqVi19MIJWJE07MmbDMEzHiBqaoVtC8jF3zqTqN9wdY0g9MSsFXU0
 e99TX8RRz6yJ3YqwYsOja4uou9yEUJR/GkojPBf+u8/cRZ/VtvvQfbMRqCdpJwr+oJTKE3qCO
 oLIs491W8aDh97fDhKQncY71VgreCvHSLL2Tz5RGjhSoldUlCKDxu4eAUhjADGMxH4c6LCyJM
 CMwuZ3fomSxndbhi2OmmM4mn1Gh088TdC7YNuOMZhQ45U/FVSJXROCWVruASmHqt/O4mguKTH
 o1loBfXn+sQph51ZBrhJiSU5WXF7MDw1v2N458kcpugCD9qIByUCjQtzieVKZuSPJ7P9mJcSw
 p5u5B3jE5Fq5N1b2NYVgiBimNpS97/hNRNE4Qn3+qZryhhRdweqgvRuTfUS+ZDnEYqukf9xx6
 prAySnzP56frQCk+0riDhzIQLlexvOizG5h4Qhj9UAq4nxbnToDfg7pJNfD8ZObcMPs6/7CpN
 z1bmGpbXDJHYsF9Gn1y0BNgiPCwsHLGC5rld3wFQfeJgl0Xxadk0DR6rZMkZc2SsF16eM0YMW
 RhluvK5tEpkszqRaaOz7WKrIUEcAKJF2Ti1jjZ8oB8He/8ABPmzfUgO9049EeVxaimhSguqby
 9r0XPv60PFoy/8jxol6cJmEkgLEHq5EBTwfZLovYn53lLjbyEVInkyzbYQItBNQWNGl/l7zzk
 CBskZqknCTbrvk6Z761hA0XLmhM2fq38XBcjf1pie8JhW8k34Nq+8BQwsUfpchBFWvpCrW6Ah
 XF2y2URPVNJFIlvEp4TjfTvWpqLSK757DGlW3Fvss+UvL6AoQiTyKzyW8GTAPLuBFEyxLKQH7
 r6ufZbq+GMLGuD29iaOukApQLZ3ZsnT7639UDFq9GjHlthpRR7uaMh/6yVcPWZaCH8JE0IOnZ
 nxl8pAZN/EOlMirMsdmygl4NWSu60kAks7iPnpQgVqci2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



Am 05/10/2022 um 16:45 schrieb Daniel Bristot de Oliveira:
> On 10/5/22 15:31, Sebastian Andrzej Siewior wrote:
>> On 2022-10-05 09:46:30 [+0200], Florian Paul Schmidt wrote:
>>> 5.19-rt10    has the problem
>>> 5.17.1-rt17  has the problem
>>> 5.16.2-rt19  does not have the problem
>> Could you check v5.17-rc1-rt1? Maybe it was introduced in v5.17 cycle.
>>
>>> I would possibly be willing to git bisect the issue. But I am a little
>>> bit confused about how to go about that. What repo/tree would I
>>> precisely bisect (I am using the the patch tarballs from
>>> https://cdn.kernel.org/pub/linux/kernel/projects/rt/)?
>> if it got introduced post v5.17-rc1-rt1 then we could try to bisect it.
>> Otherwise we would have to trace it. Since the latency spike is huge, i=
t
>> should be easy to spot.
>
> try:
> # timerlat -a 100
>
> wait for it to stop and save the trace. Then see what the trace points o=
ut at the
> end of the trace.

What package contains the timerlat command? I gathered from searching
online for timerlat that it is part of the tracing machinery but I
didn't find the executable itself..

Kind regards,
FPS
