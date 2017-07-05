From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.9.35-rt25
Date: Wed, 5 Jul 2017 15:31:38 -0400
Message-ID: <20170705153138.5008cdcf@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.9.35-rt25 stable release.

As development has moved onto 4.11, 4.9-rt has moved to stable
releases. It will be supported as long as the LTS of 4.9 is.

This release is just an update to the new stable 4.9.35 version
and no RT specific changes have been made.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: f9b8c53d3a2eac222ae3885319ede420792d3cfe


Or to build 4.9.35-rt25 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.35.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.35-rt25.patch.xz




Enjoy,

-- Steve
