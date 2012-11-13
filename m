From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
Date: Tue, 13 Nov 2012 15:41:20 -0800
Message-ID: <50A2DAA0.2010105@am.sony.com>
References: <3BC12164-17B6-4F1A-94F8-A65C2A11BEAD@vmware.com> <5089B0DA.2010909@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Bhavesh Davda <bhavesh@vmware.com>, John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:48810
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755043Ab2KMXlR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2012 18:41:17 -0500
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
> reviewed patch, then you can add my:
> 
>   Reviewed-by: Frank Rowand <frank.rowand@am.sony.com>
>   Tested-by: Frank Rowand <frank.rowand@am.sony.com>
> 
> to the combined patch.

< snip >

Bhavesh,

I never saw I reply to my suggestions.  Unfortunately John took my
reviewed-by for your white space patch and applied it to your
"cyclictest: histogram overflow instance tracking" patch, without
my suggestions, and released it in v0.85 rt-tests.

So...., any thoughts about the suggestions in the email that
this one is responding to?  And also any thoughts about my
second email in the series (I'll forward that one again to
you).

-Frank

