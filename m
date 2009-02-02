From: m.luescher@vtxmail.ch
Subject: Hard lockup with 2.6.24.7-rt26 on x86
Date: Mon, 2 Feb 2009 21:55:36 +0100
Message-ID: <37144.1233608136@vtxmail.ch>
Reply-To: m.luescher@vtxmail.ch
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-02.datacomm.ch ([212.40.2.27]:49993 "EHLO
	smtp-02.datacomm.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbZBBVQe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Feb 2009 16:16:34 -0500
Received: from localhost (webmail-01.datacomm.ch [212.40.2.18])
	by smtp-02.datacomm.ch (VTX Datacomm AG) with ESMTP id 05ED712020C
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Feb 2009 21:55:36 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear Linux rt users

On two different desktop PC (both Core 2 Duo) and on a notebook (Core Duo) the kernel (2.6.24.7-rt26, CONFIG_X86_32) locks up hard under a certain rt load. The failure can be reproduced reliably with the following command:

sudo ./cyclictest -p99 -t10 -n -i250

During the test I made some additional observations:
- The lockup is really hard: there is no output on a netconsole and even the magic sysrequest keys to reboot the system (Alt+SysRQ+b) do not work anymore.
- with a lower realtime priority the system seems to run at least more stable (e.g. sudo ./cyclictest -p95 -t10 -n -i250)
- with the vanilla 2.6.26.6-rt11 kernel I observed probably the same crash
- the problem also appears on Ubuntu Hardy Heron with the latest official kernel (2.6.24.23.25 with rt21 patch)
- the problem did not appear on Ubuntu Hardy Heron with older rt-kernel versions (also 2.6.24 but based on rt3 patch)

So at the moment I am really clueless and I would be happy for any hint on how I can further debug this crash.

Best regards
Matthias
