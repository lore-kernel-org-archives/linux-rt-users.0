Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E9FC4361B
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 12:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17433233F6
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 12:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgLGMgH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Dec 2020 07:36:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:59463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgLGMgG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Dec 2020 07:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607344442;
        bh=0d1+Dzo1u/9nlI5Vu2HRoIjjB7ZSUOHMPNkpO7nwQYg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Y7S/hbp1SKISw1ufN7WFJgTRMtCHIK3oVG6G1OUknkvdkqfzk89X/Cyr2wSsDMxAW
         0Kqi1L95wYKzN7AVhPFU1p+DKWnUrVS0H3kK/e7C0V3ehC76S9X1UME+nOZzcgfu8Z
         OFUyb3YzRO2EGcrgfVFH86U8Kw2EoaBCXl3A80+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.4]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1krSMw3Xqh-00Cynv; Mon, 07
 Dec 2020 13:34:01 +0100
Message-ID: <3ec93680c6a27626b23e99d552aa778be7b2ecec.camel@gmx.de>
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
Date:   Mon, 07 Dec 2020 13:34:00 +0100
In-Reply-To: <CAM4kBBL5+xNWq6DWHY6nQjwDTj8PZKem-rGuFvimi7jekjA+Xw@mail.gmail.com>
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
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e2CuKsVCIq1wO8Gyf47ggrWJwiV1KEEQde9dViGUgPjRcDUEE5r
 NCJiMn3ocxzTghgRjCHq5OiEPfJt//iNw1qttvfGfzTi1ZAa9/GhNI0uoh8Ik3eOlFtlJ26
 OFFkHRuRnoskDwK52D8lpsH2S3Xgyv9qa4QEkAgwI7r4iCjDNgPx0JNgXzz6PJY5MFBhgvu
 JRuoLqsLkdbbP0aBipFNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OV65OwFGK3I=:YKyr6c3slvGtZo4SANrQt7
 rNdKyHcMeAsjOl1dPNzzmBsfNAi211xhkO5LrNHq9zssL6FGdEYq4Qex4sVimR3M/bGqn5lyo
 nAJaUzTadWPVDp7bqMEZQBetoM0+b06LHyJ5iHfePf22VEuvWzLkbglGRucHIpsSCsoNnNudz
 5H2NeW6SJ8YPZGjb3z6NemcDaQfMDFY40+pcOHjxUwPQx7WBu8X7jBgiYCjYYW73JhJyg2ezD
 PpXx/duS07dxaThYVNZABtaz9wSUql9DB3yMareD0eq+xRZNttqgLK/OhcDL+Br/pzzvaw0lK
 rtJqNYPWe+EY7NjAcelqZFhL2ZkYepGTaWWAP6lVpZtlgVoD/VfgM8b7IFbQmM9F0ZjrjnJzD
 26keiuS1HeS8Cq9qacH4Q/TKvG84/CycWP4V/aUiaPMhurATqDkXEOCpoviQHGR4/0WaJs5I6
 0Q5andS/aWdC8I7CxEie5d2JR8FX79zdhR1oqiVO48lhGRcpAUTTl1ZAsj3dAqr+27bS2tbhy
 YhQ/SzJxmlJG0YRd+SccVZ/D7BmoFxk3uqGqp/TAgEe6OrlzPgdwXZBfbkPC1UkCeLz514R2v
 QiezfSaTmUAQ0LF7Pt4g/V2BDRtps05tS5TSw+0j3Yd3v2BF6ZI7RaYRHe7TjHOXMx6qS4EJ4
 36AQhscPFBY4FjMbNo9iEA/7bqHFqVJ0UvMbH2BE3mKxA/NV4D8dQK20+7IQpVGoNrrGfUxnQ
 yH0/rMiH18WgFdmqovrJOE3abwBq284htWi/fYeia7C2AezPy1ZrqES0RrB7NPGMQ/WjLxTGr
 A10JofJcnstYL3hLtT4nuPmtAGzIaWi+xr2X4KeHqZF3v9g71O7ZThFk88NOi9HZk/AmfugWx
 b2Q4o1FqR/OF/OUw892w==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-12-07 at 12:52 +0100, Vitaly Wool wrote:
>
> Thanks. This trace beats me because I don't quite get how this could
> have happened.

I swear there's a mythical creature loose in there somewhere ;-)
Everything looks just peachy up to the instant it goes boom, then you
find in the wreckage that which was most definitely NOT there just a
few ns ago.

> Hitting write_unlock at line 341 would mean that HANDLES_ORPHANED bit
> is set but obviously it isn't.
> Could you please comment out the ".shrink =3D z3fold_zpool_shrink" line
> and retry?

Unfortunately, that made zero difference.

	-Mike

