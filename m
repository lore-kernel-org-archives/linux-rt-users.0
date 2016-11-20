From: Tracy Smith <tlsmith3777@gmail.com>
Subject: Re: Calculate average latencies on the fly
Date: Sat, 19 Nov 2016 23:03:33 -0600
Message-ID: <DAAA8613-A872-4CF9-8A1D-593C7052E488@gmail.com>
References: <CAK+oA4V8yFDnieAa4tsCQKTapNe6gA_VLJvvEh6_u_jgWpyahQ@mail.gmail.com> <CAK+oA4WFAaT4DmR=8nKqTsyKe9imDYCu5p6DG4kqbhoBPD=LXw@mail.gmail.com> <alpine.LFD.2.20.1611161525280.12617@riemann.fritz.box> <CAK+oA4UTKEazEFZ9+H6xWT7yNw50LNLe+e_DpfwKFvnwaYe1xQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Cc: John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
To: Piotr Gregor <piotrgregor@rsyncme.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35094 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbcKTFDg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 20 Nov 2016 00:03:36 -0500
Received: by mail-oi0-f65.google.com with SMTP id v84so17416628oie.2
        for <linux-rt-users@vger.kernel.org>; Sat, 19 Nov 2016 21:03:36 -0800 (PST)
In-Reply-To: <CAK+oA4UTKEazEFZ9+H6xWT7yNw50LNLe+e_DpfwKFvnwaYe1xQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Piotr, please explain what you believe to be the root cause?

> On Nov 19, 2016, at 5:27 PM, Piotr Gregor <piotrgregor@rsyncme.org> wrote:=

>=20
> Hi John, Clark,
>=20
> Recently I observed jitter of > 100 000 during tests of virtualized system=
.
> In that case 30 years would change into 0.3 year which is not as much.
> The jitter depends on the hardware/software you test, what if someone
> deliberately wishes to measure jitter of more than this or he is just
> out of luck and gets huge values?
> Also, the limit will change if the type of average changes, but if it
> is calculated in the way I proposed, it will always work.
> Apart from this, since the benign possibility exists - why not to fix this=

> if the fix is easy.
>=20
> cheers,
> Piotr
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
