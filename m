From: Ingo Molnar <mingo@elte.hu>
Subject: v2.6.21-rt2
Date: Wed, 16 May 2007 20:04:47 +0200
Message-ID: <20070516180447.GA17922@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763516AbXEPSFK@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


i'm pleased to announce the v2.6.20-rt2 kernel, which can be downloaded 
from the usual place:

    http://redhat.com/~mingo/realtime-preempt/
 
more info about the -rt patchset can be found in the RT wiki:
 
    http://rt.wiki.kernel.org

This is a fixes-mostly release and has been assembled by Thomas 
Gleixner. Thanks Thomas! Here are the various changes:

  - ppc fixes from Tsutomu OWA

  - new sh -rt port from Paul Mundt & Co

  - fixes for various problems by Steven Rostedt and Clark Williams

  - x86/64 high-res timers and dynticks update (Thomas Gleixner)

  - various fixes from Sergie Shtylyov

  - latency fixes from John Stultz

  - misc fixes

to build a 2.6.21-rt2 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.21.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.21-rt2

	Ingo
