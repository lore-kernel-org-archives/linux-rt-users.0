From: Mark Hounschell <dmarkh@cfl.rr.com>
Subject: Re: timer signal loss on RT
Date: Sat, 10 Mar 2012 06:53:31 -0500
Message-ID: <4F5B40BB.9080305@cfl.rr.com>
References: <4F5B2C50.2090907@cfl.rr.com> <alpine.LFD.2.02.1203101231230.2742@ionos>
Reply-To: dmarkh@cfl.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-rt <linux-rt-users@vger.kernel.org>,
	Mark Hounschell <markh@compro.net>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:22632 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab2CJLxd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 10 Mar 2012 06:53:33 -0500
In-Reply-To: <alpine.LFD.2.02.1203101231230.2742@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/10/2012 06:34 AM, Thomas Gleixner wrote:
> On Sat, 10 Mar 2012, Mark Hounschell wrote:
>> I'm sure you can find many things wrong with this test case but I'm not
>> sending it for discussion on the merits, or certainly the lack of, an
>> application that contains a cpu hog, but only to show what I think is a
>> problem with RT kernels.
>
> Nope, PEBKAC.
>
> Timer signals are delivered via ksoftirqd, so your cpu hog prevents
> ksoftirqd frum running.
>

Does ksoftirqd deliver timer signals in vanilla?

Thanks
Mark
