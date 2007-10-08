From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Cyclictest expected results
Date: Mon, 8 Oct 2007 11:55:52 -0300
Message-ID: <20071008145552.GC27098@unix.sh>
References: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com> <20070930183253.GW23573@pengutronix.de> <alpine.LFD.0.9999.0709302353540.5677@localhost.localdomain> <1985e0f60709302030q62d19dd3q398a5d0685353786@mail.gmail.com> <20071002065451.GM23573@pengutronix.de> <1985e0f60710070550w47b1ccd7na897920cbd0aeb40@mail.gmail.com> <20071008145508.GA29081@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jaswinder Singh <jaswinderlinuxrt@gmail.com>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tucuriba.hst.terra.com.br ([200.176.10.214]:40634 "EHLO
	tucuriba.hst.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbXJHPEy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2007 11:04:54 -0400
Received: from sr06-09.mta.terra.com.br (sr06-09.mta.terra.com.br [200.154.152.78])
	by tucuriba.hst.terra.com.br (Postfix) with ESMTP id 77DC0275EF9
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Oct 2007 12:04:52 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <20071008145508.GA29081@thunk.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Oct 08, 2007 at 10:55:09AM -0400, Theodore Tso wrote:
| On Sun, Oct 07, 2007 at 06:20:29PM +0530, Jaswinder Singh wrote:
| > 
| > But I am not able to see performance difference in my GNOME
| > Environment. It is still very very slow, how can I boost X-Windows by
| > -rt patch.
| 
| There are many reasons why GNOME performance might be slow.  Stupid
| application design going to helped by some magic kernel patch.  Keep
| in mind the GNOME doesn't run with real-time priority levels; neither
| does the X server.  
| 
| The -rt patch isn't magic; no RTOS is magic.  A large amount of
| application design and reworking in order to properly utilize the
| POSIX real-time interfaces.

Also keep in mind that by its very nature, -rt is more sensible to bad
coding and bad application design. Some applications that perform well in
mainstream linux may present bugs in -rt (those bugs exist in the code but
are more prone to show uo in -rt).

People here have been working most of time focused on determinism.
Eventually it comes with a performance enhancement bonus. Sometimes not.

Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
