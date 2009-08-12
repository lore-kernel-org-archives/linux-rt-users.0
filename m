From: Robin Gareus <robin@gareus.org>
Subject: Re: remembering rt-sched attributes - was: [LAD] rtirq script is
 broken with  2.6.31
Date: Wed, 12 Aug 2009 11:24:17 +0200
Message-ID: <4A828A41.9040109@gareus.org>
References: <4A7B01F3.2060200@gareus.org> <4A7B3EA6.1080509@rncbc.org> <4A7C259D.9020409@gareus.org> <4A7EE291.3000500@gareus.org> <4A80A0A7.8000807@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	The Linux Audio Developers' Mailing List
	<linux-audio-dev@lists.linuxaudio.org>
To: Rui Nuno Capela <rncbc@rncbc.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:22582 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbZHLJYT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Aug 2009 05:24:19 -0400
In-Reply-To: <4A80A0A7.8000807@rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rui Nuno Capela wrote:
> Robin Gareus wrote:
>> Hello rt-users and -devs,
>>
>> I have a question about per-device-IRQ-threads in 2.6.31-rc5-rt1.1:
>>
>> After a suspend/resume cycle some IRQ-threads come up with a new PID.
>> The scheduling policy of those threads is reset to default values
>> instead of retaining the previously set values.
>>
>> Is this an issue that is being worked on? Or must userspace from now on
>> re-init rtprio settings after each suspend/resume cycle?
>>
>> As you can see from the information below (from linux-audio-dev @
>> linuxaudio.org) not all IRQ-threads are re-started, but for example the
>> HDA-Intel is. It may just as well be a specific issue with snd_hda_intel
>> (and sdhci, e1000e, i810/intelfb,..).
>>
>> [...]
> 
> picking on old subject, why not doing a plain `/etc/init.d/rtirq
> restart` on resume?
> 

Sure, adding it to
/usr/lib/hal/scripts/linux/hal-system-power-suspend-linux
or a script in /etc/acpi/resume.d/ (depending on the distribution)
does the trick.

However it would be necessary to be included in quite a few
distributions: Ubuntustudio, 64studio, AVlinux, JACKlab, etc. It would
be better if the problem could be solved at the source.

Anyways, can anyone explain why only a particular set of IRQ-threads are
affected by this issue?

robin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkqCikEACgkQeVUk8U+VK0J0eQCeNPiTVO6wLBkuNc2CaQLpPuK4
h/sAnRGExpwt4zKQ1PH7LSo2NlCF6Y55
=oGVR
-----END PGP SIGNATURE-----
