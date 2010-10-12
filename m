From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: Kernel start code
Date: Tue, 12 Oct 2010 12:22:41 +0200
Message-ID: <87wrpn3e32.fsf@steelpick.2x.cz>
References: <AANLkTimxFvKiG6F8WHCe2Q+Ov5BaQ1ZVC3rr+rufVWE0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>,
	Kernel-newbies <kernelnewbies@nl.linux.org>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:46822 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756888Ab0JLKab (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Oct 2010 06:30:31 -0400
In-Reply-To: <AANLkTimxFvKiG6F8WHCe2Q+Ov5BaQ1ZVC3rr+rufVWE0@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 06 Oct 2010, Sri Ram Vemulpali wrote:
> Hi all,
> 
>   Can anyone, please help me on pointing to kernel boot code after
> grubs loads the kernel and transfers control to it.
>   I want in which files this resides, location. Any explanation on the
> code or any link would be helpful to me.
>   I know this is kind of lousy question, but entry.S is where I looked
> at. It is overwhelming for me where to start in that file.

Hi,

I'guess you are interested in x86 architecture. The boot code of x86 is
the most complex one. Look at Documentation/x86/boot.txt. You can see
what the kernel does during early boot by running it under qemu and
attaching a debuger.

-Michal
