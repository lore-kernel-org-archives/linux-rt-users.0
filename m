From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Changing checksums of RT patches
Date: Sat, 11 Mar 2017 08:43:19 -0500
Message-ID: <20170311084319.37f294b2@gandalf.local.home>
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
        <alpine.DEB.2.20.1703111044300.4213@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Dominic =?UTF-8?B?U2FjcsOp?= <dominic.sacre@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, Julia Cartwright <julia@ni.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755178AbdCKNnY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 11 Mar 2017 08:43:24 -0500
In-Reply-To: <alpine.DEB.2.20.1703111044300.4213@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 11 Mar 2017 10:45:32 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 10 Mar 2017, Steven Rostedt wrote:
> > Just an FYI, especially if you are using my older scripts (I haven't
> > updated the ones I posted). I was asked when I do my upload of a new
> > version to copy to both the main and older directory. But my scripts
> > still moved the main to the older one when a new release went out. This
> > caused the checksums of the created .gz to change in the older
> > directory.
> > 
> > What I do now is to still upload to both main and older, but when I
> > have a new release, I simply delete the main one, as the older one
> > already exists.  
> 
> That double upload does not make sense. Upload it once to the older folder
> and make a link. kup supports that.
> 

OK, I'll have to update my scripts to do this.

Thanks,

-- Steve
