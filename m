From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: 2.6.24-rc8-rt1: Strange latencies on mpc5200 powerpc
Date: Thu, 24 Jan 2008 11:49:51 -0200
Message-ID: <20080124134951.GG4776@unix.sh>
References: <1200544050.318.18.camel@localhost.localdomain> <478F2A46.5070506@grandegger.com> <20080123145340.GE6200@pengutronix.de> <47976D06.1010900@grandegger.com> <47986E44.3010101@grandegger.com> <20080124112847.GE4776@unix.sh> <47987D73.8090904@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from marova.hst.terra.com.br ([200.176.10.215]:51753 "EHLO
	marova.hst.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYAXNv7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jan 2008 08:51:59 -0500
Received: from sr06-04.mta.terra.com.br (sr06-04.mta.terra.com.br [200.154.152.73])
	by marova.hst.terra.com.br (Postfix) with ESMTP id 502A83B6A36
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Jan 2008 11:51:57 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <47987D73.8090904@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 24, 2008 at 12:58:43PM +0100, Wolfgang Grandegger wrote:
| Hi Luis,
| 
| I re-added CC to the mailing list.
| 
| Luis Claudio R. Goncalves wrote:
| > On Thu, Jan 24, 2008 at 11:53:56AM +0100, Wolfgang Grandegger wrote:
| > | Wolfgang Grandegger wrote:
| > ... 
| > I deleted lots of lines just to make it easy to see my question:
| > ...
| > | OK, here is the full report.
| > ...
| > |   bash-3.00# ./cyclictest -n -p80 -t1 -i1000
| > |   2.91 4.81 13.72 1/50 23887
| > | 
| > |   T: 0 (  976) P:80 I:1000 C:1634520 Min: 15 Act:  45 Avg:  68 Max:  138
| > 
| > ...
| >  
| > |   bash-3.00# ./cyclictest -n -p80 -i1000
| > |   52.31 96.08 61.61 2/51 9129
| > | 
| > |   T: 0 (  976) P:80 I:1000 C: 795180 Min:  14 Act: 75 Avg:  69 Max:  134
| >  
| > Are the loadavg values right? If so, the results were obtained in very
| > different circunstances. In the first case, load was around 2.91... in the
| > second one, 52.31. This is also true for the other tests below.
| > 
| > Please compare /proc/loadavg and /proc/loadavgrt (a simple cat do the
| > trick). If loadavgrt is reporting bogus values, let us know. It was fixed a
| > looong time ago, but I never tested that in a ppc.
| 
| Here is the output:
| 
|   bash-3.00# cat /proc/loadavg; cat /proc/loadavgrt
|   3.12 3.13 4.57 3/46 5541
|   75.35 73.84 72.94 0/46 5543
| 
| There is no constant load as I run:
| 
|   "while ./hackbench 10; do ./calibrator 400 32M cali; sleep 30; done"
| 
| in the second terminal window. What you see is the load when I
| interrupted the test manually.
| 
| Wolfgang.

The bogus readings in /proc/loadvgrt were fixed a while ago and the fix is
in the 2.6.24-rcX-rtX series. Not that this could be leading you to wrong
results, but that's really strange seeing it.

OTOH, cyclictest reads the load from /proc/loadavg and system pressure (at
least for the last 15 minutes) was really different on the tests, even though
results were close.

Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
