From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Unlucky 3.0-rt7
Date: Fri, 05 Aug 2011 09:04:05 -0700
Message-ID: <4E3C1475.7040908@ccrma.stanford.edu>
References: <20110805054017.472bef0d.shakti@bayarea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Tracey Hytry <shakti@bayarea.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.Stanford.EDU ([171.67.219.82]:50292 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753623Ab1HEQEI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Aug 2011 12:04:08 -0400
In-Reply-To: <20110805054017.472bef0d.shakti@bayarea.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/05/2011 05:40 AM, Tracey Hytry wrote:
> I managed to download the new build about an hour and a half after it finished.
> Installed it on the fedora 15 partition and the kernel fell on it's face!
>
> It hangs up right after the start of boot, with just a few(maybe 50) lines of text.
> I wrote down the last few lines, but don't have much time for setting things up for a serial console(don't know if it would help much here(but I should have the capability if needed)).
>
> Anyway, here's the end of the text.  I'll drop it off on the list this time.
>
> Memory:8089012k/9437184k ...more mem stuff
> Preemptible hierarchical RCU implementation
> RCU lockdep checking enabled
> Verbose stalled-CPUs detection is disabled
> NR_IRQS:33024 nr_irqs:512 16
> Extended CMOS year: 2000
> Console: colour VGA+ 80x25
>
> That's it, and the computer would sit there lost in it's own nightmare getting very warm.
> I tried putting "nomodeset rdblacklist=nouveau" on the kernel boot line, but got the same hang/message.
> This is the same computer that was mentioned in the message from Fernanado  a few back.

I'll try it out on my test laptop (i386) when I get to ccrma.
(I just left the build going overnight and did not test at all)

-- Fernando
