From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH-rt 0/2] Fix up aio splats at reboot garbage collection
Date: Fri, 20 Feb 2015 12:46:48 -0500
Message-ID: <54E77308.5080904@windriver.com>
References: <1424033559-63051-1-git-send-email-paul.gortmaker@windriver.com> <20150218112823.GF28763@linutronix.de> <1424266433.7113.1.camel@gmail.com> <54E76F65.7040800@windriver.com> <20150220173929.GJ26974@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-rt-users@vger.kernel.org>,
	Kent Overstreet <kmo@daterainc.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:37616 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbbBTRrC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Feb 2015 12:47:02 -0500
In-Reply-To: <20150220173929.GJ26974@kvack.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2015-02-20 12:39 PM, Benjamin LaHaise wrote:
> On Fri, Feb 20, 2015 at 12:31:17PM -0500, Paul Gortmaker wrote:
>> On 2015-02-18 08:33 AM, Mike Galbraith wrote:
>>> On Wed, 2015-02-18 at 12:28 +0100, Sebastian Andrzej Siewior wrote:
>>>> * Paul Gortmaker | 2015-02-15 15:52:37 [-0500]:
>>>>
>>>>> We ran into a splat during reboot that was caused by the percpu_ref_kill
>>>>> garbage collection in the fs/aio code.
>>>>
>>>> Could you please check if
>>>>      https://lkml.org/lkml/2015/2/16/391
>>>> works for you?
>>>
>>> I did not see a gripe with that and ltp.
>>
>> Same here ; set aside my two commits and applied the
>> sworkqueue implementation and the proposed aio patch
>> to the 3.14-rt tree and it doesn't splat on reboot.
>
> Sebastian, is this safe for non-RT kernels?  If so, could you please resend
> against mainline with a Signed-off-by so we can get this properly fixed?

The simple waitqueue and simple workqueue are -rt specific
additions; while we probably want to get those mainline
since they bring size optimizations, they aren't in there
yet, so we can't use this in mainline yet.

P.
--

>
> 		-ben
>
>> Thanks,
>> Paul.
>> --
>>
>>>
>>> 	-Mike
>>>
>

