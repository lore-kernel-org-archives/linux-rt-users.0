From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: fork() blocking rt-threads?
Date: Fri, 16 Oct 2009 13:22:58 -0300
Message-ID: <20091016162258.GH3394@uudg.org>
References: <20091016162521.457c18ee@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: hollunder@gmx.at
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:59583 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbZJPQWu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Oct 2009 12:22:50 -0400
Received: by qyk2 with SMTP id 2so1581334qyk.21
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Oct 2009 09:22:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091016162521.457c18ee@gmx.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Oct 16, 2009 at 04:25:21PM +0200, hollunder@gmx.at wrote:
| Hi,
| I'm a Linux audio user and following the rt kernel development closely
| (only as a user).
| I've experienced something that might be relevant for all of us.
| 
| When loading the plug-in 'lv2fil' in one of our most relevant
| Linux audio applications, ardour, and opening the ui, fork() was used.
| This usually blocks the rt thread long enough to wreak havoc to the
| underlying rt audio server jack.
| 
| What's relevant here is the ill effect of fork() and that tests
| showed that vfork() works a lot better.
| One ticket associated with this is:
| http://nedko.arnaudov.name/soft/lv2fil/trac/ticket/9
| 
| Ardour also uses some gtk function (to open a page in the
| default webbrowser) that uses fork() and causes the same problem.
| 
| Again, it seems the problem stems from the fork() implementation and is
| present at least in 2.6.21.x through 2.6.31.x(-rt).
| I'm quite sure this doesn't only affect us audio people.
| 
| I hope this information is of help and someone will look into it.

Do you know how people benchmarked fork, vfork and clone? Is it easier than
reproducing the issue you observed?

Another question that comes to mind is: was Ardour running with a realtime
priority too? Higher or lower prio than jack's?

Regards,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

