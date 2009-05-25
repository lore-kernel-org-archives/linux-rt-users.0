From: Robin Gareus <robin@gareus.org>
Subject: Re: Linux audio on mini-laptop
Date: Tue, 26 May 2009 01:48:02 +0200
Message-ID: <4A1B2E32.7080203@gareus.org>
References: <21938316.1112611243265405549.JavaMail.ekam@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: ekam@kolumbus.fi
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:31903 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZEZAAG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 May 2009 20:00:06 -0400
In-Reply-To: <21938316.1112611243265405549.JavaMail.ekam@kolumbus.fi>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ekam@kolumbus.fi wrote:
> Hi,
> 
> I hope you could help me. I have used linux for audio recording for
> ages. I have stable environent LG laptop with realtime kernel and
> firewire interface.
> Now, I have bought Lenovo Ideapad s10e mini-laptop and I'm trying to get
> all working there too, but no success yet.
> 
> I installed LinuxMint with realtime kernel (same combination in my LG).
> I also tried with Ubuntu and XUbuntu.
> 
> I have tried different jack parameters but I have several xruns also as
> a root user and my DAW (energyXT) stucks.
> 
> This Lenovo is quite powerfull (1,6 GHz Intel Atom N270, 1 Gt memory),
> so I thought that everything should work with it, but is there something
> I don't know ( I quess, yes there is)?
> Please help me, I haven't found answers from net.

Which kernel-version are you running?
and what does `cat /proc/interrupts` say?

I don't know about the s10e, but thinkpads allow to re-assign interupts
from the BIOS. Check if you can get the Firewire interface it's own
interrupt line.
If the 1394's IRQ is shared with another device, see if the xruns stop
once you unload the module of that other device..

Are you using Rui's rtirq script
(http://www.rncbc.org/jack/rtirq-20090131.tar.gz)  to assign rt-priority
to audio device's interrupts?

BTW. if you grant rtprio and memlock to the audio-user/group in
/etc/security/limits.conf, there's no difference in running jackd as
root, or user.

robin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkobLjIACgkQeVUk8U+VK0JtgQCgmcMf9A3uCEdeeK71P2tNkzro
UBoAoLpRYztfsWlGwidG+uwS8iLbg0j9
=0fBg
-----END PGP SIGNATURE-----
