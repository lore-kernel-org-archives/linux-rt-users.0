From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Oops issue with patch-2.6.29.4-rt15
Date: Mon, 25 May 2009 09:32:57 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0905250930080.3582@localhost.localdomain>
References: <4A1A38AF.4000706@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Udo van den Heuvel <udovdh@xs4all.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:59426 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755958AbZEYHdB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 May 2009 03:33:01 -0400
In-Reply-To: <4A1A38AF.4000706@xs4all.nl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 25 May 2009, Udo van den Heuvel wrote:
> I decided to try linux-rt on one of my x86_64 PC's running Fedora 10. I
> installed patch-2.6.29.4-rt15 and set up my kernel.
> 
> After rebooting into the new kernel all was fine except a few exceptions:
> Programs like `top`, `w` and the Gnome system monitor got Oopsed whenever I
> tried to start them. The rest of the system was stable.
> Is this normal?

No. It would be great if you could provide some more detailed
information. 

What means "got Oopsed" ? Is there an Ooops in the kernel ? If yes,
please provide the output from dmesg.

Thanks,

	tglx


