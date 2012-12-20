From: Darren Hart <dvhart@infradead.org>
Subject: Re: Real-time kernel thread performance and optimization
Date: Wed, 19 Dec 2012 16:11:43 -0800
Message-ID: <50D257BF.2060803@infradead.org>
References: <6b5093025753dbc76e1d23af7c999826@mail.gmail.com> <50B933A5.3020400@am.sony.com> <d27143389b68c615c242b56c7cd4dd22@mail.gmail.com> <50CF9A1E.5000902@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Simon Falsig <simon@newtec.dk>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	jkacur@redhat.com
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22427 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489Ab2LTAMS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 19:12:18 -0500
In-Reply-To: <50CF9A1E.5000902@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 12/17/2012 02:18 PM, Frank Rowand wrote:
> On 12/11/12 06:30, Simon Falsig wrote:
> 
> < snip >
> 
>>>> Once I get this finished up, I'll be happy to do a complete write-up
>>>> of the timer-thread code, if anyone is interested. I remember looking
>>>> for something similar (but without success), when I wrote the code
>>>> earlier this year.
>>>
>>> It would be very useful to add your results to the wiki.
>>>
>>> -Frank
>>
>> Cool - is there any particular place it should go? A how-to, FAQ entry,
>> etc? Just so I know how to do the write-up...
> 
> https://rt.wiki.kernel.org/index.php/Main_Page would be my default
> suggestion.  I'm not quite sure where on the wiki would be good
> though.  Maybe under "Tips and Techniques"?
> 
> I added the rtwiki maintainers to the cc: list.

I don't have all the context, but this sounds a bit more like something
for linux/Documentation (possibly for the preempt-rt patch set). If not,
the Documentation section on the wiki is a possibility.
-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Technical Lead - Linux Kernel
