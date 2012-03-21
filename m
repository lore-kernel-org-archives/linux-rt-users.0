From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 2/3] rt-tests: Silence unused-but-set warning in rt-migrate-test
Date: Wed, 21 Mar 2012 09:45:14 -0700
Message-ID: <4F6A059A.2010701@linux.intel.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com> <b1216a51f76a038623057621a737d02a4ab441e4.1332270303.git.dvhart@linux.intel.com> <1332338731.23924.40.camel@gandalf.stny.rr.com> <4F69E940.9060808@linux.intel.com> <CAONaPpHsCHG6QS+k9QRnQr7e1ZLEqFPHUf=-V6cw8bN+XWZPUA@mail.gmail.com> <1332346704.23924.42.camel@gandalf.stny.rr.com> <4F6A03A3.80104@linux.intel.com> <CAONaPpH3VoiMw5tWFXu1nNDKMJu6AcWJDsoi5Bt2FdS145TC+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2000 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab2CUQq7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 12:46:59 -0400
In-Reply-To: <CAONaPpH3VoiMw5tWFXu1nNDKMJu6AcWJDsoi5Bt2FdS145TC+Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 03/21/2012 09:41 AM, John Kacur wrote:
> On Wed, Mar 21, 2012 at 5:36 PM, Darren Hart <dvhart@linux.intel.com> wrote:
>>
>>
>> On 03/21/2012 09:18 AM, Steven Rostedt wrote:
>>> On Wed, 2012-03-21 at 15:56 +0100, John Kacur wrote:
>>>>>
>>>>
>>>> Yup, shows up on my F16 machine too, with a slightly different gcc version.
>>>> gcc --version
>>>> gcc (GCC) 4.6.2 20111027 (Red Hat 4.6.2-1)
>>>
>>> Egad! This is an old version. It still uses *gasp* logdev!
>>>
>>> I have a new version that writes into ftrace, and doesn't use #ifdef,
>>> but instead just looks to see if it is added to the kernel or not.
>>>
>>> So no, this patch isn't the fix. The real fix is to upgrade to the new
>>> version of the code.
>>>
>>
>> Of the compiler you mean?
>>
> 
> :) Yup, that's what he meant. Of course this is not a realistic option
> for many of us. Can you live with the stupid warning for now instead
> of cluttering the code with the annotations?

Of course, provided this is indeed a gcc bug. I understand we should use
attributes like this very sparingly and I relunctantly sent the patch
thinking it was reasonable for gcc to miss the usage as it gets rolled
into va_list.

Is this resolved in a later version of gcc? Rostedt you apparently use a
newer compiler, can you try a build?

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
