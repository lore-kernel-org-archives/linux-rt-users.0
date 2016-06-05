From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: RT, what to do about up/down_read_non_owner()
Date: Sun, 05 Jun 2016 08:57:49 +0200
Message-ID: <1465109869.4263.23.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37455 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbcFEG5y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2016 02:57:54 -0400
Received: by mail-wm0-f42.google.com with SMTP id z87so40507909wmh.0
        for <linux-rt-users@vger.kernel.org>; Sat, 04 Jun 2016 23:57:53 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

In v4.7, Al added those buggers to NFS.  BCACHE is disabled in RT
because of same.. but that's a somewhat suboptimal solution for
something as widely used as NFS.

Suggestions?  I reverted the offending commit to get 4.7-rt up and
running, but that's not gonna fly long term.

	-Mike
