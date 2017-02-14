From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Changing checksums of RT patches
Date: Tue, 14 Feb 2017 13:57:38 -0500
Message-ID: <20170214135738.366f21e5@gandalf.local.home>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
        <20170210185433.h35nynmmeu5toml6@linutronix.de>
        <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
        <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
        <20170214091829.12273157@gandalf.local.home>
        <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
To: Dominic =?UTF-8?B?U2FjcsOp?= <dominic.sacre@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752962AbdBNS5n (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Feb 2017 13:57:43 -0500
In-Reply-To: <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 14 Feb 2017 19:42:35 +0100
Dominic Sacré <dominic.sacre@gmx.de> wrote:

> Could this be the cause of your issue?  
> 
> I think so. Looking at the current contents of rt/4.1, I see that
> patch-4.1.38-rt45.patch.gz and older/patch-4.1.38-rt45.patch.gz have
> different sha256 hashes. I would have expected them to be copies of the
> exact same file, so I guess the question is why they're different in the
> first place.

It's the way kernel.org does the updates. I upload a .xz file and a
signed gpg file of the uncompressed image. kernel.org creates the gz
file from the uncompressed version. As I upload it twice, kernel.org
does two gzips of the uncompressed file. I'm guessing that there's a
timestamp that gets used as well, making both gzipped files different,
even though what they contain are the same.

I may need to change my workflow to simply delete the file in the
current directory than to move it. Although, I had better make sure
that there's a copy in the older directory first. Maybe I'll change my
tool to download the older and current versions, uncompress them, make
sure they are the same, and if they are, remove the current version,
else, move the current version on the older one.

-- Steve
