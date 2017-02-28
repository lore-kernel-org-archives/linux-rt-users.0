From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Changing checksums of RT patches
Date: Tue, 28 Feb 2017 13:30:23 -0500
Message-ID: <20170228133023.3f175844@gandalf.local.home>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
        <20170210185433.h35nynmmeu5toml6@linutronix.de>
        <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
        <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
        <20170214091829.12273157@gandalf.local.home>
        <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de>
        <20170214135738.366f21e5@gandalf.local.home>
        <alpine.DEB.2.20.1702281856310.4732@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Dominic =?UTF-8?B?U2FjcsOp?= <dominic.sacre@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbdB1ScO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Feb 2017 13:32:14 -0500
In-Reply-To: <alpine.DEB.2.20.1702281856310.4732@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 28 Feb 2017 19:03:29 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 14 Feb 2017, Steven Rostedt wrote:
> > On Tue, 14 Feb 2017 19:42:35 +0100
> > Dominic Sacré <dominic.sacre@gmx.de> wrote:
> >   
> > > Could this be the cause of your issue?  
> > > 
> > > I think so. Looking at the current contents of rt/4.1, I see that
> > > patch-4.1.38-rt45.patch.gz and older/patch-4.1.38-rt45.patch.gz have
> > > different sha256 hashes. I would have expected them to be copies of the
> > > exact same file, so I guess the question is why they're different in the
> > > first place.  
> > 
> > It's the way kernel.org does the updates. I upload a .xz file and a
> > signed gpg file of the uncompressed image. kernel.org creates the gz
> > file from the uncompressed version. As I upload it twice, kernel.org
> > does two gzips of the uncompressed file. I'm guessing that there's a
> > timestamp that gets used as well, making both gzipped files different,
> > even though what they contain are the same.  
> 
> Right. And it does not matter at all.
> 
> The sha256 tells you that the file you downloaded is the one which
> kernel.org advertised to you. Not more, not less.
> 
> The content is protected by the *.patch.sign and *.tar.sign files.
> 
> > I may need to change my workflow to simply delete the file in the
> > current directory than to move it.  
> 
> And the point is?

The issue I believe is that there's a third party downloading the
compressed files and doing a checksum on them.

> 
> > Although, I had better make sure that there's a copy in the older
> > directory first. Maybe I'll change my tool to download the older and
> > current versions, uncompress them, make sure they are the same, and if
> > they are, remove the current version, else, move the current version on
> > the older one.  
> 
> That does not make any sense.
> 
> The proper thing to do is move file from rt/4.x/ to rt/4.x/older.

This is a fallout of the change in work flow I have already made for
multiple people that have asked.

The issue is that we have a "current" and "older" directory. When we
do a new release, the current files get moved to the older directory.
This caused issues with people that supply scripts to down load the
tarballs. The problem is that they would be looking for a specific
version and suddenly it would move. I was asked to place the current
version in the "older" directory too. What I was told was that Sebastian
would upload the same file to both the current and older directories.
Which is what I changed to do as well.



> 
> If kernel.org decides to redo the archives, then you can't do anything
> about it. And if you upload it another time there is no guarantee either
> that the resulting gz/xz are the same.
> 
> What matters is the content and not the compressed thingy. Again:
> 
>  - The sha256 only tells you that the download was not corrupted.
> 
>  - The PGP signature is what protects the content and that does not change
>    whether you move it or upload the same thing again.

Actually, there's no "upload again" step. I believe Sebastian does the
same thing that I'm changing my workflow into. That is, when I upload
for the first time, I upload the same file into both "current" and
"older". This was added to my old workflow. But when I do a new
release, I didn't change my workflow to just remove what was in
current, but instead I moved current into older *overwriting* what was
already in older. That is the problem people are having.

They had a checksum of the .gz file in "older", and when I did the move
from current to older, I overwrote that file, and the checksum changed,
as it was compressed twice.

If I just do what I believe Sebastian does, and simply remove the files
in "current" as they already exist in "older", then everyone should be
happy.

-- Steve

