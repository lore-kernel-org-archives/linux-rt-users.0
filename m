From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: debian 8 rt kernel
Date: Fri, 13 Jan 2017 11:36:14 +0100
Message-ID: <20170113113614.0f7db08a@archlinux.localdomain>
References: <CADzbtTJ8BAX+HaBQkxe8_YOjX7RKyghNz5jS8UToEoSbMXXo3w@mail.gmail.com>
        <20170113075215.GF2532@falbala.home.lespocky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail76c50.megamailservers.eu ([91.136.10.86]:35196 "EHLO
        mail70c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751356AbdAMKgS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Jan 2017 05:36:18 -0500
Received: from archlinux.localdomain (x5ce0d113.dyn.telefonica.de [92.224.209.19])
        (authenticated bits=0)
        by mail70c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id v0DAaDMQ020678
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Jan 2017 10:36:15 +0000
In-Reply-To: <20170113075215.GF2532@falbala.home.lespocky.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 13 Jan 2017 08:52:15 +0100, Alexander Dahl wrote:
>Ubuntu Studio

Hi,

I'm an Arch Linux user, but I'm helping users with Ubuntu flavours,
including Ubuntu Studio.

The Ubuntu repositories provide a so called "lowlatency" kernel,
without the rt patch. I doubt that this is much better than a vanilla
kernel with threadirqs as boot option. It's easy to build the linux-rt
packages for Ubuntu flavours, but Ubuntu Studio has got other pitfalls,
too.

Ubuntu Studio is a distro for artists, it's not optimised for
musicians. The default is a jackdbus-pulseaudio mix/mess. While I'm an
Arch user, I anyway set up a tailored Ubuntu install, based upon a
minimal install from a server image.
The Ubuntu policy is to start all services provided by package, so the
user needs to disable all unwanted services, even when starting with a
minimal install, but at least such an install doesn't come with
pulseaudio and you could chose jackd instead of jackdbus.

I recommend against Ubuntu Studio, if a user should be unwilling to
check everything on her own and unwilling to set up everything on her
own. You even can't be sure that somebody really cares that rtirq and
the used kernel fit to each other.

Btw. there's nothing wrong with even using a vanilla kernel with
threadirqs as boot option. In regards to audio latency and MIDI jitter
there are a lot of things to consider, e.g. unbinding USB ports that
share unfavourable IRQs, caring about the CPU frequency handling ...

In my more than a decade of Linux audio experiences IMO the best
approach is to set up everything on your own, by optimizing several
settings. Without knowing all "audio distros" I anyway recommend
against just installing an "audio distro". In my experiences the work
that has to be done by the user is the same for "normal" distros and
"audio distros".

YMMV!

Regards,
Ralf
