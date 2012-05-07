From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH] rt-tests: incorrect first latency value for --verbose
 option
Date: Mon, 7 May 2012 15:13:59 -0700
Message-ID: <4FA84927.8010803@am.sony.com>
References: <4FA1CB20.5000209@am.sony.com> <alpine.LFD.2.02.1205072322250.3886@tycho> <4FA8428B.4050809@am.sony.com> <alpine.LFD.2.02.1205072353210.3886@tycho>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:51365 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752760Ab2EGWO3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2012 18:14:29 -0400
In-Reply-To: <alpine.LFD.2.02.1205072353210.3886@tycho>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/07/12 15:03, John Kacur wrote:
> 
> 
> On Mon, 7 May 2012, Frank Rowand wrote:
> 
>> On 05/07/12 14:41, John Kacur wrote:
>>>
>>>
>>> On Wed, 2 May 2012, Frank Rowand wrote:
>>>
>>>>
>>>> When the --verbose option is selected, the first value for each thread is
>>>> incorrectly reported as zero.
>>>>
>>>> This is because when collecting the first value, the index into stat->values is
>>>> incremented from zero to one before storing the value.  But when printing the
>>>> values, the first value printed is stat->values[0], which has been initialized
>>>> to zero.
>>>
>>> Hi Frank
>>>
>>> Ok, no more posting from me after winning a bottle of whiskey at the Irish 
>>> Pub on quiz night. :)
>>
>> Or if you do, you should share a bit of the whiskey with me.
> 
> You get the bottle and 30 shot glasses and share it with everyone at the 
> pub, so if you want some you have to come, and then help my team win too 
> :)

Hmmm, that's a long way to go for a shot.

> 
>  > 
>>>
>>> I've been looking at this one, and I'm not sure about it.
>>> According to the help output, 
>>>
>>> "-v       --verbose         output values on stdout for statistics
>>>                            format: n:c:v n=tasknum c=count v=value in us"
>>>
>>> ./cyclictest --verbose -p99 -t | awk '$2~/^0/{ print }' 
>>>
>>>        0:       0:       0
>>>        1:       0:       0
>>>        2:       0:       0
>>>        3:       0:       0
>>>        4:       0:       0
>>>        5:       0:       0
>>>        6:       0:       0
>>>        7:       0:       0
>>>
>>> So, it looks like the values are 0 at count 0, doesn't that make sense?
>>
>> Nope.  The event for count == 0 is the first event.  And the first event
>> has an actual latency that is not zero on the system I tested it on.
>>
> 
> Hmmm, this may be a quibble about definitions. I know that in the c-world 
> we're used to start counting at 0, but to me, count == 0 is before the 
> first event. You're not losing any data here, it's just that the first 
> event is stored in the first count. Or am I still missing something here?

In that case, there is no value in reporting event zero for each thread,
because it will always be:  0:   0:   0

Another thing that points to reporting latency == 0 is not intended is
that the summary does not report a 'Min' of zero, even when the trace
shows the first event having a latency of zero:

  # cyclictest -q --verbose -p99 -t -l 3
  Thread 0 Interval: 1500
  Thread 1 Interval: 2000
         0:       0:       0
         0:       1:     190
         0:       2:     166
         1:       0:       0
         1:       1:     178
         1:       2:     173
  T: 0 (  633) P:99 I:1000 C:      3 Min:    166 Act:  173 Avg:  176 Max:     190
  T: 1 (  634) P:98 I:1500 C:      3 Min:    138 Act:  138 Avg:  163 Max:     178

