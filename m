From: John Blackwood <john.blackwood@ccur.com>
Subject: Re: ANTS Report
Date: Fri, 26 Feb 2010 08:59:21 -0600
Message-ID: <4B87E1C9.8030209@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>,
	Jeff Hollensen <jeff.hollensen@ccur.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from flmx07.ccur.com ([12.192.68.12]:17605 "EHLO flmx07.ccur.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964837Ab0BZPEd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2010 10:04:33 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 >
 > Friday, February 26, 2010
 >
 > HAWKER FAILURES
 >    2.6.31.12-RedHawk-5.4.2-debug (32-bit):
 >       ihawk1     shield_all

For what ever it's worth, this failure was the 'invalidate_ktlb' kernel
variety, not the user space 'invalidate_tlb_x' type of tlbflush.

Just an idea (maybe a bad one)...

I'm wondering if this shield_all test script should be changed to not
fail if it sees just one invalidate_ktlb occur during a 10 second shield
trace on a given cpu....  maybe this would be only for 32bit systems
with HIGHMEM.

Feel free to ignore this suggestion.

It's just that we'll (I'll) have to look at manufacturing
systems everytime this test fails, and say whether or not
this is a user or kernel failure and whether to ignore it.


