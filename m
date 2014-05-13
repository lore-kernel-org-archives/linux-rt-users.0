From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.14.3-rt5
Date: Tue, 13 May 2014 17:33:45 +0200
Message-ID: <20140513153345.GC15049@linutronix.de>
References: <20140509181214.GK29014@linutronix.de>
 <536D5CAA.9050100@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Pavel Vasilyev <pavel@pavlinux.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <536D5CAA.9050100@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Pavel Vasilyev | 2014-05-10 02:54:34 [+0400]:

>09.05.2014 22:12, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
>
>>The delta patch against v3.14.3-rt4 is appended below and can be foun=
d
>
>Where delta from 3 to 4 ?
I can remeber answering that question to an earlier release. The change
is mostly in
    https://git.kernel.org/cgit/linux/kernel/git/bigeasy/rt-devel.git/c=
ommit/?id=3Dbe0f124e477586b437108e09b66153be66dad29d

=46or more details feel free to "git diff v3.14.2-rt3..v3.14.3-rt4" in
that tree. This is however just a stable fixup.

Sebastian
