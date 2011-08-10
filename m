From: Oon-Ee Ng <ngoonee.talk@gmail.com>
Subject: Re: 3.0.1-rt8 + Nvidia
Date: Wed, 10 Aug 2011 12:11:00 +0800
Message-ID: <CAGQ70etT_LO4GV9wvcPyMJfeYiV-m-_y7dAbG-qfgceTcbPQFQ@mail.gmail.com>
References: <CAOcfFMyObtC2qeqRBxo-cDGaDLHrPdHXmfQc=fujY64dRVBHPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52013 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab1HJELB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Aug 2011 00:11:01 -0400
Received: by eyx24 with SMTP id 24so568965eyx.19
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Aug 2011 21:11:00 -0700 (PDT)
In-Reply-To: <CAOcfFMyObtC2qeqRBxo-cDGaDLHrPdHXmfQc=fujY64dRVBHPw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Aug 10, 2011 at 11:00 AM, jordan <triplesquarednine@gmail.com> =
wrote:
> Hi everyone,
>
> First i'd like to thank all of the RT developers for pushing 3.0-rt
> out. =A0I had (somewhat) been keeping an eye, on the list fro progres=
s ~
> when i decided tonight to install 3.0.1-rt8 (as this seems to be
> fairly solid now).
>
> the compile and install went fine, successful boot, etc.
>
> Now, i have a question. Does Nvidia 280.13 need to be patched for RT?
>
> I am an Archlinux user, and usually i would expect to see a pkgbuild
> in the Arch User Repository for Nvidia-rt (driver + patch), but so fa=
r
> i have not run across an nvidia patch..
>
> if anyone knows the status on this, or has the available patch -
> please let me know.
>
> thanks
>
> jordan

This is covered on another thread on this list. You need to 'patch'
the kernel, not the driver, some symbols are exported as GPL which
prevents the driver from being used.

This is a licensing issue though, so I've held off implementing that
patch in my own kernel PKGBUILD in Arch (linux-rt-ice). I think it is
illegal to distribute such a patch, though using it on your own
machine may be fine (those who are more knowledgable should correct me
on this).
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
