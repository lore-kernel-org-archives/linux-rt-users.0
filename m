Return-Path: <SRS0=sCGC=UU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE809C43613
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jun 2019 10:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5871208C3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jun 2019 10:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7jc4gh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfFUKeX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:34:23 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35036 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFUKeT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Jun 2019 06:34:19 -0400
Received: by mail-oi1-f176.google.com with SMTP id a127so4326156oii.2
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2019 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0RLkoUb2/1pClVPN2BX8urv8fWlCgxgYV5jTd+sDW4=;
        b=C7jc4gh3pY7YRAmPpWFRzNW149jTcTO9vhUMEKWk4GvsTaCjC0Nw0avGuSfffgdtTI
         Og+50ciuMIxo3Zn2Jj/2ec4S0Wg6GcG2jK7ccZ9uqNc5PAeuzC+uw5jrnlN3pASppUfD
         CHoeM2t4QSPeetaNMrYRqHjxACzpqhyh3jj7nAFqY12Lm4SkvwIQJuaXqzQoQViw7X3R
         id7SchLbJLaLZrgHl8/pCCC3ksvFv5xN84yyX8HmJ0RVdbAJCdTjWM7V3EFdUPZ/5ftN
         DMPwwHrvfJvdRjmRexCORIqNiqujATR7WiTxiDcoEInfTy0L9E2k80Yvj52C0HvA/6dR
         G1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0RLkoUb2/1pClVPN2BX8urv8fWlCgxgYV5jTd+sDW4=;
        b=U/nSo9+0qhdT3F3DXY/Kxz/RWSa3TDleJyREIyjpoeRJSFvk3i87dQ43VwqZB1SipO
         Q9V5hXqPqfsKgBVbcZtMDBERSp7N1NOxIKkgwbQilS6fg1NpIav3S7wZoXk3dISUz6Vz
         JJBjA5AHfZm/vFCb05PlHUQz7vY1AFylhU8DebIMB/WSnOoJ+ctOa7a0qMKGDrENxnZ5
         D/lcp2BKa0/YAU2DY+z20z//F9tbEkxcWSI/lBrzjXzoAYwKiTyj1sA1IFz0Tn+tcwFL
         gBGv7a+AEdEd+t6PJdP9WtlHjJZvfMrQxOzOB2/R+4zpiVvZSAgEpph8CfXpb6bi7Yde
         G0Pw==
X-Gm-Message-State: APjAAAVbqQcKYFf0PwJUFdzjAtLgUHrCQFF0Q9w17CbUP/opL3aizrdl
        +mgwpwgm+en8z0wJfdmXSsHz7k8perdaxVQ/lLQ=
X-Google-Smtp-Source: APXvYqwdFGK91zBQziecTN3MhHr8weT5hBm5egRffuES6DS2QR1mr7bJxGqhnjc2DQOHi1LDEUbycC+BjGRz+y1dk1w=
X-Received: by 2002:aca:170d:: with SMTP id j13mr2245547oii.77.1561113258629;
 Fri, 21 Jun 2019 03:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAEVNDXsR03jGXKO5diQbjMQecS=wXxdEW5eGQAAL1PPOQ_RO6Q@mail.gmail.com>
 <CAJfkoWqsPJoxeQwxCYAU1kG6ny5BBuiTCpiqM+KgAsZH58trbw@mail.gmail.com> <CAEVNDXv88RvDgWDhxD=3XW=0kO3TSBYy57q0s1u985z1TaaFVg@mail.gmail.com>
In-Reply-To: <CAEVNDXv88RvDgWDhxD=3XW=0kO3TSBYy57q0s1u985z1TaaFVg@mail.gmail.com>
From:   Luca Abeni <lucabe72@gmail.com>
Date:   Fri, 21 Jun 2019 12:34:07 +0200
Message-ID: <CAJfkoWp=eDa86x7EmAdqa1chSsLRMPBg=XnqaeBPP+H2La1XNg@mail.gmail.com>
Subject: Re: sched_deadline sched_setattr fails after setting cpuset
To:     Ming Yang <minos.future@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On Fri, 21 Jun 2019 at 02:54, Ming Yang <minos.future@gmail.com> wrote:
[...]
> I have a question about the admission test with cpuset.  Is the
> sched_deadline admission test examined with respect to the CPUs
> allowed in the cpuset?

Yes, in theory you should be able to use up to 95% (or whatever you
configured in /proc/sys/kernel/sched_rt*) of the CPUs contained in the
cpuset.

I am pretty sure it worked correctly when I tested this, but it was a
lot of time ago...

> I get deterministic admission test result without cpuset.  m-1 cores
> can be utilized (not m?).

The maximum SCHED_DEADLINE utilization should be 95% of m (unless you
changed the values in /proc/sys/kernel/sched_rt_{runtime,period}_us).


> But with cpuset, the total utilization of accepted sched_deadline
> tasks seems not respecting the cpuset and changes every run.  For
> example, if cpuset contains 4 cores, I can have task sets (bound to
> this cpuset) utilizing 400%, 600%, or 300% before failing to add
> another task. It could be my program's issue. I'm still looking into
> it.

If you get this result, I suspect you found a bug... Can you provide a
simple testcase for reproducing int?


Luca
