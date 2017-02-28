From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Changing checksums of RT patches
Date: Tue, 28 Feb 2017 19:03:29 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702281856310.4732@nanos>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>        <20170210185433.h35nynmmeu5toml6@linutronix.de>        <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>        <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>        <20170214091829.12273157@gandalf.local.home>
        <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de> <20170214135738.366f21e5@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-280205796-1488305009=:4732"
Cc: =?ISO-8859-15?Q?Dominic_Sacr=E9?= <dominic.sacre@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36486 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdB1SDd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Feb 2017 13:03:33 -0500
In-Reply-To: <20170214135738.366f21e5@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-280205796-1488305009=:4732
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Feb 2017, Steven Rostedt wrote:
> On Tue, 14 Feb 2017 19:42:35 +0100
> Dominic Sacré <dominic.sacre@gmx.de> wrote:
> 
> > Could this be the cause of your issue?  
> > 
> > I think so. Looking at the current contents of rt/4.1, I see that
> > patch-4.1.38-rt45.patch.gz and older/patch-4.1.38-rt45.patch.gz have
> > different sha256 hashes. I would have expected them to be copies of the
> > exact same file, so I guess the question is why they're different in the
> > first place.
> 
> It's the way kernel.org does the updates. I upload a .xz file and a
> signed gpg file of the uncompressed image. kernel.org creates the gz
> file from the uncompressed version. As I upload it twice, kernel.org
> does two gzips of the uncompressed file. I'm guessing that there's a
> timestamp that gets used as well, making both gzipped files different,
> even though what they contain are the same.

Right. And it does not matter at all.

The sha256 tells you that the file you downloaded is the one which
kernel.org advertised to you. Not more, not less.

The content is protected by the *.patch.sign and *.tar.sign files.

> I may need to change my workflow to simply delete the file in the
> current directory than to move it.

And the point is?

> Although, I had better make sure that there's a copy in the older
> directory first. Maybe I'll change my tool to download the older and
> current versions, uncompress them, make sure they are the same, and if
> they are, remove the current version, else, move the current version on
> the older one.

That does not make any sense.

The proper thing to do is move file from rt/4.x/ to rt/4.x/older.

If kernel.org decides to redo the archives, then you can't do anything
about it. And if you upload it another time there is no guarantee either
that the resulting gz/xz are the same.

What matters is the content and not the compressed thingy. Again:

 - The sha256 only tells you that the download was not corrupted.

 - The PGP signature is what protects the content and that does not change
   whether you move it or upload the same thing again.

Thanks,

	tglx
--8323329-280205796-1488305009=:4732--
