From: Dan Murphy <dmurphy@ti.com>
Subject: Re: Linux stable vs RT stable and RT dev
Date: Tue, 6 Feb 2018 14:07:01 -0600
Message-ID: <562d010a-efb2-8af4-3ae5-40eacf7d6e9e@ti.com>
References: <8155aea247374c058bd7c797124c3d28@ti.com>
 <20180202214611.GD868@jcartwri.amer.corp.natinst.com>
 <1c47b7e6-86d0-cbb0-9b72-7b7d63e46ddc@ti.com>
 <6eecb69a-e60f-f837-bc2c-a627e2660027@ti.com>
 <20180206143426.fdzs6hnvmakqdwiu@linutronix.de>
 <8e201971-d626-7ef6-addd-bbbc32f63770@ti.com>
 <20180206111718.0eb267da@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        William Mills <wmills@ti.com>, Julia Cartwright <julia@ni.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Hernandez, Carlos" <ceh@ti.com>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:41111 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeBFUHs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Feb 2018 15:07:48 -0500
In-Reply-To: <20180206111718.0eb267da@gandalf.local.home>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steve

On 02/06/2018 10:17 AM, Steven Rostedt wrote:
> On Tue, 6 Feb 2018 09:47:15 -0600
> Dan Murphy <dmurphy@ti.com> wrote:
> 
>> This is where we can put an automated job in place to merge GKH rc
>> stable into the RT branch and report only upcoming merge conflicts.
>> Then no one actually has to report or ask it would just be assumed?
> 
> I'd be careful about this. There's a few (not many) subtle changes that
> get backported to stable that can break RT. You wont be able to notice
> it with compiling, but it can cause deadlocks in certain scenarios.
> 

We agree merge conflicts are only half the battle.  I guess I was not clear that the auto
merge would not be distributed or even public it would just be informative.

It would just be a test for merge conflicts.  And maybe build errors/warnings if we had a limited set
of defconfig options.

Again the merge would be informative so we would know that the Linux stable will merge cleanly or not.
If there was a conflict then that could trigger the merging of the stable into the RT branch to
help the community consumers of the RT branch.

Dan


> -- Steve
> 


-- 
------------------
Dan Murphy
