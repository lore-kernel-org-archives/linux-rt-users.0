From: =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>
Subject: Re: Changing checksums of RT patches
Date: Wed, 15 Feb 2017 14:38:38 +0100
Message-ID: <0bf7c1fd-ab6e-75a3-a04b-158b6e2c1a8b@gmx.de>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
 <20170210185433.h35nynmmeu5toml6@linutronix.de>
 <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
 <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
 <20170214091829.12273157@gandalf.local.home>
 <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de>
 <20170214135738.366f21e5@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:62512 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbdBONlS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Feb 2017 08:41:18 -0500
In-Reply-To: <20170214135738.366f21e5@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-14 19:57, Steven Rostedt wrote:
> It's the way kernel.org does the updates. I upload a .xz file and a
> signed gpg file of the uncompressed image. kernel.org creates the gz
> file from the uncompressed version. As I upload it twice, kernel.org
> does two gzips of the uncompressed file. I'm guessing that there's a
> timestamp that gets used as well, making both gzipped files different,
> even though what they contain are the same.
> 
> I may need to change my workflow to simply delete the file in the
> current directory than to move it. Although, I had better make sure
> that there's a copy in the older directory first. Maybe I'll change my
> tool to download the older and current versions, uncompress them, make
> sure they are the same, and if they are, remove the current version,
> else, move the current version on the older one.

Sounds good to me!

I'll upgrade my Bitbake recipe to use older/patch-4.1.38-rt45.patch.gz
then. I've checked that the uncompressed contents are identical, so
everything should be fine with the process you describe.

(I've also just submitted a patch to OpenEmbedded to support
xz-compressed patches, which AFAICT are not affected by the whole issue.)


Thanks,

Dominic
