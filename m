From: Vasudev Kamath <kamathvasudev@gmail.com>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Mon, 12 Sep 2016 15:51:20 +0530
Message-ID: <CAK+NOPW3t0GmPdiaYBsLRNBFh3LT3pcYWbQ7UEDLZef4hbxhOA@mail.gmail.com>
References: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
 <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de> <20160808164505.GA13707@linutronix.de>
 <CAL7_A_Vz+BCg-QXraob1ndDF4b3ggGN-j+fnQ9FTqY1FdbVvug@mail.gmail.com>
 <20160812123735.zboeocbv4o5sjnwb@linutronix.de> <CAL7_A_WcvqmghJiQaDdnYRZmPf9=-s3eveMfM1uYtHfKykbmVg@mail.gmail.com>
 <1e95689e-ae42-7f47-03ff-732f1bc4841c@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34814 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbcILKVl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Sep 2016 06:21:41 -0400
Received: by mail-oi0-f50.google.com with SMTP id m11so303224028oif.1
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Sep 2016 03:21:40 -0700 (PDT)
In-Reply-To: <1e95689e-ae42-7f47-03ff-732f1bc4841c@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Sep 12, 2016 at 2:46 PM, Stanislav Meduna <stano@meduna.org> wrote:
> This got my attention as I have hunted some very similar looking
> thing 3 years ago:

When we first started facing this issue, we had explored almost all of
your threads about throttling :-), but we never found a proper answer.
We did not know exact way to reproduce the issue of throttling except
setup running for few days 2-3 will result in throttling. Only one
common behavior in every case of throttling  throttled thread had
minor page fault of 900k to 1m.

When we read description of patch from Sebastian, we had a gut feeling
it may be our case as we were also a x86 UP system and we also had
minor page faults during throttling.

After using patch we did not faced throttling even after running
couple of weeks.

Cheers,
-- 

Vasudev Kamath
https://copyninja.info
