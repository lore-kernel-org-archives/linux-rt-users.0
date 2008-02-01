From: Clark Williams <williams@redhat.com>
Subject: Re: 2.6.24-rt1 SSttrraannggee keyboard behaviour
Date: Fri, 01 Feb 2008 10:20:19 -0600
Message-ID: <47A346C3.8070308@redhat.com>
References: <10a58eee0802010706s65929d0dte10a4cde35df317f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Uli Brueggemann <uli.brueggemann@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52901 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756600AbYBAQUY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Feb 2008 11:20:24 -0500
In-Reply-To: <10a58eee0802010706s65929d0dte10a4cde35df317f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Uli Brueggemann wrote:
> Hi,
> 
> I'm trying to use 2.6.24-rt1 in combination with BruteFIR (audio). So
> far everything looks fine except:
> 
> After starting BruteFIR (which is doing its job) after a while the
> keyboard responds like with double clicks. TTeerrrriibbllee. I cannot
> enter a command anymore. The running BruteFIR itself still is running
> stable.
>  The system without starting BruteFIR keeps stable. BruteFIR itself is
> working fine with older kernels. Also with e.g. 2.6.24-rc3-zen3. So I
> guess the realtime patch is causing this.
> BTW Brutefir is using realtime priorities 1 to 4 and it also uses SCHED_FIFO.
> 
> Any idea?
> 
> Uli

Uli,

I've seen this behavior before; on my system in addition to the doubled keystrokes,
cursor animations were jerky.

Are you running on a 64-bit kernel, is your clocksource hpet and is vsyscall64 on?

$ uname -m
x86_64
$ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
hpet
$ cat /proc/sys/kernel/vsyscall64
1

If so, try putting this into your /etc/sysctl.conf and rebooting:

# vsyscall64 off
kernel.vsyscall64 = 0

You could try echoing "1" into /proc/sys/kernel/vsyscall64, but with the keyboard
doubling issue, it might be a problem :)

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkejRsMACgkQHyuj/+TTEp14GgCg1PV1n23nDDJg8Bp6NTEXIUTQ
iukAoK56x+wQcZ8Z+YNea8glzIe41EpA
=ZKru
-----END PGP SIGNATURE-----
