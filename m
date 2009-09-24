From: Remy Bohmer <linux@bohmer.net>
Subject: Re: 2.6.31-rt11 freeze on userland start on ARM
Date: Thu, 24 Sep 2009 10:26:31 +0200
Message-ID: <3efb10970909240126j24949c5al75e721b2f3c6c0cf@mail.gmail.com>
References: <3efb10970909211136g4e74c8b3vc339d548cdd0959f@mail.gmail.com>
	 <loom.20090924T010608-530@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:47864 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbZIXIdm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Sep 2009 04:33:42 -0400
Received: by ywh4 with SMTP id 4so1694287ywh.33
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Sep 2009 01:33:46 -0700 (PDT)
In-Reply-To: <loom.20090924T010608-530@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

It seems I am not the only one with this problem:

2009/9/24 Azraiyl <azraiyl@gmail.com>:
> Same problem here on a Olimex SAM9-L9260 Board (ARM926EJ-S). Your "fix" helps
> aswell.

Can you please give me some advise here on this problem?
Should it work with the recent RT-patchset to share an interrupt line
between the NODELAY and the threaded domains?
Notice that moving the interrupt handler of the atmel serial driver to
the NODELAY domain works stable.
I could provide a patch for it, but that would mask the root cause of
this problem, so I would prefer debugging it first before patching
it... What do you think?

Kind regards,

Remy
