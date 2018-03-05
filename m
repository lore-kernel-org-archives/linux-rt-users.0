Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from lelnx194.ext.ti.com ([198.47.27.80]:62927 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeCESC3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Mar 2018 13:02:29 -0500
Subject: Re: Merge conflict on RT 4.14 to latest stable
References: <abeee969-3171-da04-ab56-bb0482640e87@ti.com>
 <20180301134123.GA955@jcartwri.amer.corp.natinst.com>
 <0e822795-fa27-abb5-aec0-db27f81d703e@ti.com>
 <20180301211335.GB955@jcartwri.amer.corp.natinst.com>
 <8806abae-ac00-08ec-894b-904ebfcdb7f0@ti.com>
 <20180301215909.GD955@jcartwri.amer.corp.natinst.com>
 <20180305175614.nobnduk7td2rixz4@linutronix.de>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <a968ebf8-d810-e039-ed7f-3f88685ddfa9@ti.com>
Date: Mon, 5 Mar 2018 12:02:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180305175614.nobnduk7td2rixz4@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Julia Cartwright <julia@ni.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

Sebastian

On 03/05/2018 11:56 AM, Sebastian Andrzej Siewior wrote:
> On 2018-03-01 15:59:09 [-0600], Julia Cartwright wrote:
>> On Thu, Mar 01, 2018 at 03:21:48PM -0600, Dan Murphy wrote:
>>>> You're off into Sebastian territory for 4.14-rt conflicts, although I'm
>>>> sure he is either already aware, or will shortly be made aware when he
>>>> does the merge himself.
> 
> the merge has been done v4.14.24-rt19 is out.
> 

Thank you.  It could not have been at a more perfect time.  We are starting
our test cycle on 4.14 RT.  I was resolving it locally as well and I came to the
same resolution.  But I will merge your branch first before adding our product
branch on top.

Dan

>>> There is no consistent merge cadence like we have for the stable RT
>>> tree.  As GKH points out we all need to be using the latest stable.
> 
> be ware that v4.14-RT is not exactly stable maintenance work here. I do
> throw new things into it and I am glad about any testing it gets. So I
> have a pile of dcache related patches which I did not want to add to the
> queue yet. And we had the one or other timer related problem before the
> queue hit Linus' tree.
> 
>> Now, if there are actually real users asking for a 4.14.y merge on a
>> more frequent cadence, then it might be a sign we should transfer
>> ownership of this branch to the rt stable team; I'm sure there is
>> already an impeding conversation in this direction (maybe at ELC).
> 
> It might be good not having multiple people hacking on one branch.
> However, given that v4.16 will be out "soon" I will move on.
> 
>>    Julia
> 
> Sebastian
> 


-- 
------------------
Dan Murphy
