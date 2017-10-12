From: Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] v4.11.12-rt15
Date: Thu, 12 Oct 2017 10:28:53 -0400
Message-ID: <201710121028.53449.gheskett@shentel.net>
References: <20171011103530.llpmvu36bekaixzh@linutronix.de> <201710111516.35276.gheskett@shentel.net> <20171012064208.2e6cfe22@archlinux.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org,
        EMC developers <emc-developers@lists.sourceforge.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda.cloud.shentel.net ([204.111.1.144]:53955 "EHLO
        barracuda.cloud.shentel.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751492AbdJLO25 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Oct 2017 10:28:57 -0400
In-Reply-To: <20171012064208.2e6cfe22@archlinux.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thursday 12 October 2017 00:42:08 Ralf Mardorf wrote:

> On Wed, 11 Oct 2017 15:16:35 -0400, Gene Heskett wrote:
> >git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> >v4.11.12-rt15
> >
> >does not exist.
>
> Hi Gene,
>
> I'll download and build from
>
> https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.11.tar.xz
> https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.11.tar.sign
> https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.11.12.xz
> https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.11.12.sign
> https://www.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4
>.11.12-rt15.patch.xz
> https://www.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4
>.11.12-rt15.patch.sign
>
> Regards,
> Ralf

All links worked.

Full rt-preempt build underway, _on_ the rock64. Thanks Ralf. Est 2 hours 
for kernel. I note this "make help" is much more "helpfull".  Last time 
thru I didn't understand that making the dtsb's was a separate step, so 
of course the make install wasn't complete and the reboot was to the 
older kernel. I might even copy all this to the pi3b, but I expect a 
build on it will take most of a day.  They use a /boot/config.txt to 
control which of several installed kernels to boot. I'm not 100% sure I 
have the rock64's boot selection mechanism understood yet.

Question you might know about: These logitech "unifying" keyboard/mouse 
buttons for wireless keyboards & mice, does one button handle both 
keyboard and mouse if dmesg reports it as unifying? I am wondering if 
that might be my missed events problem on the pi, which is driving my 
attempts to bring up the much faster rock64 as an lcnc controller.

This is something I've not seen discussed on any of the lists I'm subbed 
to.

Thanks again.


Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
