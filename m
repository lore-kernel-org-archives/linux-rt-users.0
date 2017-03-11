From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Changing checksums of RT patches
Date: Fri, 10 Mar 2017 22:21:26 -0500
Message-ID: <20170310222126.30fbeb3d@grimm.local.home>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Dominic Sacr? <dominic.sacre@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-rt-users@vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:57753 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755554AbdCKDVb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Mar 2017 22:21:31 -0500
In-Reply-To: <20170311022751.GE32162@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 10 Mar 2017 20:27:51 -0600
Julia Cartwright <julia@ni.com> wrote:

> I'd still like to understand why kernel.org decides to re-compress when
> the simply moving patches around...

It doesn't but I'm guessing that each upload has a different
compression result. The change happens when we remove the one from the
older directory and replace it with the one from the top directory. The
moved files still have the same checksum, but it's not the same as what
it replaced. Then it's reported that the one that got replaced had its
checksum changed.

-- Steve
