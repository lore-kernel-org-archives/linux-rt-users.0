From: Nathan Grennan <linux-rt-users@cygnusx-1.org>
Subject: Re: Soft lock issue with 2.6.33.7-rt29
Date: Thu, 18 Nov 2010 09:48:33 -0800
Message-ID: <4CE566F1.1020701@cygnusx-1.org>
References: <4CE428CB.20808@willowgarage.com> <4CE480BF.7050603@linux.intel.com> <20101118113523.GB11256@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Darren Hart <dvhart@linux.intel.com>,
	Nathan Grennan <ngrennan@willowgarage.com>,
	linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from okcforum.org ([173.8.189.10]:39399 "EHLO mail.okcforum.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203Ab0KRRzF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Nov 2010 12:55:05 -0500
In-Reply-To: <20101118113523.GB11256@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/18/2010 03:35 AM, Luis Claudio R. Goncalves wrote:
> I noticed a e1000e warning on the first log. Those are usually harmful.

   That is only in the level 7 log, and isn't in the level 9 log. So as 
much as wish it wasn't there, I don't think it is the problem.

>
> You may also want to boot your kernel with
>
> 	"ignore_loglevel debug initcall_debug"
>
> appended to your kernel command line. The real issue or the important
> warning may happen during the boot process.

   I will try these.
