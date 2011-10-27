From: jordan <triplesquarednine@gmail.com>
Subject: Re: rt for newbie
Date: Thu, 27 Oct 2011 16:47:14 -0400
Message-ID: <CAOcfFMx2akKGygxUVAX85+AntwJOM0o8NY=gdnGeWL2da1jhTg@mail.gmail.com>
References: <CADZpk3tRdH2uPw-Kq_qiowThtBicqP=0S-=knvgYCSNfUrY+kw@mail.gmail.com>
	<CAOcfFMyOZ5zu9NgS4tdw8eVm0fU88R6rtOmODNN5mRAAwuAHew@mail.gmail.com>
	<CADZpk3sbagk7nTfjuXpvwtoDd6U+4sY_W=eH9+jowuUqpjFvfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: sashka@mail.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43367 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab1J0UrO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Oct 2011 16:47:14 -0400
Received: by iaby12 with SMTP id y12so3310483iab.19
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Oct 2011 13:47:14 -0700 (PDT)
In-Reply-To: <CADZpk3sbagk7nTfjuXpvwtoDd6U+4sY_W=eH9+jowuUqpjFvfQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Oct 27, 2011 at 3:47 PM, Sashka <sashka@mail.ru> wrote:
> Hi,
>
>> What Linux distribution are you using?
> I should have mentioned that. I've got Centos 6.

Ah, now i see. You alsmot definitely have to compile it yourself. ;)

>> https://aur.archlinux.org/packages.php?ID=51360
> thanks

No, problem.

> I've got it build several time. I'm confused with all those different
> guides telling me what to enable and disable. Most of them are
> outdated, as I can see.
> rtwiki is down for some time, so I can't see if there is anything
> updated to 3.0-rt.

Yeah, that is the unfortunate way of the internet, and also the lack
of good documentation available in some situations relating to linux.

That being said, you could actually look inside the PKGBUILD for
linux-rt, and see from the commandline how various things were
applied. ie: the patching, etc. it's just that obviously, because Arch
isn't CentOS - not everything applies.

but it might be helpful anyways, you can check that, and consult
CentOS/RHEL documentation for the rest (which it sounds like you
already know anyway).

cheerz
