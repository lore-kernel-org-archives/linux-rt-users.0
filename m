Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-wr1-f46.google.com ([209.85.221.46]:36493 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeHQNbI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Aug 2018 09:31:08 -0400
Received: by mail-wr1-f46.google.com with SMTP id m27-v6so425841wrf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Aug 2018 03:28:13 -0700 (PDT)
Date: Fri, 17 Aug 2018 12:28:10 +0200
From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <20180817102810.GC27071@localhost.localdomain>
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tim Blechmann <tim@klingt.org>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org

On 17/08/18 18:08, Tim Blechmann wrote:
> hi juri,
> 
> >>> i wonder, what's the preferred way to obtain SCHED_DEADLINE privileges
> >>> as non-root user?
> >>
> >> Hi Tim,
> >>
> >> It is still not possible to use sched deadline as a non-root user :-(.
> > 
> > Indeed, but Tim, is this hindering you from experimenting/using
> > DEADLINE?
> 
> it's a showstopper for using it in audio applications, which are running
> as user.
> audio applications typically use SCHED_FIFO. however they are
> rate-monotonic by design, so i wanted to evaluate how SCHED_DEADLINE
> behaves here.

Right. Exactly what I started to think about lately as well.

> 
> > Asking because we might want to have a look at how to relax the current
> > privileges requirement.
> 
> please :)

Anything to try attracting new users. :-P

More seriously, could you please describe in a bit more details your
specific use case? Based on JACK I guess? Is it the application you are
interested into public available somewhere?

Thanks,

- Juri
