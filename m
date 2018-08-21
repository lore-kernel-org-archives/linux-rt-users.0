Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45312 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeHUK5l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Aug 2018 06:57:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so9006559wrb.12
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Aug 2018 00:38:38 -0700 (PDT)
Date: Tue, 21 Aug 2018 09:38:34 +0200
From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <20180821073834.GA24428@localhost.localdomain>
References: <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
 <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
 <4c58c94c-d99d-9f08-a5a3-710defc612c8@bristot.me>
 <dfe1cea0-089d-fed9-a349-23de2660889e@klingt.org>
 <e207a65d-b1af-3fb1-8802-d1c05c0a9118@bristot.me>
 <05fbd5a4-f354-e084-cf40-8488548d7cb1@klingt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05fbd5a4-f354-e084-cf40-8488548d7cb1@klingt.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tim Blechmann <tim@klingt.org>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Luca Abeni <luca.abeni@santannapisa.it>, Alessio Balsini <alessio.balsini@santannapisa.it>

On 21/08/18 00:45, Tim Blechmann wrote:

[...]

> apart from that, i'm only missing two features:
> 
> * using SCHED_DEADLINE from user applications is kind of a showstopper
> for me

Right. Would you be up for continuing experimenting with DEADLINE (while
we get our heads around removing this constraint) by - ugly hack warning
- removing the check at

https://elixir.bootlin.com/linux/latest/source/kernel/sched/core.c#L4216

?

I guess it would be good if you could provide even more feedback than
you already did, so that we can plan ahead what needs fixing/changing or
implementing.

BTW, thanks a lot already for this discussion! :-)

> * a nicer glibc wrapper, that allows me to use pthreads rather than
> using `syscall`: it's all pretty easy to obtain the `tid` for a calling
> thread (gettid), but it seems to be impossible to obtain the `tid` from
>  `pthread_t` without some hacks which are way too dirty to share in
> public ...

Indeed. We have been basically relying on

https://github.com/scheduler-tools/rt-app/tree/master/libdl

so far. But, I guess it's time - it has been time for a while - that we
reach glibc guys and try to understand why this is not yet all in the
standard libraries.
