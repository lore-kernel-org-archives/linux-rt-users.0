From: =?iso-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Subject: Re: Random 3 to 4.5 second blocks of RT thread
Date: Wed, 13 Feb 2013 10:15:32 +0100
Message-ID: <F6E121C4-2DD3-47AB-ABFE-301E5A636C69@bj-ig.de>
References: <8426D3F6-9553-4B6A-B318-4983625ACC8E@bj-ig.de> <CADkTA4MNMCm-6T7rN+9-kujpO4hUmXJmR7hTOkVy2y4xGWX5BQ@mail.gmail.com> <7E3E5777-3AD4-4A87-B27D-6B3D152DE296@bj-ig.de> <CADkTA4ME9Ce1_vc8e60t_BmH5FZ55u5mYhRNCNuCRLMBOjU4Gw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: Realtime Mailinglist <linux-rt-users@vger.kernel.org>,
	Thomas Weisser <thomas@bj-ig.de>
To: Bruce Ashfield <bruce.ashfield@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpgate.bj-ig.de ([194.127.182.6]:34127 "EHLO smtp.bj-ig.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751195Ab3BMJQC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Feb 2013 04:16:02 -0500
In-Reply-To: <CADkTA4ME9Ce1_vc8e60t_BmH5FZ55u5mYhRNCNuCRLMBOjU4Gw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Am 12.02.2013 um 15:28 schrieb Bruce Ashfield:
> 
> I agree that such a long SMI isn't likely, but running the hwlat
> detector is a fairly simple way to see if time is in fact being
> stolen from your kernel, so it's something to look into.

hwlat - up to now - was unknown to me. I will give it a try. Thanks.

>> BTW: Are there any links to SMI events in a multi second
>> range? What in a system is done within such a long time span?
> 
> I've never seen it first hand, but I have heard of thermal SMIs that
> can "borrow" quite a bit of time (depending on what your platform
> is doing). Like anything, not all BIOS/SMIs are created equal :)

:)

> Which of course can be more of a problem in your
> case, since it sounds like you aren't on exactly
> the same h/w as the problematic system.

Thats the case - yes. But I can try here, build an installation
packet for the customer system. Remote control the customer - so
he can activate that packet and send me results.

> Anyway, just a thought and something to rule out.

> If the customer machines can have tracing enabled, you can always set
> a latency threshold and stop tracing when it is crossed. That should
> get you insight into what is happening in the long latency case.

You are right - great idea.

Thank you very much
Ralf

