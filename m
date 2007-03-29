From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: [patch 00/11] Autotool support for IBM RT Cases
Date: Wed, 28 Mar 2007 19:57:57 -0700
Message-ID: <460B2B35.4090108@us.ibm.com>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Darren Hart <dvhltc@us.ibm.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:35472 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965918AbXC2C6G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Mar 2007 22:58:06 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2T2w6s7016137
	for <linux-rt-users@vger.kernel.org>; Wed, 28 Mar 2007 22:58:06 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2T2w60r175232
	for <linux-rt-users@vger.kernel.org>; Wed, 28 Mar 2007 20:58:06 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2T2w56i031081
	for <linux-rt-users@vger.kernel.org>; Wed, 28 Mar 2007 20:58:05 -0600
In-Reply-To: <20070324121045.396218000@metis.extern.pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Robert Schwebel wrote:
> Darren,
> 
> Here is a first raw cut for autotool support for your rt testcases. It
> is against the version on your website. The series survives a basic
> distcheck.
> 
> Known issues & discussion points:
> 
> - test programs which use pthread_mutexattr_setprotocol and
>   pthread_mutexattr_setrobust_np could not be tested (debian unstable
>   does not have a recent enough glibc)
> 
> - due to the above, I assume the tests in question will have a similar
>   quantity of warnings, so I see if I can get access to a box which is
>   recent enough to do the rest of the fixes.
> 
> - a sane version number and contact mail address should be added to
>   configure.ac; I've just taken our template here, please adjust
>   according to your needs.
> 
> Robert

Hey Robert!

Thanks a lot for the patches. I believe Chirag Jog who's
working on cleaning up some of the tests responded to you
offline already. I thought I'd let everyone know we'll
be rolling out an updated tarball once we have that
working.

What we'd like to do, however, is integrate these tests
into the LTP project. I'm hoping people will still find
it as convenient to use. Anyone foresee any issues with
that move?

thanks,
Nivedita
