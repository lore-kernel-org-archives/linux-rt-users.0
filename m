From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
Date: Thu, 25 Oct 2012 15:05:30 -0700
Message-ID: <5089B7AA.9040507@am.sony.com>
References: <3BC12164-17B6-4F1A-94F8-A65C2A11BEAD@vmware.com> <5089B0DA.2010909@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bhavesh Davda <bhavesh@vmware.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: "Rowand, Frank" <Frank_Rowand@sonyusa.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:58466
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750748Ab2JYWFh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2012 18:05:37 -0400
In-Reply-To: <5089B0DA.2010909@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/25/12 14:36, Frank Rowand wrote:
> On 10/16/12 10:02, Bhavesh Davda wrote:
>> From: Bhavesh Davda <bhavesh@vmware.com>
>>
>> Add feature to cyclictest histogram mode to track cycle counts every time a
>> sample overflows the histogram limit. This should help identify if there is a
>> timing pattern to jitters in cyclictest runs.
>>
>> Example output (with -h 10):
>>  ...
>>  Histogram Overflows: 00001 00007 00000 00009 00004 00007 00000 00001
>>  Histogram Overflow at cycle number:
>>  Thread 0: 09964
>>  Thread 1: 00000 00004 00006 00008 00010 09962 11594
>>  Thread 2:
>>  Thread 3: 01169 04698 06782 09033 10299 11561 21517 28734 29532
>>  Thread 4: 11574 11580 11583 11586
>>  Thread 5: 00020 09448 13954 14954 18954 20587 24973
>>  Thread 6:
>>  Thread 7: 18950
>>  ...
>>
>> Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
> 
> My comments up to "--" are not meant to be part of the header of the
> following patch.
> 
> I am including the following patch as my review of the patch I am
> replying to.  If the following patch is incorporated into the

One further thought...  The histogram overflow cycle report shows
what cycle the overflow occurred in, not the actual time.  Adding
the merged for all threads cycle times works because the histogram
turns off the "different intervals for different threads" option:

                if (!histogram) /* same interval on CPUs */
                        interval += distance;

but if that ever changes then cycle is not a useful value to be
reporting.

So it seems like it would be useful to convert cycle to a time
in the report.  This is something that would have to be done
anyway in post processing when trying to make use of the report.

-Frank

