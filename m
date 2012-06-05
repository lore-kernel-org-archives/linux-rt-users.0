From: Glenn Elliott <gelliott@cs.unc.edu>
Subject: Re: nvidia bug or RT bug?
Date: Tue, 5 Jun 2012 23:32:50 +0000 (UTC)
Message-ID: <loom.20120606T011822-880@post.gmane.org>
References: <CAOcfFMwkXC1Ozs3+QhKUU18JY4KDzNaxAuLq34r+PQOCipSFSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33282 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514Ab2FEXfL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jun 2012 19:35:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Sc3HE-00009x-IJ
	for linux-rt-users@vger.kernel.org; Wed, 06 Jun 2012 01:35:07 +0200
Received: from searspoint.nvidia.com ([216.228.112.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Jun 2012 01:35:04 +0200
Received: from gelliott by searspoint.nvidia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Jun 2012 01:35:04 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

jordan <triplesquarednine <at> gmail.com> writes:

> I've been using linux-rt-3.0 series, which has been very stable using
> the nvidia proprietary drivers (pretty much flawlessly, actually). I
> had used rt-3.0 with nvidia all the way upto nvidia version 290.35. I
> never experienced any problems relating to nvidia, at all... But
> external/other reasons, recently I have upgraded to rt-3.2 which also
> seems to be working quite well. At the same time, i also upgraded my
> nvidia driver to the latest available driver, which is 302.07 (beta).

I've used the 270 drivers with an older version of PREEMPT_RT.  However,
I had to modify the GPL layer code to make the compilation/install go
through.  Did you have to do the same?

In the GPL layer (which you can extract from the *.run driver package),
I had to  edit kernel/nv-linux.h and update the NV_SPIN_*LOCK() to call
raw_spin_*lock().  (Using raw spin locks seemed like the only safe thing
to do, given the closed-source nature of the driver.)

I haven't looked at the 290 GPL layer, so I don't know if this
spinlock edit is still necessarily.

Another interesting edit is to enable MSI interrupts.
In kernel/nv-reg.h, change the line 
"NV_DEFINE_REG_ENTRY(__NV_ENABLE_MSI, 0);"
to
"NV_DEFINE_REG_ENTRY(__NV_ENABLE_MSI, 1);"

After your edits, simply do "make module; make install" from within the
kernel  directory to install the custom driver to the currently running
kernel (you'll probably want to run the full installer first to pick up
the various shared libraries and X configurations).

I've found that the GPL layer code changes rarely, so I believe there
is a good chance that these edits will still be valid.

-Glenn

