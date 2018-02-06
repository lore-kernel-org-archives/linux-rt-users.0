From: Dan Murphy <dmurphy@ti.com>
Subject: Re: Linux stable vs RT stable and RT dev
Date: Tue, 6 Feb 2018 09:47:15 -0600
Message-ID: <8e201971-d626-7ef6-addd-bbbc32f63770@ti.com>
References: <8155aea247374c058bd7c797124c3d28@ti.com>
 <20180202214611.GD868@jcartwri.amer.corp.natinst.com>
 <1c47b7e6-86d0-cbb0-9b72-7b7d63e46ddc@ti.com>
 <6eecb69a-e60f-f837-bc2c-a627e2660027@ti.com>
 <20180206143426.fdzs6hnvmakqdwiu@linutronix.de>
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
Received: from fllnx209.ext.ti.com ([198.47.19.16]:30437 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeBFPsI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Feb 2018 10:48:08 -0500
In-Reply-To: <20180206143426.fdzs6hnvmakqdwiu@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian

On 02/06/2018 08:34 AM, Sebastian Andrzej Siewior wrote:
> On 2018-02-05 15:17:56 [-0600], Dan Murphy wrote:
>> We are catching warnings and errors with these defconfigs.  I have reported 2 warnings but
>> I have not received a response.  I guess I should report these to this list as opposed to the maintainers.
> 
> You reported two warnings to my private address while I was traveling.
> The usual workflow for reporting is to send this to the mailing list and
> Cc the RT maintainer(s) (which would contain the email address I am
> using right now).

Agreed sorry for that.  I sent the issues before I got the mail list information.

> 
>> We have a "next" process that runs nightly that merges in the stable rc candidate into our branch
>> so we can anticipate if the new stable or TI developer branches will cause a merge conflict when merged into our branch sets.
>>
>> For instance 4.14.17 stable rc caused a merge conflict in the hrtimer.c file. This became a known issue as soon as the stable rc was
>> available.  The RT 4.14 upstream branch is currently on 4.14.15 so now our RT branch is blocked from receiving a new stable until the
>> RT upstream branch is updated.
> 
> I usually do a new release once I have something in my pipe or if people
> ask to update new stable due to $reason.
> 

OK.  I see the stable RT tree for 4.9 gets updated with every GKH stable release.
Since RT touches kernel files would it be advantageous to keep the development branch up to date until
especially if we still have RT patches?  Or at the very least if there is an upcoming merge conflict to update and resolve on the RT
development branch when we know?

This is where we can put an automated job in place to merge GKH rc stable into the RT branch and report only upcoming merge conflicts.
Then no one actually has to report or ask it would just be assumed?

Dan

>> Dan
> 
> Sebastian
> 


-- 
------------------
Dan Murphy
