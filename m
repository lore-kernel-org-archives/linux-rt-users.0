From: Daniel Vidal <danielvidalchornet@gmail.com>
Subject: Re: debian 8 rt kernel
Date: Sat, 14 Jan 2017 10:12:11 +0100
Message-ID: <CAObZbXRd8WBBN=9LWfppvz=c9_MjxtpLeagCTGD76TOT6dqYgQ@mail.gmail.com>
References: <CADzbtTJ8BAX+HaBQkxe8_YOjX7RKyghNz5jS8UToEoSbMXXo3w@mail.gmail.com>
 <20170113075215.GF2532@falbala.home.lespocky.de> <20170113113614.0f7db08a@archlinux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36766 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbdANJMN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 14 Jan 2017 04:12:13 -0500
Received: by mail-wm0-f42.google.com with SMTP id c85so95081109wmi.1
        for <linux-rt-users@vger.kernel.org>; Sat, 14 Jan 2017 01:12:12 -0800 (PST)
In-Reply-To: <20170113113614.0f7db08a@archlinux.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi.

I compile and pack a rt patched kernel for the newest longterm kernel.
Now i run 4.4.38 with rt49 patch.

x64-v3:~$ uname -a
Linux x64-v3 4.4.38-rt49 #1 SMP PREEMPT RT Mon Dec 19 10:28:46 CET
2016 x86_64 GNU/Linux
x64-v3:~$

Is a blobed kernel (not strict free kernel).

if someone send me a site or FTP to upload i can share the packages.

I build bin, headers and source packages.

sorry for my english.

2017-01-13 11:36 GMT+01:00 Ralf Mardorf <ralf.mardorf@alice-dsl.net>:
> On Fri, 13 Jan 2017 08:52:15 +0100, Alexander Dahl wrote:
>>Ubuntu Studio
>
> Hi,
>
> I'm an Arch Linux user, but I'm helping users with Ubuntu flavours,
> including Ubuntu Studio.
>
> The Ubuntu repositories provide a so called "lowlatency" kernel,
> without the rt patch. I doubt that this is much better than a vanilla
> kernel with threadirqs as boot option. It's easy to build the linux-rt
> packages for Ubuntu flavours, but Ubuntu Studio has got other pitfalls,
> too.
>
> Ubuntu Studio is a distro for artists, it's not optimised for
> musicians. The default is a jackdbus-pulseaudio mix/mess. While I'm an
> Arch user, I anyway set up a tailored Ubuntu install, based upon a
> minimal install from a server image.
> The Ubuntu policy is to start all services provided by package, so the
> user needs to disable all unwanted services, even when starting with a
> minimal install, but at least such an install doesn't come with
> pulseaudio and you could chose jackd instead of jackdbus.
>
> I recommend against Ubuntu Studio, if a user should be unwilling to
> check everything on her own and unwilling to set up everything on her
> own. You even can't be sure that somebody really cares that rtirq and
> the used kernel fit to each other.
>
> Btw. there's nothing wrong with even using a vanilla kernel with
> threadirqs as boot option. In regards to audio latency and MIDI jitter
> there are a lot of things to consider, e.g. unbinding USB ports that
> share unfavourable IRQs, caring about the CPU frequency handling ...
>
> In my more than a decade of Linux audio experiences IMO the best
> approach is to set up everything on your own, by optimizing several
> settings. Without knowing all "audio distros" I anyway recommend
> against just installing an "audio distro". In my experiences the work
> that has to be done by the user is the same for "normal" distros and
> "audio distros".
>
> YMMV!
>
> Regards,
> Ralf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
