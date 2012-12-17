From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Real-time kernel thread performance and optimization
Date: Mon, 17 Dec 2012 14:18:06 -0800
Message-ID: <50CF9A1E.5000902@am.sony.com>
References: <6b5093025753dbc76e1d23af7c999826@mail.gmail.com> <50B933A5.3020400@am.sony.com> <d27143389b68c615c242b56c7cd4dd22@mail.gmail.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<jkacur@redhat.com>, <dvhart@infradead.org>
To: Simon Falsig <simon@newtec.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:36398
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754773Ab2LQWSP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Dec 2012 17:18:15 -0500
In-Reply-To: <d27143389b68c615c242b56c7cd4dd22@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/11/12 06:30, Simon Falsig wrote:

< snip >

>>> Once I get this finished up, I'll be happy to do a complete write-up
>>> of the timer-thread code, if anyone is interested. I remember looking
>>> for something similar (but without success), when I wrote the code
>>> earlier this year.
>>
>> It would be very useful to add your results to the wiki.
>>
>> -Frank
> 
> Cool - is there any particular place it should go? A how-to, FAQ entry,
> etc? Just so I know how to do the write-up...

https://rt.wiki.kernel.org/index.php/Main_Page would be my default
suggestion.  I'm not quite sure where on the wiki would be good
though.  Maybe under "Tips and Techniques"?

I added the rtwiki maintainers to the cc: list.

-Frank

