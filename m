Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A416BC83014
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 16:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AD3206E3
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 16:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cb8lgFKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgK3Q3Y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 11:29:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:43335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbgK3Q3Y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 11:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606753639;
        bh=g7gIuzXdJkNWVgDL+psau+dbSeSo+v1g6CMrN/YRsHc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cb8lgFKsWvlHg9BxwLAsvwUNmGGb7b/UPHsZB9g3WOSf7FL7epADsDhM6gv8/BayY
         /mk/w09tpYqvjbdsHVQRr7lCCy60MduiNGyC5nstJGRHX9zYBX0CPjeByB0rscfx0R
         XSCzGn/eiRuvMJh8fYTd4Ws7o07NRkLfc9y5+S7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.20]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lY1-1kk38O0J2x-000tvU; Mon, 30
 Nov 2020 17:27:19 +0100
Message-ID: <2658a2a26e53826687cd7b22f424e2d3319423dd.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Mon, 30 Nov 2020 17:27:17 +0100
In-Reply-To: <20201130160327.ov32m4rapk4h432a@linutronix.de>
References: <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
         <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
         <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
         <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
         <20201129112922.db53kmtpu76xxukj@spock.localdomain>
         <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WHhCmV7H4GPew09tvTHmBnfaIWrnHFSbzOsPB0lILlwf3Jfpx1r
 ocXOPwkliheZ8aw5NcPkvOMVbLmTkuY76gQ+V/yObwxT6eCCPSY3CZ8cOcZZ+eL3yGvKu0g
 1emKxA3izcLeeu/+18kCgu8MqQzhejmonMOOO/PkYYXjjR5gfe83hfFN/+XiaHrTBjqHrEp
 DWj/nzVhwS1sfRq8G7HCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vDsTuF1V16c=:qw+O0BalqIzFaPuITU06gb
 yjDxB+Ac2G7zYpuqm46uBDQwtN2glSWtQWeUBG2FU3nDHxLBRyQPM5kGSGHU+/IDeSd4BYTvH
 ufmQcUu7Sl2hDA5102IPAnzb5hNRY7dut6L/oUTdpaBsdf0WPth04XDuOb7aygIMbZRk0kbBx
 K9c7KWt8ksFLwq4PGUbSZCqNC/EnHndOtpLoQ7SQbRKwd76MdqevaUaMwOcgtFRPY5lLeItZt
 6UxYujwOjOEajJU7ngMeA8dgXxc/sw+09m5Zfpru9jz7hr7L7PkXeLu6wWHUpId2GSvwwKUYc
 EKsSDPEsH80myjkStNA75h+TFM84vFXs27c5y5AOh7uWIIPoNSgkNscTnYCe3QjvgeN/0GAUG
 1WqtJ+EmelcRTmvRkwVo17bTEgKBHk40j+0OL2vXnAXYlMWO06T3sTE54oVp7OE4ayWj6cdAO
 urmcxHiUK6RCw3Ia5Z1dG6EfCLgN7v1X9rqZqN13nBRDomRtyEIBh14dfLIJ8yWD0pBm9gCbk
 J7j7SowppVAFD9CUaPCVHax9B+S8OHfTs+A6fYlPC8dGkxeD9mgjyVE35dXUylrvTdJfoHj7K
 H8kJqOvOUDC7wjX+yYf5f8T0R1eUG9DoSyna4gEYd/fPW/LCqvrS5EI+th8A4Fk3PB7420i8Q
 56eZ6TxmRp8wTweKgMJwXNV7xzocHp2HDqFWZSC5Zz8b1CJGVR1ml+AoDd/i+/nF/o+yhYAe0
 2DHXrlFXXVnZOnn72CmJD0w4vIIu2zGpcG/QHHi1Ho+a33F+0XTzk7De2XvyZ71hAV6oSruBw
 XwwvkADrkMOtKM3nhhmm38UCIGnahySGXKB9VZrpUqdubWOveNAlT/h2ojLkUpedyl9gGelHZ
 2vMjAMS4aJFvOQHi4VnQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-11-30 at 17:03 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-30 16:01:11 [+0100], Mike Galbraith wrote:
> > On Mon, 2020-11-30 at 15:52 +0100, Sebastian Andrzej Siewior wrote:
> > > How do you test this? I triggered a few oom-killer and I have here g=
it
> > > gc running for a few hours now=E2=80=A6 Everything is fine.
> >
> > In an LTP install, ./runltp -f mm.  Shortly after box starts swapping
> > insanely, it explodes quite reliably here with either z3fold or
> > zsmalloc.. but not with zbud.
>
> This just passed. It however killed my git-gc task which wasn't done.
> Let me try tomorrow with your config.

FYI, I tried 5.9-rt (after fixing 5.9.11), it exploded in the same way,
so (as expected) it's not some devel tree oopsie.

	-Mike

