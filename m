From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Changing checksums of RT patches
Date: Tue, 14 Feb 2017 09:18:29 -0500
Message-ID: <20170214091829.12273157@gandalf.local.home>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
        <20170210185433.h35nynmmeu5toml6@linutronix.de>
        <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
        <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
To: Dominic =?UTF-8?B?U2FjcsOp?= <dominic.sacre@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754049AbdBNOSm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Feb 2017 09:18:42 -0500
In-Reply-To: <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 14 Feb 2017 00:15:33 +0100
Dominic Sacré <dominic.sacre@gmx.de> wrote:

> On 2017-02-13 23:56, Dominic Sacré wrote:
> > On 2017-02-10 19:54, Sebastian Andrzej Siewior wrote:  
> >> Can you tell me which file in which folder changed?  
> > 
> > The files I'm currently concerned with are in the rt/4.1/older directory.  
> 
> While I was writing my previous mail, 4.1.38-rt45 was released. Attached
> is a diff between rt/4.1/older/sha256sums.asc before (4 days ago) and
> after -rt45 was added.
> Note how the gzip-compressed files for 4.1.35-rt40 and 4.1.38-rt44
> changed in the meantime.

I wonder if my process caused this. I use to just have a copy of the
current patches in the main directory, and someone asked me to place a
copy in the older directory, which I started doing. Now when I release
a newer kernel, I move the previous version from the main directory
into the older directory deleting the copy that was there.

Could this be the cause of your issue?

-- Steve

