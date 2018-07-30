Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-oi0-f54.google.com ([209.85.218.54]:47059 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeG3XDf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Jul 2018 19:03:35 -0400
Received: by mail-oi0-f54.google.com with SMTP id y207-v6so24020945oie.13
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Jul 2018 14:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAF_dkJC2UqpDVGzF4K575_hZYii_-OL6H1h=nNO8mTQm4QK2SQ@mail.gmail.com>
 <20180730205931.GL29574@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20180730205931.GL29574@jcartwri.amer.corp.natinst.com>
From: Patrick Doyle <wpdster@gmail.com>
Date: Mon, 30 Jul 2018 17:26:15 -0400
Message-ID: <CAF_dkJAHfM6QO7UUeyf8YqVmniDLrhBJoVkVJvGwfPC8rED42Q@mail.gmail.com>
Subject: Re: How to apply RT patches to a kernel not listed in http://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: julia@ni.com
Cc: linux-rt-users@vger.kernel.org

On Mon, Jul 30, 2018 at 5:00 PM Julia Cartwright <julia@ni.com> wrote:
> Most of the major vendors make available RT variants in their official
> repos, have you checked with them?
>
Thank you Julia.  I do not believe that they have an rt variant
(although I can push on that when my FAE returns from vacation next
week).

> I'm in the process of cooking up a version on top of v4.9.116 this week.
> This doesn't directly address your problem, as it still may not apply
> on top of your v4.9.109 vendor kernel, but might get you closer.
Wow!  That's timely.  I'm rebasing v4.9-rt on top of v4.9.109 now.  If
that blows up in my face, I'll look for your patch and try again.
(That will be plan C.)

It turns out that there is a v4.9.87-rt65 in the linux-rt tree, but it
doesn't apply to the linux-at91 tree because they have a customized
variant of kernel/softirq.c.  (They had to revert an earlier commit on
mainline).  Since I am likely to want a newer kernel in the future
anyway, I figured I would try the rebase effort first, and have the
create-a-patch-to-revert-the-revert approach as a plan B.

--wpd
