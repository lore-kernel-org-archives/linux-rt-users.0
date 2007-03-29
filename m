From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: [patch 00/11] Autotool support for IBM RT Cases
Date: Thu, 29 Mar 2007 13:08:18 -0700
Message-ID: <460C1CB2.80707@us.ibm.com>
References: <20070324121045.396218000@metis.extern.pengutronix.de> <460B2B35.4090108@us.ibm.com> <20070329073452.GE32369@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Darren Hart <dvhltc@us.ibm.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:41564 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030660AbXC2UIi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Mar 2007 16:08:38 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2TK8bna005900
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Mar 2007 16:08:37 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2TK8b4o201292
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Mar 2007 14:08:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2TK8aBr027870
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Mar 2007 14:08:37 -0600
In-Reply-To: <20070329073452.GE32369@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Robert Schwebel wrote:

>> What we'd like to do, however, is integrate these tests into the LTP
>> project. I'm hoping people will still find it as convenient to use.
>> Anyone foresee any issues with that move?
> 
> However that might end - I think it is important to have cross compiling
> support in LTP; last time I looked it was really difficult to achieve,
> because you more or less had to care about every single piece of
> sourcecode.

Yes, we're looking into all those issues now :(. It's probably
a bit more than we wanted to chew off at the moment. I agree
with wanting to have cross-compiling support, we might keep
some interim solution around perhaps.

Thanks a lot for your input! We'll discuss with the list
in greater detail next week.

thanks,
Nivedita
