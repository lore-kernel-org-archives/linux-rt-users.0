From: =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>
Subject: Re: Changing checksums of RT patches
Date: Sat, 11 Mar 2017 12:14:00 +0100
Message-ID: <4184540c-e4a7-d471-fd3a-c3e3b611956c@gmx.de>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
 <20170210185433.h35nynmmeu5toml6@linutronix.de>
 <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
 <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
 <20170214091829.12273157@gandalf.local.home>
 <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de>
 <20170214135738.366f21e5@gandalf.local.home>
 <alpine.DEB.2.20.1702281856310.4732@nanos>
 <067fe46c-dd9f-6bb4-36d5-4ceccfee2f88@gmx.de>
 <20170310181947.3f9cde20@gandalf.local.home>
 <20170311022751.GE32162@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>,
        Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:49610 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755038AbdCKLPU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 11 Mar 2017 06:15:20 -0500
In-Reply-To: <20170311022751.GE32162@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-03-11 03:27, Julia Cartwright wrote:
> On Fri, Mar 10, 2017 at 06:19:47PM -0500, Steven Rostedt wrote:
>> What I do now is to still upload to both main and older, but when I
>> have a new release, I simply delete the main one, as the older one
>> already exists.
> 
> Okay, sounds simple enough.  I've uploaded both the patch and series
> tarball to older/, which should now remain unchanged.

Thanks, Julia.
Would it also be possible for you to restore patch-4.1.38-rt45.patch.gz
to the version that was previously in older/? That way we could minimize
the breakage. I still have the original file, if that helps.


Dominic
