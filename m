From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Query regarding 2.6.335 RT and Non-RT performance
Date: Tue, 17 Aug 2010 12:45:27 -0700
Message-ID: <4C6AE6D7.2060006@us.ibm.com>
References: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com> <AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com> <4C6AC4A6.4080407@redhat.com> <AANLkTikM5sMtOmu959EZkXUxr=zX8L2HwK52L5JjAK59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Sommerseth <davids@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Manikandan Ramachandran <crmanik@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:55052 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab0HQTog (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Aug 2010 15:44:36 -0400
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7HJdjTH008328
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Aug 2010 13:39:45 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o7HJiRDw176892
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Aug 2010 13:44:28 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o7HJlron011702
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Aug 2010 13:47:53 -0600
In-Reply-To: <AANLkTikM5sMtOmu959EZkXUxr=zX8L2HwK52L5JjAK59@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/17/2010 11:24 AM, Manikandan Ramachandran wrote:

> Thanks David&  Mark for your valuable input!
>
> I'm not expecting RT kernel to be real fast. However I expect latency
> of higher priority task to be less in RT kernel. I'll run the tests
> that you have suggested and see if there is any inherent issue with my
> system.

Actually, a more accurate statement would be "I expect max latency
of higher priority task to be less in RT kernel."

This is true for max latency as reported by you (max, min):

Stock:	418011us	3s
RT:	366156us	3s

So while the min might reflect the best that the system can do, the
max does seem a tad high -- you do need to look into that.

> One more query, with RT patch is it possible for higher priority task
> to preempt a lower priority IRQ thread [For eg, IDE] ? If so when does
> that happen, during next timer interrupt [Assuming IRQ thread uses
> whole schedule slot and doesn't yield between]?

Yes, and when that higher priority task becomes runnable.

thanks,
Nivedita
