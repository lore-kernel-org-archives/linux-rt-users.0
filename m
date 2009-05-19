From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 0/9] Backport of ftrace's function profiler
Date: Tue, 19 May 2009 11:36:07 -0300
Message-ID: <20090519143607.GH27687@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	williams <williams@redhat.com>, tglx <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:52405 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbZESOgL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2009 10:36:11 -0400
Received: by pxi29 with SMTP id 29so2448814pxi.33
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2009 07:36:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

The following patches are the backport of Steven Rostedt's ftrace's
function profiler, as published in his RFC series posted to LKML. This
backport has been done on top of 2.6.29.3-rt14.

The feature is fully functional but we do have one known problem, a kernel
panic when stressing the function profiler (a fast sequence of start, stop,
read in loop for 30+ minutes). This problem has a Bugzilla entry at:

	https://bugzilla.redhat.com/show_bug.cgi?id=500156

Luis
-- 
[ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

