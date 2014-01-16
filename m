From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/8] Linux 3.2.53-rt76-rc1
Date: Thu, 16 Jan 2014 09:18:47 -0500
Message-ID: <20140116091847.0786c8af@gandalf.local.home>
References: <20140116015824.201732155@goodmis.org>
	<52D7A93C.9090801@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: pavel@pavlinux.ru
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52D7A93C.9090801@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 16 Jan 2014 13:41:16 +0400
Pavel Vasilyev <pavel@pavlinux.ru> wrote:

> 16.01.2014 05:58, Steven Rostedt =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Dear RT Folks,
> >=20
> > This is the RT stable review cycle of patch 3.2.53-rt76-rc1.
>=20
> Yap..., mainline is 3.2.54 !
>=20

Yeah, but I already had the -rt specific changes merged into 3.2.53
before 3.2.54 was released, and then I discovered the cpu hotplug bug.
I did not want to release that -rc until it was solved. Now that it is,
I can release this one and then move to 3.2.54.

Thanks,

-- Steve
