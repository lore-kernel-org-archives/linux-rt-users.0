From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH] rt-tests: incorrect first latency value for --verbose
 option
Date: Mon, 7 May 2012 14:45:47 -0700
Message-ID: <4FA8428B.4050809@am.sony.com>
References: <4FA1CB20.5000209@am.sony.com> <alpine.LFD.2.02.1205072322250.3886@tycho>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:45788 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062Ab2EGVqQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2012 17:46:16 -0400
In-Reply-To: <alpine.LFD.2.02.1205072322250.3886@tycho>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/07/12 14:41, John Kacur wrote:
> 
> 
> On Wed, 2 May 2012, Frank Rowand wrote:
> 
>>
>> When the --verbose option is selected, the first value for each thread is
>> incorrectly reported as zero.
>>
>> This is because when collecting the first value, the index into stat->values is
>> incremented from zero to one before storing the value.  But when printing the
>> values, the first value printed is stat->values[0], which has been initialized
>> to zero.
> 
> Hi Frank
> 
> Ok, no more posting from me after winning a bottle of whiskey at the Irish 
> Pub on quiz night. :)

Or if you do, you should share a bit of the whiskey with me.

> 
> I've been looking at this one, and I'm not sure about it.
> According to the help output, 
> 
> "-v       --verbose         output values on stdout for statistics
>                            format: n:c:v n=tasknum c=count v=value in us"
> 
> ./cyclictest --verbose -p99 -t | awk '$2~/^0/{ print }' 
> 
>        0:       0:       0
>        1:       0:       0
>        2:       0:       0
>        3:       0:       0
>        4:       0:       0
>        5:       0:       0
>        6:       0:       0
>        7:       0:       0
> 
> So, it looks like the values are 0 at count 0, doesn't that make sense?

Nope.  The event for count == 0 is the first event.  And the first event
has an actual latency that is not zero on the system I tested it on.

-Frank

