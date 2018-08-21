Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48030 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726780AbeHURCl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Aug 2018 13:02:41 -0400
Date: Tue, 21 Aug 2018 08:42:21 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: kernel freeze when running docker
Message-ID: <20180821134221.GC8562@jcartwri.amer.corp.natinst.com>
References: <CAH3OF51v8_KK_XF_sttVzSddmWoLUvVOjbUvKr2OuiJTLntTQQ@mail.gmail.com>
 <20180821012731.GB8562@jcartwri.amer.corp.natinst.com>
 <CAH3OF50F26ywGHZ2Rfa7v-SeoZ6KccSPt+1uNq65eBNTqom=-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH3OF50F26ywGHZ2Rfa7v-SeoZ6KccSPt+1uNq65eBNTqom=-A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Vignesh Raman <vignesh.raman.in@gmail.com>
Cc: linux-rt-users@vger.kernel.org

Hello Vignesh-

On Tue, Aug 21, 2018 at 07:03:20PM +0530, Vignesh Raman wrote:
> Hi Julia,
> 
> > On Tue, Aug 21, 2018 at 6:57 AM Julia Cartwright <julia@ni.com> wrote:
> > Serial console is really the best way to go, especially if the higher
> > level tools (crash, pstore, etc.) aren't functioning properly.  With the
> > hopes that you can get an oops or panic message...
> 
> Added 'debug systemd.journald.forward_to_console=1 pause_on_oops=120' to
> kernel boot parameters. When the freeze/reset happens with the docker test
> case, the kernel oops/panic is not seen in the serial console.

That's annoying.  When you are in this state can you trigger a dump via
the magic sysrq sequence over serial?

Have you tried enabling the various lockup detectors?  There is a
software-driven one, and an NMI watchdog based one.  Enabling both
at the same time should be fine.

   Julia
