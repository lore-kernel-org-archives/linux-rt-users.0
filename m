Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:43903 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIXKP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Oct 2018 19:10:15 -0400
Date: Tue, 9 Oct 2018 17:52:39 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: __migrate_disabled symbol not exported for rt kernel > 4.9
Message-ID: <20181009155239.gfwvw7lwj3ohvpzi@linutronix.de>
References: <20180918205514.GB31793@joraj-alpa>
 <20181005142325.bltjehfbffvnhkam@linutronix.de>
 <20181009152723.GA7665@joraj-alpa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009152723.GA7665@joraj-alpa>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: linux-rt-users@vger.kernel.org, skrishnakar@gmail.com

On 2018-10-09 11:27:23 [-0400], Jonathan Rajotte-Julien wrote:
> Hi,
Hi,

> The inline nature of it, for us, is less pertinent, the symbol presence is more
> important.

Okay. Let me add that export for the upcoming v4.18 release.

Sebastian
