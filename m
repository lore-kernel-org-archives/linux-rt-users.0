From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: loadavg vs loadavgrt
Date: Fri, 21 Dec 2007 10:54:05 -0200
Message-ID: <20071221125405.GE19965@unix.sh>
References: <1985e0f60712200235v61e78b99s646149e0d27f125b@mail.gmail.com> <Pine.LNX.4.58.0712201147390.17621@gandalf.stny.rr.com> <1985e0f60712202058h50e6cd74ne047ff85221a3e3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from marova.hst.terra.com.br ([200.176.10.215]:34443 "EHLO
	marova.hst.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbXLUNSl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Dec 2007 08:18:41 -0500
Received: from sr04-01.mta.terra.com.br (sr04-01.mta.terra.com.br [200.154.152.50])
	by marova.hst.terra.com.br (Postfix) with ESMTP id E54C411A8319
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Dec 2007 10:56:14 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <1985e0f60712202058h50e6cd74ne047ff85221a3e3b@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Dec 21, 2007 at 10:28:39AM +0530, Jaswinder Singh wrote:
| On Dec 20, 2007 10:19 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
| >
| > So the numbers are bogus!
| >
| 
| Thanks, understood :)
| 
| root@192.168.1.253:~# cat /proc/loadavg
| 0.00 0.00 0.02 1/52 1159
| 
| This seems loadavg is calculating average for non-RT tasks.
| 
| I think loadavg should be loadavg(all RT Tasks) + loadavg(all non-RT
| tasks) , it means loadavg should be all Tasks(RT + non-RT)  running on
| the machine.
| 
| In RT we introduced loadavgrt, but we changed the meaning of loadavg.

In fact, we haven't changed the meaning at all. The question is that in
some cases the calculation happens in sync with some kernel threads
dispatch and that makes system load _artificially_ equal to the number of
processors in the system. Have fun reading kernel/timer.c (calc_load()) and
understanding the logic behind it. All the answers lie there...

| Currently loadavgrt is correct it is trying to calculate average of RT tasks.
| But currently loadavg is loadavgnonrt, it should be loadavg (for all Tasks)
| 
| Please correct me, If I am wrong.
| 
| Thank you,
| 
| Jaswinder Singh.
| -
| To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
