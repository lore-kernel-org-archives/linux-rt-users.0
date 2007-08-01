From: John Sigler <linux.kernel@free.fr>
Subject: Old -rt patches
Date: Wed, 01 Aug 2007 18:41:08 +0200
Message-ID: <46B0B7A4.8060805@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:38647 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbXHAQm3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Aug 2007 12:42:29 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

I wrote a Linux app where I need high-resolution timers. I went all the 
way and installed the -rt patch, which includes the -hrt patches, as far 
as I understand.

Since I could not afford to change kernels with every new release, I 
decided to track the 2.6.20 branch (arbitrarily).

At this point I'm using 2.6.20.7-rt8 (-rt8 was the last patch to the 
2.6.20 branch). (I see 2.6.20 is already up to .15)

I see a lot of patches going into the -rt patch, but development moved 
on to 2.6.21, then 2.6.22, and now 2.6.23, following mainline.

I'm not a kernel hacker, so I don't claim to understand the patches, but 
the comments sound like a few bugs are fixed here and there. I can't 
tell whether these bugs also exist in previous kernels or only appeared 
in newer kernels. Even if I knew, I probably wouldn't have the expertise 
to back-port the patch.

I'm seeing weird behavior in my app, when it has been running 2-4 days. 
The timers start to act out, and all hell breaks loose. Basically, I 
have no idea what's going on...

My question is: is it possible that there is a bug in 2.6.20-rt8 that 
has been fixed in subsequent -rt patches (there's a 2.6.21.6-rt21 and a 
2.6.22.1-rt9)? In other words, if I give 2.6.21.6-rt8 or 2.6.22.1-rt9 a 
spin, is it possible that my weird behavior disappears?

I'm not saying that it's impossible for the bug to be in my app, but the 
app is small enough that I'm fairly confident there's no problem there.

Thanks for reading this far,

John
