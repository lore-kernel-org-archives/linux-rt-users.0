From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: Ubuntu 16.04 with Intel i7-6700
Date: Thu, 10 Nov 2016 12:58:16 +0100
Message-ID: <CALqGcGqifgU04OBo2win-jJRzk3VAypB-XYJ9PE=e+2jWfuJVw@mail.gmail.com>
References: <CAK+oA4U8=YwZb5ewpZSDRO+FPv1EgvvbSgoumdooaunTXKsjCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Piotr Gregor <piotrgregor@rsyncme.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:36271 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932474AbcKJL6X (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Nov 2016 06:58:23 -0500
Received: by mail-it0-f52.google.com with SMTP id q124so229566511itd.1
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Nov 2016 03:58:18 -0800 (PST)
In-Reply-To: <CAK+oA4U8=YwZb5ewpZSDRO+FPv1EgvvbSgoumdooaunTXKsjCg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Thu, Nov 10, 2016 at 1:39 AM, Piotr Gregor <piotrgregor@rsyncme.org> wrote:
> What is your experience with Ubuntu (16.04)
> and rt preempt.
> What is your experience with rt preempt and Intel Core i7-6700?

We are very happy with our Ivy Bridge systems (i7-3700). But we are
not yet happy with Skylake (like i6700), especially when there is some
GPU load. But you can take a look here, the system seems to perform OK
(not ours):

https://www.osadl.org/Latency-plot-of-system-in-rack-c-slot.qa-latencyplot-rcs0.0.html?shadow=0

> Is there any definite "no" for Ubuntu as a real-time operating system?

We have used Ubuntu for ages (since 8.04 IIRC) as a development
environment. For a kernel we use an lts-kernel with PREEMPT_RT
patchset. We never bothered with Ubuntu-specific kernel patches. We
use lxc containers to host the development environment, which allows
us to target different distributions or Ubuntu releases.

A complete Ubuntu desktop system brings along a quite complex default
configuration (resolvconf, AppArmor, NetworkManager to just name a
few) which you might have to deal with depending on your scenario. But
so far, I never got the impression that Ubuntu is not a good fit as a
development system for realtime applications. A lot of stuff just
works out of the box, installation is trivial and you get regular new
releases.

We only use Ubuntu LTS releases. They get new hardware support from
time to time (backports of kernel and Xorg from newer Ubuntu releases)
which makes it possible to even skip a LTS release, using PPA for
software we really care about.

Disclaimer: Since we are quite happy with Ubuntu/Debian I never
checked out other distros.

> Would it be better to start from Debian?

We switched our target to Debian this year. Partly out of licensing
consideration, partly because snapshot.debian.org is just a fantastic
service for long lived software.

I don't know where Ubuntu is heading. I get the impression that they
want to differentiate themselves more and more from the rest of the
Linux ecosystem (e.g. Wayland vs Mir) which I don't see as an
advantage because it will limit how much we can profit from other
peoples experience with different distros.

HTH
Christoph
