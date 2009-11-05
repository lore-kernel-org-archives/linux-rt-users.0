From: Remy Bohmer <linux@bohmer.net>
Subject: Re: rt file i/o
Date: Thu, 5 Nov 2009 21:30:41 +0100
Message-ID: <3efb10970911051230n57deab7fvbcaea5406164484c@mail.gmail.com>
References: <hcs6dr$235$1@ger.gmane.org>
	 <5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com>
	 <4AF1A327.3040103@klingt.org> <20091104171412.GB1702@opentech.at>
	 <4AF1BAB9.5080104@klingt.org> <20091104164413.3aff479c@torg>
	 <4AF29B16.1000104@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Clark Williams <williams@redhat.com>,
	Nicholas Mc Guire <der.herr@hofr.at>, y@opentech.at,
	Mark Knecht <markknecht@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:34383 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758549AbZKEUag (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Nov 2009 15:30:36 -0500
Received: by gv-out-0910.google.com with SMTP id r4so127829gve.37
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Nov 2009 12:30:41 -0800 (PST)
In-Reply-To: <4AF29B16.1000104@klingt.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

>>> that is what i thought for years ... but according to [1] a page fault
>>> in an rt process freezes the entire process with both rt and non-rt
>>> threads until the page fault is handled ...
>>
>> No, we need to get that fixed in the wiki. It may have been the case
>> that the entire process was frozen while a fault was being handled, but
>> I don't believe that is the case now. If you're in a thread on core0
>> and a sibling thread on core1 faults, you shouldn't be impacted unless
>> you're trying to reference the same memory.
>
> well, then my application seems to be real-time safe ... it would be
> nice if the wiki would reflect the current state of the rt-preempt
> kernel, though ...

Well, I wrote this part of the wiki quite some time ago, and yes it
might be outdated on some points.
I will look into it, and update it in a couple of days.

Kind regards,

Remy
