From: Giuliano Colla <giuliano.colla@fastwebnet.it>
Subject: Re: CLOCK_MONOTONIC issue
Date: Mon, 22 Jun 2015 14:42:12 +0200
Message-ID: <558802A4.10908@fastwebnet.it>
References: <5587EC34.2070808@fastwebnet.it> <20150622114023.GB2539@netboy>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mr004msr.fastwebnet.it ([85.18.95.67]:53928 "EHLO
	mr004msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933319AbbFVMmQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Jun 2015 08:42:16 -0400
Received: from microserver.localdomain (151.41.156.223) by mr004msr.fastwebnet.it (8.5.140.03) (authenticated as giuliano.colla)
        id 54FF13C40657A4D8 for linux-rt-users@vger.kernel.org; Mon, 22 Jun 2015 14:42:14 +0200
In-Reply-To: <20150622114023.GB2539@netboy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Il 22/06/2015 13:40, Richard Cochran ha scritto:
> On Mon, Jun 22, 2015 at 01:06:28PM +0200, Giuliano Colla wrote:
>> Using as a parameter CLOCK_REALTIME everything appears to work as expected,
>> but if I attempt to use CLOCK_MONOTONIC (which should be a more reliable
>> timing source, from what I read), I get bogus times.
> What do you mean by "bogus times"?

I mean that the timing of sem_timedwait() appears to be inconsistent 
with the requested values.
But I believe I've found the reason in the meantime.
According the documentation, sem_timedwait() uses CLOCK_REALTIME, and it 
would appear that it can't be configured differently.
If I supply an absolute time value calculated from a different clock 
source, of course I'm bound to find inconsistencies!

Thanks however.

Giuliano


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
