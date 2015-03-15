From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: Re: 3.18.9-rt4 kernel panic - Was: 3.18.9-rt4
Date: Sun, 15 Mar 2015 14:51:53 +0100
Message-ID: <20150315145153.44f5217c@tor.valhalla.alchemy.lu>
References: <20150313223041.0a8bf390@archlinux>
	<20150314104336.756a6f0e@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:35722 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbCONwI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Mar 2015 09:52:08 -0400
Received: from skinbark.wpsintrax.se (unknown [5.178.78.91])
	by mailsafe.webbplatsen.se (Halon Mail Gateway) with ESMTP
	for <linux-rt-users@vger.kernel.org>; Sun, 15 Mar 2015 14:51:57 +0100 (CET)
Received: from skinbark.wpsintrax.se (localhost [127.0.0.1])
	by skinbark.wpsintrax.se (Postfix) with ESMTP id A034EBC8168
	for <linux-rt-users@vger.kernel.org>; Sun, 15 Mar 2015 14:51:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by skinbark.wpsintrax.se (Postfix) with ESMTP id 7F48FBC819F
	for <linux-rt-users@vger.kernel.org>; Sun, 15 Mar 2015 14:51:48 +0100 (CET)
Received: from skinbark.wpsintrax.se ([127.0.0.1])
	by localhost (skinbark.wpsintrax.se [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id O2tfC8a-WHbn for <linux-rt-users@vger.kernel.org>;
	Sun, 15 Mar 2015 14:51:48 +0100 (CET)
Received: from tor.valhalla.alchemy.lu (vodsl-4965.vo.lu [80.90.57.101])
	by skinbark.wpsintrax.se (Postfix) with ESMTPA id 3ECE7BC8168
	for <linux-rt-users@vger.kernel.org>; Sun, 15 Mar 2015 14:51:48 +0100 (CET)
In-Reply-To: <20150314104336.756a6f0e@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 14 Mar 2015 10:43:36 +0100
Ralf Mardorf <ralf.mardorf@rocketmail.com> wrote:

> On Fri, 13 Mar 2015 22:30:41 +0100, Ralf Mardorf wrote:
> >all kernels >= 3.14.34-rt31 I tested, don't finish startup on my
> >machine [1]. This are the last messages of startups for 4 different
> >startups for 3.18.9-rt4.
> >
> >Picture URLs:
> >http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_2.jpg
> >http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_3.jpg
> >http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_4.jpg
> >http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_5.jpg
> >
> >The last kernel I tested that does work is 3.14.28-rt25.
> 
> Hi,
> 
> this morning the messages finished with a kernel panic.
> 
> Picture URL:
> http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_6.jpg

Let me try to add some information that I think might be relevant to
the problem.

I remember that you had boot problems a while ago, together
with a couple of other AMD cpu users.  IIRC it just affected a few
specific AMD cpus.  AFAIK, you could not succesfully boot any kernel
starting with with 3.12.6-rt9, and I have another report from another
afflicted user saying that the boot problem was fixed by reverting:

timers-do-not-raise-softirq-unconditionally.patch
timer-Raise-softirq-if-there-s-irq_work.patch
timer-rt-Always-raise-the-softirq-if-there-s-irq_wor.patch

This might be significant, as these patches are in play again, at
least on 3.18-rt.

Try to revert those patches and see if the kernel can boot.

-- 

   Joakim
