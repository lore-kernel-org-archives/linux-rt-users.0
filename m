From: Mark Hounschell <dmarkh@cfl.rr.com>
Subject: Re: Latency Problems with 2.6.31/PREEMPT_RT on a 1.2GHz Celeron
Date: Sat, 19 Dec 2009 06:34:00 -0500
Message-ID: <4B2CBA28.1030405@cfl.rr.com>
References: <abe060d60912171537j10fe194r5f0cd1aca85475df@mail.gmail.com> <4B2BB45A.9040909@mantatest.com>
Reply-To: dmarkh@cfl.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Scott Gilbertson <scottg@mantatest.com>
To: Vladimir Cotfas <vladc@mantatest.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.123]:39864 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbZLSLeE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Dec 2009 06:34:04 -0500
In-Reply-To: <4B2BB45A.9040909@mantatest.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/18/2009 11:56 AM, Vladimir Cotfas wrote:
> All,
> 
> I have a a driver that must process an interrupt every 100 uS without
> missing any. I am having latency issues and I am looking for some help
> debugging my problem.
> 

You'll probably never get this working reliably with the RT kernel. Latencies
are more deterministic with the RT kernel but slightly higher. You'll have better
luck with a vanilla kernel running your app in run level 4. And then even better
luck running on an SMP machine isolating your process and IRQ to a single
processor. And stay away from the VGA console. You have better luck with
faster hardware too.

Mark

