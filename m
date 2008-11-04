From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: nohz=off
Date: Tue, 4 Nov 2008 17:46:52 -0200
Message-ID: <20081104194652.GN19329@unix.sh>
References: <1225729643.10570.6.camel@segulix.localdomain> <20081103170234.GC19329@unix.sh> <1225811449.30849.2.camel@segulix.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:57544 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429AbYKDTr4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Nov 2008 14:47:56 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1687141qwe.37
        for <linux-rt-users@vger.kernel.org>; Tue, 04 Nov 2008 11:47:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1225811449.30849.2.camel@segulix.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 04, 2008 at 03:10:48PM +0000, Sergio Monteiro Basto wrote:
| 
| On Mon, 2008-11-03 at 15:02 -0200, Luis Claudio R. Goncalves wrote:
| > it is not a problem to use
| > RT with NOHZ disabled.
| 
| Well but when NOHZ is enable and laptop hang on boot , this problem
| should be reported here ? 

Sure thing.

But it is usually important to add all the relevant information you have
available. Exact kernel version, any special config option you used when
compiling the kernel, any error message printed during boot, the last
message printed before the system froze, etc...

It is hard to help debugging a problem without information.

Regards,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

