From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Thu, 18 Oct 2007 11:36:18 -0400
Message-ID: <20071018153618.GI12471@unix.sh>
References: <20071018124827.GA22282@in.ibm.com> <20071018.055242.115933276.davem@davemloft.net> <20071018132614.GB22282@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Ankita Garg <ankita@in.ibm.com>,
	David Miller <davem@davemloft.net>,
	linux-rt-users@vger.kernel.org, rostedt@goodmis.org,
	ghaskins@novell.com, mingo@elte.hu, dino@in.ibm.com,
	dvhltc@
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tucuriba.hst.terra.com.br ([200.176.10.214]:46116 "EHLO
	tucuriba.hst.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbXJRNoD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 09:44:03 -0400
Received: from sr06-06.mta.terra.com.br (sr06-06.mta.terra.com.br [200.154.152.75])
	by tucuriba.hst.terra.com.br (Postfix) with ESMTP id F0EA427D369
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Oct 2007 11:40:25 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <20071018132614.GB22282@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ankita,

On Thu, Oct 18, 2007 at 06:56:14PM +0530, Ankita Garg wrote:
| Hi David,
| 
| On Thu, Oct 18, 2007 at 05:52:42AM -0700, David Miller wrote:
| > From: ankita@in.ibm.com (Ankita Garg)
| > Date: Thu, 18 Oct 2007 18:18:27 +0530
| > 
| > > Any thoughts on where in the code could these large latencies be
| > > attributed to?
| > 
| > If the max latency is usually the first one, it's could be the page
| > fault the signal handler is taking the first time it is executed.
| 
| Thanks for looking into this. Attaching the entire log from the testrun.
| It indicates that in each run of the 10000 iterations, there are about 100+
| failures, with large iterations. Also, on intrumenting the testcode to
| find out the iterations which see large latencies, I see that as the
| number of iterations increase, the latencies increase.

You might wanna check signaltest:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/tglx/rt-tests.git rt-tests

Regards,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
