From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.12.12-rt19
Date: Wed, 26 Feb 2014 22:07:43 -0500
Message-ID: <20140226220743.28f61b33@gandalf.local.home>
References: <20140223184727.GA12442@linutronix.de>
	<530A486A.2000802@pavlinux.ru>
	<530A4C00.5070205@pavlinux.ru>
	<alpine.DEB.2.02.1402232211300.21251@ionos.tec.linutronix.de>
	<530A7C58.2060009@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: pavel@pavlinux.ru
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <530A7C58.2060009@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 24 Feb 2014 02:55:20 +0400
Pavel Vasilyev <pavel@pavlinux.ru> wrote:

> No, because in positional number systems, an increase in the senior level,
> junior reset, but not stays the same. Mainline kernel and patches is senior level.

If you notice, there's no '.' between the mainline version and the rt
version. It's a dash "-rtX". What that number represents is the version
of the patch series for that release. We don't start a new version at
each stable release, but we do start a new one at each major release.

Thus, -rt19 is the 19th version of this rt patch series. When we rebase
on top of another major release, a lot of rewrites need to be done, and
we start a new version series.

Resetting the -rt number at each minor release would not be useful to
us and thus not necessary.

-- Steve
