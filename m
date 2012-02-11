From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: jffs2 filesystem: possible circular locking dependency detected
Date: Fri, 10 Feb 2012 22:57:54 -0800
Message-ID: <CAN8TOE8xLdawRm9i6oTXJOE5T+MUEinkQysH9_ossikdW+8ZhA@mail.gmail.com>
References: <D61182AC8012EA4EBC531B3AF23BE109B3C6C6@tranzeo-mail2.12stewart.tranzeo.com>
	<alpine.LFD.2.02.1202082104470.2794@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Darcy Watkins <DWatkins@tranzeo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Josh Cartwright <joshc@linux.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57082 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab2BKG5y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 11 Feb 2012 01:57:54 -0500
Received: by ggnh1 with SMTP id h1so1841201ggn.19
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Feb 2012 22:57:54 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1202082104470.2794@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 8, 2012 at 12:09 PM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> On Wed, 8 Feb 2012, Darcy Watkins wrote:
>> [ =A0 20.932000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [ =A0 20.932000] [ INFO: possible circular locking dependency detect=
ed ]
>> [ =A0 20.932000] 3.0.18-rt34 #41
>> [ =A0 20.932000] ---------------------------------------------------=
----
>> [ =A0 20.932000] depmod/734 is trying to acquire lock:
>> [ =A0 20.932000] =A0(&mm->mmap_sem){++++++}, at: [<800e82d0>] might_=
fault+0x4c/0xa4
>> [ =A0 20.932000]
>> [ =A0 20.932000] but task is already holding lock:
>> [ =A0 20.932000] =A0(&f->sem){+.+.+.}, at: [<80184f88>] jffs2_readdi=
r+0x108/0x1c0
>> [ =A0 20.932000]
>> [ =A0 20.932000] which lock already depends on the new lock.
>
> Classic ABBA deadlock. I don't think it's RT specific, but I might be
> wrong as usual. Will have a look later this week, when noone beats me=
=2E

Looks like someone beat you :) Josh Cartwright has a patch here:
http://lists.infradead.org/pipermail/linux-mtd/2012-February/039787.htm=
l

Testing is always helpful to the MTD maintainers!

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
