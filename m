From: Shane M Smith <shanemsmith@raytheon.com>
Subject: Re: rt file i/o
Date: Wed, 4 Nov 2009 21:30:21 -0700
Message-ID: <OFD6B69A61.C9E9EA94-ON07257665.00183AF8-07257665.0018C09A@mck.us.ray.com>
References: <hcs6dr$235$1@ger.gmane.org>	<5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com>
	<4AF1A327.3040103@klingt.org>	<20091104171412.GB1702@opentech.at>	<4AF1BAB9.5080104@klingt.org> <20091104164413.3aff479c@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dfw-mailout1.raytheon.com ([199.46.199.198]:42541 "EHLO
	dfw-mailout1.raytheon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZKEEiY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2009 23:38:24 -0500
Received: from dmoutt00.directory.ray.com ([147.25.154.125])
	by dfw-mailout1.raytheon.com (Switch-3.4.1/Switch-3.4.0) with ESMTP id nA54UQMS020536
	for <linux-rt-users@vger.kernel.org>; Thu, 5 Nov 2009 04:30:26 GMT
Received: from dmsmtpt00.directory.ray.com (dmsmtpt00.directory.ray.com [147.25.154.118])
	by dmoutt00.directory.ray.com (Switch-3.4.1/Switch-3.4.0) with ESMTP id nA54UPBZ014308
	sender shanemsmith@raytheon.com for <linux-rt-users@vger.kernel.org>; Thu, 5 Nov 2009 04:30:25 GMT
Received: from tu2-msg07.raymail.ray.com ([147.24.232.89])
	by dmsmtpt00.directory.ray.com (8.12.11/8.12.11) with ESMTP id nA54ULC5010227
	sender shanemsmith@raytheon.com for <linux-rt-users@vger.kernel.org>; Thu, 5 Nov 2009 04:30:22 GMT
In-Reply-To: <20091104164413.3aff479c@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams <williams@redhat.com> wrote on 11/04/2009 03:44:13 PM:
> No, we need to get that fixed in the wiki. It may have been the case
> that the entire process was frozen while a fault was being handled, but
> I don't believe that is the case now. If you're in a thread on core0
> and a sibling thread on core1 faults, you shouldn't be impacted unless
> you're trying to reference the same memory. 
> 
> Clark

I had seen this myself in the wiki and have been telling many people about 
it.  I finally tested this a couple of months ago and found out it was not 
true.  I tried having a thread malloc and touch memory, write to the disk, 
and read from the disk.  No matter what I did, I couldn't affect a second 
thread.

I have read briefly on some of the differences with the current and 
previous user model.  I don't know all the facts, but I believe that it 
used to be a user library.  At that time, I'm sure that a page fault would 
effect every thread.

Shane
