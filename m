From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.0.39-rt59
Date: Fri, 03 Aug 2012 09:13:36 -0400
Message-ID: <1343999616.27983.111.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	john stultz <johnstul@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.0.39-rt59 stable release.

Like the 3.2-rt and 3.4-rt kernel before, this one also had issues with
the backport of the leap second. Please test to make sure it works for
you.

This release is an update to the new stable 3.0.39 version. Some fixes
to the stable code (mentioned above) had to be done.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  Head SHA1: 0ab721484338f8d93d90135f0fbeb1057533b456


Or to build 3.0.39-rt59 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.39.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.39-rt59.patch.xz



Enjoy,

-- Steve
