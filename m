From: "John Kacur" <jkacur@gmail.com>
Subject: Re: 2.6.25.8-rt7 Bugs
Date: Fri, 1 Aug 2008 11:04:01 +0200
Message-ID: <520f0cf10808010204v50b4146fue567c3e8c9db1e53@mail.gmail.com>
References: <48928BE4.6030509@smiffytech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Matthew Smith" <matt@smiffytech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.181]:26638 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbYHAJEF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Aug 2008 05:04:05 -0400
Received: by ik-out-1112.google.com with SMTP id c28so980255ika.5
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Aug 2008 02:04:02 -0700 (PDT)
In-Reply-To: <48928BE4.6030509@smiffytech.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Aug 1, 2008 at 6:07 AM, Matthew Smith <matt@smiffytech.com> wrote:
> Hi Folks
>
> I am trying to run 2.6.25.8-rt7, patched via the RT version of ketchup
> on my ThinkPad (Core2Duo CPU) to provide a low-latency base for audio
> applications (Jack, Rosegarden, Hydrogen, Zynaddsubfx).
>
> Jack is throwing xruns and, on boot, I am seeing a load of bugs (the
> actually say BUG) so I have been advised to post my bugs here.  Here's
> my dmesg:
>
> <http://www.smiffysplace.com/files/dmesg_rt_20080801>
>
> And my kernel configuration:
>
> <http://www.smiffysplace.com/files/kconfig_rt_20080801>
>
> Have I configured something wrong, or is this a real bug?  I'm quite
> happy to try other kernel versions but don't want to move to a 2.6.26 as
> there are other driver issues that affect me and don't really want to go
> any older than the Gentoo-patched 2.6.23 that I am running for general
> use (I'm dual-booting to the RT kernel).
>
> Just in case it's relevant, I can't disable ACPI; this machine has
> either a design or a manufacturing fault - if I don't manually set the
> fan to run at full speed all the time, the GPU (I think) overheats and
> the whole thing locks up.
>
> Cheers

Hi Matthew

If you don't want to move up to a 2.6.26 kernel, I wonder if you
should try the latest 2.6.24 rt kernel which is 2.6.24.7-rt17
http://rt.et.redhat.com/download/

Good Luck
John
