From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Linux stable vs RT stable and RT dev
Date: Tue, 6 Feb 2018 15:34:26 +0100
Message-ID: <20180206143426.fdzs6hnvmakqdwiu@linutronix.de>
References: <8155aea247374c058bd7c797124c3d28@ti.com>
 <20180202214611.GD868@jcartwri.amer.corp.natinst.com>
 <1c47b7e6-86d0-cbb0-9b72-7b7d63e46ddc@ti.com>
 <6eecb69a-e60f-f837-bc2c-a627e2660027@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Mills <wmills@ti.com>, Julia Cartwright <julia@ni.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, rostedt@goodmis.org,
        "Hernandez, Carlos" <ceh@ti.com>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
To: Dan Murphy <dmurphy@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54959 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeBFOee (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Feb 2018 09:34:34 -0500
Content-Disposition: inline
In-Reply-To: <6eecb69a-e60f-f837-bc2c-a627e2660027@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2018-02-05 15:17:56 [-0600], Dan Murphy wrote:
> We are catching warnings and errors with these defconfigs.  I have reported 2 warnings but
> I have not received a response.  I guess I should report these to this list as opposed to the maintainers.

You reported two warnings to my private address while I was traveling.
The usual workflow for reporting is to send this to the mailing list and
Cc the RT maintainer(s) (which would contain the email address I am
using right now).

> We have a "next" process that runs nightly that merges in the stable rc candidate into our branch
> so we can anticipate if the new stable or TI developer branches will cause a merge conflict when merged into our branch sets.
> 
> For instance 4.14.17 stable rc caused a merge conflict in the hrtimer.c file. This became a known issue as soon as the stable rc was
> available.  The RT 4.14 upstream branch is currently on 4.14.15 so now our RT branch is blocked from receiving a new stable until the
> RT upstream branch is updated.

I usually do a new release once I have something in my pipe or if people
ask to update new stable due to $reason.

> Dan

Sebastian
