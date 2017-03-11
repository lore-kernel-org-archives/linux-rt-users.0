From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Changing checksums of RT patches
Date: Sat, 11 Mar 2017 10:45:32 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703111044300.4213@nanos>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de> <20170210185433.h35nynmmeu5toml6@linutronix.de> <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de> <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de> <20170214091829.12273157@gandalf.local.home>
 <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de> <20170214135738.366f21e5@gandalf.local.home> <alpine.DEB.2.20.1702281856310.4732@nanos> <067fe46c-dd9f-6bb4-36d5-4ceccfee2f88@gmx.de> <20170310181947.3f9cde20@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Dominic_Sacr=E9?= <dominic.sacre@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, Julia Cartwright <julia@ni.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60615 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbdCKJpi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 11 Mar 2017 04:45:38 -0500
In-Reply-To: <20170310181947.3f9cde20@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 10 Mar 2017, Steven Rostedt wrote:
> Just an FYI, especially if you are using my older scripts (I haven't
> updated the ones I posted). I was asked when I do my upload of a new
> version to copy to both the main and older directory. But my scripts
> still moved the main to the older one when a new release went out. This
> caused the checksums of the created .gz to change in the older
> directory.
> 
> What I do now is to still upload to both main and older, but when I
> have a new release, I simply delete the main one, as the older one
> already exists.

That double upload does not make sense. Upload it once to the older folder
and make a link. kup supports that.

Thanks,

	tglx
