From: Julia Cartwright <julia@ni.com>
Subject: Re: [4.9-rt][report] latency with i915 on skylake
Date: Tue, 16 Jan 2018 12:25:03 -0600
Message-ID: <20180116182503.GV1153@jcartwri.amer.corp.natinst.com>
References: <CALqGcGr06F8POQT+JGj0f7xRYXCtkF3j=btnhXqERqdm6MeP=A@mail.gmail.com>
 <c3d12b4904bb4b88903e8a92680e3ed3@KEB10314.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Christoph Mathys <eraserix@gmail.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
To: eg Engleder Gerhard <eg@keba.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:36438 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750885AbeAPSZK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jan 2018 13:25:10 -0500
Content-Disposition: inline
In-Reply-To: <c3d12b4904bb4b88903e8a92680e3ed3@KEB10314.keba.co.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jan 16, 2018 at 08:55:49AM +0000, eg Engleder Gerhard wrote:
> Hello Christoph,
>
> > On a Intel G4400 "Skylake" with kernel 4.9.47-rt37 I get a
> > reproducible latency spike (>200us) when the screen goes to standby.
> > The display is connected to the onboard DVI connector. The same
> > thing works fine on an older Ivy Bridge CPU. To trigger the spike
> > when in Xorg I use:
> >
> > xset dpms force off
> >
> > After setting the options below for the i915 kernel module I was no longer able to
> > reproduce the spikes:
> > - enable_rc6=0
> > - enable_dc=0
> > - disable_power_well=0
>
> Similar on our side, but we reduced it and are using only enable_dc=0. CPU is
> Celeron 3955U (Skylake).
>
> To be more detailed, a PCIe read command of our real-time software was blocked
> for >200us.

Have you been able to identify which of the read(s) are problematic?

We've identified register access patterns in other drivers that can be
reworked to not introduce large latency spikes.  Maybe that's on option
here, but it will require some tracking down of exactly where this is
happening.

Thanks,

   Julia
