From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: RT patchset naming convention
Date: Sat, 30 Dec 2017 09:37:11 -0500
Message-ID: <CAF_dkJCFuv0mXB7chObC=h0oS5RwSEvaLWsV-Y8-XUh4C-abRw@mail.gmail.com>
References: <CAF_dkJDQy-ONu59RG4HbiuYPEm+DA1zqME8pQp7VdUspcsptVA@mail.gmail.com>
 <20171230060728.398d1845@archlinux.localdomain> <20171230061848.1918cd85@archlinux.localdomain>
 <CAJjrzcX21K54qnTA0iRpJsnvwvkceWus1wffSjSHHAhXkSgjMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-rt-users@vger.kernel.org
To: Arve Barsnes <arve.barsnes@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34814 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdL3Ohm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 30 Dec 2017 09:37:42 -0500
Received: by mail-ot0-f193.google.com with SMTP id n18so30197191otd.1
        for <linux-rt-users@vger.kernel.org>; Sat, 30 Dec 2017 06:37:42 -0800 (PST)
In-Reply-To: <CAJjrzcX21K54qnTA0iRpJsnvwvkceWus1wffSjSHHAhXkSgjMg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Dec 30, 2017 at 6:21 AM, Arve Barsnes <arve.barsnes@gmail.com> wrote:
> On 30 December 2017 at 05:18, Ralf Mardorf <ralf.mardorf@alice-dsl.net> wrote:
>>
>> 4.9.61-rt61
>> 4.9.68-rt60
>>
>> It's somewhat unusual that the kernel version does increases and the rt
>> patch version decreases, usually it's vice versa ;).
>
> That's probably a spelling error in some way, 4.9.61 had the -rt51
> patch set, and no -rt61 patch set has been announced as far as I could
> find. Meaning -rt60 is the latest one :)

Sorry for the confusion... I know better than to post a question when
I'm tired and grumpy... but unfortunately, discretion is one of the
virtues I lose when I'm tired and grumpy :-)

I was looking at the patches available at
https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/

I was confused by names such as:
patch-4.9.61-rt51-rt52-rc1.patch.gz
patch-4.9.65-rt56.patch.gz
and
patches-4.9.61-rt61.tar.gz
(and, yes indeed, there are both patches-4.9.61-rt61.tar.gz and
patches-4.9.68-rt60.tar.gz available there)

I should have just stopped and looked more carefully before I posted
my question... in hindsight, it is clear to me that the
patch-*A-B.patch.gz file is a patchset to go from A to B, whereas the
patches-X.gz file is the entire set of patches for release X.

So, sorry for the spam.

But I do remain curious as to the best approach to take to apply
patches to my vendor supplies 4.9.51 kernel.  There appear to be no
patches available for any of the 4.9.5x kernels (the "older"
subdirectory contains patches for kernel 4.9.47 and 4.9.61, but
nothing for kernel revisions between those two).

What is the best approach to take here?
I could go down a path of working with the (ARM chip) vendor to bump
up to an rt-linux supported kernel rev.
I could just apply the 4.9.61 patchset to my 4.9.51 kernel, see that
they apply, and run from there.

(For the moment, I'm starting with plan "b", and will contact my
vendor about plan "a").

--wpd
