From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.2.24-rt38
Date: Thu, 02 Aug 2012 18:42:20 -0400
Message-ID: <1343947340.27983.102.camel@gandalf.stny.rr.com>
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

I'm pleased to announce the 3.2.24-rt38 stable release.

Note, there were some non-trivial conflicts with leap-second backports.
I believe I solved them correctly (and added a change to convert
read_seqbegin to read_seqcount_begin() in ktime_get_update_offsets()).

This release passed all my internal tests, but test it out anyway, and
let me know if something fails for you.

This release is an update to the new stable 3.2.24 version. Some fixes
to the stable code (mentioned above) had to be done.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  Head SHA1: 860793bbc278575a33695cf1baa67be900f159ef


Or to build 3.2.24-rt38 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.24.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.24-rt38.patch.xz



Enjoy,

-- Steve
