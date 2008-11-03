From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: nohz=off
Date: Mon, 3 Nov 2008 17:54:35 -0200
Message-ID: <20081103195435.GG19329@unix.sh>
References: <1225729643.10570.6.camel@segulix.localdomain> <20081103170234.GC19329@unix.sh> <1225734521.14192.5.camel@segulix.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:51972 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbYKCTyo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Nov 2008 14:54:44 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1033579yxm.1
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Nov 2008 11:54:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1225734521.14192.5.camel@segulix.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Nov 03, 2008 at 05:48:41PM +0000, Sergio Monteiro Basto wrote:
| 
| On Mon, 2008-11-03 at 15:02 -0200, Luis Claudio R. Goncalves wrote:
| > On Mon, Nov 03, 2008 at 04:27:23PM +0000, Sergio Monteiro Basto wrote:
| > | Hi, 
| > | When I have to boot with nohz=off , this could be a problem with rt
| > | isn't it ? 
| > 
| > I am not sure I understood your question but it is not a problem to use
| > RT with NOHZ disabled. I even dare to say that most distributions ship with
| > NOHZ disabled by default.
| > 
| 
| Hi, to laptop not hang on boot with a kernel 2.6.24 until a kernel
| 2.6.27, I need put on boot options, nohz=off , and this seems the bigger
| problem . 
| How I find out / debug what happen on my laptop with nohz ? 

What kernel versions are you are using? Which laptop model?

Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

