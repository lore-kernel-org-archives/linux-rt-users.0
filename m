From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] 3.0.1-rt11
Date: Tue, 16 Aug 2011 17:10:08 +0200
Message-ID: <1313507408.6321.4.camel@marge.simson.net>
References: <1313232790.25267.7.camel@twins>
	 <1313236135.4486.10.camel@marge.simson.net>
	 <1313236713.25267.10.camel@twins>
	 <1313243965.4486.36.camel@marge.simson.net>
	 <20110813162735.GA2650@linux.vnet.ibm.com>
	 <1313295821.6334.5.camel@marge.simson.net>  <4E4A7BE3.5090902@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:41879 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751485Ab1HPPKc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Aug 2011 11:10:32 -0400
In-Reply-To: <4E4A7BE3.5090902@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2011-08-16 at 07:17 -0700, Nivedita Singhvi wrote:

> Mike,
> 
> Which test were you running? Because I'm not seeing it
> on our x3550 M3..

-rt11 did not trip up just idling along like a couple earlier releases
did, but did stall when I tried to run ltp realtime testcases.

	-Mike

