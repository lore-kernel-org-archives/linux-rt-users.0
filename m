From: Dan Murphy <dmurphy@ti.com>
Subject: Re: Linux stable vs RT stable and RT dev
Date: Fri, 9 Feb 2018 13:43:42 -0600
Message-ID: <e6b1a499-6bf4-ae84-629a-961117966a47@ti.com>
References: <8155aea247374c058bd7c797124c3d28@ti.com>
 <20180202214611.GD868@jcartwri.amer.corp.natinst.com>
 <1c47b7e6-86d0-cbb0-9b72-7b7d63e46ddc@ti.com>
 <6eecb69a-e60f-f837-bc2c-a627e2660027@ti.com>
 <20180206143426.fdzs6hnvmakqdwiu@linutronix.de>
 <8e201971-d626-7ef6-addd-bbbc32f63770@ti.com>
 <20180209173921.mtz55hgs5idj4vhk@linutronix.de>
 <a1c7a58e-2d67-f6fd-6e91-9cbd03678e7d@ti.com>
 <20180209193015.wms4o7wxsi3t535g@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: William Mills <wmills@ti.com>, Julia Cartwright <julia@ni.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, <rostedt@goodmis.org>,
        "Hernandez, Carlos" <ceh@ti.com>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:44215 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeBITn5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Feb 2018 14:43:57 -0500
In-Reply-To: <20180209193015.wms4o7wxsi3t535g@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian

On 02/09/2018 01:30 PM, Sebastian Andrzej Siewior wrote:
> On 2018-02-09 12:59:43 [-0600], Dan Murphy wrote:
>> Sebastian
> HI Dan,
> 
>> Hmmm I wonder why the compiler does not complain about this warning then.
>>
>> I will look into it.  This warning has been around for a while (4.9-rt as well).
> 
> probably once the local_irq_save() was removed.
> 
>> We also noticed that there are 2 merge conflicts when going to 4.14.18.
>> Any comments about providing a merge conflict email to the list?
> 
> I am not sure about how helpful this actually is. Usually I do a RT
> release a week while I have stuff in my pipe. Currently Greg is
> releasing a lot. On the other hand it is almost two weeks since my last
> release.

For us it is helpful to have the experts resolve these stable->rt conflicts that occur
in the base kernel files.  At least if there is a merge conflict that will occur this
could be the "stuff" in your pipe.  If there were no merge conflicts detected for upcoming
merges there would be no expectation to move quicker.

I mean GKH 4.14.19 is coming on Monday it may be better just to wait for that to be released
then merge that in.  There were only 22 patches added to 4.14.19 so it should be minimal.

Dan

> 
>> Attached is the merge conflicts we are seeing 4.14.15-> 4.14.18
> 
> In meantime I already uploaded the patch queue for v4.14.18-rt14.
> I plan to sync with Steven's tracing then release -rt15 probably later
> today.
> 
>> Dan
> 
> Sebastian
> 


-- 
------------------
Dan Murphy
