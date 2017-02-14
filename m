From: =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>
Subject: Re: Changing checksums of RT patches
Date: Tue, 14 Feb 2017 19:42:35 +0100
Message-ID: <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
 <20170210185433.h35nynmmeu5toml6@linutronix.de>
 <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
 <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
 <20170214091829.12273157@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:64195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752506AbdBNSo4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Feb 2017 13:44:56 -0500
In-Reply-To: <20170214091829.12273157@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-14 15:18, Steven Rostedt wrote:
> On Tue, 14 Feb 2017 00:15:33 +0100
> Dominic Sacré <dominic.sacre@gmx.de> wrote:
>> While I was writing my previous mail, 4.1.38-rt45 was released. Attached
>> is a diff between rt/4.1/older/sha256sums.asc before (4 days ago) and
>> after -rt45 was added.
>> Note how the gzip-compressed files for 4.1.35-rt40 and 4.1.38-rt44
>> changed in the meantime.
> 
> I wonder if my process caused this. I use to just have a copy of the
> current patches in the main directory, and someone asked me to place a
> copy in the older directory, which I started doing.

Thanks! To me it's very useful to have a permanent URL for all patches,
including the latest one.

> Now when I release a newer kernel, I move the previous version from
> the main directory into the older directory deleting the copy that
> was there.
> 
> Could this be the cause of your issue?

I think so. Looking at the current contents of rt/4.1, I see that
patch-4.1.38-rt45.patch.gz and older/patch-4.1.38-rt45.patch.gz have
different sha256 hashes. I would have expected them to be copies of the
exact same file, so I guess the question is why they're different in the
first place.


Dominic
