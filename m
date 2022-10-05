Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5766AC433FE
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Oct 2022 16:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJEQUc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJEQU3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Oct 2022 12:20:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A626C766
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Oct 2022 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664986817;
        bh=xp0YDhyK4r3237xFIDXjx45OISuXKpw7nqdyvq0OPIU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MFr9UaaSW76hvGE2KFlBfr5YA1mw5ibnCXFi9eaFIGVTl1iJvab1W4AmIyljyKmI9
         5OM81psXSItvujmQJjqfAsf4YU6YpWh34CokET/xyoDRGLyA7o1l34pQrNk7u5OmLd
         0Xhcfa80ZlFff5zcsn+oozy2YTWR9fyiHCIO08jA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.43] ([178.208.115.148]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1oSLEV1CbO-00Ey9O; Wed, 05
 Oct 2022 18:20:17 +0200
Message-ID: <ff61ad6d-a8d3-e83e-1296-bf7d1f503aeb@gmx.net>
Date:   Wed, 5 Oct 2022 18:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Regression (latency spike) between 5.16.2-rt19 and 5.17.1-rt17
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
 <Yz2HQlzZ491HtOm+@linutronix.de>
From:   Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <Yz2HQlzZ491HtOm+@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OHbtmkkZt3f+K8ORVjjw3HdD2ir6wgJFe/d3AMw1wERYMzaz1Wv
 V8/sawbcOe8DvwryTpBnuND0tSF74lcz+aL0+DQQjPkwUgizqMn7+AL91D6norCA1Q/pfTB
 wMO8TtQzSdh9rICLsaG+PWSScG8l+wbzxcs/j5atkGqEnlBrZUA7aNcgxrOxc8fLBnrE1nn
 RewuK8AwgX8PGfmxp4glw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:no2lDiShx2U=:Hatfd5grRh22jyI2jTOsA+
 Bee2UcLDN+mizTc/aWhBc/6VR5QH+W2YoBBK1vP00I/H9sQLkKM6J1oecKFSCBTh81IGpPBCH
 K5WV2R+J19guzytBKsv6aPMsgpmhi/oEasEScqhlgt3r54hoP6mUNItvFADKTkO9K1c3+Vdr8
 xn66REDjiQzQU5USZdPxmKFq15NZ/Hr4hbi8swSUKNjulXwS3aaQPUSXlzksjKXyjAAtZwyfQ
 1/qkH2UIH+sarw8jW5tnTU3cD0yClBmDYJ5onI4+0RRe8v/GUts3HFatALOhN0PSHTZ6bz69M
 wqTs1ppufhAz+CzgJq8dP2ac4MWeSX1Zfy920UejjLEfQrVPBKJr3AOYWbm4P3+d0M8eooyvR
 ESbcGPMw1tidXht9yg2qcoVBAVz08jWdk2unYMDA0ywRlq/gr4w26CZETzAjQ0CgRA0Ictamv
 sdWajBQfkanh3HLxA+yqW+BLTnunH/AGyTH5vdsm5cVjVvhQcN4OtlCMTrx/+hdF2zHbCKQlr
 5G+xpUUJ0uiVCruwEZNGsGHucj9viLjxwNYqEH8r4pqYTOFrEFMvHrqgm5GOyejFF/5qYcSXu
 yxT2FKFO4g/tTmrMGVqE6NRzi+9wjg2+YJA0rRpX8kl/qnHfY8g534vTKmNUeHOzreHzlLhbY
 4t42k7rtQkcAcj4nRjT6Dz+G4LaH1CLQ4KvEk//ZfLpeTZ+/k5jpfYBhrfS7mck9S2gMZUnKi
 B5oxCVoB08CZtMzJmejBSjgUDFDKf0kI1CJjI0MZWWuVxR5pcbIEtFLryl0FQFhFFBWs5iOCZ
 ZAXRASK+edWXsDAW+Fv1+ER2VMPCH9HovSyYOySPw+u/WVhceccS7lgDQQqkvzW4TAWZaZsZr
 dg5ZA2nu/dcmo0Obl1crqhIEFPJMEYUpnq6ZTjmpXb8VFl2i8MjLqswJj3zmnX52xTRr+UYre
 dO6j0mdlVgJrDJBNfgjbRmJ1Srp/6qpife1qR7im1pPvB5LCHntlFRJMf4cAulM0vkQe5GL7/
 TxG6n9YnaDkFxAsE0pPE+xPIckQ3VtIWRv8AOFZJR7aAyF4inbGZSnGqguqtbZHrnZWwZUSXR
 SdDFeI3EZvxjWDQW5gh89/PLNEUE2zwFsgsroVwsaDgW27B/i3g4qQEZACUyfi7BQfGWw7A25
 V6gI1M6fHOs8XiLPfoERHLLcxr
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



Am 05/10/2022 um 15:31 schrieb Sebastian Andrzej Siewior:
> On 2022-10-05 09:46:30 [+0200], Florian Paul Schmidt wrote:
>> 5.19-rt10    has the problem
>> 5.17.1-rt17  has the problem
>> 5.16.2-rt19  does not have the problem
>
> Could you check v5.17-rc1-rt1? Maybe it was introduced in v5.17 cycle.

Will do!

>> I would possibly be willing to git bisect the issue. But I am a little
>> bit confused about how to go about that. What repo/tree would I
>> precisely bisect (I am using the the patch tarballs from
>> https://cdn.kernel.org/pub/linux/kernel/projects/rt/)?
>
> if it got introduced post v5.17-rc1-rt1 then we could try to bisect it.
> Otherwise we would have to trace it. Since the latency spike is huge, it
> should be easy to spot.

Will try and see if I get the tracing working afterwards (will take a
while - slow PC) :)

Kind regards,
FPS
