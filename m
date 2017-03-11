From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Changing checksums of RT patches
Date: Sat, 11 Mar 2017 08:42:54 -0500
Message-ID: <20170311084254.215a2df2@gandalf.local.home>
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
        <4184540c-e4a7-d471-fd3a-c3e3b611956c@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Julia Cartwright <julia@ni.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
To: Dominic =?UTF-8?B?U2FjcsOp?= <dominic.sacre@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755178AbdCKNm7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 11 Mar 2017 08:42:59 -0500
In-Reply-To: <4184540c-e4a7-d471-fd3a-c3e3b611956c@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 11 Mar 2017 12:14:00 +0100
Dominic Sacré <dominic.sacre@gmx.de> wrote:

> Thanks, Julia.
> Would it also be possible for you to restore patch-4.1.38-rt45.patch.gz
> to the version that was previously in older/? That way we could minimize
> the breakage. I still have the original file, if that helps.

No it's not possible. The .gz files are created by kernel.org when we
upload them. That's the reason they are different in the first place.
Because we upload the same file twice, and each time kernel.org creates
the .gz file which creates the differences.

-- Steve
