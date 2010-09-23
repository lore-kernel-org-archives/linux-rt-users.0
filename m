From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Subject: Re: Help about Ubuntu Linux-rt
Date: Thu, 23 Sep 2010 09:05:10 +0530
Message-ID: <4C9ACAEE.8020402@linux.vnet.ibm.com>
References: <AANLkTinqKwzhDpMuLXZi6L47OZuSgi+ym_bo3c0QQ2Tk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: rafet ilgin <rafetilginmetu@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:39354 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab0IWDfP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Sep 2010 23:35:15 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id o8N3UZEh023498
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 13:30:35 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8N3ZDaO1187896
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 13:35:13 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8N3ZDmX013750
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 13:35:13 +1000
In-Reply-To: <AANLkTinqKwzhDpMuLXZi6L47OZuSgi+ym_bo3c0QQ2Tk@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thursday 23 September 2010 02:27 AM, rafet ilgin wrote:
> I have installed real time image on my ubuntu karmic(9.10) by using
> the command apt-get install linux-rt(2.6.31.9-rt). After installing
> the image I have booted my system from real time kernel(2.6.31.9-rt).
> Can I say that is it now real time? And is it soft real time or hard
> real time? I looked at the file /boot/config-2.6.31.9-rt and saw that
> CONFIG_PREEMPT_RT=y is set. If you reply me I would really appreciate
> it.
>    

CONFIG_PREEMPT_RT is written to meet the hard realtime challenges,
but it also depends on the hardware you use. Make sure the system is not
against you :) . Also, your software should also be written to make use of
realtime api's, otherwise you may not see the difference.

Thanks,
Gowrishankar

> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>    

