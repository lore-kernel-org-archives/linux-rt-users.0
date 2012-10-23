From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
Date: Mon, 22 Oct 2012 18:41:57 -0700
Message-ID: <5085F5E5.3090204@am.sony.com>
References: <3BC12164-17B6-4F1A-94F8-A65C2A11BEAD@vmware.com> <5085EFD6.7080500@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bhavesh Davda <bhavesh@vmware.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: "Rowand, Frank" <Frank_Rowand@sonyusa.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:52723
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756380Ab2JWBl7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Oct 2012 21:41:59 -0400
In-Reply-To: <5085EFD6.7080500@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/22/12 18:16, Frank Rowand wrote:
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
> 
> After the patches survive checkpatch, I'll review and test them.

< snip >

> /home/frowand/tmp/hist_overflow_xxx_1 has style problems, please review.
> 
> If any of these errors are false positives, please report
> them to the maintainer, see CHECKPATCH in MAINTAINERS.

Oooooops, the following message was about the series file I would
use to apply the patches with quilt.  Please ignore it.

> ERROR: Does not appear to be a unified-diff format patch
> 
> total: 1 errors, 0 warnings, 0 lines checked

-Frank

