From: Daniel Walker <dwalker@mvista.com>
Subject: 2.6.25-rc9-dw1
Date: Mon, 14 Apr 2008 09:35:44 -0700
Message-ID: <1208190944.4877.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762611AbYDNQf4@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


This is a pure Real Time forward port. I started with my bisect changes
to 2.6.24.4-rt4. This version should be more bisectable than the
original release.

Some of the few things that are missing are all of ftrace, and most of
the additional preemptible RCU changes (most of which got merged for
2.6.25 or just aren't needed).

It's only available in broken out form. You can download it from,

ftp://source.mvista.com/pub/dwalker/rt/patch-2.6.25-rc9-dw1-broken-out.tar.bz2

Check for updates here,

ftp://source.mvista.com/pub/dwalker/rt/

Enjoy!

Daniel
