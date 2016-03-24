From: Mats Karrman <mats.dev.list@gmail.com>
Subject: Re: [PATCH][rt-tests] cyclictest: Make the tracemark option imply
 notrace
Date: Thu, 24 Mar 2016 16:57:31 +0100
Message-ID: <56F40E6B.4050107@gmail.com>
References: <alpine.LFD.2.20.1603241543150.8641@riemann>
 <20160324105255.48459b11@redhat.com>
 <alpine.LFD.2.20.1603241608370.8641@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36688 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbcCXP5e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Mar 2016 11:57:34 -0400
Received: by mail-lb0-f170.google.com with SMTP id qe11so33536374lbc.3
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2016 08:57:33 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.20.1603241608370.8641@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 2016-03-24 16:24, John Kacur wrote:
>
> On Thu, 24 Mar 2016, Luiz Capitulino wrote:
>
>> On Thu, 24 Mar 2016 15:44:39 +0100 (CET)
>> John Kacur <jkacur@redhat.com> wrote:
>>
...
>>> Therefore turn --notrace on if --tracemark is invoked even if the user
>>> doesn't explicitly request this.
>> I'm not necessarily against this, but at the same time I think
>> I prefer options doing only one thing.
> Maybe think about it a little differently. The option implies a certain
> consistent state. So, the option really only does do one thing, it puts
> cyclictest in the correct state as required. If we don't do this, someone
> is sure to use the --tracemark option without --notrace, and some
> unexpected things are going to occur.
>
Another alternative is to exit with an error if conflicting options are 
used.

// Mats

