From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.12.12-rt19
Date: Sun, 23 Feb 2014 22:13:21 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402232211300.21251@ionos.tec.linutronix.de>
References: <20140223184727.GA12442@linutronix.de> <530A486A.2000802@pavlinux.ru> <530A4C00.5070205@pavlinux.ru>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1827808936-1393190002=:21251"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Pavel Vasilyev <pavel@pavlinux.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <530A4C00.5070205@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1827808936-1393190002=:21251
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 23 Feb 2014, Pavel Vasilyev wrote:
> 23.02.2014 23:13, Pavel Vasilyev пишет:
> 
> > But not  -rt1, -rt2, -rt3 -rt4, .... -rt99
> 
> Or
> 
> 3.12-rt1,
> 3.12-rt2,
> ...
> 3.12-rt33,
> ...
> 3.12-rt111,
> ...
> 3.12-rt999
> ...
> 
> Now, to have to roll back all my changes, then work -rt patch,
> then impose SUBLEVEL mainline diff, then last -rt patch, then my сhanges.

So we need a different numbering scheme just because your workflow is
completely backwards?

Thanks,

	tglx
--8323329-1827808936-1393190002=:21251--
