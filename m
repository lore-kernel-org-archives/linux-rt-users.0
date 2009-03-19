From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: real-time priority
Date: Thu, 19 Mar 2009 16:26:22 -0700
Message-ID: <49C2D49E.2010900@am.sony.com>
References: <49C2CAFB.5030702@lavabit.com> <49C2D117.9070501@lavabit.com>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Rodrigo Amestica <ramestica@lavabit.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:54575 "EHLO
	SG2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbZCSX0v (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Mar 2009 19:26:51 -0400
In-Reply-To: <49C2D117.9070501@lavabit.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Rodrigo Amestica wrote:
> yes, i forgot to include the link. now it goes.
> 
> http://www.ddj.com/linux-open-source/200900827
> 
> Rodrigo Amestica wrote:
>> Hi,
>>
>> general questions from somebody who's just starting to look into the
>> preempt patch.
>>
>> the article linked below makes direct reference to the behavior of the
>> preempt rt patch. The article was written in 2007. How much of that
>> still holds true in the current version of the patch?
>>
>> I'm basically wondering about the first sentences in the abstract of
>> that article. The big picture seems to be rather simple: calls to
>> specific linux services could break the performance of a real time
>> task by depending on lower priority tasks to complete that service.
>>
>> Does this mean that one must always be alert to which system services
>> are invoked during the execution of a real time task?

Yes.

>> Does the vanilla
>> kernel or the preempt-rt patch tries to somehow detect this condition
>> and alert somehow?

I am not aware of any such test, but it sounds like an interesting idea.

>>
>> thanks,
>> Rodrigo
>>


